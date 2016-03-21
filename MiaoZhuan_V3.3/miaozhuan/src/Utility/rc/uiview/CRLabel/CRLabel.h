//
//  CRLabel.h
//  test
//
//  Created by abyss on 14/11/25.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSUInteger cr_CRLABEL_ANIMATION_JUMTIMES = 100;     // 即数字跳100次
static CGFloat cr_CRLABEL_ANIMATION_JUMDURATION = 2.0;      // 默认动画时间
static NSString *cr_CRLABEL_UI_FORMAT_NORMAL = @"%.0f";     // 输出格式
static NSString *cr_CRLABEL_UI_FORMAT_UNIT = @"%.1f万";     // 输出格式

@protocol cr_LabelDelegate;
@interface CRLabel : UILabel
//数字
@property (assign, nonatomic) CGFloat numbers;
//动画开关
@property (assign, nonatomic) BOOL isAnimatingNumbers;
//是否有单位
@property (assign, nonatomic) BOOL hasUnit;
//动画时间随机
@property (assign, nonatomic) BOOL randAnmation;
@property (assign, nonatomic) id<cr_LabelDelegate> delegate;


//自定义动画
- (void)jumpNumberWithDuration:(CGFloat)duration from:(CGFloat)start to:(CGFloat)end;
@end

@protocol cr_LabelDelegate <NSObject>
@optional
//动画完成
- (void)label:(CRLabel *)label didFinishedAnimationg:(CGFloat)numbers;
//输出格式自定义
- (void)label:(CRLabel *)label shouldPrintfResultSelf:(CGFloat)numbers;
- (NSString *)label:(CRLabel *)label shouldPrintfResult:(CGFloat)numbers;
//frame改变
- (void)label:(CRLabel *)label didChangeTheFrame:(CGRect)labelFrame;
@end