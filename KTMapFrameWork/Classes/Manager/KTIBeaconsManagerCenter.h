//
//  KTIBeaconsManagerCenter.h
//  cocore
//
//  Created by KT--stc08 on 2019/4/9.
//

#import <Foundation/Foundation.h>

//value 为array
typedef void(^iBeaconsUpdateData)(NSDictionary * _Nonnull dic);

NS_ASSUME_NONNULL_BEGIN
//iBeacon管理中心
@interface KTIBeaconsManagerCenter : NSObject
+(instancetype)shareInstance;

//开始请求

+(BOOL)locationServicesEnabled;
//定位服务
+(void)locationServiceAlert;
//
+(BOOL)startRangingBeacons:(iBeaconsUpdateData)updateBlock;
//结束
+(void)stopRangingBeacons;
@end

NS_ASSUME_NONNULL_END
