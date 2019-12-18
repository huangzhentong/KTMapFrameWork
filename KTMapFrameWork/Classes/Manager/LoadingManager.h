//
//  LoadingManager.h
//  KOS-Objc
//
//  Created by KT--stc08 on 2018/7/16.
//  Copyright © 2018年 KT--stc08. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadingManager : NSObject
+(void)showLoading:(NSString *)string;
+(void)dismiss;
+(void)showError:(NSError*)error;
+(void)showSuccess:(NSString*)success;
@end
