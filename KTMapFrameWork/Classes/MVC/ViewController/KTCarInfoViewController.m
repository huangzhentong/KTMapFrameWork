//
//  KTCarInfoViewController.m
//  KTFindCarSDK
//
//  Created by KT--stc08 on 2019/3/29.
//

#import "KTCarInfoViewController.h"
#import "KTCarInfoView.h"

#import "UIViewController+BackBarItem.h"


@interface KTCarInfoViewController ()
@property(nonatomic,strong)KTCarInfoView *carInfoView;
@end

@implementation KTCarInfoViewController

-(KTCarInfoView*)carInfoView{
    if (!_carInfoView) {
        _carInfoView = [[KTCarInfoView alloc] initWithFrame:self.view.bounds];
       [self.view addSubview:self.carInfoView];
    }
    return _carInfoView;
}
-(void)reloadRequest
{

    [super reloadRequest];
}
- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = @"查询结果";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.carInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];

    [self addBackBarBtn:@"" withSelector:@selector(backBtnEvent)];

    
    [self.carInfoView.pathBtn addTarget:self action:@selector(pushToNearParkPlaceViewController) forControlEvents:UIControlEventTouchUpInside];

    self.carInfoView.pathBtn.enabled = false;
   
}

-(void)pushToNearParkPlaceViewController
{
    
}

-(void)backBtnEvent
{

    [self.navigationController popViewControllerAnimated:true];
}

-(void)dealloc
{
    NSLog(@"dealloc");
}

@end
