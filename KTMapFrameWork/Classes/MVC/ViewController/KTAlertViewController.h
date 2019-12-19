//
//  KTAlertViewController.h
//  cocore
//
//  Created by KT--stc08 on 2019/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//按钮动作事件
@interface KTAlertAction : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)void(^block)(void);

+(instancetype)actionWithTitle:(nullable NSString*)title withAction:( nullable void(^)(void))block;

@end
//提示框
@interface KTAlertViewController : UIViewController
@property(nonatomic,copy)NSString *titleString;                 //标题
@property(nonatomic,copy)NSAttributedString *attTitle;
@property(nonatomic,copy)NSString *message;                     //内容
@property(nonatomic,copy)NSAttributedString *attMessage;
@property(nonatomic,copy)UIImage *image;                        //图片
@property(nonatomic,strong)UIView * middleView;                 //中间图层


+(instancetype)alertViewWithTitle:(nullable NSString*)title withImage:(nullable UIImage*)image withMessage:(nullable NSString*)message;
//添加按钮事件
-(void)addAction:(KTAlertAction*)action;

@end







NS_ASSUME_NONNULL_END
