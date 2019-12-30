//
//  KTDMapManager.h
//  KTMapSDK
//
//  Created by KT--stc08 on 2019/12/19.
//

#import <Foundation/Foundation.h>

#import "KTNotifiction.h"



NS_ASSUME_NONNULL_BEGIN

@interface KTDMapManager : NSObject
@property(nonatomic)NSInteger locateState;                //定位状态 0室内定位，-1表示未初使化完成
@property(nonatomic,copy)NSString* code;                //定位状态
@property(nonatomic,copy)NSString* url;                //定位状态
+(instancetype)shareInstance;

-(void)initWithDMapWithCode:(NSString*)code url:(NSString*)url;
//创建dDap
+(id)createDMapView:(UIView*)view code:(NSString*)code url:(NSString*)url;
@end

NS_ASSUME_NONNULL_END
