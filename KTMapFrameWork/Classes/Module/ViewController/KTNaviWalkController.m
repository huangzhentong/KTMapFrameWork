//
//  ViewController.m
//  MapText
//
//  Created by KT--stc08 on 2019/12/17.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "KTNaviWalkController.h"
#import <MapKit/MapKit.h>
#import "KTDMapViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import "SpeechSynthesizer.h"
@interface KTNaviWalkController ()<AMapNaviWalkManagerDelegate,AMapNaviWalkViewDelegate>
@property(nonatomic,strong)AMapNaviWalkView *driveView;
@property(nonatomic,strong)AMapNaviPoint *endPoint;
@property(nonatomic,strong)AMapNaviWalkManager *walkManager;
@end

@implementation KTNaviWalkController



-(instancetype)initWithEndLatitude:(CGFloat)latitude longitude:(CGFloat)longitude{
    if( self = [super initWithNibName:nil bundle:nil])
    {
        self.endPoint = [AMapNaviPoint locationWithLatitude:latitude longitude:longitude];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [AMapServices sharedServices].apiKey = @"745dc31cded658ccfedfdc33684a75eb";
    [AMapServices sharedServices].enableHTTPS = YES;
    
    if([AMapServices sharedServices].apiKey.length < 1)
    {
        NSLog(@"请设置高德的APIKey");
    }
    [self initDriveView];
    [self initWalkManager];
    
    if(!self.endPoint)
        [self initProperties];
    [self.walkManager calculateWalkRouteWithEndPoints:@[self.endPoint]];
   
}

- (void)initDriveView
{
    if (self.driveView == nil)
    {
      
        self.driveView = [[AMapNaviWalkView alloc] initWithFrame:self.view.bounds];
        self.driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.driveView setDelegate:self];
        
        [self.view addSubview:self.driveView];
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
        [self.walkManager addDataRepresentative:self.driveView];
    }
}



- (void)walkManagerOnCalculateRouteSuccess:(AMapNaviWalkManager *)walkManager
{
    NSLog(@"显示路径或开启导航");
    
    //显示路径或开启导航
    BOOL isSuccess = [self.walkManager startEmulatorNavi];
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
     [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
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
    [self.walkManager stopNavi];
    [self.walkManager removeDataRepresentative:self.driveView];
    [self.walkManager setDelegate:nil];
}
@end
