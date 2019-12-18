//
//  UIImageView+URL.m
//  AFNetworking
//
//  Created by KT--stc08 on 2019/9/3.
//

#import "UIImageView+ImageWithURL.h"

@implementation UIImageView (ImageWithURL)
-(void)setImageWithURL:(NSURL *)url
{
    if (url == nil) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        self.image = image;
    });
    
}
@end
