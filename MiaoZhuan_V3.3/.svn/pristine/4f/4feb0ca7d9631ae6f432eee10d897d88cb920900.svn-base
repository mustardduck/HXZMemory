//
//  CRScrollController.h
//  miaozhuan
//
//  Created by abyss on 15/1/6.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
/** CRScrollController CRSC 
 *  App统一样式参数
 */
extern BOOL         CRSC_Debug;                 //Debug模式
extern CGFloat      CRSC_Defalut_TimeATP;       //默认翻页时间
extern CGFloat      CRSC_Defalut_FixPageCon;    //修复pageCon距离
extern NSString*    CRSC_Defalut_StringD;       //默认读取字段
extern NSString*    CRSC_Defalut_ImgHold;       //默认加载默认图

/** PageControllPositon PCP 
 *  pageCon 方位
 */
typedef NS_OPTIONS(NSInteger,CRSC_PCP)
{
    CRSC_PCPNone    = 0,
    CRSC_PCPLeft    = 1 << 0,
    CRSC_PCPRight   = 1 << 1,
    CRSC_PCPMiddle  = 1 << 2,
};

typedef void (^CRSCTapBlock) (NSInteger index);

@protocol CRSCDelegate;
@interface CRScrollController : NSObject
@property (assign) id<CRSCDelegate> delegate;

/** 数据源 */
@property (retain, nonatomic) NSArray* picArray;
/** 点击回调:不建议使用，请用__block调用参数检查dealloc */
@property (copy, nonatomic) CRSCTapBlock tapBlock;
@property (assign, nonatomic, readonly) BOOL justHolder;
/** 实例化 */
+ (instancetype)controllerFromView:(UIScrollView*)view;
/** realse */
- (void)remove;

/** CRScrollController CRSC
 *  自定义样式
 */
/** 字段读取 */
@property (retain, nonatomic) NSString* key;
/** 背景图缩放 */
@property (assign, nonatomic) CGFloat  picZoom;
/** 翻页时间 */
@property (assign, nonatomic) CGFloat  timeATP;
/** pagecontrol位置:默认右边 */
@property (assign, nonatomic) CRSC_PCP positon;
/** holder图颜色:白色/灰色 */
@property (assign, nonatomic) BOOL     isBackWhite;
@end

@protocol CRSCDelegate <NSObject>
@optional
/** 点击回调 */
- (void)scrollView:(CRScrollController *)view didSelectPage:(NSInteger)index;
@end