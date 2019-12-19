//
//  KTParkPointModel.m
//  Network
//
//  Created by KT--stc08 on 2019/4/3.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "KTParkPointModel.h"

@implementation KTParkPointModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"pointID"  : @"id",
           };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"neighbours" : [self class],
            };
}
-(CGPoint)point
{
   return  CGPointMake(self.x, self.y);
}
@end
