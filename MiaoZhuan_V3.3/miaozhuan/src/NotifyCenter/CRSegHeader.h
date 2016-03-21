//
//  CRSegHeader.h
//  miaozhuan
//
//  Created by abyss on 14/11/29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

//统一设置，一旦修改所有页面生效，谨慎
//line比buttonTitle文字长的长度
static CGFloat cr_SegHeader_Line_AddWidth = 10.f;
//line的高度
static CGFloat cr_SegHeader_Line_Height   = 1.0f;

@protocol cr_SegHeaderDelegate;
@interface CRSegHeader : UIControl
//button数与buttonTitle 可重新赋值刷新button title及数量
@property (retain, nonatomic) NSArray *buttonArray;

//line的高度，单独修改一个页面提供
@property (assign, nonatomic) CGFloat lineSize;

//默认创建时响应的button,不需要请设置-
@property (assign, nonatomic) NSInteger autoawakIndex;              //defualt is 0
@property (assign, nonatomic) id<cr_SegHeaderDelegate> delegate;

//button右侧红点
@property (assign, nonatomic) BOOL hasPoint;                        //defualt is no
//控制某button消失与出现
- (void)bringPointForIndex:(NSInteger)index show:(BOOL)show;
- (instancetype)initWithDelegate:(id<cr_SegHeaderDelegate>)delegate;
@end

@protocol cr_SegHeaderDelegate <NSObject>
@optional
//点击获取button事件响应
- (void)button:(UIButton *)button didBetouch:(NSInteger)buttonIndex;
@end
