//
//  KTCarInfoViewController.h
//  KTFindCarSDK
//
//  Created by KT--stc08 on 2019/3/29.
//

#import <UIKit/UIKit.h>
#import "KTBaseViewController.h"
#import "KTCarInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
//找车路口
@interface KTCarInfoViewController : KTBaseViewController
@property(nonatomic,copy)NSString *lotID;
@property(nonatomic,copy)NSString *carNumber;
@property(nonatomic,strong)KTCarInfoModel * model;
@end

NS_ASSUME_NONNULL_END
