//
//  KTBaseModel.m
//  KOS-Objc
//
//  Created by KT--stc08 on 2018/7/12.
//  Copyright © 2018年 KT--stc08. All rights reserved.
//

#import "KTBaseModel.h"
//#import <NSObject+YYModel.h>
@implementation KTBaseModel
-(instancetype)copyWithZone:(NSZone *)zone
{
    return [self KT_modelCopy];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self KT_modelInitWithCoder:aDecoder];
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [self KT_modelEncodeWithCoder:aCoder];
}
-(NSString*)description
{
    return [self KT_modelDescription];
}
@end
