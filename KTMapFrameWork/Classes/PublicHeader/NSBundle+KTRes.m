//
//  NSBundle+KTRes.m
//  KTFindCarSDK
//
//  Created by KT--stc08 on 2019/3/29.
//

#import "NSBundle+KTRes.h"
#import "KTMapSDKManager.h"
@implementation NSBundle (KTRes)
static  NSBundle *imageBundle = nil;
+(NSBundle*)getResBundel
{
  
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *bundle = [NSBundle bundleForClass:[KTMapSDKManager class]];
        NSLog(@"bundle= %@",bundle);
        NSURL *url = [bundle URLForResource:@"KTRes" withExtension:@"bundle"];
        NSLog(@"bundle url =%@",url);
        if (url) {
            imageBundle = [NSBundle bundleWithURL:url];
        }
        else{
            imageBundle = nil;
        }
        
    });
    
    return imageBundle;
}
+(void)setBundle:(NSBundle*)bundle
{
    if (bundle) {
        imageBundle = bundle; 
    }
}
static NSString * localLanguage = nil;
static NSBundle *bundle = nil;
//设置语言 en zh-Hant zh-Hans
+(void)setLanguage:(NSString*)language
{
    localLanguage = language;
    bundle = nil;
}

-(NSString*)localizedStringKey:(NSString*)key
{
    
    if (bundle == nil) {
        // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language hasPrefix:@"en"]) {
            language = @"en";
        } else if ([language hasPrefix:@"zh"]) {
            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                language = @"zh-Hans"; // 简体中文
            } else { // zh-Hant\zh-HK\zh-TW
                if ([language rangeOfString:@"CN"].location != NSNotFound) {
                     language = @"zh-Hant"; // 繁體中文
                }
                else if ([language rangeOfString:@"HK"].location != NSNotFound)
                {
                     language = @"zh-HK"; // 繁體香港
                }
                else if ([language rangeOfString:@"TW"].location != NSNotFound)
                {
                     language = @"zh-TW"; // 繁體台湾
                }
                else
                {
                     language = @"zh-Hant"; // 繁體
                }
               
            }
        } else {
            language = @"en";
        }
        
        // 从MJRefresh.bundle中查找资源
        bundle = [NSBundle bundleWithPath:[self pathForResource:localLanguage?:language ofType:@"lproj"]];
    }
    NSString * value = nil;
     value = [bundle localizedStringForKey:key value:value table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];

}

@end
