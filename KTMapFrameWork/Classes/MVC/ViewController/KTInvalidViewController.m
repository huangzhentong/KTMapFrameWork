//
//  KTInvalidViewController.m
//  KTMapFrameWork
//
//  Created by KT--stc08 on 2019/12/18.
//

#import "KTInvalidViewController.h"
#import "UIViewController+BackBarItem.h"
#import "UIImage+Bundle.h"

#import "KTColorHeader.h"
@interface KTInvalidViewController ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *label;
@end

@implementation KTInvalidViewController

-(UIImageView*)imageView
{
    if(!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage getBundleImage:@""]];
        [self.view addSubview:_imageView];
        return _imageView;
    }
    return _imageView;
}

-(UILabel*)label
{
    if(!_label)
    {
        _label = [UILabel new];
        _label.text = @"车辆不在场";
        _label.font = [UIFont systemFontOfSize:17];
        _label.textColor =KTColor_A6A;
        [self.view addSubview:_label];
    }
    return _label;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查询结果";
     self.view.backgroundColor = [UIColor whiteColor];
     [self addBackBarBtn:@"" withSelector:@selector(backBtnEvent)];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(100);
        
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView);
        make.top.equalTo(self.imageView.mas_bottom).offset(30);
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
