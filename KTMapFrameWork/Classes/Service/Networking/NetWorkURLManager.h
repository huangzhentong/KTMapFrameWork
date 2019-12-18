//
//  NetWorkURLManager.h
//  Network
//
//  Created by KT--stc08 on 2019/4/3.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//根据车场id和车牌号，获取车场蓝牙uuid和车辆停车信息
#define KTGetParkingInfoURL  [[NetWorkURLManager baseURL] stringByAppendingString:@"/app-api/getParkingInfo"]
//App获取找车初始化数据
#define KTGetUserFloorInfoURL  [[NetWorkURLManager baseURL] stringByAppendingString:@"/app-api/getUserFloorInfo"]
//App根据车位号获取坐标
#define KTFindUsersLocationInfoURL  [[NetWorkURLManager baseURL] stringByAppendingString:@"/app-api/findUsersLocationInfo"]
//App获取找车线路
#define KTFindFlastRouteURL  [[NetWorkURLManager baseURL] stringByAppendingString:@"/app-api/findFlashRoute"]
//查找车位坐标点
#define KTFindBusNumberPointURL  [[NetWorkURLManager baseURL] stringByAppendingString:@"/service/find_car/findBusNumberPoint"]

#define KTCollectIBeaconsURL  [[NetWorkURLManager baseURL] stringByAppendingString:@"/debug/collect/ibeacon"]

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkURLManager : NSObject
+(void)setBaseURL:(NSString*)baseURL;
+(NSString*)baseURL;
//拼接URL
+(NSString*)appendURL:(NSString*)appendURL
        withParameter:(NSDictionary*)dic;

//根据车场id和车牌号，获取车场蓝牙uuid和车辆停车信息
+(NSString*)getParkingInfoURL:(NSString*)lotID
              withCarPlateNum:(NSString*)carNumber;


//App获取找车初始化数据
//用户打开找车功能，并开启蓝牙信号，App采集一部分蓝牙信号，传入服务端取回用户所在楼层和关键点信息
+(NSString*)getUserFloorInfoURL:(NSString*)lotID withiBeacons:(NSArray*)iBeacons;

//App根据车位号获取坐标
//根据用户所在位置和停车位置，获取最佳路线（坐标数组）
+(NSString*)findUsersLocationInfoURL:(NSString*)lotID
                          withParkNo:(NSString*)parkNo;


//App获取找车线路
//根据用户所在位置和停车位置，获取最佳路线（坐标数组）
+(NSString*)findFlastRouteURL:(NSString*)lotID
                  withFloorID:(NSString*)flootID
               withBeginPoint:(CGPoint)beginPoint
                 withEndPoint:(CGPoint)endPoint;
@end

NS_ASSUME_NONNULL_END
