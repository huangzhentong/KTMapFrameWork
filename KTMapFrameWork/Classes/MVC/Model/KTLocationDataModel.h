//
//  KTLocationDataModel.h
//  AFNetworking
//
//  Created by KT--stc08 on 2019/12/20.
//

#import <Foundation/Foundation.h>
#import "KTBaseModel.h"
NS_ASSUME_NONNULL_BEGIN
@class KTLocationPointModel;
@interface KTLocationDataModel : KTBaseModel
@property(nonatomic,copy)NSString *lotId;
@property(nonatomic,copy)NSString *lotName;
@property(nonatomic,copy)NSArray<KTLocationPointModel *> *lotPoint;
+(NSArray<KTLocationDataModel*>*)initWithLoactionData;

@end

@interface KTLocationPointModel : KTBaseModel
@property(nonatomic)CGFloat latitude;
@property(nonatomic)CGFloat longitude;
@property(nonatomic,copy)NSString *name;
@end

NS_ASSUME_NONNULL_END
