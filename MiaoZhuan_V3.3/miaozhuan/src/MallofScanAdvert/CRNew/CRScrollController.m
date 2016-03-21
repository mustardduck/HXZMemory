//
//  CRScrollController.m
//  miaozhuan
//
//  Created by abyss on 15/1/6.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "CRScrollController.h"
#import "NSTimer+Addition.h"
#import "NetImageView.h"

#import "SMPageControl.h"

//#import "UserInfo.h"

BOOL        CRSC_Debug = NO;
CGFloat     CRSC_Defalut_TimeATP    = 5.f;
CGFloat     CRSC_Defalut_FixPageCon = 10.f;
NSString*   CRSC_Defalut_StringD    = @"Image";
NSString*   CRSC_Defalut_ImgHold    = nil;

#define Debug(_something) \
if(CRSC_Debug == YES)\
{ _something }\

@interface CRScrollController () <UIScrollViewDelegate>
{
    int     _currentPage;
    int     _totalNumber;
    BOOL    _DidSetPagecon;
    
    UIView* _parentView;
}
@property (retain, nonatomic) UIScrollView* view;
@property (retain, nonatomic) SMPageControl* pageCon;
@property (retain, nonatomic) NSTimer* animationTimer;
@end

@implementation CRScrollController

- (void)remove
{
    [_animationTimer invalidate];
    [self release];
}

- (void) dealloc
{
    CRDEBUG_DEALLOC();
    
    [_view release];
    _view.delegate = nil;
    _view = nil;
    [_pageCon release];
    
    [super dealloc];
}

//使用默认样式初始化
- (instancetype) initWithView:(UIScrollView*)view
{
    if(!(self = [super init]))
    {
        return nil;
    }
    
    _view = [view retain];
    [self initScrollView:_view];
    [self initPageControl];

    //Default Setting
    {
        _positon      = CRSC_PCPRight;
        _timeATP      = 0;
        _currentPage  = 0;
        _totalNumber  = 0;
    }
    
    Debug(NSLog(@"%@ init",self););
    return self;
}

- (void)initScrollView:(UIScrollView*)view
{
    _view.delegate = self;
    
    _view.pagingEnabled = YES;
    _view.bouncesZoom   = YES;
    
    _view.showsHorizontalScrollIndicator = NO;
}

- (void)initPageControl
{
    _pageCon = [[SMPageControl alloc] init];
    _pageCon.frame = CGRectMake(0, 0, 320, 20);
    _pageCon.indicatorMargin = 6.0f;                    //间距
    
    [_pageCon setPageIndicatorImage:[UIImage imageNamed:@"001"]];
    [_pageCon setCurrentPageIndicatorImage:[UIImage imageNamed:@"002"]];
    
    _parentView = _view.superview;
    [_parentView insertSubview:_pageCon aboveSubview:_view];
}

#pragma mark - Event

- (void)CRScrollControllerTap
{
    Debug(NSLog(@"%@ tap",self););
    
    if (_delegate && [_delegate respondsToSelector:@selector(scrollView:didSelectPage:)])
    {
        [_delegate scrollView:self didSelectPage:_pageCon.currentPage];
    }
    
    if (_tapBlock && !_justHolder)
    {
        _tapBlock(_pageCon.currentPage);
    }
}

#pragma mark - animation

