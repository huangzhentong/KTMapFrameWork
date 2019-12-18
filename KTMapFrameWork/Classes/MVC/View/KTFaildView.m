//
//  KTFaildView.m
//  AFNetworking
//
//  Created by KT--stc08 on 2019/4/25.
//

#import "KTFaildView.h"

#import "NSString+AddLineSpace.h"
#import "NSBundle+KTRes.h"
#import "UIColor+Hexadecimal.h"
#import "UIImage+Bundle.h"
#import "KTColorHeader.h"

@interface KTFaildView ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *errorLabel;
@end
@implementation KTFaildView

-(instancetype)init
{
    if (self = [super init]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)showError:(NSString *)errorString
{
    self.errorLabel.text = errorString;
}


-(void)setupUI{
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_equalTo(140);
    }];
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.mas_equalTo(25);
        make.top.equalTo(self.imageView.mas_bottom).offset(38);
        make.right.mas_equalTo(-25);
    }];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.errorLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(40);
    }];
    
}
-(UIImageView*)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage getBundleImage:@"default_requesttimedout"];
        [self addSubview:_imageView];
    }
    return _imageView;
}
-(UILabel *)errorLabel
{
    if (!_errorLabel) {
        _errorLabel = [UILabel new];
        _errorLabel.textColor = KTColor_3E3;
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        _errorLabel.numberOfLines = 0;
        _errorLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_errorLabel];
    }
    return _errorLabel;
}
-(UIButton*)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *string = KTLocalizedString(@"Reload");
        NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange strRange = {0,[strAtt length]};
        [strAtt addAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                NSFontAttributeName:[UIFont systemFontOfSize:14],
                                NSForegroundColorAttributeName: KTColor_0072
                                } range:strRange];
        [strAtt addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [_button setAttributedTitle:strAtt forState:UIControlStateNormal];
   
        [self addSubview:_button];
    }
    return _button;
}

@end
