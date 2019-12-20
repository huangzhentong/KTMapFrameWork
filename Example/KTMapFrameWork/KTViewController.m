//
//  KTViewController.m
//  KTMapFrameWork
//
//  Created by 181310067@qq.com on 12/17/2019.
//  Copyright (c) 2019 181310067@qq.com. All rights reserved.
//

#import "KTViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <KTMapFrameManager.h>
@interface KTViewController ()

@end

@implementation KTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"开始" forState:UIControlStateNormal];
    button.frame = CGRectMake(50, 50, 100, 30);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(startEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)startEvent:(id)object
{
    Class globalModel = NSClassFromString(@"KTGlobalModel");
           if (globalModel == nil) {
              
               return;
           }
           SEL defaultServiceSel = NSSelectorFromString(@"shareInstance");
           if ([globalModel respondsToSelector:defaultServiceSel]) {
               id (*sharedServices)(id,SEL) = (id (*) (id,SEL))objc_msgSend;
               id model =  sharedServices(globalModel,defaultServiceSel);
               [model setValue:@"B1" forKey:@"floor"];
               [model setValue:@"B1-1001" forKey:@"park"];
               NSString *floor = [model valueForKey:@"floor"];
               NSString *park = [model valueForKey:@"park"];
               NSLog(@"floor = %@|park=%@",floor,park);
           }
    [KTMapFrameManager presentSDK:self mapAPIKey:@"adfad"];
}



@end
