//
//  UIColor+Hexadecimal.h
//  KOS-Objc
//
//  Created by KT--stc08 on 2018/7/11.
//  Copyright © 2018年 KT--stc08. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorHex(x) [UIColor colorWithHex:x]


@interface UIColor (Hexadecimal)

+(UIColor*)colorWithHex:(NSString*)hex;

@end
