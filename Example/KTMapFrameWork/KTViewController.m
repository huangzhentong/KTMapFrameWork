//
//  KTViewController.m
//  KTMapFrameWork
//
//  Created by 181310067@qq.com on 12/17/2019.
//  Copyright (c) 2019 181310067@qq.com. All rights reserved.
//

#import "KTViewController.h"
#import "KTTextModel.h"

@interface KTViewController ()

@end

@implementation KTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *dic = @{@"key1":@"123",@"key2":@"567"};
    KTTextModel *model = [KTTextModel KT_modelWithJSON:dic];
   
    NSLog(@"model=%@",model);

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
