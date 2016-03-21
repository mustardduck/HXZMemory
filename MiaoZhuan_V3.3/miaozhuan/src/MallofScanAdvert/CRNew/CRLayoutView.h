//
//  CRLayoutView.h
//  CRCoreUnit
//
//  Created by abyss on 14/12/19.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CRLayoutViewDelegate;
@interface CRLayoutView : UIView

@property (assign) NSInteger lineNumber;
@property (retain, readonly) NSMutableArray* buttonObjectArray;

@property (assign) id<CRLayoutViewDelegate> cr_delegate;

- (instancetype)initWithFrame:(CGRect)frame with:(NSArray *)buttonArray delegate:(id<CRLayoutViewDelegate>)delegate line:(NSInteger)line;

@end

@protocol CRLayoutViewDelegate <NSObject>

@optional

- (UIButton *)layoutView:(CRLayoutView *)view willbuttonCustomBy:(CGFloat)height;
- (UIButton *)layoutView:(CRLayoutView *)view the:(id)customButton shouldLayoutBy:(NSDictionary *)data;
- (void)layoutView:(CRLayoutView *)view button:(id)button shouldResponseButtonTouchAt:(NSInteger)buttonIndex;

@end