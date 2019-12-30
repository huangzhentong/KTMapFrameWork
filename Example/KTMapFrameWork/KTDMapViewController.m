//
//  KTDMapViewController.m
//  MapText
//
//  Created by KT--stc08 on 2019/12/17.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "KTDMapViewController.h"
#import <WebKit/WebKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <KTMapFrameWork/NSBundle+KTRes.h>
@interface KTDMapViewController ()
@property(nonatomic,strong)id map;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *url;

@property(nonatomic,copy)NSString *floor;
@property(nonatomic,copy)NSString *park;
@end

@implementation KTDMapViewController

-(instancetype)initWithCode:(NSString *)code withURL:(NSString *)url
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        
        NSAssert(code, @"code 不能为空");
        NSAssert(url, @"url 不能为空");
        self.code = code;
        self.url = url;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"室内定位";
    {
        Class mapClass = NSClassFromString(@"DMap.DMap");
        if (mapClass) {
            
            id (*allocAction)(id,SEL) = (id (*) (id,SEL))objc_msgSend;
            id allocMap = allocAction(mapClass, NSSelectorFromString(@"alloc"));
            
            id (*initAction)(id,SEL,UIView*) = (id (*) (id,SEL,UIView*))objc_msgSend;
            id mapObject = initAction(allocMap, NSSelectorFromString(@"initWithView:"),self.view);
            
            NSLog(@"mapObject=%@",mapObject);
            
            void (*setSourceAction)(id,SEL,int,NSString*,NSString*) = (void(*)(id,SEL,int,NSString*,NSString*))objc_msgSend;
            setSourceAction(mapObject,NSSelectorFromString(@"setSourceWithType:source:url:"),0,self.code,self.url);
            
            class_addProtocol([self class], NSProtocolFromString(@"DMapDelegate"));
            
            [mapObject setValue:self forKey:@"delegate"];
            self.map = mapObject;
            
        }
        
    }

    self.navigationController.navigationBarHidden  = false;
    [self addBackBtn];
    //获取楼层信息
    {
        Class globalModel = NSClassFromString(@"KTGlobalModel");
        if (globalModel == nil) {
            
            return;
        }
        SEL defaultServiceSel = NSSelectorFromString(@"shareInstance");
        if ([globalModel respondsToSelector:defaultServiceSel]) {
            id (*sharedServices)(id,SEL) = (id (*) (id,SEL))objc_msgSend;
            id model =  sharedServices(globalModel,defaultServiceSel);
           
            NSString *floor = [model valueForKey:@"floor"];
            NSString *park = [model valueForKey:@"park"];
            NSLog(@"floor = %@|park=%@",floor,park);
            self.floor = floor;
            self.park = park;
        }
    }
    

}
-(void)addBackBtn
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
       
    UIImage *image =  [UIImage imageNamed:@"nav_return" inBundle:[NSBundle getResBundel] compatibleWithTraitCollection:nil];
    [leftBtn setImage:image forState:UIControlStateNormal];

    [leftBtn addTarget:self action:@selector(backBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 44-image.size.width);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

-(void)backBtnEvent
{
    NSArray *array = self.navigationController.viewControllers;
    BOOL isCarInfo = false;
    for (UIViewController * vc in array) {
        if([NSStringFromClass( vc.class) isEqualToString:@"KTCarInfoViewController"])
        {
            [self.navigationController popToViewController:vc animated:false];
            isCarInfo = true;
            return;
        }
    }
    if (!isCarInfo) {
        [self.navigationController popViewControllerAnimated:true];
    }
       
   
//    [self.navigationController pop]
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.map) {
        if( [self.map respondsToSelector:NSSelectorFromString(@"dispose")])
        {
            void (*dispose)(id,SEL) = (void(*)(id,SEL))objc_msgSend;
            dispose(self.map,NSSelectorFromString(@"dispose"));
            
            self.map = nil;
        }
    }
}
-(void)centralManagerDidUpdateStateWithState:(NSInteger)state
{
    //    switch (state) {
    //        case BluetoothStateUnauthorized:
    //            NSLog(@"无权使用蓝牙");
    //            break;
    //            case BluetoothStatePoweredOff:
    //            NSLog(@"蓝牙关闭");
    //            break;
    //            case BluetoothStatePoweredOn:
    //            NSLog(@"蓝牙启动");
    //            break;
    //        default:
    //            NSLog(@"蓝牙故障");
    //            break;
    //    }
}
-(void)didMapReady {
    NSLog(@"map ready");
    
    if(self.floor.length >=1 && self.park.length >= 1)
    {
        NSInteger (*bookParking)(id,SEL,NSString*,NSString*) = (NSInteger(*)(id,SEL,NSString*,NSString*))objc_msgSend;
        NSInteger state =bookParking(self.map,NSSelectorFromString(@"bookParkingWithFloor:parkingNumber:"),self.floor,self.park);
        NSLog(@"state=%li",(long)state);
    }

    
}


@end
