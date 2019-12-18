//
//  NSBundle+KTRes.h
//  KTFindCarSDK
//
//  Created by KT--stc08 on 2019/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (KTRes)
+(void)setBundle:(NSBundle*)bundle;
+(NSBundle*)getResBundel;
-(NSString*)localizedStringKey:(NSString*)key;
//设置语言 en zh-Hant zh-Hans
+(void)setLanguage:(NSString*)language;
@end

//#define KTLocalizedString(string) NSLocalizedStringFromTableInBundle(string, @"Localizable", [NSBundle getResBundel], nil)
#define KTLocalizedString(string) [[NSBundle getResBundel] localizedStringKey:string]
NS_ASSUME_NONNULL_END
