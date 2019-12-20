//
//  KTNearParkPlaceView.m
//  KTFindCarSDK
//
//  Created by KT--stc08 on 2019/4/1.
//

#import "KTNearParkPlaceView.h"

#import "NSString+AddLineSpace.h"
#import "KTColorHeader.h"
#import "UIImage+Bundle.h"
#import "HTCKeyboard.h"
#import "UITextField+MaxLength.h"
@interface KTNearParkPlaceView ()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *messageLabel;

@property(nonatomic,strong)UILabel *hintLabel;
@property(nonatomic,strong)UILabel *hintLabel2;

@end

@implementation KTNearParkPlaceView


-(UIView*)headerView
{
    if(!_headerView)
    {
        _headerView = [UIView new];
        _headerView.backgroundColor = KTColor_194;
        [self addSubview:_headerView];
    }
    return _headerView;
}

-(UILabel*)messageLabel
{
    if(!_messageLabel)
    {
        _messageLabel = [UILabel new];
        NSString *line1 = @"反向寻车";
        NSString *line2 = @"输入车牌号导航至停放地点";
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",line1,line2]];
        
        [att addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:27],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, line1.length)];
        [att addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15],NSForegroundColorAttributeName:KTColor_BBC} range:NSMakeRange(line1.length+1, line2.length)];
        _messageLabel.numberOfLines = 0;
        _messageLabel.attributedText = att;
        [self.headerView addSubview:_messageLabel];
    }
    return _messageLabel;
}
-(UILabel*)hintLabel
{
    if(!_hintLabel)
    {
        _hintLabel = [UILabel new];
        _hintLabel.text = @"请输入车牌号";
        _hintLabel.font = [UIFont systemFontOfSize:17];
        _hintLabel.textColor =KTColor_3E3;
        [self addSubview:_hintLabel];
    }
    return _hintLabel;
}
-(UILabel*)hintLabel2
{
    if(!_hintLabel2)
    {
        _hintLabel2 = [UILabel new];
        _hintLabel2.text = @"温馨提示：请打开手机蓝牙以支持找车功能";
        _hintLabel2.font = [UIFont systemFontOfSize:14];
        _hintLabel2.textColor =KTColor_A6A;
        [self addSubview:_hintLabel2];
    }
    return _hintLabel2;
}


-(UITextField*)parkPlaceTF
{
    if (!_parkPlaceTF) {
        _parkPlaceTF = [UITextField new];
        _parkPlaceTF.backgroundColor = KTColor_F348;
        _parkPlaceTF.layer.cornerRadius = 3;
        _parkPlaceTF.layer.masksToBounds = true;
        _parkPlaceTF.delegate = self;
        _parkPlaceTF.keyboardType = UIKeyboardTypeASCIICapable;
        [self addSubview:_parkPlaceTF];
        _parkPlaceTF.maxLenght = 8;
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:KTColor_A6A }];
        _parkPlaceTF.textAlignment = NSTextAlignmentCenter;
        _parkPlaceTF.attributedPlaceholder = placeHolder;
         _parkPlaceTF.inputView = [[HTCKeyboard alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 225)];
    }
    return _parkPlaceTF;
}
-(UIButton*)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setTitle:@"查询" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _searchBtn.backgroundColor = KTBtnNormalColor;
        _searchBtn.layer.cornerRadius = 5;
        [self addSubview:_searchBtn];
    }
    return _searchBtn;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
   
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.equalTo(self.mas_width).multipliedBy(0.8);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.top.mas_equalTo(17+44+20);
        make.right.mas_equalTo(-24);
    }];
    UIImageView *gridImageView = [[UIImageView alloc] initWithImage:[UIImage getKTBundleImage:@"home_topbg_grid"]];
    [self.headerView addSubview:gridImageView];
    
    UIImageView *pathImageView = [[UIImageView alloc] initWithImage:[UIImage getKTBundleImage:@"home_topbg_polyline"]];
    [self.headerView addSubview:pathImageView];
    
    [gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.bottom.mas_equalTo(0);
        make.height.equalTo(gridImageView.mas_width).multipliedBy(0.43);
    }];
    [pathImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.height.top.equalTo(gridImageView);
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        
        make.top.equalTo(self.headerView.mas_bottom).offset(24);
    }];
    [self.parkPlaceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hintLabel);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(41);
        make.top.equalTo(self.hintLabel.mas_bottom).offset(18);
    }];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.parkPlaceTF);
        make.height.mas_equalTo(43);
        make.top.equalTo(self.parkPlaceTF.mas_bottom).offset(24);
    }];
    
    [self.hintLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-45);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

@end
