//
//  KTParkDetailModel.h
//  Network
//
//  Created by KT--stc08 on 2019/4/3.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "KTBaseModel.h"

#import "KTIBeaconModel.h"
#import "KTFloorInfoModel.h"
#import "KTParkPointModel.h"
@class KTParkInfoModel,KTIBeaconsInfoModel;
NS_ASSUME_NONNULL_BEGIN
//车场详情
@interface KTParkDetailModel : KTBaseModel
@property(nullable,nonatomic,strong)KTParkInfoModel* parkInfo;
@property(nullable,nonatomic,strong)NSArray<KTIBeaconsInfoModel*>* ibeacons;
@property(nullable,nonatomic,strong)NSArray<KTParkPointModel*>* keyPoints;
@property(nonatomic)CGFloat keyPointCount;
@property(nonatomic)NSInteger mapCorrectAngle;
@property(nonatomic)NSInteger ibeaconStationCount;
@end

NS_ASSUME_NONNULL_END

//停车场信息
@interface KTParkInfoModel : KTBaseModel
@property(nullable,nonatomic,copy)NSString* parkNo;                  //车位
@property(nullable,nonatomic,copy)NSString* imgUrl;                  //图片
@property(nullable,nonatomic,copy)NSString* carPlateNum;             //车牌号
@property(nullable,nonatomic,copy)NSString* parkAddr;                //车场地址
@property(nullable,nonatomic,copy)NSString* areaName;                //车场区
@property(nullable,nonatomic,copy)KTFloorInfoModel* floorInfo;        //楼层信息
@property(nullable,nonatomic,copy)KTParkPointModel* parkPoint;             //地图
@end


@interface KTIBeaconsInfoModel : KTBaseModel
@property(nullable,nonatomic,copy)NSString* floorId;                  //楼层
@property(nullable,nonatomic,copy)NSString* uuid;                  //楼层
@property(nullable,nonatomic,copy)NSArray<KTIBeaconModel *>*  items;                  //蓝牙信号
@end
