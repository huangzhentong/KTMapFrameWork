//
//  KTViewController.m
//  KTMapFrameWork
//
//  Created by 181310067@qq.com on 12/17/2019.
//  Copyright (c) 2019 181310067@qq.com. All rights reserved.
//

#import "KTViewController.h"

#import <KTMapSDK.h>
@interface KTViewController ()

@end

@implementation KTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [KTMapSDK presentSDK:self mapAPIKey:@"adfad"];
}

@end
