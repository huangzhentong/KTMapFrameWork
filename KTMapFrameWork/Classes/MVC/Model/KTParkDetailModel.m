//
//  KTParkDetailModel.m
//  Network
//
//  Created by KT--stc08 on 2019/4/3.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "KTParkDetailModel.h"

@implementation KTParkDetailModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"parkInfo" : [KTParkInfoModel class],
             @"ibeacons" : [KTIBeaconsInfoModel class],
              @"keyPoints" : [KTParkPointModel class],
             };
}
@end

@implementation KTParkInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"floorInfo": @[@"floorInfo", @"floor",@"carPlaceInfo"],
              @"parkPoint": @[@"parkPoint", @"point"],
             @"parkAddr":@[@"parkAddr",@"addr"],
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"floorInfo" : [KTFloorInfoModel class],
             @"parkPoint":[KTParkPointModel class],
             };
}
@end

@implementation KTIBeaconsInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : [KTIBeaconModel class],
             };
}

@end
