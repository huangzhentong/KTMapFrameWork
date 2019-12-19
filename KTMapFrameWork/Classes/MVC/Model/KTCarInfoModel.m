//
//  KTCarInfoModel.m
//  KTFindCarSDK
//
//  Created by KT--stc08 on 2019/4/1.
//

#import "KTCarInfoModel.h"
#import "NSBundle+KTRes.h"
@implementation KTCarInfoModel

@synthesize title,rightArray,imageURL;



-(NSArray*)leftArray
{
    return @[KTLocalizedString(@"KTFloor")?:@"",
             KTLocalizedString(@"KTParkSpace")?:@"",
             KTLocalizedString(@"KTParkAddresse")?:@""];
}



@end
