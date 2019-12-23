//
//  KTCarInfoView.m
//  KTFindCarSDK
//
//  Created by KT--stc08 on 2019/3/29.
//

#import "KTCarInfoView.h"
#import "NSString+AddLineSpace.h"
#import "UIImage+KTNSBundle.h"
#import "KTColorHeader.h"
#import "UIImageView+ImageWithURL.h"
@interface KTCarInfoView ()
@property(nonatomic,strong)UIView *carBackgroundView;
@property(nonatomic,strong)UIImageView *carImageView;
@property(nonatomic,strong)UIView *infoView;
@property(nonatomic,strong)UILabel *carLabel;
@property(nonatomic,strong)UILabel *leftLabel;
@property(nonatomic,strong)UILabel *rightLabel;
@end
@implementation KTCarInfoView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(UIView*)carBackgroundView
{
    if (!_carBackgroundView) {
        _carBackgroundView = [self createBackGroundView];
    }
    return _carBackgroundView;
}

-(UIImageView*)carImageView
{
    if (!_carImageView) {
        _carImageView = [[UIImageView alloc] initWithImage:[UIImage getKTBundleImage:@""]];
        _carImageView.backgroundColor = KTColor_ECE;
        [self.carBackgroundView addSubview:_carImageView];
    }
    return _carImageView;
}

-(UIView*)infoView
{
    if (!_infoView) {
        _infoView = [self createBackGroundView];
    }
    return _infoView;
}

-(UILabel*)carLabel
{
    if (!_carLabel) {
        _carLabel = [UILabel new];
        _carLabel.textColor = KTColor_3E3;
        _carLabel.font = [UIFont systemFontOfSize:21];
        [self.infoView addSubview:_carLabel];
    }
    return _carLabel;
}

-(UILabel*)leftLabel
{
    if(!_leftLabel)
    {
        _leftLabel = [UILabel new];
        _leftLabel.numberOfLines = 0;
        _leftLabel.font = [UIFont systemFontOfSize:13];
        _leftLabel.textColor = KTColor_959;
        [self.infoView addSubview:_leftLabel];
    }
    return _leftLabel;
}
-(UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.numberOfLines = 0;
        _rightLabel.font = [UIFont systemFontOfSize:18];
        _rightLabel.textColor = KTColor_3E3;
        [self.infoView addSubview:_rightLabel];
    }
    return _rightLabel;
}

-(UIButton*)pathBtn
{
    if (!_pathBtn) {
        _pathBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pathBtn setTitle:@"开始" forState:UIControlStateNormal];
        [_pathBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _pathBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_pathBtn setBackgroundColor:KTBtnNormalColor];
        [self addSubview:_pathBtn];
    }
    return _pathBtn;
}

-(UIView*)createBackGroundView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
//    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowColor = [UIColor colorWithRed:230/255.0 green:231/255.0 blue:236/255.0 alpha:0.8].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,3);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 10;
    view.layer.cornerRadius = 2;
//    view.layer.masksToBounds = true;
    [self addSubview:view];
    return view;
}
-(void)setupUI{
    [self.carBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(26));
        make.left.equalTo(@(24));
        make.right.equalTo(@(-24));
        make.height.equalTo(self.carBackgroundView.mas_width).multipliedBy(0.61);
    }];
    [self.carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(8, 10, 8, 10));
    }];
    
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.carBackgroundView);
        make.top.equalTo(self.carBackgroundView.mas_bottom).offset(17);

    }];
    

    [self.carLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(23));
        make.top.equalTo(@(21));
        make.right.equalTo(@(-23));
    }];
    [self.leftLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.rightLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carLabel);
        make.top.equalTo(self.carLabel.mas_bottom).offset(23);
        make.bottom.equalTo(self.infoView.mas_bottom).offset(-20);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-23));
        make.centerY.equalTo(self.leftLabel.mas_centerY);
        make.left.equalTo(self.leftLabel.mas_right).offset(10);
        make.height.equalTo(self.leftLabel.mas_height);
    }];
    
//    NSArray *arrar = @[self.pathBtn,self.ARBtn];
////    NSArray *arrar = @[self.pathBtn,self.ARBtn,self.bluBtn];
//    [arrar mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
//    [arrar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(47);
//        make.bottom.mas_equalTo(0);
//    }];
    
    [self.pathBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(47);
        make.width.equalTo(self);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.mas_safeAreaLayoutGuideBottom);
        }
        else{
            make.bottom.mas_equalTo(0);
        }
    }];

    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    [self setupUI];
   
}

-(void)updateDataSource:(id<KTCarInfoDataSource>)object
{
   
    self.carLabel.text = object.title;
    NSArray *leftTextArray = object.leftArray;
    NSArray *rightTextArray = object.rightArray;
    NSMutableString *string = [NSMutableString string];
    

    [self.carImageView setImageWithURL:[NSURL URLWithString:object.imageURL]];
    
    
    
     self.rightLabel.attributedText = [[rightTextArray componentsJoinedByString:@"\n"] addLineSpacing:22 withTextAlignment:NSTextAlignmentRight];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < rightTextArray.count; i++) {
            NSString *text = rightTextArray[i];
            [string appendString:leftTextArray[i]];
            if (i < rightTextArray.count-1) {
                [string appendString: [self newlineWithCount:[self textLineCountWithLabel:self.rightLabel withText:text]]];
            }
        }
        
        self.leftLabel.attributedText = [string addLineSpacing:25];
       
    });
    
   
}

-(NSString*)newlineWithCount:(NSInteger)count
{
    NSString *string = @"";
    for (int i = 0; i < count ; i++) {
        string = [string stringByAppendingString:@"\n"];
    }
    return string;
}

-(NSInteger)textLineCountWithLabel:(UILabel*)label withText:(NSString*)text
{
    if(text == nil || text == [NSNull null])
    {
        return 1;
    }
    UIFont *font = label.font;
    CGRect rect =  [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(label.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    
    
    CGSize size =  rect.size;
    NSInteger count = (size.height) /font.lineHeight;
    return count;
}

@end
