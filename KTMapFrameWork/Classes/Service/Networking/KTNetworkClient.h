//
//  KTNetworkClient.h
//  Network
//
//  Created by KT--stc08 on 2019/9/3.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KTNetworkClient : NSObject
@property(nonatomic,strong,nullable)NSURLSessionDataTask *dataTask;
@property(nonatomic,strong)void (^successEvent)(id object);
@property(nonatomic,strong)void (^faildEvent)(NSError *error);
@end

NS_ASSUME_NONNULL_END
