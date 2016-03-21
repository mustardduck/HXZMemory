//
//  CRHeaderView.h
//  CRCoreUnit
//
//  Created by abyss on 14/12/11.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRHeaderItem;
@protocol CRHeaderViewDelegate;
@interface CRHeaderView : UIScrollView

@property (assign, readonly)  CGFloat       realHeight;     //the real height of the CRHeaderView will + Line/Separator height (3)

@property (assign, nonatomic) BOOL          needCheckReTouch;
@property (assign)            BOOL          cancelAutoAwak;
@property (assign)            BOOL          equalButtonWidh;//the width of button is equal
@property (assign)            BOOL          lineWidthFit;   //Default is yes
@property (assign, nonatomic) BOOL          hasLine;        //Default height is 2
@property (assign, nonatomic) BOOL          hasSeparator;   //Default height is 1
@property (assign, nonatomic) BOOL          hasArrow;       //Default is no

@property (assign)            NSInteger     startPage;

@property (retain, nonatomic) NSArray*      buttonArray;    //NSString or NSDictionary,if it is NSDictionary,has key "title"

@property (assign) id<CRHeaderViewDelegate> cr_delegate;

- (instancetype)initWithFrame:(CGRect)frame with:(NSArray *)buttonArray delegate:(id<CRHeaderViewDelegate>)delegate;

@end

@protocol CRHeaderViewDelegate <NSObject>

@optional
- (UIButton *)headerView:(CRHeaderView *)header buttonNeedCustomAt:(CGFloat)height;
- (UIButton *)headerView:(CRHeaderView *)header button:(id)customButton shouldLayout:(NSDictionary *)data;

- (void)headerView:(CRHeaderView *)header button:(UIButton *)button didTouchedAt:(NSInteger)buttonIndex;
@end



extern CGFloat CRHeaderView_Default_Height;
extern CGFloat CRHeaderView_Default_Line_Height;
extern CGFloat CRHeaderView_Default_Line_ExtraWidth;
extern CGFloat CRHeaderView_Default_Separator_Height;