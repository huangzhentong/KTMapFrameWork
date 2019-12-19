//
//  KTIBeaconsManagerCenter.m
//  cocore
//
//  Created by KT--stc08 on 2019/4/9.
//

#import "AIBBeaconRegionAny.h"
#import "AIBUtils.h"
#import <CoreLocation/CoreLocation.h>
#import "KTIBeaconsManagerCenter.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "KTAlertViewController.h"
#import "NSBundle+KTRes.h"
#import "UIImage+Bundle.h"
#import "UIViewController+GetViewController.h"


@interface KTIBeaconsManagerCenter()<CLLocationManagerDelegate,CBCentralManagerDelegate>
@property(nonatomic, strong) CLLocationManager* locationManager;
@property(nonatomic, strong) NSArray*            listUUID;
@property(nonatomic, strong) NSDictionary*        beaconsDict;
@property(nonatomic, strong) CBCentralManager *centralManager;
@property(nonatomic, strong) AIBBeaconRegionAny *beaconRegionAny;
@property(nonatomic, strong) iBeaconsUpdateData updateBlock;


@end

@implementation KTIBeaconsManagerCenter


+(void)load
{
    [self shareInstance];
}

+(instancetype)shareInstance
{
    static KTIBeaconsManagerCenter * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [KTIBeaconsManagerCenter new];
    });
    return manager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;
        
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
        
        self.beaconRegionAny = [[AIBBeaconRegionAny alloc] initWithIdentifier:@"Any"];
        
        
    }
    return self;
}
+(BOOL)locationServicesEnabled
{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {
        
        //定位功能可用
        if([self blueServicesEnabled])
        {
            return true;
        }
        [self blueServiceAlert];
        return false;
       
        
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        //定位不能用
        [self locationServiceAlert];
        return false;
        
    }
    return false;
}


+(BOOL)blueServicesEnabled
{
    if([KTIBeaconsManagerCenter shareInstance].centralManager.state == CBCentralManagerStatePoweredOn)
        return true;
    return false;
}

//定位服务
+(void)locationServiceAlert
{
    KTAlertViewController *alertView = [KTAlertViewController alertViewWithTitle:KTLocalizedString(@"LocationSetting") withImage:[UIImage getBundleImage:@"popbox_prompt_bluetooth"] withMessage:@""];
    KTAlertAction *action = [KTAlertAction actionWithTitle:KTLocalizedString(@"IKnow") withAction:nil];
    [alertView addAction:action];
    KTAlertAction *action2 = [KTAlertAction actionWithTitle:KTLocalizedString(@"GoSetting") withAction:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
    }];
    [alertView addAction:action2];
    UIViewController *view = [UIViewController getCurrentViewController];
    [view presentViewController:alertView animated:true completion:nil];
}
//定位服务
+(void)blueServiceAlert
{
    KTAlertViewController *alertView = [KTAlertViewController alertViewWithTitle:KTLocalizedString(@"kt_warnBluth") withImage:[UIImage getBundleImage:@"popbox_prompt_bluetooth"] withMessage:@""];
    KTAlertAction *action = [KTAlertAction actionWithTitle:KTLocalizedString(@"IKnow") withAction:nil];
    [alertView addAction:action];
//    KTAlertAction *action2 = [KTAlertAction actionWithTitle:KTLocalizedString(@"GoSetting") withAction:^{
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//
//    }];
//    [alertView addAction:action2];
    UIViewController *view = [UIViewController getCurrentViewController];
    [view presentViewController:alertView animated:true completion:nil];
}




-(BOOL)startRangingBeacons:(iBeaconsUpdateData)updateBlock;
{
    self.updateBlock = updateBlock;
    if([KTIBeaconsManagerCenter locationServicesEnabled])
    {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startRangingBeaconsInRegion:self.beaconRegionAny];
        return true;
    }
    return false;
    
   
}


-(void)stopRangingBeacons{
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegionAny];
}
//开始请求
+(BOOL)startRangingBeacons:(iBeaconsUpdateData)updateBlock;
{
    return  [[self shareInstance] startRangingBeacons:updateBlock];
}
//结束
+(void)stopRangingBeacons
{
    [[self shareInstance] stopRangingBeacons];
}


-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    //第一次打开或者每次蓝牙状态改变都会调用这个函数
    if(central.state==CBCentralManagerStatePoweredOn)
    {
        NSLog(@"蓝牙设备开着");
      
    }
    else
    {
        NSLog(@"蓝牙设备关着");

    }
}

#pragma mark -

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"locationManagerDidChangeAuthorizationStatus: %d", status);
    
    [UIAlertController alertControllerWithTitle:@"Authoritzation Status changed"
                                        message:[[NSString alloc] initWithFormat:@"Location Manager did change authorization status to: %d", status]
                                 preferredStyle:UIAlertControllerStyleAlert];
    
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
//    NSLog(@"locationManager:%@ didRangeBeacons:%@ inRegion:%@",manager, beacons, region);
    
    NSMutableArray* listUuid=[[NSMutableArray alloc] init];
    NSMutableDictionary* beaconsDict=[[NSMutableDictionary alloc] init];
    for (CLBeacon* beacon in beacons) {
        NSString* uuid=[beacon.proximityUUID UUIDString];
        NSMutableArray* list=[beaconsDict objectForKey:uuid];
        if (list==nil){
            list=[[NSMutableArray alloc] init];
            [listUuid addObject:uuid];
            [beaconsDict setObject:list forKey:uuid];
        }
        [list addObject:beacon];
    }
    [listUuid sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString* string1=obj1;
        NSString* string2=obj2;
        return [string1 compare:string2];
    }];

    _listUUID=listUuid;
    _beaconsDict=beaconsDict;
    if (self.updateBlock) {
        self.updateBlock(_beaconsDict);
    }
    

}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    NSLog(@"locationManager:%@ rangingBeaconsDidFailForRegion:%@ withError:%@", manager, region, error);
    
    [UIAlertController alertControllerWithTitle:@"Ranging Beacons fail"
                                        message:[[NSString alloc] initWithFormat:@"Ranging beacons fail with error: %@", error]
                                 preferredStyle:UIAlertControllerStyleAlert];
}
@end



///获取存储的蓝牙信号
//+(CLBeacon*)getIbeaconsInfo:(CLBeacon*)beacon;
////存储蓝牙信号
//-(void)saveIbeaconsInfo:(CLBeacon*)beacon;
