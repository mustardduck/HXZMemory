//
//  RCScrollView.m
//  miaozhuan
//
//  Created by abyss on 14/10/25.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RCScrollView.h"

@interface RCScrollView () <UIScrollViewDelegate>
{
    UITapGestureRecognizer *_tapGesture;
    
    //是否翻页
    BOOL _snapping;
    //加速度
    CGPoint _dragVelocity;
    //位移
    CGPoint _dragDisplacement;
    CGFloat _pageWidth;
    CGFloat _pageHeight;
    //
    BOOL _isStop;
}
@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , retain) UIScrollView *scrollView;
@property (nonatomic , retain) NSTimer *animationTimer;
@property (nonatomic , assign) NSTimeInterval animationDuration;

@end

@implementation RCScrollView
@synthesize scrollView     = _scrollView;
@synthesize contentViews   = _contentViews;
@synthesize animationTimer = _animationTimer;
@synthesize pageCon        = _pageCon;
@synthesize pageConPosition   =  _pageConPosition;
@synthesize advertMode  = _advertMode;

//- (BOOL)advertModel
//{
//    return self.advertModel;
//}

- (void)setAdvertMode:(BOOL)advertMode
{
    _advertMode = advertMode;
}

- (void)setTotalPageCount:(NSInteger)totalPageCount
{
    _totalPageCount = totalPageCount;
    if (_totalPageCount > 0)
    {
        [self configContentViews];
        [_animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
        [_animationTimer retain];
    }
    
    if (_pageConPosition == PageConPositonNone)
    {
        return;
    }
    
    float w =  _totalPageCount*20;
    float pageConleft = 0;
    if (_pageConPosition == PageConPositonMiddle)
    {
        pageConleft = (_scrollView.frame.size.width - w) /2;
    }
    else if (_pageConPosition == PageConPositonRight)
    {
        pageConleft = _scrollView.frame.size.width - w;
    }
    _pageCon = [[RRPageControl alloc] initWithFrame:CGRectMake(pageConleft , _scrollView.frame.size.height - 15, w, 10)];
    [self addSubview:_pageCon];
    _pageCon.imagePageStateNormal = [UIImage imageNamed:@"001.png"];
    _pageCon.imagePageStateHighlighted = [UIImage imageNamed:@"002.png"];
    _pageCon.numberOfPages = self.totalPageCount;
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        _animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [_animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.autoresizesSubviews = YES;
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.autoresizingMask = 0xFF;
        _scrollView.showsVerticalScrollIndicator = FALSE;
        _scrollView.showsHorizontalScrollIndicator = FALSE;
        _scrollView.contentMode = UIViewContentModeCenter;
        _scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
        _scrollView.delegate = self;
        _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame), 0);
        _scrollView.clipsToBounds = YES;
        [self addSubview:_scrollView];
        self.currentPageIndex = 0;
        _scrollView.pagingEnabled = YES;
        if (_advertMode)
        {
            _scrollView.pagingEnabled = NO;
            _pageWidth = 160;
            _pageHeight = _scrollView.height;
        }
    }
    return self;
}

#pragma mark -
#pragma mark - 私有函数

- (void)configContentViews
{
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in _contentViews)
    {
        contentView.userInteractionEnabled = YES;
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:_tapGesture];
        CGRect rightRect = contentView.frame;
        if (self.advertMode)
        {
            rightRect.origin = CGPointMake(160 * (counter ++), 0);
        }
        else
        {
#warning !
            rightRect.origin = CGPointMake(_scrollView.width * (counter ++), 0);
        }
        
        contentView.frame = rightRect;
        [_scrollView addSubview:contentView];
    }
#warning !
    [_scrollView setContentOffset:CGPointMake(_advertMode? 210:_scrollView.width, 0)];
}

