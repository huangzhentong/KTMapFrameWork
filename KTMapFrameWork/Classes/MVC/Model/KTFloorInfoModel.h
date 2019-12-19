//
//  KTFloorInfoModel.h
//  Network
//
//  Created by KT--stc08 on 2019/4/3.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "KTBaseModel.h"

#import "KTParkPointModel.h"
NS_ASSUME_NONNULL_BEGIN
//楼层信息
@interface KTFloorInfoModel : KTBaseModel
@property(nonatomic)double spaceL;                      //高
@property(nonatomic)double spaceW;                      //宽
@property(nonatomic)double distancePerPixel;            //距离比例
@property(nullable,nonatomic,copy)NSString* lotId;               //车场ID
@property(nullable,nonatomic,copy)NSString* floorName;           //楼层名
@property(nullable,nonatomic,copy)NSString* floorId;             //楼层ID
@property(nullable,nonatomic,copy)NSString* mapFile;             //地图

@end

NS_ASSUME_NONNULL_END
