//
//  RCScrollView.h
//  miaozhuan
//
//  Created by abyss on 14/10/25.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRPageControl.h"

//RCSrollView 滚动页 -- RCScrollViewInit(YourView,Frame,Position,Animations,Data)
//* YourView    :ScrollView指针
//* Inview      :添加到的图层(如self.view)
//* Frame       :CGFrame
//* Position    :PageCon的方位 None没有pagecon
//* advertMode  :广告模式（BOOL）
//* Animations  :滚动间隔时间
//* Data        :滚动页面数据(NSMutableArray)

#define RCScrollViewInit(YourView,Frame,Position,advertBool,Animations,Data) \
\
\
(YourView) = [[RCScrollView alloc] initWithFrame:(Frame) animationDuration:(Animations)];\
(YourView).pageConPosition = (Position);\
(YourView).advertMode = (advertBool);\
(YourView).fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex)\
{return (Data)[pageIndex];};\
(YourView).totalPageCount = (Data).count

//1.点击回调 - (void)RCScrollViewResponse:(NSInteger)pageIndex
//2.已经autorelease
//3.Data为NSMutableArray请事先创建好 并在页面退出时释放,存放UIview类型的数组
//4.需要协议 <UIScrollViewDelegate>
//5.NSTimer 会retain self,页面不会进入dealloc，请在popViewController的时候调用 fireTimer
//6.点击事件 (YourView).TapActionBlock = ^(NSInteger pageIndex) {}


@interface RCScrollView : UIView

typedef NS_OPTIONS(NSInteger,PageConPositon)
{
    PageConPositonNone    = 0,
    PageConPositonLeft    = 1,
    PageConPositonRight   = 2,
    PageConPositonMiddle  = 3,
};

@property (nonatomic, retain) RRPageControl    *pageCon;
@property (nonatomic, retain) NSMutableArray   *contentViews;
@property (nonatomic, assign) NSInteger        totalPageCount;   //请在fetchContentViewAtIndex之后调用
@property (nonatomic, assign) PageConPositon   pageConPosition;
@property (nonatomic, assign) BOOL             advertMode;

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

//页面block
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
//点击block
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);
//网络请求稍后

- (void)fireTimer;
//- (void)startTimer;

@end