//
//  ScrollerAdPageController.m
//  miaozhuan
//
//  Created by Santiago on 14-10-27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ScrollerViewWithTime.h"
#import "NSTimer+Addition.h"
#import "NetImageView.h"
#import "SMPageControl.h"

@interface ScrollerViewWithTime () <UIScrollViewDelegate>
{
    UIScrollView*       _view;
    int _nowPage;
    int _adNumber;
    NSTimer *_animationTimer;
    float _autoScrollInternal;
    SMPageControl *_pageController;
    
    //广告翻页宽度
    int _width;
    UIView  *_clearViewForSwipe;
    
    CGSize _pictureSize;
    
    BOOL _ifUseFreeStyle;
}

@end

@implementation ScrollerViewWithTime

-(void)setWidthSelf:(int)width{
    _width = width;
}


//使用默认样式初始化
- (instancetype) initWithView:(UIScrollView*)view
{
    if(!(self = [super init]))
    {
        return nil;
    }
    _view = [view retain];
    _view.delegate = self;
    
    _ifUseFreeStyle = NO;
    
    //设置是否整页翻动
    _view.pagingEnabled = YES;
    //设置是否反弹
    _view.bouncesZoom = YES;
    _view.scrollEnabled=YES;
    _view.userInteractionEnabled=YES;
    _view.delegate=self;
    _view.showsHorizontalScrollIndicator=NO;
    
    
    _nowPage  = 0;
    _adNumber = 0;
    
    _pageController = STRONG_OBJECT(SMPageControl, initWithFrame:CGRectMake(0, 0, 320, 20));
    [_pageController setPageIndicatorImage:[UIImage imageNamed:@"001"]];
    [_pageController setCurrentPageIndicatorImage:[UIImage imageNamed:@"002"]];
    _pageController.indicatorMargin = 6.0f;   //间距
    
    
    UIView* parentView = _view.superview;
    [parentView insertSubview:_pageController aboveSubview:_view];

    
    if ([SystemUtil aboveIOS6_0])
    {
        _pageController.pageIndicatorTintColor=[UIColor lightGrayColor];
        _pageController.currentPageIndicatorTintColor=[UIColor redColor];
        
    }
    //设置默认广告展示图片宽度
    _width = _view.frame.size.width;
    
    _ifUseFreeStyle = NO;
    
    return self;
}

//使用自定义样式初始化(公益广告）
- (instancetype) initWithView:(UIScrollView*)view andPSAsPictureSize:(CGSize)size{
    
    if(!(self = [super init]))
    {
        return nil;
    }
    _view = [view retain];
    _view.delegate = self;
    
    //设置是否整页翻动
    _view.pagingEnabled = NO;
    //设置是否反弹
    _view.bouncesZoom = YES;
    _view.scrollEnabled=YES;
    _view.userInteractionEnabled=YES;
    _view.delegate=self;
    _view.showsHorizontalScrollIndicator=NO;
    
    _pictureSize = size;
    
    _nowPage  = 0;
    _adNumber = 0;
    
    _pageController = STRONG_OBJECT(SMPageControl, initWithFrame:CGRectMake(0, 0, 320, 20));
    [_pageController setPageIndicatorImage:[UIImage imageNamed:@"001"]];
    [_pageController setCurrentPageIndicatorImage:[UIImage imageNamed:@"002"]];
    _pageController.indicatorMargin = 6.0f;   //间距
    
    
    
    
    UIView* parentView = _view.superview;
    [parentView insertSubview:_pageController aboveSubview:_view];
    
    
    if ([SystemUtil aboveIOS6_0])
    {
        _pageController.pageIndicatorTintColor=[UIColor lightGrayColor];
        _pageController.currentPageIndicatorTintColor=[UIColor redColor];
    }
    
    
    UISwipeGestureRecognizer *swipeLeft;
    swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeftFunction)];
    [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    UISwipeGestureRecognizer *swipeRight;
    swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRightFunction)];
    [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    
    
    _clearViewForSwipe = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _view.frame.size.width, _view.frame.size.height)];
    
    [_clearViewForSwipe addGestureRecognizer:swipeLeft];
    [_clearViewForSwipe addGestureRecognizer:swipeRight];
    
    [swipeLeft release];
    [swipeRight release];
    
    [_clearViewForSwipe setBackgroundColor:[UIColor clearColor]];
    
    
    [parentView insertSubview:_clearViewForSwipe aboveSubview:_view];
    
    
    UIButton *clickButton = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake(_view.frame.size.width-_pictureSize.width*2, 0, _pictureSize.width, _pictureSize.height));
    [clickButton setBackgroundColor:[UIColor clearColor]];
    
    [_clearViewForSwipe addSubview:clickButton];
    
    [clickButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //设置默认广告展示图片宽度
    _width = size.width + 25;

    _ifUseFreeStyle = YES;
    return self;
}