- (void)setAutoScrollInternal:(float)internal
{
    Debug(NSLog(@"%@ timeATP %f",self,_timeATP););
    _timeATP = internal;
    [_animationTimer invalidate];
    _animationTimer = [NSTimer scheduledTimerWithTimeInterval:_timeATP
                                                       target:self
                                                     selector:@selector(turnPage)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _view)
    {
        CGPoint point = _view.contentOffset;
        int page = point.x/_view.width + 0.5;
        
        if (page == 0)
        {
            page = _totalNumber;
        }
        if (page == _totalNumber + 1)
        {
            page = 1;
        }
        _pageCon.currentPage = page - 1;
    
        _currentPage = (int)_pageCon.currentPage;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _view.userInteractionEnabled = NO;
    [_animationTimer resumeTimerAfterTimeInterval:_timeATP];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _view.userInteractionEnabled = YES;
    CGPoint point = _view.contentOffset;
    int page = point.x/_view.width + 0.5;
    if (page == 0)
    {
        page = _totalNumber;
        [scrollView setContentOffset:CGPointMake(_view.width*page, 0) animated:NO];
    }
    else if (page == _totalNumber + 1)
    {
        page = 1;
        [scrollView setContentOffset:CGPointMake(_view.width*page, 0) animated:NO];
    }
    _currentPage = (int)_pageCon.currentPage + 1;
    Debug(NSLog(@"%@ page: %d - %d:%f",self, (int)_pageCon.currentPage,_currentPage,scrollView.contentOffset.x););
}

- (void)turnPage
{
    if (_totalNumber)
    {
        if (_pageCon.currentPage == _totalNumber - 1)
        {
            [_view setContentOffset:CGPointMake(0, 0) animated:NO];
            [_view setContentOffset:CGPointMake(_view.width, 0) animated:YES];
        }
        else
        {
            [_view setContentOffset:CGPointMake(_view.width*(_pageCon.currentPage + 2), 0) animated:YES];
        }
    }
}

#pragma mark - DataSource

- (void)setPicArray:(NSArray *)picArray
{
    if (!picArray || 0 == picArray.count)
    {
        [self setPicArray:@[@""]];
        _justHolder = YES;
        return;
    }
    
    if (_picArray.count > 0)
    {
        for (id object in _view.subviews)
        {
            if ([object isKindOfClass:[NetImageView class]])
            {
                [object removeFromSuperview];
            }
        }
    }
    
    _picArray = picArray;
    [_picArray retain];
    
    int count = 0;
    NSString* firstImg = nil;
    NSString* lastImg  = nil;
    
    _totalNumber = (int)[picArray count];
    _pageCon.numberOfPages = _totalNumber;
    
    if (0 == _totalNumber)
    {
        Debug(NSLog(@"%@ PicArray No Data",self);)
        return;
    }
    
    if (1 == _totalNumber)
    {
        Debug(NSLog(@"%@ PicArray 1 , can`t scroll",self);)
        _view.scrollEnabled = NO;
        _pageCon.hidden = YES;
        
        [self setTimeATP:MAXFLOAT];
    }
    else
    {
        _view.scrollEnabled = YES;
        _pageCon.hidden = NO;
        [self setTimeATP:_timeATP];
        
        NetImageView *first     = nil;
        NetImageView *last      = nil;
        
        firstImg = [self forceToString:[picArray.lastObject copy]];
        lastImg  = [self forceToString:[picArray.firstObject copy]];
        
        first = [self setupImage:count++ url:firstImg];
        [_view addSubview:first];
        
        last = [self setupImage:_totalNumber + 1 url:lastImg];
        [_view addSubview:last];
    }
    
    if (!_DidSetPagecon)
    {
        {
            if (_positon == CRSC_PCPNone)
            {
                _pageCon.hidden = YES;
            }
            else if (_positon & CRSC_PCPLeft)
            {
                _pageCon.alignment = SMPageControlAlignmentLeft;
                _pageCon.left += CRSC_Defalut_FixPageCon;
            }
            else if (_positon & CRSC_PCPMiddle)
            {
                _pageCon.alignment = SMPageControlAlignmentCenter;
            }
            else if (_positon & CRSC_PCPRight)
            {
                _pageCon.alignment = SMPageControlAlignmentRight;
            _pageCon.left -= CRSC_Defalut_FixPageCon;
            }
        }
        _pageCon.top = _view.height - 22;
        _DidSetPagecon = YES;
    }
    
    for (id objct in picArray)
    {
        NSString* ret       = nil;
        NetImageView* image = nil;
        
        ret = [self forceToString:objct];
        
        image = [self setupImage:count url:ret];
        count ++;
        [_view addSubview:image];
    }
    
    [_view setContentSize:CGSizeMake(_view.width*(_totalNumber + 2), _view.height)];
    [_view setContentOffset:CGPointMake(_totalNumber>1?_view.width:0, 0) animated:YES];
    
    [_view.layer needsDisplay];
}

- (NSString *)forceToString:(id)objct
{
    NSString* ret = nil;
    
    if ([objct isKindOfClass:[NSDictionary class]])
    {
        objct = ((NSDictionary *)objct).wrapper;
    }
    
    if ([objct isKindOfClass:[DictionaryWrapper class]])
    {
        if (!CRSC_Defalut_StringD) return @"Image";
        
        _key = _key?_key:CRSC_Defalut_StringD;
        
        ret = [((DictionaryWrapper *)objct) getString:_key];
    }
    
    if ([objct isKindOfClass:[NSString class]])
    {
        ret = (NSString *)objct;
    }
    else
    {
        if (ret == nil) ret = @"";
    }
    
    if ([ret isEqualToString: @""]) Debug(NSLog(@"%@ can`t get url",self););
    return ret;
}

#pragma mark - setter/getter

- (NetImageView *)setupImage:(int)count url:(NSString *)ret
{
    NetImageView* image = [[[NetImageView alloc] init] autorelease];
    image.holderColor = _isBackWhite?[UIColor whiteColor]:nil;
    image.zoom = _picZoom>0.1?_picZoom:0.55f;
    image.frame = CGRectMake(count*_view.width, 0, _view.width, _view.height);
    
    if (CRSC_Defalut_ImgHold)
    {
        [image requestCustom:ret
                       width:image.width*2
                      height:image.height*2
                 placeHolder:CRSC_Defalut_ImgHold];
    }
    else
    {
        [image requestCustom:ret width:image.width*2 height:image.height*2];
    }
    
    __block CRScrollController* weakself = self;
    [image setTapActionWithBlock:^{
        [weakself CRScrollControllerTap];
    }];
    
    return image;
}

- (void)setTapBlock:(CRSCTapBlock)tapBlock
{
    _tapBlock = nil;
    if (tapBlock)
    {
        _tapBlock = [tapBlock copy];
    }
}

- (void)setTimeATP:(CGFloat)timeATP
{
    [self setAutoScrollInternal:timeATP];
    _timeATP = timeATP;
}

#pragma mark - Instance

+ (instancetype)controllerFromView:(UIScrollView*)view
{
    CRScrollController* ret = STRONG_OBJECT(CRScrollController, initWithView:view);
    [ret setTimeATP:5.0f];
    return ret;
}

@end
