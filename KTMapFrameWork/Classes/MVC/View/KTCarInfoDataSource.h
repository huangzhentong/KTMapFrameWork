//
//  KTCarInfoDataSource.h
//  KTFindCarSDK
//
//  Created by KT--stc08 on 2019/4/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KTCarInfoDataSource <NSObject>

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *imageURL;
@property(nonatomic,copy)NSArray *leftArray;
@property(nonatomic,copy)NSArray *rightArray;

@end

NS_ASSUME_NONNULL_END
