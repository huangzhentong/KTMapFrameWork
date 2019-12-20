//
//  NSObject+Window.m
//  AFNetworking
//
//  Created by KT--stc08 on 2019/12/20.
//

#import "NSObject+Window.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@implementation NSObject (Window)

+(void)load
{
    id object = [UIApplication sharedApplication].delegate;
    
    if(![object respondsToSelector:@selector(window)])
    {
        Method origMethod = class_getInstanceMethod([object class], @selector(window));
        SEL origsel = @selector(window);
        Method swizMethod = class_getInstanceMethod([self class], @selector(KT_window));
        SEL swizsel = @selector(KT_window);
        BOOL addMehtod = class_addMethod([self class], origsel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
        
    }
}

-(UIWindow*)KT_window{
   return  [[UIApplication sharedApplication] keyWindow];
}

@end
