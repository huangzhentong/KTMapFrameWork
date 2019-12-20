//
//  KTLocationDataModel.m
//  AFNetworking
//
//  Created by KT--stc08 on 2019/12/20.
//

#import "KTLocationDataModel.h"

@implementation KTLocationDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
           return @{@"lotPoint" : [KTLocationPointModel class],
                    };
}
+(NSArray<KTLocationDataModel*>*)initWithLoactionData;
{
  NSArray *array =  @[
      @{@"lotId":@"2513",
              @"lotName":@"汉峪金谷A1地块",
          @"lotPoint":@[@{@"latitude":@"36.659474",@"longitude":@"117.145562",@"name":@"A1-2车库入口"},
        @{@"latitude":@"36.659402",@"longitude":@"117.143971",@"name":@"A1-5车库入口"}
      ,@{@"latitude":@"36.661188",@"longitude":@"117.145393",@"name":@"A1-1车库入口"},
        @{@"latitude":@"36.660095",@"longitude":@"117.144411",@"name":@"A1车库A1层人行入口"}
      ,@{@"latitude":@"36.660293",@"longitude":@"117.144556",@"name":@"A1-B1商业2号门入口"},
        @{@"latitude":@"36.660534",@"longitude":@"117.145361",@"name":@"A1-B1商业3号门入口"}
        ,@{@"latitude":@"36.660486",@"longitude":@"117.143805",@"name":@"A1-B1商业1号门入口"}
        ]},
  @{@"lotId":@"1708",
        @"lotName":@"汉峪金谷A1地块",
    @"lotPoint":@[@{@"latitude":@"36.659474",@"longitude":@"117.145562",@"name":@"A1-2车库入口"},
  @{@"latitude":@"36.659402",@"longitude":@"117.143971",@"name":@"A1-5车库入口"}
,@{@"latitude":@"36.661188",@"longitude":@"117.145393",@"name":@"A1-1车库入口"},
  @{@"latitude":@"36.660095",@"longitude":@"117.144411",@"name":@"A1车库A1层人行入口"}
,@{@"latitude":@"36.660293",@"longitude":@"117.144556",@"name":@"A1-B1商业2号门入口"},
  @{@"latitude":@"36.660534",@"longitude":@"117.145361",@"name":@"A1-B1商业3号门入口"}
  ,@{@"latitude":@"36.660486",@"longitude":@"117.143805",@"name":@"A1-B1商业1号门入口"}
  ]},
  @{@"lotId":@"426",
    @"lotName":@"汉峪金谷A2地块",
    @"lotPoint":@[@{@"latitude":@"36.658566",@"longitude":@"117.145455",@"name":@"峪悦里芳草路2号门"},
  @{@"latitude":@"36.658566",@"longitude":@"117.145455",@"name":@"A2-6车库出入口"}
    ,@{@"latitude":@"36.659224",@"longitude":@"117.144881",@"name":@"A2-5车库出入口"},
  @{@"latitude":@"36.659474",@"longitude":@"117.145562",@"name":@"A2-1车库出入口"}
    ]},
 @{@"lotId":@"427",
    @"lotName":@"汉峪金谷A3地块",
    @"lotPoint":@[@{@"latitude":@"36.657972",@"longitude":@"117.147086",@"name":@"峪悦里晴日亭5号门"},@{@"latitude":@"36.657395",@"longitude":@"117.146775",@"name":@"峪悦里晴日亭6号门"}
    ,@{@"latitude":@"36.657413",@"longitude":@"117.147617",@"name":@"A3-2车库出入口"},@{@"latitude":@"36.656617",@"longitude":@"117.146421",@"name":@"A3-5车库出入口"}
    ,@{@"latitude":@"36.657585",@"longitude":@"117.145595",@"name":@"A3-4车库出入口"}
    ]},
  @{@"lotId":@"1707",
    @"lotName":@"汉峪金谷A4地块",
    @"lotPoint":@[@{@"latitude":@"36.660198",@"longitude":@"117.14646",@"name":@"A4-4车库入口"},@{@"latitude":@"36.661244",@"longitude":@"117.14954",@"name":@"A4-3车库入口"}
    ,@{@"latitude":@"36.662423",@"longitude":@"117.148896",@"name":@"A4-1车库入口"},@{@"latitude":@"36.661394",@"longitude":@"117.145892",@"name":@"A4-6车库入口"}
    ,@{@"latitude":@"36.661093",@"longitude":@"117.147142",@"name":@"A4-B1层商业5号口"},@{@"latitude":@"36.661291",@"longitude":@"117.147549",@"name":@"A4-B1层商业6号口"}
    ,@{@"latitude":@"36.661386",@"longitude":@"117.147844",@"name":@"A4-B1层商业7号口"},@{@"latitude":@"36.661648",@"longitude":@"117.148451",@"name":@"A4-B1层商业8号口"}
    ]}
    ];
    return [NSArray KT_modelArrayWithClass:[KTLocationDataModel class] json:array];
}



@end

@implementation KTLocationPointModel



@end
