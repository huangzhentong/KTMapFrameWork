//
//  NSString+AddLineSpace.h
//  OperationalSystem
//
//  Created by KT--stc08 on 2018/8/6.
//  Copyright © 2018年 KT--stc08. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AddLineSpace)
//添加行间距
-(NSMutableAttributedString*)addLineSpacing:(CGFloat)lineSpace;

-(NSMutableAttributedString*)addLineSpacing:(CGFloat)lineSpace withTextAlignment:(NSTextAlignment)algnment;
@end
