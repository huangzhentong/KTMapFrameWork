//
//  KTPathInfoModel.h
//  Network
//
//  Created by KT--stc08 on 2019/4/3.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "KTBaseModel.h"
#import "KTParkPointModel.h"
NS_ASSUME_NONNULL_BEGIN
//路径模型
@interface KTPathInfoModel : KTBaseModel
@property(nullable,nonatomic,strong)KTParkPointModel *endVerticalPoint;
@property(nullable,nonatomic,strong)KTParkPointModel *beginVerticalPoint;
@property(nullable,nonatomic,strong)NSArray <KTParkPointModel *>*pathPoints;
@end

NS_ASSUME_NONNULL_END
