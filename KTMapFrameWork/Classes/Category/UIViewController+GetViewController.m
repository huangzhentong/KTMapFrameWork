//
//  UIViewController+GetViewController.m
//  MGJRouterController
//
//  Created by KT--stc08 on 2018/10/24.
//  Copyright © 2018 KT--stc08. All rights reserved.
//

#import "UIViewController+GetViewController.h"

@implementation UIViewController (GetViewController)
+(UIViewController*)getRootViewController
{
    UIViewController * vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    return vc;
}
+(UIViewController*)getCurrentViewController
{
    UIViewController *viewController  = [self getRootViewController];
    return [self getCurrentViewControllerFrom:viewController];
}
+(UIViewController*)getCurrentViewControllerFrom:(UIViewController*)fromViewController
{
    if (fromViewController == nil) {
        fromViewController =  [self getRootViewController];
    }
    if (fromViewController.presentedViewController != nil) {
        return [self getCurrentViewControllerFrom:fromViewController.presentedViewController];
    }
    else if ([fromViewController isKindOfClass:[UINavigationController class]]) {
        
        UIViewController * viewController = [(UINavigationController*)fromViewController visibleViewController];
        return [self getCurrentViewControllerFrom:viewController];
    }
    else if([fromViewController isKindOfClass:[UITabBarController class]])
    {
        UIViewController *  viewController = [(UITabBarController*)fromViewController selectedViewController];
        return [self getCurrentViewControllerFrom:viewController];
    }else
    {
        return fromViewController;
    }
    return nil;
}
@end
