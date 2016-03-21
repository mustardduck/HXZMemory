//
//  CRInfoNotify.h
//  test
//
//  Created by abyss on 14/11/24.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol cr_InfoNotifyDelegate;
@interface CRInfoNotify : UIControl
//点的位置
@property (assign, nonatomic) CGPoint rootPoint;
//现实文字
@property (retain, nonatomic) NSString *info;
//颜色
@property (retain, nonatomic) UIColor *color;
//透明度
@property (assign, nonatomic) CGFloat alpha;
@property (assign, nonatomic) NSUInteger tag;
//点击自动隐藏
@property (assign, nonatomic) BOOL isAutoHidden;
//箭头是否居中，默认右边
@property (assign, nonatomic, getter=isHookCenter) BOOL HookCenter;
@property (assign, nonatomic) id<cr_InfoNotifyDelegate> delegate;

//初始化
- (instancetype)initWith:(NSString *)title at:(CGPoint)point;
//出现和隐藏
- (void)display:(BOOL)show;
@end
@protocol cr_InfoNotifyDelegate <NSObject>
@optional
//点击事件代理
- (void)infoNotify:(CRInfoNotify *)infoNotify didTouchedAt:(CGPoint)point;
@end

@interface UIViewController (UIViewController_CRInfoNotify)
- (CRInfoNotify *)getInfoObject;
- (void)cr_showInfoNotify:(NSString *)str at:(CGPoint)point;
- (void)cr_showInfoNotify:(NSString *)str at:(CGPoint)point inColor:(UIColor *)color;

//快速调用cr_mz_showInfoNotify:at: 但是只能存在一个
- (void)cr_mz_showInfoNotify:(NSString *)str at:(CGPoint)point;
@end