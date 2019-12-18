//
//  UIViewController+GetViewController.h
//  MGJRouterController
//
//  Created by KT--stc08 on 2018/10/24.
//  Copyright © 2018 KT--stc08. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GetViewController)
//获取当前RootViewController
+(UIViewController*)getRootViewController;
//获取当前ViewController
+(UIViewController*)getCurrentViewController;
+(UIViewController*)getCurrentViewControllerFrom:(UIViewController*)viewController;
@end

NS_ASSUME_NONNULL_END
