//
//  UIImage+Bundle.m
//  Demo
//
//  Created by KT--stc08 on 2019/3/27.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "UIImage+Bundle.h"

#import "NSBundle+KTRes.h"

@implementation UIImage (Bundle)


+(UIImage*)getKTBundleImage:(NSString*)imageName
{
    if([NSBundle getResBundel])
    {
      return   [UIImage imageNamed:imageName inBundle:[NSBundle getResBundel] compatibleWithTraitCollection:nil];
    }
    return nil;
}

@end

