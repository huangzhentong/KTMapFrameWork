//
//  UIColor+Hexadecimal.m
//  KOS-Objc
//
//  Created by KT--stc08 on 2018/7/11.
//  Copyright © 2018年 KT--stc08. All rights reserved.
//

#import "UIColor+Hexadecimal.h"

@implementation UIColor (Hexadecimal)

+(UIColor*)colorWithHex:(NSString *)hex
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    hex = [hex stringByTrimmingCharactersInSet:set];
    if ([hex hasPrefix:@"#"]) {
        hex = [hex substringFromIndex:1];
    } else if ([hex hasPrefix:@"0X"]) {
        hex = [hex substringFromIndex:2];
    }
    NSScanner *scanner = [[NSScanner alloc] initWithString:hex];
    scanner.scanLocation = 0;
    UInt64 rgbValue = 0;
    [scanner scanHexInt:&rgbValue];
    CGFloat r = (rgbValue & 0xff0000) >> 16;
    CGFloat g = (rgbValue & 0xff00) >> 8;
    CGFloat b = rgbValue & 0xff;
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];
    
}

@end
