//
//  KTViewController.m
//  KTMapFrameWork
//
//  Created by 181310067@qq.com on 12/17/2019.
//  Copyright (c) 2019 181310067@qq.com. All rights reserved.
//

#import "KTViewController.h"
#import <KTDMapViewController.h>

@interface KTViewController ()

@end

@implementation KTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *viewController = [[KTDMapViewController alloc] initWithCode:@"hyjg" withURL:@"https://test.seeklane.com/test/hyjg/index.html"];
    [self presentViewController:viewController animated:true completion:nil];
}

@end
