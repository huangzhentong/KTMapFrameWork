//
//  LoadingManager.m
//  KOS-Objc
//
//  Created by KT--stc08 on 2018/7/16.
//  Copyright © 2018年 KT--stc08. All rights reserved.
//

#import "LoadingManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
@implementation LoadingManager
+(void)showLoading:(NSString *)string
{
    [SVProgressHUD showWithStatus:string?:@"加载中..."];
}
+(void)dismiss
{
    [SVProgressHUD dismiss];
}
+(void)showError:(NSError*)error
{
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD showErrorWithStatus:error.domain];
    
}
+(void)showSuccess:(NSString *)success
{
    [SVProgressHUD showSuccessWithStatus:success?:@"成功"];
}
@end
