//
//  AppPopView.h
//  miaozhuan
//
//  Created by abyss on 14/10/31.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

//block 回调
#define AppPopBlock ^(void)
typedef void (^leftRCAppPopViewCallBackBlock) ();
typedef void (^rightRCAppPopViewCallBackBlock) ();
#define AppDrawBlock ^(UIView *blockView)
typedef void (^drawRectBlock) (UIView *blockView);
#warning 有错

@interface AppPopView : UIView

@property (retain, nonatomic) NSString *titleName;
@property (retain, nonatomic) UIView   *contentView;
@property (copy, nonatomic) drawRectBlock block;     //wait

- (void)up:(int64_t)height;
/* view弹出/收起 **/
- (void)show:(BOOL)show;

- (id)initWithAnimateUpOn:(UIViewController *)Con frame:(CGRect)frame left:(leftRCAppPopViewCallBackBlock)block1 right:(rightRCAppPopViewCallBackBlock)block2;

@end
