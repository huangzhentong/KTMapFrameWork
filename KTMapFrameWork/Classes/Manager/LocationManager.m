//
//  LocationManager.m
//  OperationalSystem
//
//  Created by KT--stc08 on 2019/3/11.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "LocationManager.h"
#import "CoordinateTransformation.h"
#import <CoreLocation/CoreLocation.h>
NSString *const latitude = @"latitude";

NSString *const longitude = @"longitude";
@interface LocationManager ()<CLLocationManagerDelegate>
@property (nonatomic,strong)CLLocationManager *locationmanager;//定位服务
@property (nonatomic,strong)LocationBlock block;//定位服务

@end

@implementation LocationManager



+(instancetype)shareInstance
{
    static LocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [LocationManager new];
    });
    return manager;
}
+(void)startLocationWithblock:(LocationBlock)block
{
    [LocationManager shareInstance].block = block;
    [[LocationManager shareInstance].locationmanager startUpdatingLocation];
}

+(void)startLocation
{
    [[LocationManager shareInstance].locationmanager startUpdatingLocation];
}
+(void)stopLocation
{
    [[LocationManager shareInstance].locationmanager stopUpdatingLocation];
    [LocationManager shareInstance].block = nil;
}

+(NSDictionary*)locationData
{
    return  [LocationManager shareInstance].locationDic;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self addListen];
    }
    return self;
}

-(void)addListen{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLocation) name:UIApplicationWillEnterForegroundNotification object:nil];
}

-(CLLocationManager*)locationmanager
{
    if (!_locationmanager) {
        _locationmanager = [[CLLocationManager alloc]init];
        _locationmanager.delegate = self;
        [_locationmanager requestAlwaysAuthorization];
        [_locationmanager requestWhenInUseAuthorization];
        _locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationmanager.distanceFilter = kCLDistanceFilterNone;
    }
    return _locationmanager;
}

-(void)getLocation
{
    //判断定位功能是否打开
    
    switch (CLLocationManager.authorizationStatus) {
            
        case kCLAuthorizationStatusNotDetermined:
        {
            [self.locationmanager requestWhenInUseAuthorization];
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways :
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            [self.locationmanager requestWhenInUseAuthorization];
        }
            break;
            
        default:
            [self alertShow];
            break;
    }
    
}


-(void)alertShow
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在iPhone的\"设置-隐私-定位服务\"中允许使用定位。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *setting = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:nil completionHandler:^(BOOL success) {
                
            }];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:setting];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertVC animated:true completion:nil];
}

#pragma mark CoreLocation delegate (定位失败)
//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //设置提示提醒用户打开定位服务
    [self alertShow];
    [self.locationmanager stopUpdatingLocation];
    _locationDic = nil;
    _lastDate = nil;
    if (self.block) {
        self.block(0, 0,error);
    }
}
#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [self.locationmanager stopUpdatingLocation];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
  
    CLLocationCoordinate2D coor  = currentLocation.coordinate;
   
    CLLocationCoordinate2D newCoor = [CoordinateTransformation transformFromWGSToGCJ:coor];
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    if (self.block) {
        self.block(newCoor.latitude, newCoor.longitude,nil);
        self.block = nil;
    }
    _locationDic = @{latitude:[NSString stringWithFormat:@"%lf",newCoor.latitude],
                         longitude:[NSString stringWithFormat:@"%lf",newCoor.longitude]
                         };
    _lastDate = [NSDate date];
    //反地理编码
    
    
}
@end
