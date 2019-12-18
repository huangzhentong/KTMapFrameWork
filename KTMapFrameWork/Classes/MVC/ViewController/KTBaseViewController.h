//
//  KTBaseViewController.h
//  KTFindCarSDK
//
//  Created by KT--stc08 on 2019/4/25.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "KTNetworkClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseViewController : UIViewController

@property(nonatomic,strong)KTNetworkClient *client;
-(void)bindVM;
//请求成功处理
-(void)requestSuccess:(id)x;
-(void)requestFaild:(NSError *)error;
-(void)reloadRequest;
@end

NS_ASSUME_NONNULL_END
