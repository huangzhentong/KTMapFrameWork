//
//  KTSDK.m
//  KTMapSDK
//
//  Created by KT--stc08 on 2019/12/20.
//

#import "KTSDK.h"
#import <KTMapFrameWork/KTMapFrameManager.h>
@implementation KTSDK
+(void)presentSDK:(UIViewController*)viewController mapAPIKey:(NSString*)apiKey
{
    [KTMapFrameManager presentSDK:viewController mapAPIKey:apiKey];
}
//设置 debug模式 true 表示debug 模式，false 表示release
+(void)setDebugMode:(BOOL)isDebug
{
    [KTMapFrameManager setDebugMode:isDebug];
}
@end