//使用自定义样式初始化
- (instancetype) initWithView:(UIScrollView*)view andPictureSize:(CGSize)size{
    
    if(!(self = [super init]))
    {
        return nil;
    }
    _view = [view retain];
    _view.delegate = self;
    
    //设置是否整页翻动
    _view.pagingEnabled = NO;
    //设置是否反弹
    _view.bouncesZoom = YES;
    _view.scrollEnabled=YES;
    _view.userInteractionEnabled=YES;
    _view.delegate=self;
    _view.showsHorizontalScrollIndicator=NO;
    
    _pictureSize = size;
    
    _nowPage  = 0;
    _adNumber = 0;
    
    _pageController = STRONG_OBJECT(SMPageControl, initWithFrame:CGRectMake(0, 0, 320, 20));
    [_pageController setPageIndicatorImage:[UIImage imageNamed:@"001"]];
    [_pageController setCurrentPageIndicatorImage:[UIImage imageNamed:@"002"]];
    _pageController.indicatorMargin = 6.0f;   //间距
    
    
    
    
    UIView* parentView = _view.superview;
    [parentView insertSubview:_pageController aboveSubview:_view];
    
    
    if ([SystemUtil aboveIOS6_0])
    {
        _pageController.pageIndicatorTintColor=[UIColor lightGrayColor];
        _pageController.currentPageIndicatorTintColor=[UIColor redColor];
    }
    
    
    UISwipeGestureRecognizer *swipeLeft;
    swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeftFunction)];
    [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    UISwipeGestureRecognizer *swipeRight;
    swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRightFunction)];
    [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    
    
    _clearViewForSwipe = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _view.frame.size.width, _view.frame.size.height)];
    
    [_clearViewForSwipe addGestureRecognizer:swipeLeft];
    [_clearViewForSwipe addGestureRecognizer:swipeRight];
    
    [swipeLeft release];
    [swipeRight release];
    
    [_clearViewForSwipe setBackgroundColor:[UIColor clearColor]];
    
    
    [parentView insertSubview:_clearViewForSwipe aboveSubview:_view];
    
    
//    UIButton *clickButton = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake(_view.frame.size.width-_pictureSize.width*2, 0, _pictureSize.width, _pictureSize.height));
    UIButton *clickButton = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake(10, 0, _view.frame.size.width, _view.frame.size.height));
    [clickButton setBackgroundColor:[UIColor clearColor]];
    
    [_clearViewForSwipe addSubview:clickButton];
    
    [clickButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //设置默认广告展示图片宽度
    _width = size.width+(_view.frame.size.width-2*size.width)*0.5;
    
    _ifUseFreeStyle = YES;
    return self;
}

- (void) dealloc
{
    [_animationTimer invalidate];
    _animationTimer = nil;
    
    [_pageController release];
    _pageController = nil;
    
    [_view release];
    _view = nil;
    
    [super dealloc];
}

- (void)buttonClicked{

    if (self.TapActionBlock)
    {
        self.TapActionBlock(_nowPage);
    }
    
    NSLog(@"the %d is clicked!!",_nowPage);
    [self.delegate scrollerPictureClicked:_nowPage];

}

- (void)swipeLeftFunction {
    
    _nowPage = (_nowPage+1)%_adNumber;
    
    if (_pageController.currentPage == _adNumber-1) {
        [_view setContentOffset:CGPointMake(_width*_nowPage, 0) animated:NO];
    }else{
        [_view setContentOffset:CGPointMake(_width*_nowPage, 0) animated:YES];
    }
    
    [_animationTimer resumeTimerAfterTimeInterval:_autoScrollInternal];
}

- (void)swipeRightFunction {
    
    if (_pageController.currentPage != 0) {
        _nowPage = (_nowPage-1)%_adNumber;
        [_view setContentOffset:CGPointMake(_width*_nowPage, 0) animated:YES];
    }
    [_animationTimer resumeTimerAfterTimeInterval:_autoScrollInternal];
}


