//
//  NSString+AddLineSpace.m
//  OperationalSystem
//
//  Created by KT--stc08 on 2018/8/6.
//  Copyright © 2018年 KT--stc08. All rights reserved.
//

#import "NSString+AddLineSpace.h"

@implementation NSString (AddLineSpace)
-(NSMutableAttributedString*)addLineSpacing:(CGFloat)lineSpace
{
    return [self addLineSpacing:lineSpace withTextAlignment:NSTextAlignmentLeft];
}

-(NSMutableAttributedString*)addLineSpacing:(CGFloat)lineSpace withTextAlignment:(NSTextAlignment)algnment
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpace];
    [paragraphStyle setAlignment:algnment];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    
    return attributedString;
}
@end
