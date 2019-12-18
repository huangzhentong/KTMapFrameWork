//
//  NSMutableArray+KTCacheArray.m
//  Network
//
//  Created by KT--stc08 on 2019/5/24.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "NSMutableArray+KTCacheArray.h"
#import <objc/runtime.h>
@implementation NSMutableArray (KTCacheArray)


+(void)load
{
    [self hft_hookOrigMenthod:@selector(addObject:) NewMethod:@selector(addLimitobject:)];
    [self hft_hookOrigMenthod:@selector(addObjectsFromArray:) NewMethod:@selector(addLimitArray:)];

   
}
+ (BOOL)hft_hookOrigMenthod:(SEL)origSel NewMethod:(SEL)altSel {
     Class class = NSClassFromString(@"__NSArrayM");
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method altMethod = class_getInstanceMethod(class, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    BOOL didAddMethod = class_addMethod(class,origSel,
                                        method_getImplementation(altMethod),
                                        method_getTypeEncoding(altMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,altSel,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, altMethod);
    }
    
    return YES;
}


-(void)setCountLimit:(NSInteger)countLimit
{
    objc_setAssociatedObject(self, @selector(countLimit), @(countLimit), OBJC_ASSOCIATION_ASSIGN);
}
-(NSInteger)countLimit
{
    return [objc_getAssociatedObject(self, @selector(countLimit)) integerValue];
}

-(void)addLimitobject:(id)object
{
    [self addLimitobject:object];
    if (self.countLimit <= 0) {
        
    }
    else
    {
        
        if(self.count>self.countLimit)
        {
            [self removeObjectAtIndex:0];
        }
    }
}

-(void)addLimitArray:(NSArray*)otherArray
{
    if (self.countLimit == 0) {
        [self addLimitArray:otherArray];
    }
    else{
        NSInteger beyondCount = self.count+otherArray.count - self.countLimit;
        if(beyondCount>0 )
        {
            if (self.count>=beyondCount) {
                NSIndexSet *set = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, beyondCount)];
                [self removeObjectsAtIndexes:set];
                [self addLimitArray:otherArray];
            }
            else
            {
              
                NSMutableArray *array = [NSMutableArray arrayWithArray:otherArray];
                NSIndexSet *set = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, beyondCount-self.count)];
                [array removeObjectsAtIndexes:set];
                [self removeAllObjects];
               [self addLimitArray:array];
            }
            
            
        }
        else{
             [self addLimitArray:otherArray];
        }
       
    }
    
}

@end
