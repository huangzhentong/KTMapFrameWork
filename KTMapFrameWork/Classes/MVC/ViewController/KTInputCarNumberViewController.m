//
//  KTNearParkingPlaceViewController.m
//  KTFindCarSDK
//
//  Created by KT--stc08 on 2019/4/1.
//

#import "KTInputCarNumberViewController.h"
#import "KTNearParkPlaceView.h"
#import "UIImage+KTNSBundle.h"
#import "KTNetWorkService.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "KTCarInfoViewController.h"
#import "KTInvalidViewController.h"
#import "NetWorkURLManager.h"
#import "KTGlobalModel.h"
#import "KTParkDetailModel.h"
@interface KTInputCarNumberViewController ()
@property(nonatomic,strong)KTNearParkPlaceView *placeView;
@property(nonatomic,strong)KTParkDetailModel *detailModel;
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
    NSString * code = @"hyjg";
    NSString * url = @"https://test.seeklane.com/test/hyjg/index.html";
       Class aMapClass = NSClassFromString(@"KTDMapManager");
          if (aMapClass == nil) {
              NSLog(@"未集成DMap");
              return;
          }
          SEL defaultServiceSel = NSSelectorFromString(@"shareInstance");
          if ([aMapClass respondsToSelector:defaultServiceSel]) {
              id (*sharedServices)(id,SEL) = (id (*) (id,SEL))objc_msgSend;
              id aMap =  sharedServices(aMapClass,defaultServiceSel);
              [aMap setValue:code forKey:@"code"];
              [aMap setValue:url forKey:@"url"];
          }
     
  
}

-(void)bindVM{
    [self.placeView.searchBtn addTarget:self action:@selector(searchBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.placeView.pushSDK addTarget:self action:@selector(pushToSDK) forControlEvents:UIControlEventTouchUpInside];
}
-(void)pushToSDK{
    [KTGlobalModel shareInstance].park = nil;
    [KTGlobalModel shareInstance].floor = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PushToDMapViewController" object:@{@"viewController":self}];
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
        __weak typeof(self) weakSelf = self;
        NSString *carNumber = self.placeView.parkPlaceTF.text;
      
        KTNetworkClient *client = [[KTNetWorkService shareInstance] requestJSONWithURL:[NetWorkURLManager getParkingFromCarNumber] withParameters:@{@"carPlateNum":carNumber} withType:@"get"];
        self.client = client;
        client.successEvent = ^(id  _Nonnull object) {
            
          KTParkDetailModel *detailModel = [KTParkDetailModel KT_modelWithJSON:object];
            weakSelf.detailModel = detailModel;
            NSString *lotID = detailModel.lotId;
            if (lotID) {
                KTCarInfoViewController *viewController = [KTCarInfoViewController new];
                viewController.lotID =  lotID;
                viewController.carNumber = carNumber;
                KTCarInfoModel * model = [KTCarInfoModel new];
                   model.imageURL = detailModel.parkInfo.imgUrl;
                   model.title = carNumber;
                   model.rightArray=@[detailModel.parkInfo.floorInfo.floorName,
                                      detailModel.parkInfo.parkNo];
                [KTGlobalModel shareInstance].floor =detailModel.parkInfo.floorInfo.floorName;
                viewController.model = model;
                [KTGlobalModel shareInstance].park =detailModel.parkInfo.parkNo;
                [weakSelf.navigationController pushViewController:viewController animated:true];
            }
        };
        client.faildEvent = ^(NSError * _Nonnull error) {
            if(error.code == 5000)
            {
                KTInvalidViewController *viewController = [KTInvalidViewController new];
                [weakSelf.navigationController pushViewController:viewController animated:true];
            }
        };
        [client.dataTask resume];
  
    }
    [self.placeView.parkPlaceTF resignFirstResponder];
    
   
}

-(void)setupUI{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage  getKTBundleImage:@"nav_return_w"];
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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KTSDKClose" object:nil];
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
