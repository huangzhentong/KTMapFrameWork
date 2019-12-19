//
//  KTCarInfoViewController.m
//  KTFindCarSDK
//
//  Created by KT--stc08 on 2019/3/29.
//

#import "KTCarInfoViewController.h"
#import "KTCarInfoView.h"
#import "NetWorkURLManager.h"
#import "KTNetWorkService.h"
#import "UIViewController+BackBarItem.h"
#import "KTParkDetailModel.h"
#import "KTCarInfoModel.h"
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

-(void)reloadRequest
{
    self.client =  [[KTNetWorkService shareInstance] requestJSONWithURL:KTGetParkingInfoURL withParameters:@{@"lotId":self.lotID,@"carPlateNum":self.carNumber} withType:@"get"];
    [super reloadRequest];
}

-(void)requestSuccess:(id)x
{
    [super requestSuccess:x];
    KTParkDetailModel *detailModel = nil;
    detailModel = [KTParkDetailModel KT_modelWithJSON:x];
    KTCarInfoModel * model = [KTCarInfoModel new];
    model.imageURL = detailModel.parkInfo.imgUrl;
    model.title = self.carNumber;
    model.rightArray=@[detailModel.parkInfo.floorInfo.floorName,
                       detailModel.parkInfo.areaName,
                       detailModel.parkInfo.parkNo];
    [self.carInfoView updateDataSource:model];
    self.carInfoView.pathBtn.enabled = true;
    
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}
-(void)requestFaild:(NSError *)error
{
//    if (error.code>=3000) {
    [super requestFaild:error];
    
}

-(void)pushToNearParkPlaceViewController
{
//    KTDMapViewController *viewController =[[KTDMapViewController alloc] initWithCode:@"hyjg" withURL:@"https://test.seeklane.com/test/hyjg/index.html"];
//    [self.navigationController pushViewController:viewController animated:true];
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
