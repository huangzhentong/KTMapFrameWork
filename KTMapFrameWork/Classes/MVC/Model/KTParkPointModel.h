//
//  KTParkPointModel.h
//  Network
//
//  Created by KT--stc08 on 2019/4/3.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "KTBaseModel.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
//车场位置点信息模型
@interface KTParkPointModel : KTBaseModel
@property(nonatomic)double x;                      //x
@property(nonatomic)double y;                      //y
@property(nonatomic)NSInteger pointID;        //id
@property(nonatomic)int pointType;                  //类型
@property(nonatomic,copy)NSString * busNumber;        //车位信息
@property(nonatomic)BOOL visited;                  //类型
@property(nullable,nonatomic,copy)NSArray <KTParkPointModel*>* neighbours;        //邻居位置

-(CGPoint)point;
@end

NS_ASSUME_NONNULL_END
