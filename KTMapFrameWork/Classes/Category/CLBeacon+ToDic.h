//
//  CLBeacon+ToDic.h
//  cocore
//
//  Created by KT--stc08 on 2019/4/11.
//

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLBeacon (ToDic)
@property(nonatomic)double x;
@property(nonatomic)double y;

-(NSDictionary*)dict;
-(NSString*)beaconKey;
@end

NS_ASSUME_NONNULL_END
