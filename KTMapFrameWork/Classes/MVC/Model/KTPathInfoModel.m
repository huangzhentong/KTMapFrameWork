//
//  KTPathInfoModel.m
//  Network
//
//  Created by KT--stc08 on 2019/4/3.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "KTPathInfoModel.h"

@implementation KTPathInfoModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"beginVerticalPoint":@[@"beginVerticalPoint",@"startPoint"],
             @"endVerticalPoint":@[@"endVerticalPoint",@"targetPoint"],
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pathPoints" : [KTParkPointModel class],
             @"beginVerticalPoint" : [KTParkPointModel class],
             @"endVerticalPoint" : [KTParkPointModel class],
             };
}


@end