- (void)setAutoScrollInternal:(float)internal {
    
    _autoScrollInternal = internal;
    
    [_animationTimer invalidate];
    
    _animationTimer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollInternal
                                                       target:self
                                                     selector:@selector(turnPage)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)addImageItems:(NSArray*)adImageArray {
    
    int oldNumber = _adNumber;
//    _adNumber += (int)[adImageArray count];
    _adNumber = [adImageArray count];
    _pageController.numberOfPages = _adNumber;
    float height = _view.frame.size.height;
    if (!_ifUseFreeStyle) {
        //默认样式
        _pageController.center = CGPointMake(_view.frame.size.width-[_pageController sizeForNumberOfPages:_adNumber].width*0.5-10, _view.frame.size.height-15);
        
        if (_adNumber == 1) {
            
            _pageController.hidden = YES;
        }else {
        
            _pageController.hidden = NO;
        }
        
        float width  = _view.frame.size.width;
        for(int i = oldNumber;i<_pageController.numberOfPages;++i)
        {
            NetImageView *imageTop = WEAK_OBJECT(NetImageView, initWithFrame:CGRectMake(i*width, 0, width, height));
            [imageTop requestPicture:[adImageArray objectAtIndex:i-oldNumber]];
            imageTop.contentMode = UIViewContentModeScaleToFill;
            imageTop.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
            [imageTop addGestureRecognizer:tapGesture];
            [_view addSubview:imageTop];
        }
        
        [_view setContentSize:CGSizeMake(width*_adNumber, height)];
        
    }else{
        //自定义样式
        _pageController.center = CGPointMake((SCREENWIDTH)*0.5, _view.frame.size.height-15);
        
        if (_adNumber == 1) {
            
            _pageController.hidden = YES;
        }else {
            
            _pageController.hidden = NO;
        }
        
        for(int i = oldNumber;i<_pageController.numberOfPages;++i)
        {
            
            NetImageView *imageTop = WEAK_OBJECT(NetImageView, initWithFrame:CGRectMake(i*_width+(SCREENWIDTH-_pictureSize.width)*0.5, _view.frame.size.height-_pictureSize.height, _pictureSize.width, _pictureSize.height));
            [imageTop requestPicture:[adImageArray objectAtIndex:i-oldNumber]];
            imageTop.contentMode = UIViewContentModeScaleToFill;
            imageTop.userInteractionEnabled = YES;
            
            [_view addSubview:imageTop];
        }
        
        [_view setContentSize:CGSizeMake(160*_adNumber+110, height)];
    }
}

#pragma mark - ScrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _view)
    {
        CGPoint point = _view.contentOffset;
        _pageController.currentPage = point.x/_width+0.5;
        _nowPage = (int)_pageController.currentPage;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [_animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [_animationTimer resumeTimerAfterTimeInterval:_autoScrollInternal];
}


- (void)turnPage {
    
    if (_adNumber) {
        _nowPage = (_nowPage+1)%_adNumber;
        if (_pageController.currentPage == _adNumber-1) {
            [_view setContentOffset:CGPointMake(_width*_nowPage, 0) animated:NO];
        }else{
            [_view setContentOffset:CGPointMake(_width*_nowPage, 0) animated:YES];
        }
    }
}

//点击响应
- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(_nowPage);
    }
}

+ (instancetype) controllerFromView:(UIScrollView*) view
{
    ScrollerViewWithTime* ret = WEAK_OBJECT(ScrollerViewWithTime, initWithView:view);
    [ret setAutoScrollInternal:2.0f];
    return ret;
}


+ (instancetype) controllerFromView:(UIScrollView*) view pictureSize:(CGSize)size {
    
    ScrollerViewWithTime* ret = WEAK_OBJECT(ScrollerViewWithTime, initWithView:view andPictureSize:size);
    [ret setAutoScrollInternal:2.0f];
    return ret;
}

+ (instancetype) controllerFromView:(UIScrollView*) view andPSAsPictureSize:(CGSize)size {
    
    ScrollerViewWithTime* ret = WEAK_OBJECT(ScrollerViewWithTime, initWithView:view andPSAsPictureSize:size);
    [ret setAutoScrollInternal:2.0f];
    return ret;
}

@end
