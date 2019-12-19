//
//  LocationManager.h
//  OperationalSystem
//
//  Created by KT--stc08 on 2019/3/11.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString * _Nullable const  latitude;
extern NSString *_Nullable const  longitude;

typedef void(^LocationBlock)(CGFloat lat,CGFloat lon,NSError * _Nonnull error);

NS_ASSUME_NONNULL_BEGIN

@interface LocationManager : NSObject
@property(nonatomic,copy,nullable,readonly)NSDictionary *locationDic;
@property(nonatomic,copy,nullable,readonly)NSDate *lastDate;
+(instancetype)shareInstance;

+(NSDictionary*)locationData;                               //获取定位
+(void)startLocation;
+(void)startLocationWithblock:(LocationBlock)block;
+(void)stopLocation;

@end

NS_ASSUME_NONNULL_END
