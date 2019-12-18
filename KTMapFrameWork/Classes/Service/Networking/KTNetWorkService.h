//
//  NetWorkManager.h
//  Network
//
//  Created by KT--stc08 on 2019/4/3.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BaseClient+RAC.h"
#import "NetWorkURLManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface KTNetWorkService : NSObject
+(instancetype)shareInstance;
-(id)requestJSONWithURL:(NSString*)url;
-(id)requestJSONWithURL:(NSString*)url withParameters:(NSDictionary*)dic  withType:(NSString*)type;
-(id)requestJSONWithURL:(NSString*)url withParameters:(NSDictionary*)dic  withType:(NSString*)type withShowLoading:(BOOL)isLoading;
@end

NS_ASSUME_NONNULL_END
