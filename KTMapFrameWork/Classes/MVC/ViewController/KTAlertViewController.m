//
//  KTAlertViewController.m
//  cocore
//
//  Created by KT--stc08 on 2019/4/9.
//

#import "KTAlertViewController.h"
#import <Masonry/Masonry.h>
@interface KTAlertViewController ()
@property(nonatomic,strong)UIView *boxView;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *messageLabel;               //消息label
@property(nonatomic,strong)UIView *btnView;                     //按钮图层
@property(nonatomic,strong)NSMutableArray *actionArray;
@property(nonatomic,strong)MASConstraint *btnHeightConstraint;
@end

@implementation KTAlertAction

+(instancetype)actionWithTitle:(nullable NSString *)title withAction:(nullable void (^)(void))block
{
    KTAlertAction *action = [KTAlertAction new];
    action.title = title;
    action.block = block;
    return action;
}

@end

@implementation KTAlertViewController


+(instancetype)alertViewWithTitle:(nullable NSString *)title withImage:(nullable UIImage *)image withMessage:(nullable NSString *)message
{
    KTAlertViewController *vc = [[self alloc] init];
    vc.titleString = title;
    vc.message = message;
    vc.image = image;
    return vc;
}

-(UIView*)middleView
{
    if (!_middleView) {
        _middleView = [UIView new];
        [self.boxView addSubview:_middleView];
    }
    return _middleView;
}
- (void)viewDidLoad {
    
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupUI];
    NSMutableArray * btnArray = [NSMutableArray new];
    int i = 1;
    for (KTAlertAction *atcion in self.actionArray) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:atcion.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0/255.0 green:114/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(actionBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [btnArray addObject:button];
        button.layer.borderWidth = 1;
        button.layer.borderColor  =[UIColor colorWithRed:224/255.0 green:225/255.0 blue:230/255.0 alpha:1.0].CGColor;
        button.layer.masksToBounds  = true;
        [self.btnView addSubview:button];
        button.tag = i;
        i++;
    }
    if(btnArray.count>=2)
    {
    
        [btnArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        [btnArray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }else
    {
        [btnArray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
        }];
    }
    
}
-(void)setupUI{
    
    [self.boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view.mas_centerY).offset(-10);
//        make.width.equalTo(self.view.mas_width).multipliedBy(0.67);
        make.width.equalTo(self.view).multipliedBy(0.67);
        make.height.mas_greaterThanOrEqualTo(180);
    }];
  
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.boxView);
        make.centerY.equalTo(self.boxView.mas_top);
        make.size.mas_equalTo(self.image.size);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23);
        make.right.mas_equalTo(-23);
        make.top.equalTo(self.imageView.mas_bottom).offset(15);
    }];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.messageLabel.mas_top).offset(-10).priorityLow();
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.btnView.mas_top).offset(-16);
    }];
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0).priorityLow();
        make.left.right.mas_equalTo(0);
        self.btnHeightConstraint = make.height.mas_equalTo(self.actionArray.count>0?45: 0);
    }];
}
-(UIView *)boxView
{
    if (!_boxView) {
        _boxView = [UIView new];
        _boxView.backgroundColor = [UIColor whiteColor];
        _boxView.layer.cornerRadius = 3;
        _boxView.layer.masksToBounds = true;
//        _boxView.clipsToBounds = false;
        [self.view addSubview:_boxView];
    }
    return _boxView;
}
-(UIImageView*)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:self.image];
        [self.view addSubview:_imageView];
    }
    return _imageView;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor colorWithRed:62/255.0 green:62/255.0 blue:64/255.0 alpha:1.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.boxView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel*)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:12];
        _messageLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:184/255.0 alpha:1.0];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [self.boxView addSubview:_messageLabel];
    }
    return _messageLabel;
}
-(UIView*)btnView
{
    if (!_btnView) {
        _btnView = [UIView new];
        [self.boxView addSubview:_btnView];
    }
    return _btnView;
}

-(void)setTitleString:(NSString *)titleString
{
    self.titleLabel.text = titleString;
}
-(void)setAttTitle:(NSAttributedString *)attTitle
{
    self.titleLabel.attributedText = attTitle;
}
-(void)setMessage:(NSString *)message
{
    self.messageLabel.text = message;
}
-(void)setAttMessage:(NSAttributedString *)attMessage
{
    self.messageLabel.attributedText =  attMessage;
}
-(void)setImage:(UIImage *)image
{
    _image = [image copy];
    self.imageView.image = image;
}

-(void)addAction:(KTAlertAction *)action
{
    if (!self.actionArray) {
        self.actionArray = [NSMutableArray new];
    }
    if (action) {
        [self.actionArray addObject:action];
    }

}

-(void)actionBtnEvent:(UIButton*)button
{
    KTAlertAction *action  = self.actionArray[button.tag-1];
    if (action.block) {
        action.block();
    }
    [self dismissViewControllerAnimated:false completion:nil];
}
@end



