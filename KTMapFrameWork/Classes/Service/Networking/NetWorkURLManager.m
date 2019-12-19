//
//  NetWorkURLManager.m
//  Network
//
//  Created by KT--stc08 on 2019/4/3.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "NetWorkURLManager.h"

@interface NetWorkURLManager ()
{
    
}
@property(nonatomic,copy)NSString *baseURL;

@end
@implementation NetWorkURLManager
+(instancetype)shareInstance{
    
    static NetWorkURLManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [NetWorkURLManager new];
    });
    return manager;
}
+(void)load
{
    [NetWorkURLManager setBaseURL:KTBaseRequestURL];
}
+(void)setBaseURL:(NSString*)baseURL
{
    [NetWorkURLManager shareInstance].baseURL = baseURL;
}
+(NSString*)baseURL
{
    return [NetWorkURLManager shareInstance].baseURL;
}

+(NSString*)appendURL:(NSString*)appendURL
        withParameter:(NSDictionary*)dic
{
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:[NetWorkURLManager shareInstance].baseURL];
    [mutableString appendFormat:@"%@",appendURL];
    if (dic.count >0) {
        [mutableString appendString:@"?"];
        int i = 0;
        for (NSString *key in dic.allKeys) {
            id object = dic[key];
            if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingSortedKeys error:nil];
                NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                object =string;
            }
            
            
            [mutableString appendFormat:@"%@=%@",key,object];
            if (i < dic.count-1) {
                [mutableString appendString:@"&"];
            }
            i++;
        }
    }

    
    return  [mutableString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
}

//根据车场id和车牌号，获取车场蓝牙uuid和车辆停车信息
+(NSString*)getParkingInfoURL:(NSString*)lotID
              withCarPlateNum:(NSString*)carNumber
{
    return [self appendURL:@"/app-api/getParkingInfo" withParameter:@{@"lotId":lotID,
                                                                      @"carPlateNum":carNumber}];
}

//App获取找车初始化数据
//用户打开找车功能，并开启蓝牙信号，App采集一部分蓝牙信号，传入服务端取回用户所在楼层和关键点信息
+(NSString*)getUserFloorInfoURL:(NSString*)lotID
                   withiBeacons:(NSArray*)iBeacons
{
    return [self appendURL:@"/app-api/getUserFloorInfo" withParameter:@{@"lotId":lotID,
                                                                        @"Ibeacons":iBeacons}];
}

//App根据车位号获取坐标
//根据用户所在位置和停车位置，获取最佳路线（坐标数组）
+(NSString*)findUsersLocationInfoURL:(NSString*)lotID
                          withParkNo:(NSString*)parkNo
{
    return [self appendURL:@"/app-api/findUsersLocationInfo" withParameter:@{@"lotId":lotID,
                                                                             @"parkNo":parkNo}];
}


//App获取找车线路
//根据用户所在位置和停车位置，获取最佳路线（坐标数组）
+(NSString*)findFlastRouteURL:(NSString*)lotID
                  withFloorID:(NSString*)flootID
               withBeginPoint:(CGPoint)beginPoint
                 withEndPoint:(CGPoint)endPoint
{
    return [self appendURL:@"/app-api/findFlashRoute" withParameter:@{@"lotId":lotID,
                                                                      @"floorId":flootID,
                                                                      @"beginPoint":[NSString stringWithFormat:@"{x:%i,y:%i}",(int)beginPoint.x,(int)beginPoint.y],
                                                                      @"tagetPoint":[NSString stringWithFormat:@"{x:%i,y:%i}",(int)endPoint.x,(int)endPoint.y]
                                                                      }];
}

@end