//- (void)layoutSubviews
//{
//    if (_totalPageCount == 1)
//    {
//        self.userInteractionEnabled = NO;
//    }
//}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger ppreviousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 2];
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    NSInteger rrearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 2];
    
    if (_contentViews == nil)
    {
        _contentViews = [@[] mutableCopy];
    }
    [_contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex)
    {
        if (_advertMode)
        {
            [_contentViews addObject:self.fetchContentViewAtIndex(ppreviousPageIndex)];
        }
        
        [_contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
        [_contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
        [_contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
        
        if (_advertMode)
        {
            [_contentViews addObject:self.fetchContentViewAtIndex(rrearPageIndex)];
        }
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1)
    {
        return self.totalPageCount - 1;
    }
    else if (currentPageIndex == -2)
    {
        return self.totalPageCount - 2;
    }
    else if (currentPageIndex == self.totalPageCount)
    {
        return 0;
    }
    else if (currentPageIndex == self.totalPageCount + 1)
    {
        return 1;
    }
    else
    {
        return currentPageIndex;
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_animationTimer pauseTimer];
    _snapping = YES;
    _dragDisplacement = scrollView.contentOffset;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (_advertMode)
    {
        *targetContentOffset = scrollView.contentOffset;
        
        
        _dragVelocity = velocity;
        
        _dragDisplacement = CGPointMake(scrollView.contentOffset.x - _dragDisplacement.x, scrollView.contentOffset.y - _dragDisplacement.y);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate && _advertMode) [self snapToPage];
    [_animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    _snapping = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_advertMode)
    {
        int contentOffsetX = scrollView.contentOffset.x;
        if(contentOffsetX >= (_advertMode?210:320) + (_advertMode?160:_scrollView.width))
        {
            self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
//            NSLog(@"next，当前页:%d",self.currentPageIndex);
            [self configContentViews];
        }
        if(contentOffsetX <= 0)
        {
            self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
//            NSLog(@"previous，当前页:%d",self.currentPageIndex);
            [self configContentViews];
        }
        _pageCon.currentPage = self.currentPageIndex;
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(_advertMode? 210:_scrollView.width, 0) animated:YES];
    if (_advertMode) [self snapToPage];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if (_advertMode)
    {
        int contentOffsetX = scrollView.contentOffset.x;
        if(contentOffsetX >= (_advertMode?210:320) + (_advertMode?160:_scrollView.width))
        {
            self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
//            NSLog(@"next，当前页:%d",self.currentPageIndex);
            [self configContentViews];
        }
        if(contentOffsetX <= 50)
        {
            self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
//            NSLog(@"previous，当前页:%d",self.currentPageIndex);
            [self configContentViews];
        }
        _pageCon.currentPage = self.currentPageIndex;
        
        if (!_snapping) [self snapToPage];
        else  _snapping = NO;
    }
}

#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(_scrollView.contentOffset.x + (_advertMode?160:_scrollView.width), _scrollView.contentOffset.y);
    _snapping = NO;
    [_scrollView setContentOffset:newOffset animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock)
    {
        self.TapActionBlock(self.currentPageIndex);
    }
}

- (void)fireTimer
{
    if (!self) return;
    
//    NSLog(@"Timer Stop");
    if (!_isStop)
    {
        [_animationTimer invalidate];
        _isStop = YES;
    }
}

- (void)startTimer
{
    if (!self) return;
    
//    NSLog(@"Timer Star");
    if (_isStop)
    {
        [_animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
        _isStop = NO;
    }
}

- (void)dealloc
{
#warning memory持续增长的原因
    [_scrollView removeAllSubviews];
    
    [_tapGesture release];
    _animationTimer = nil;
    [_scrollView release];
    _scrollView = nil;
    [_pageCon release];
    _pageCon = nil;
    [_contentViews removeAllObjects];
    [_contentViews release];
    _contentViews = nil;
    
    [super dealloc];
}

#pragma pageControl

- (void)snapToPage
{
    if (_snapping == NO) return;
    //检查时间停止
    CGPoint pageOffset;
    pageOffset.x = [self pageOffsetForComponent:YES];
    pageOffset.y = [self pageOffsetForComponent:NO];
    
    
    CGPoint currentOffset = _scrollView.contentOffset;
    
    if (!CGPointEqualToPoint(pageOffset, currentOffset))
    {
        _snapping = YES;
        
        if (_advertMode)
        {
            if (pageOffset.x > 320) pageOffset.x = 320.f;
            [_scrollView setContentOffset:CGPointMake(pageOffset.x + 50,0) animated:YES];
        }
    }
    
    
    _dragVelocity = CGPointZero;
    _dragDisplacement = CGPointZero;
}

- (CGFloat)pageOffsetForComponent:(BOOL)isX {
    if (((isX ? CGRectGetWidth(self.bounds) : CGRectGetHeight(self.bounds)) == 0) || ((isX ? _scrollView.contentSize.width : _scrollView.contentSize.height) == 0))
        return 0;
    
    
    CGFloat pageLength = isX ? _pageWidth : _pageHeight;
    
    if (pageLength < FLT_EPSILON)
        pageLength = isX ? CGRectGetWidth(self.bounds) : CGRectGetHeight(self.bounds);
    
    pageLength *= _scrollView.zoomScale;
    
    
    CGFloat totalLength = isX ? _scrollView.contentSize.width : _scrollView.contentSize.height;
    
    CGFloat visibleLength = (isX ? CGRectGetWidth(self.bounds) : CGRectGetHeight(self.bounds)) * _scrollView.zoomScale;
    
    CGFloat currentOffset = isX ? _scrollView.contentOffset.x : _scrollView.contentOffset.y;
    
    CGFloat dragVelocity = isX ? _dragVelocity.x : _dragVelocity.y;
    
    CGFloat dragDisplacement = isX ? _dragDisplacement.x : _dragDisplacement.y;
    
    
    CGFloat newOffset;
    
    
    CGFloat index = currentOffset / pageLength;
    
    CGFloat lowerIndex = floorf(index);
    CGFloat upperIndex = ceilf(index);
    
    if (ABS(dragDisplacement) < 20 || dragDisplacement * dragVelocity < 0) {
        if (index - lowerIndex > upperIndex - index) {
            index = upperIndex;
        } else {
            index = lowerIndex;
        }
    } else {
        if (dragVelocity > 0) {
            index = upperIndex;
        } else {
            index = lowerIndex;
        }
    }
    
    
    newOffset = pageLength * index;
    
    if (newOffset > totalLength - visibleLength)
        newOffset = totalLength - visibleLength;
    
    if (newOffset < 0)
        newOffset = 0;
    
    
    return newOffset;
}

@end
