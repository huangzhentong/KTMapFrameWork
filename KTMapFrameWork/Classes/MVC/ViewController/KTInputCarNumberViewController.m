//
//  KTNearParkingPlaceViewController.m
//  KTFindCarSDK
//
//  Created by KT--stc08 on 2019/4/1.
//

#import "KTInputCarNumberViewController.h"
#import "KTNearParkPlaceView.h"
#import "UIImage+Bundle.h"
#import "KTNetWorkService.h"

#import "KTCarInfoViewController.h"
#import "KTInvalidViewController.h"
@interface KTInputCarNumberViewController ()
@property(nonatomic,strong)KTNearParkPlaceView *placeView;
@end

@implementation KTInputCarNumberViewController


-(KTNearParkPlaceView*)placeView
{
    if (!_placeView) {
        _placeView = [KTNearParkPlaceView new];
        [self.view addSubview:_placeView];
    }
    return _placeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.placeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self setupUI];
    
  
}

-(void)bindVM{
    [self.placeView.searchBtn addTarget:self action:@selector(searchBtnEvent) forControlEvents:UIControlEventTouchUpInside];
}

-(void)hintError{
   UIAlertController *alert=  [UIAlertController alertControllerWithTitle:@"未找到车位" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:true completion:nil];
}

-(void)searchBtnEvent
{
    if(self.placeView.parkPlaceTF.text.length > 0)
    {
//        __weak typeof(self) weakSelf = self;
//        KTNetworkClient *client = [[KTNetWorkService shareInstance] requestJSONWithURL:KTFindUsersLocationInfoURL withParameters:@{@"lotId":[KTFindCarManager lotID],@"parkNo":self.placeView.parkPlaceTF.text} withType:@"get"];
//        self.client = client;
//        client.successEvent = ^(id  _Nonnull object) {
//
//        };
//        client.faildEvent = ^(NSError * _Nonnull error) {
//
//        };
//        [client.dataTask resume];
        
//        KTInvalidViewController *viewController = [KTInvalidViewController new];
//        [self.navigationController pushViewController:viewController animated:true];
        
    }
    KTCarInfoViewController *viewController = [KTCarInfoViewController new];
    [self.navigationController pushViewController:viewController animated:true];
}

-(void)setupUI{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage  getBundleImage:@"nav_return_w"];
    [leftBtn setImage:image forState:UIControlStateNormal];
    SEL  selector = NSSelectorFromString(@"backBtnEvent");
    [leftBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(24, CGRectGetHeight( [UIApplication sharedApplication].statusBarFrame), 44, 44);
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 44-image.size.width);
    [self.view addSubview:leftBtn];
    
}
-(void)backBtnEvent
{
    if (self.navigationController.viewControllers.count == 1) {
        [self.navigationController dismissViewControllerAnimated:true completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:true];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = true;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     self.navigationController.navigationBarHidden = false;
}


@end
