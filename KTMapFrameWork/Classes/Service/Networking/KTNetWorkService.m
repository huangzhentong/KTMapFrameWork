//
//  NetWorkManager.m
//  Network
//
//  Created by KT--stc08 on 2019/4/3.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "KTNetWorkService.h"
//#import "BaseClient+RAC.h"

#import  <AFNetworking/AFNetworking.h>
#import "LoadingManager.h"
#import "NSBundle+KTRes.h"
#import "KTNetworkClient.h"
static NSString * const urlKey = @"url";
static NSString * const parametersKey = @"parameters";
static NSString * const typeKey = @"type";
@interface KTNetWorkService ()
{
    
}
//@property(nonatomic,strong)dispatch_queue_t networkQueue;           //线程
//@property(nonatomic,strong)COActor *networkActor;
@end

@implementation KTNetWorkService



+(instancetype)shareInstance
{
    static KTNetWorkService *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [KTNetWorkService new];
    });
    return manager;
    
}

-(instancetype)init
{
    self = [super init];
    if (self) {
//        [BaseClient setBaseURL:@""];
    }
    return self;
}
+(AFHTTPSessionManager *)httpManager
{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] init];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 10;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
    });
    
    return manager;
}




-(id)requestJSONWithURL:(NSString*)url withParameters:(NSDictionary*)dic withType:(NSString*)type{
    
    return [self requestJSONWithURL:url withParameters:dic withType:type withShowLoading:true];

}
-(id)requestJSONWithURL:(NSString*)url withParameters:(NSDictionary*)parameters  withType:(NSString*)type withShowLoading:(BOOL)isLoading
{
    AFHTTPSessionManager *manager = [KTNetWorkService httpManager];
    KTNetworkClient *client = [KTNetworkClient new];
    if (isLoading) {
        [LoadingManager showLoading:KTLocalizedString(@"Loading")];
    }
    NSLog(@"url = %@",url);

    void (^success)(NSURLSessionDataTask * _Nonnull, id _Nullable) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        id object = [KTNetWorkService responseObjectDisponse:responseObject];
        if ([object isKindOfClass:[NSError class]]) {
            if (client.faildEvent) {
                client.faildEvent(object);
            }
        }
        else
        {
            if (client.successEvent) {
                client.successEvent(object);
            }
            [LoadingManager dismiss];
        }
    };
    void (^faild)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) =^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (client.faildEvent) {
            client.faildEvent(error);
        }
        [LoadingManager showError:error];
    };
    
    NSURLSessionDataTask *dataTask = nil;
    if ([type isEqualToString:@"get"]) {
        dataTask = [manager GET:url parameters:parameters progress:nil success:success failure:faild];
    }
    else if ([type isEqualToString:@"post"])
    {
        dataTask = [manager POST:url parameters:parameters progress:nil success:success failure:faild];
    }
 
    client.dataTask = dataTask;
    return client;

}

+(id)responseObjectDisponse:(id)responseObject
{
    NSDictionary *dict = responseObject;
    if(dict[@"code"]==nil)
    {
        NSError *error  = [NSError errorWithDomain:@"未知错误" code:99999 userInfo:nil];
        return error;
    }
    else if([dict[@"code"] intValue]!= 2000)
    {
        NSString *message = dict[@"msg"]?:dict[@"message"];
        NSError *error  = [NSError errorWithDomain:message code:[dict[@"code"] intValue] userInfo:nil];
        if (error.code >= 3000 || error.code < 1000) {
            [LoadingManager showError:error];
        }
        return error;

    }
    else
    {
        
        dict = dict[@"data"];
        
        return dict;
    }
    return dict;
}


@end
