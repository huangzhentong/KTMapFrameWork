//
//  CoordinateTransformation.h
//  OperationalSystem
//
//  Created by KT--stc08 on 2019/5/28.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN
//坐标系转换
@interface CoordinateTransformation : NSObject
//将地球坐标转换成高德坐标
// 将WGS-84转为GCJ-02(火星坐标)
// 转GCJ-02
+ (CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgs;


+(double) gps2m:(double)x1 _y1:(double)y1 _x2:(double)x2 _y2:(double)y2;
@end

NS_ASSUME_NONNULL_END
