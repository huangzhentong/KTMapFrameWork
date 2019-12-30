//
//  ViewController.m
//  MapText
//
//  Created by KT--stc08 on 2019/12/17.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "KTNaviWalkController.h"
#import <MapKit/MapKit.h>
#import <Masonry.h>
#import "KTNotifiction.h"
#import <AMapNaviKit/AMapNaviKit.h>

@interface KTNaviWalkController ()<AMapNaviWalkManagerDelegate,AMapNaviWalkViewDelegate>
@property(nonatomic,strong)AMapNaviWalkView *driveView;
@property(nonatomic,strong)AMapNaviPoint *endPoint;
@property(nonatomic,strong)AMapNaviWalkManager *walkManager;

@property(nonatomic,strong)UIView *endView;

@end

@implementation KTNaviWalkController



-(instancetype)initWithEndLatitude:(CGFloat)latitude longitude:(CGFloat)longitude{
    if( self = [super initWithNibName:nil bundle:nil])
    {
        self.endPoint = [AMapNaviPoint locationWithLatitude:latitude longitude:longitude];
    }
    return self;
}

-(UIView*)endView
{
    if(!_endView)
    {
        _endView = [UIView new];
        _endView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.view addSubview:_endView];
        _endView.frame = self.view.bounds;
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setTitle:@"已到达，切换至室内导航" forState:UIControlStateNormal];
        [closeBtn setBackgroundColor: [UIColor colorWithRed:25/255.0 green:64/255.0 blue:215/255.0 alpha:1.0]];
        closeBtn.layer.cornerRadius = 23.5;
        [_endView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_endView.mas_centerX);
            make.height.mas_equalTo(47);
            make.width.equalTo(_endView.mas_width).multipliedBy(0.7);
            make.bottom.mas_equalTo(-100);
            
        }];
        [closeBtn addTarget:self action:@selector(closeBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _endView;
}


-(void)closeBtnEvent
{
    [self stopNavi];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PushToDMapViewController object:@{@"viewController":self,}];
}
- (void)viewSafeAreaInsetsDidChange
{
//   self.view.safeAreaInsets
}
- (void)viewDidLoad {
    [super viewDidLoad];
     if (@available(iOS 11.0, *)) {
         self.additionalSafeAreaInsets = UIEdgeInsetsMake(10, 0, 0, 34);
     }
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = true;
   
    
//
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if([AMapServices sharedServices].apiKey.length < 1)
    {
        NSLog(@"请设置高德的APIKey");
    }
    [self initDriveView];
    [self initWalkManager];
    
    if(!self.endPoint)
        [self initProperties];
    [self.walkManager calculateWalkRouteWithEndPoints:@[self.endPoint]];
    
    [self addListen];
    
    
}
-(void)addListen{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputInDoor:) name:@"DMapLocationStatusChange" object:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//进入室入
-(void)inputInDoor:(NSNotification*)notification{
    
    NSInteger status = [notification.object integerValue];
    //判断状态是否为0
    if (status == 0) {
        self.endView.hidden = false;
       
    }
    
    
}

- (void)initDriveView
{
    if (self.driveView == nil)
    {
      
        self.driveView = [[AMapNaviWalkView alloc] initWithFrame:self.view.bounds];
        self.driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.driveView setDelegate:self];
        
        
        [self.view addSubview:self.driveView];
        
        [self.driveView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                 make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            } else {
                 make.top.mas_equalTo(0);
                // Fallback on earlier versions
            }
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
                
            } else {
                 make.bottom.mas_equalTo(0);
                // Fallback on earlier versions
            }
            
        }];
        
//        if (@available(iOS 11, *)) {
//
//        } else {
//
//        }
        
    }
}
- (void)initProperties
{
    self.endPoint   = [AMapNaviPoint locationWithLatitude:24.27 longitude:118.06];
}

- (void)initWalkManager
{
    if (self.walkManager == nil)
    {
        self.walkManager = [[AMapNaviWalkManager alloc] init];
        [self.walkManager setDelegate:self];
        self.walkManager.isUseInternalTTS = true;
        [self.walkManager addDataRepresentative:self.driveView];
    }
}

-(void)stopNavi{
    [self.walkManager stopNavi];
    [self.walkManager removeDataRepresentative:self.driveView];
    [self.walkManager setDelegate:nil];
}
#pragma makr -
- (void)walkViewCloseButtonClicked:(AMapNaviWalkView *)walkView
{
    self.navigationController.navigationBarHidden = false;
    [self.navigationController popViewControllerAnimated:true];
}
#pragma mark -

- (void)walkManagerOnCalculateRouteSuccess:(AMapNaviWalkManager *)walkManager
{
    NSLog(@"显示路径或开启导航");
    
    //显示路径或开启导航
    BOOL isSuccess = [self.walkManager startGPSNavi];
    NSLog(@"isSuccess=%i",isSuccess);
    

}
- (void)walkManager:(AMapNaviWalkManager *)walkManager onCalculateRouteFailure:(NSError *)error
{
    NSLog(@"onCalculateRouteFailure:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)walkManager:(AMapNaviWalkManager *)walkManager didStartNavi:(AMapNaviMode)naviMode
{
    NSLog(@"didStartNavi");
}

- (void)walkManagerNeedRecalculateRouteForYaw:(AMapNaviWalkManager *)walkManager
{
    NSLog(@"needRecalculateRouteForYaw");
}

- (void)walkManager:(AMapNaviWalkManager *)walkManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
     
}

- (void)walkManagerDidEndEmulatorNavi:(AMapNaviWalkManager *)walkManager
{
    NSLog(@"didEndEmulatorNavi");
}

- (void)walkManagerOnArrivedDestination:(AMapNaviWalkManager *)walkManager
{
    NSLog(@"onArrivedDestination");
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
