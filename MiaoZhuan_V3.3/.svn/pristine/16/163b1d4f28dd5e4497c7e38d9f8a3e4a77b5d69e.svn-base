//
//  UIViewContriller+CRUI_HeaderView.m
//  CRCoreUnit
//
//  Created by abyss on 14/12/12.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import "UIViewContriller+CRUI_HeaderView.h"

#import <objc/runtime.h>

//#import "Define+UIBox.h"
//#import "Define+Debug.h"

NSString *CRHeaderView_Key = @"__CRHeaderView_Key";

@interface UIViewController ()<CRHeaderViewDelegate>
@end
@implementation UIViewController (AddtionByCRUI_HeaderView)

- (void)showCRHeaderViewWith:(NSArray *)dataArray delegate:(id<CRHeaderViewDelegate>)delegate;
{
    [self showCRHeaderViewWith:dataArray height:40.f delegate:delegate];
}

- (void)showCRHeaderViewWith:(NSArray *)dataArray height:(CGFloat)height delegate:(id<CRHeaderViewDelegate>)delegate;
{
    [self showCRHeaderViewWith:dataArray frame:CGRectMake(0, 0, SCREENWIDTH, height) delegate:delegate scrollable:NO];
}

- (void)showCRHeaderViewWith:(NSArray *)dataArray height:(CGFloat)height delegate:(id<CRHeaderViewDelegate>)delegate scrollable:(BOOL)scroll
{
    [self showCRHeaderViewWith:dataArray frame:CGRectMake(0, 0, SCREENWIDTH, height) delegate:delegate scrollable:scroll];
}

- (void)showCRHeaderViewWith:(NSArray *)dataArray frame:(CGRect)frame delegate:(id<CRHeaderViewDelegate>)delegate scrollable:(BOOL)scroll;
{
    if (0 == [dataArray count])     LOG_WARN(@"dataArray is nil");
    if (CGRectIsEmpty(frame))       LOG_WARN(@"frame is nil");
    
    
    CRHeaderView *header = [self realHeaderManager];
    if (!header)
    {
        header = [[[CRHeaderView alloc] initWithFrame:frame with:dataArray delegate:delegate] autorelease];
        
        if (scroll) header.equalButtonWidh = NO;
        [self setrealHeaderManager:header];
        [self.view addSubview:header];
    }
}

- (void)addCRHeaderArrow
{
    CRHeaderView *header = [self realHeaderManager];
    if (header)
    {
        header.hasArrow = YES;
    }
    else
    {
        APP_ASSERT(false && @"no CRHeader was install");
    }
}

- (void)setCRHeaderLineWidthFit:(BOOL)flag
{
    CRHeaderView *header = [self realHeaderManager];
    if (header)
    {
        header.lineWidthFit = flag;
    }
    else
    {
        APP_ASSERT(false && @"no CRHeader was install");
    }
}

- (void)refreshCRHeader:(NSArray *)array
{
    CRHeaderView *header = [self realHeaderManager];
    if (header)
    {
        header.buttonArray = array;
    }
    else
    {
        APP_ASSERT(false && @"no CRHeader was install");
    }
}

#pragma mark - RealTime

- (CRHeaderView *)realHeaderManager
{
    return objc_getAssociatedObject(self, &CRHeaderView_Key);
}

- (void)setrealHeaderManager:(CRHeaderView *)realHeaderManager
{
    objc_setAssociatedObject(self, &CRHeaderView_Key, realHeaderManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
