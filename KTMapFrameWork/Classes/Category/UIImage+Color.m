//
//  UIImage+Color.m
//  KOS-Objc
//
//  Created by KT--stc08 on 2018/7/11.
//  Copyright © 2018年 KT--stc08. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)
+(UIImage*)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =  UIGraphicsGetCurrentContext();
    [color set];
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return  image;
    
}
@end
