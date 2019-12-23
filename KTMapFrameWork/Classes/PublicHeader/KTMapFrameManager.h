//
//  KTMapSDK.h
//  KTMapFrameWork
//
//  Created by KT--stc08 on 2019/12/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface KTMapFrameManager : NSObject
//跳转到SDK;
//传入一个viewController;
+(void)presentSDK:(UIViewController*)viewController mapAPIKey:(NSString*)apiKey;
//设置debug 模式，true 为debug 模式，false 为release
+(void)setDebugMode:(BOOL)debug;

@end

NS_ASSUME_NONNULL_END
