//
//  KTSDK.h
//  KTMapSDK
//
//  Created by KT--stc08 on 2019/12/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface KTSDK : NSObject
+(void)presentSDK:(UIViewController*)viewController mapAPIKey:(NSString*)apiKey;

//设置 debug模式 true 表示debug 模式，false 表示release
+(void)setDebugMode:(BOOL)isDebug;
@end

NS_ASSUME_NONNULL_END
