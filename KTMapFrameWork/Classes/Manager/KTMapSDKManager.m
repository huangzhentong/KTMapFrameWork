//
//  KTMapSDK.m
//  KTMapFrameWork
//
//  Created by KT--stc08 on 2019/12/18.
//

#import "KTMapSDKManager.h"
#import "KTNaviViewController.h"
#import "KTInputCarNumberViewController.h"
#import "UIImage+Color.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation KTMapSDKManager


+(void)presentSDK:(UIViewController*)viewController mapAPIKey:(NSString*)apiKey;
{
        KTInputCarNumberViewController *infoViewController = [KTInputCarNumberViewController new];
       UINavigationController *navi = [[KTNaviViewController alloc] initWithRootViewController:infoViewController];
       [navi.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
       
       navi.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
   
       [navi.navigationBar setShadowImage:[UIImage new]];
    if (viewController) {
        navi.modalPresentationStyle = UIModalPresentationFullScreen;
        [viewController presentViewController:navi animated:true completion:nil];
    }
    else
    {
        NSLog(@"viewController is null");
    }
    if (apiKey == nil || apiKey.length < 2) {
        NSLog(@"apiKey is null");
    }
    else
    {
        Class aMapClass = NSClassFromString(@"AMapServices");
           if (aMapClass == nil) {
               NSLog(@"未集成高德地图");
               return;
           }
           SEL defaultServiceSel = NSSelectorFromString(@"sharedServices");
           if ([aMapClass respondsToSelector:defaultServiceSel]) {
                id (*sharedServices)(id,SEL) = (id (*) (id,SEL))objc_msgSend;
                id aMap =  sharedServices(aMapClass,defaultServiceSel);
                [aMap setValue:apiKey forKey:@"apiKey"];
           }
    }
}

@end
