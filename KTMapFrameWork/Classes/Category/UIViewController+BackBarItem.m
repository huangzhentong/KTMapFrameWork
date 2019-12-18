//
//  UIViewController+BackBarItem.m
//  KOS-Objc
//
//  Created by KT--stc08 on 2018/7/11.
//  Copyright © 2018年 KT--stc08. All rights reserved.
//

#import "UIViewController+BackBarItem.h"
#import <objc/runtime.h>
#import <UIImage+Bundle.h>

@implementation UIViewController (BackBarItem)



-(void)backBtnEvent
{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)addBackBarBtn:(SEL)selector
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage  getBundleImage:@"nav_return"];
    [leftBtn setImage:image forState:UIControlStateNormal];
    if (selector == nil) {
        selector = NSSelectorFromString(@"backBtnEvent");
    }
    [leftBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 44-image.size.width);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
}
-(void)addBackBarBtn:(NSString*)title withSelector:(SEL)selector
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:title forState:UIControlStateNormal];
    [leftBtn setTitleColor: [UIColor colorWithRed:21/255.0 green:20/255.0 blue:20/255.0 alpha:1.0] forState:UIControlStateNormal];
    UIFont *font = [UIFont systemFontOfSize:17];
    leftBtn.titleLabel.font = font;
    
    UIImage *image = [UIImage  getBundleImage:@"nav_return"];
    [leftBtn setImage:image forState:UIControlStateNormal];
    if (selector == nil) {
        selector = NSSelectorFromString(@"backBtnEvent");
    }
    [leftBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary*attrs =@{NSFontAttributeName: font};
    //返回一个矩形，大小等于文本绘制完占据的宽和高。
    CGSize size =  [title  boundingRectWithSize:CGSizeMake(300, 100)  options:NSStringDrawingUsesLineFragmentOrigin  attributes:attrs   context:nil].size;
    
//    [leftBtn.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
     leftBtn.frame = CGRectMake(0, 0, size.width+30, 44);
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, size.width+30-image.size.width);
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}
@end
