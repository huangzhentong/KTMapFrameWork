//
//  UIViewController+BackBarItem.h
//  KOS-Objc
//
//  Created by KT--stc08 on 2018/7/11.
//  Copyright © 2018年 KT--stc08. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BackBarItem)
-(void)addBackBarBtn:(SEL)selector;
-(void)backBtnEvent;

-(void)addBackBarBtn:(NSString*)title withSelector:(SEL)selector;
@end
