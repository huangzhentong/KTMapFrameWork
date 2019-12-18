//
//  KTCarInfoView.h
//  KTFindCarSDK
//
//  Created by KT--stc08 on 2019/3/29.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "KTCarInfoDataSource.h"
NS_ASSUME_NONNULL_BEGIN



@interface KTCarInfoView : UIView
@property(nonatomic,strong)UIButton *pathBtn;               //路线找车
@property(nonatomic,strong)UIButton *ARBtn;                 //AR找车
@property(nonatomic,strong)UIButton *bluBtn;                //蓝牙找车
-(void)updateDataSource:(id<KTCarInfoDataSource>)object;
@end

NS_ASSUME_NONNULL_END
