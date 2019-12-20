//
//  KTGlobalModel.m
//  AFNetworking
//
//  Created by KT--stc08 on 2019/12/20.
//

#import "KTGlobalModel.h"

@implementation KTGlobalModel
+(instancetype)shareInstance
{
    static KTGlobalModel *model  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[KTGlobalModel alloc] init];
    });
    return model;
}
@end
