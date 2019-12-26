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

#import "LocationManager.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "CoordinateTransformation.h"
#import "KTLocationDataModel.h"
#import "KTGlobalModel.h"
#import "LoadingManager.h"
@interface KTCarInfoViewController ()
@property(nonatomic,strong)KTCarInfoView *carInfoView;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *url;
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
    
 
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadRequest];
    });
    
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
                       detailModel.parkInfo.parkNo];
    [self.carInfoView updateDataSource:model];
    
    self.carInfoView.pathBtn.enabled = true; 
    self.code = @"hyjg";
    self.url = @"https://test.seeklane.com/test/hyjg/index.html";
    [KTGlobalModel shareInstance].floor =detailModel.parkInfo.floorInfo.floorName;
    [KTGlobalModel shareInstance].park =detailModel.parkInfo.parkNo;
    Class aMapClass = NSClassFromString(@"KTDMapManager");
    if (aMapClass == nil) {
        NSLog(@"未集成DMap");
        return;
    }
    SEL defaultServiceSel = NSSelectorFromString(@"shareInstance");
    if ([aMapClass respondsToSelector:defaultServiceSel]) {
        id (*sharedServices)(id,SEL) = (id (*) (id,SEL))objc_msgSend;
        id aMap =  sharedServices(aMapClass,defaultServiceSel);
        
        
        void(*initWithDMapWithCode)(id,SEL,NSString *,NSString *) = (id(*)(id,SEL,NSString *code,NSString *url))objc_msgSend;
        initWithDMapWithCode(aMap,NSSelectorFromString(@"initWithDMapWithCode:url:"),self.code,self.url);
    }
    
    
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}
-(void)requestFaild:(NSError *)error
{
    [super requestFaild:error];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)pushToNearParkPlaceViewController
{
    
    Class aMapClass = NSClassFromString(@"KTDMapManager");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DMapLocationStatusChange" object:nil];
    [self inputAMapSDK];
    if (aMapClass == nil) {
        NSLog(@"未集成DMap");
        return;
    }
    SEL defaultServiceSel = NSSelectorFromString(@"shareInstance");
    if ([aMapClass respondsToSelector:defaultServiceSel]) {
        id (*sharedServices)(id,SEL) = (id (*) (id,SEL))objc_msgSend;
        id aMap =  sharedServices(aMapClass,defaultServiceSel);
        NSInteger status =  [[aMap valueForKey:@"locateState"] integerValue];
        if (status == 0) {
            //进入室入定位
            [self inputDMapSDK];
        }
        else if (status != -1)
        {
            //进入高德定位
            
            [self inputAMapSDK];
        }
        else if (status == -1)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initSDKSuccess:) name:@"DMapLocationStatusChange" object:nil];
            [LoadingManager showLoading:@"定位中..."];
        }
    }
  
}
-(void)initSDKSuccess:(NSNotification*)notification
{
    if( notification.object)
    {
        [LoadingManager showSuccess:@"定位完成"];
    }
}

//进入室入SDK
-(void)inputDMapSDK
{
     [[NSNotificationCenter defaultCenter] postNotificationName:@"PushToDMapViewController" object:@{@"viewController":self}];
}
//进入高德SDK
-(void)inputAMapSDK
{
    
    __weak typeof(self) weakSelf = self;
    [LoadingManager showLoading:@"定位中..."];
    [LocationManager startLocationWithblock:^(CGFloat lat, CGFloat lon, NSError * _Nonnull error) {
        
        if (error) {
            [LoadingManager showError:[NSError errorWithDomain:@"定位失败" code:5000 userInfo:nil]];
            return ;
        }
        
       CLLocationCoordinate2D coordinte = [CoordinateTransformation transformFromWGSToGCJ:CLLocationCoordinate2DMake(lat, lon)];
        
        CGFloat latitude = 24.27;
        CGFloat longitude = 118.06;
        KTLocationPointModel *lostModel = nil;
        NSArray *array = [KTLocationDataModel initWithLoactionData];
        for (KTLocationDataModel * model in array) {
            if ([model.lotId isEqualToString:weakSelf.lotID]) {
                CGFloat dis = 999999999999999999;
                for (KTLocationPointModel * pointModel in model.lotPoint) {
                    
                    CGFloat dis2 = [CoordinateTransformation gps2m:pointModel.latitude _y1:pointModel.longitude _x2:coordinte.latitude _y2:coordinte.longitude];
                  
                    if (dis2<dis) {
                        dis = dis2;
                        lostModel = pointModel;
                    }
                }
            }
        }
        
        if (lostModel) {
            longitude = lostModel.longitude;
            latitude = lostModel.latitude;
        }
        [LoadingManager dismiss];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToWalkViewController" object:@{@"viewController":self,@"long":@(longitude),@"lat":@(latitude)}];
        
    }];
    
   
}

-(void)backBtnEvent
{

    [self.navigationController popViewControllerAnimated:true];
}

-(void)dealloc
{
//    NSLog(@"dealloc");
}

@end
