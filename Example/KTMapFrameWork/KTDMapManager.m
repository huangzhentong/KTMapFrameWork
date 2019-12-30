//
//  KTDMapManager.m
//  KTMapSDK
//
//  Created by KT--stc08 on 2019/12/19.
//

#import "KTDMapManager.h"
#import <WebKit/WebKit.h>
#import "KTDMapViewController.h"
#import "KTNaviWalkController.h"
#import "KTNotifiction.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface KTDMapManager ()
@property(nonatomic,strong)id map;
@end

@implementation KTDMapManager
+(instancetype)shareInstance
{
    static KTDMapManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KTDMapManager alloc] init];
    });
    return manager;
}


-(void)initWithDMapWithCode:(NSString *)code url:(NSString *)url
{
    self.code = code;
    self.url = url;
    if (!self.map) {
        
        UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        self.map = [KTDMapManager createDMapView:viewController.view code:code url:url];
        void(* statusEventAction)(id,SEL,void(^event)(NSDictionary<NSString*,id>*))=(void(*)(id,SEL,void(^event)(NSDictionary<NSString*,id>*)))objc_msgSend;
        __weak typeof(self) weakSelf = self;
        void(^statusEvent)(NSDictionary<NSString*,id>*)=^(NSDictionary<NSString *,id> * _Nullable dic){
            if (dic == nil) {
                weakSelf.locateState = -1;
            }
            else
            {
                NSDictionary *data = dic[@"data"];
                if (data) {
                    weakSelf.locateState = [data[@"value"] integerValue];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:DMapLocationStatusChange object:@(weakSelf.locateState)];
            }
            NSLog(@"registerLocationStatusEventWithCb=%@",dic);
        };
        statusEventAction(self.map,NSSelectorFromString(@"registerLocationStatusEventWithCb:"),statusEvent);
        
        
        
    }
    else{
        void (*setSourceAction)(id,SEL,int,NSString*,NSString*) = (void(*)(id,SEL,int,NSString*,NSString*))objc_msgSend;
        setSourceAction(self.map,NSSelectorFromString (@"setSourceWithType:source:url:"),0,code,url);
      
    }
}

+(void)load
{
    [KTDMapManager shareInstance];
}

-(instancetype)init
{
    self  = [super init];
    if (self) {
        self.locateState = -1;
        [self addListen];
    }
    return self;
}

-(void)addListen{
    //SDK关闭
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopDMapEvent) name:@"KTSDKClose" object:nil];
    //进入室内
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToDMapViewController:) name:PushToDMapViewController object:nil];
    //进入室外
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToWalkViewController:) name:PushToWalkViewController object:nil];
}
//进入室入定位
-(void)pushToDMapViewController:(NSNotification*)notification
{
    NSDictionary *dic = notification.object;
    if (dic[@"viewController"])
    {
        KTDMapViewController *dMap = [[KTDMapViewController alloc] initWithCode:self.code withURL:self.url];
        UIViewController *vc = dic[@"viewController"];
        if(vc.navigationController)
        {
            [vc.navigationController pushViewController:dMap animated:true];
        }
        else{
            [vc presentViewController:dMap animated:true completion:nil];
        }
        
    }
    
    
    
}
//进入步行导航
-(void)pushToWalkViewController:(NSNotification*)notification
{
    NSDictionary *dic = notification.object;
    if (dic[@"viewController"] && dic[@"lat"] && dic[@"long"]) {
        CGFloat latitude = [dic[@"lat"] doubleValue];
        CGFloat longitude = [dic[@"long"] doubleValue];
        
        KTNaviWalkController *walkVC = [[KTNaviWalkController alloc] initWithEndLatitude:latitude longitude:longitude];
        UIViewController *vc = dic[@"viewController"];
        if(vc.navigationController)
        {
            [vc.navigationController pushViewController:walkVC animated:true];
        }
        else{
            [vc presentViewController:walkVC animated:true completion:nil];
        }
        
    }
    NSLog(@"notification.object=%@",notification.object);
    
    
}



-(void)stopDMapEvent
{
    
    if (self.map) {
        if( [self.map respondsToSelector:NSSelectorFromString(@"dispose")])
        {
            void (*dispose)(id,SEL) = (void(*)(id,SEL))objc_msgSend;
            dispose(self.map,NSSelectorFromString(@"dispose"));
            self.map = nil;
        }
    }
}



+(id)createDMapView:(UIView*)view code:(NSString*)code url:(NSString*)url
{
    Class mapClass = NSClassFromString(@"DMap.DMap");
    if (mapClass) {
        
        id (*allocAction)(id,SEL) = (id (*) (id,SEL))objc_msgSend;
        id allocMap = allocAction(mapClass, NSSelectorFromString(@"alloc"));
        
        id (*initAction)(id,SEL,UIView*) = (id (*) (id,SEL,UIView*))objc_msgSend;
        id mapObject = initAction(allocMap, NSSelectorFromString(@"initWithView:"),view);
        
        NSLog(@"mapObject=%@",mapObject);
        
        void (*setSourceAction)(id,SEL,int,NSString*,NSString*) = (void(*)(id,SEL,int,NSString*,NSString*))objc_msgSend;
        setSourceAction(mapObject,NSSelectorFromString(@"setSourceWithType:source:url:"),0,code,url);
        return mapObject;
    }
    return nil;
}


@end
