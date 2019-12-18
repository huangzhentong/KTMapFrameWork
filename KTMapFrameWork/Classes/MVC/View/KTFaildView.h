//
//  KTFaildView.h
//  AFNetworking
//
//  Created by KT--stc08 on 2019/4/25.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface KTFaildView : UIView
@property(nonatomic,strong)UIButton *button;
-(void)showError:(NSString*)errorString;
@end

NS_ASSUME_NONNULL_END
