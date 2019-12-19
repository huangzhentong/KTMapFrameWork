//
//  KTIBeaconModel.m
//  Network
//
//  Created by KT--stc08 on 2019/4/3.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "KTIBeaconModel.h"

@implementation KTIBeaconModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"x": @[@"x", @"PosX"],
             @"y": @[@"y", @"PosY"],
             @"UUID": @[@"UUID", @"uuid"],
             @"major":@[@"Major",@"major"],
             @"minor":@[@"Minor",@"minor"],
             };
}
-(NSString*)ibeaconID
{
    return [NSString stringWithFormat:@"%@%@",self.major,self.minor];
}
@end
