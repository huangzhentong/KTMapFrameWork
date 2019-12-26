//
//  KTGlobalModel.h
//  AFNetworking
//
//  Created by KT--stc08 on 2019/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//全局部变量
@interface KTGlobalModel : NSObject
@property(nonatomic,copy,nullable)NSString *floor;          //楼层
@property(nonatomic,copy,nullable)NSString *park;           //车位

+(instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
