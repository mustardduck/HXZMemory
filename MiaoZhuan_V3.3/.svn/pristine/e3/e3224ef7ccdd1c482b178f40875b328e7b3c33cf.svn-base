//
//  UIViewContriller+CRUI_HeaderView.h
//  CRCoreUnit
//
//  Created by abyss on 14/12/12.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRHeaderView.h"
#import <UIKit/UIKit.h>

@protocol CRHeaderViewDelegate;
@interface UIViewController (AddtionByCRUI_HeaderView)
- (void)showCRHeaderViewWith:(NSArray *)dataArray delegate:(id<CRHeaderViewDelegate>)delegate;
- (void)showCRHeaderViewWith:(NSArray *)dataArray height:(CGFloat)height delegate:(id<CRHeaderViewDelegate>)delegate;

- (void)showCRHeaderViewWith:(NSArray *)dataArray
                      height:(CGFloat)height
                    delegate:(id<CRHeaderViewDelegate>)delegate
                  scrollable:(BOOL)scroll;

- (void)addCRHeaderArrow;
- (void)refreshCRHeader:(NSArray *)array;
- (void)setCRHeaderLineWidthFit:(BOOL)flag;
@end


#pragma mark - RealTime Key
extern NSString *CRHeaderView_Key;