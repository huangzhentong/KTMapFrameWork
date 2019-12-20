//
//  SVProgressHUD+Window.m
//  AFNetworking
//
//  Created by KT--stc08 on 2019/12/19.
//

#import "SVProgressHUD+Window.h"




@implementation SVProgressHUD (Window)
+ (SVProgressHUD*)sharedView {
    static dispatch_once_t once;
    
    static SVProgressHUD *sharedView;
#if !defined(SV_APP_EXTENSIONS)
    dispatch_once(&once, ^{ sharedView = [[self alloc] initWithFrame:[[UIApplication sharedApplication] keyWindow].bounds]; });
#else
    dispatch_once(&once, ^{ sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
#endif
    return sharedView;
}
@end
