//
//  KTDMapViewController.m
//  MapText
//
//  Created by KT--stc08 on 2019/12/17.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "KTDMapViewController.h"

@interface KTDMapViewController ()
@interface KTDMapViewController ()<DMapDelegate>
@property(nonatomic,strong)DMap *map;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *url;
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

-(DMap*)map
{
    if (!_map) {
        _map = [[DMap alloc] initWithView:self.view];

        [_map setSourceWithType:0 source:self.code url:self.url];

//        [_map registerLocationStatusEventWithCb:^(NSDictionary<NSString *,id> * _Nullable dic) {
//            NSLog(@"registerLocationStatusEventWithCb = %@", dic);
//        }];
//        [_map registerNavigationDistanceEventWithCb:^(NSDictionary<NSString *,id> * _Nullable dic) {
//             NSLog(@"registerNavigationDistanceEventWithCb = %@", dic);
//        }];

        WKWebView *webView = [_map getMapView];
        webView.translatesAutoresizingMaskIntoConstraints = false;
        webView.frame = self.view.bounds;

    }
    return _map;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.map.delegate = self;
    
}


//-(void)centralManagerDidUpdateStateWithState:(enum BluetoothState)state
//{
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
//}
//-(void)didMapReady {
//    NSLog(@"map ready");
//}


@end
