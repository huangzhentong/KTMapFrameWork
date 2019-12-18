//
//  CLBeacon+ToDic.m
//  cocore
//
//  Created by KT--stc08 on 2019/4/11.
//

#import "CLBeacon+ToDic.h"
#import <objc/runtime.h>
@implementation CLBeacon (ToDic)



-(void)setX:(double)x
{
    objc_setAssociatedObject(self, @selector(x), @(x), OBJC_ASSOCIATION_ASSIGN);
}
-(double)x
{
    return  [objc_getAssociatedObject(self, @selector(x)) doubleValue];
}
-(void)setY:(double)y
{
    objc_setAssociatedObject(self, @selector(y), @(y), OBJC_ASSOCIATION_ASSIGN);
}
-(double)y
{
    return  [objc_getAssociatedObject(self, @selector(y)) doubleValue];
}

-(NSDictionary*)dict
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"minor"] = [self.minor stringValue] ;
    dic[@"major"] = [self.major stringValue];
    dic[@"rssi"] = [NSString stringWithFormat:@"%li",self.rssi];
    dic[@"proximity"] = [NSString stringWithFormat:@"%li",self.proximity];
    dic[@"accuracy"] =  [NSString stringWithFormat:@"%li",self.accuracy];
    dic[@"uuid"] = [self.proximityUUID UUIDString];
    dic[@"x"] = @(self.x);
    dic[@"y"] = @(self.y);
    return dic;
}
-(NSString*)beaconKey
{
    return [NSString stringWithFormat:@"%@%@%@",[self.proximityUUID UUIDString],self.major,self.minor];
}
@end
