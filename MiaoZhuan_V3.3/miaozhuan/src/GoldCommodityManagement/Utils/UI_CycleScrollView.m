//
//  UI_CycleScrollView.m
//  Demo
//
//  Created by Nick on 15/5/5.
//  Copyright (c) 2015年 Nick. All rights reserved.
//

#import "UI_CycleScrollView.h"
#import "SMPageControl.h"
#import "NetImageView.h"

static CGFloat horizontalSpace = 10.f;                                      //横向间隙
static CGFloat verticalSpace = 10.f;                                        //纵向间隙
static int     startPage = 5000;
static CGFloat s_time = 5.f;                                                //滑动间隔时间

@interface UI_CycleScrollView ()<UIScrollViewDelegate>
{
    int             _count;                                                      //图片增加后总数
    CGFloat         _imageHeight;
    CGFloat         _imageWidth;
    
    NSMutableArray  *_imageViews;                                           //ImageView 存储
    
    NSUInteger      _firstStartPage;
    
    int             _Num;
    int             _origCount;                                                   //原来图片数
    
    NSTimer         *_animationTimer;
}
@property (nonatomic, strong) UIScrollView   *scrollView;
@property (nonatomic, assign) NSInteger last_page;
@property (nonatomic, assign) NSInteger current_page;

@property (nonatomic, strong) SMPageControl* pageCon;

@end

@implementation UI_CycleScrollView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.delegate = self;
        _scrollView.clipsToBounds = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_scrollView];//118 34  59 17
        
        
        _imageHeight = _scrollView.frame.size.height - verticalSpace*2;
        _imageWidth = (_scrollView.frame.size.width - 2 * horizontalSpace)/2;
        _scrollView.bounds = CGRectMake(0, 0, _imageWidth + horizontalSpace, _imageHeight);
        
        _imageViews = [[NSMutableArray alloc] init];
        _pictureUrls = [[NSMutableArray alloc] init];
        [self initPageControl];
        
        
        _animationTimer = [NSTimer scheduledTimerWithTimeInterval:s_time
                                                           target:self
                                                         selector:@selector(turnPage)
                                                         userInfo:nil
                                                          repeats:YES];
        
        
    }
    return self;
}


- (void)turnPage
{
    if (_origCount && _origCount > 2)
    {
        [_scrollView scrollRectToVisible:CGRectMake(_scrollView.contentOffset.x + _scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _imageHeight) animated:YES];
    }
    
    if (_origCount && _origCount == 2)
    {
        NSUInteger page = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
        
//        NSLog(@"ppp :%ld", page);
        if(page == 0)
        {
            [_scrollView scrollRectToVisible:CGRectMake(_scrollView.contentOffset.x + _scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _imageHeight) animated:YES];
            _pageCon.currentPage = 1;
        }
        else if(page == 1)
        {
            _pageCon.currentPage = 0;
            [_scrollView scrollRectToVisible:CGRectMake(_scrollView.contentOffset.x - _scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _imageHeight) animated:YES];
        }
    }
}

- (void)initPageControl
{
    _pageCon = [[SMPageControl alloc] init];
    _pageCon.frame = CGRectMake(0, self.frame.size.height - 35, [[UIScreen mainScreen] applicationFrame].size.width, 20);
    _pageCon.indicatorMargin = 6.0f;                    //间距
    
    [_pageCon setPageIndicatorImage:[UIImage imageNamed:@"001"]];
    [_pageCon setCurrentPageIndicatorImage:[UIImage imageNamed:@"002"]];
    _pageCon.alignment = SMPageControlAlignmentCenter;
    
    UIView *parentView = _scrollView.superview;
    [parentView insertSubview:_pageCon aboveSubview:_scrollView];
}


-(void)setPictureUrls:(NSMutableArray *)pictureUrls
{
    _origCount = (int)[pictureUrls count];
    _pageCon.numberOfPages = _origCount;
    
    [_pictureUrls addObjectsFromArray:pictureUrls];
    
    if([pictureUrls count] < 8)
    {
        if([pictureUrls count] == 3)
        {
            [_pictureUrls addObjectsFromArray:pictureUrls];
            [_pictureUrls addObjectsFromArray:pictureUrls];
        }
        else if([pictureUrls count] > 3)
        {
//            [_animationTimer invalidate];
            
            [_pictureUrls addObjectsFromArray:pictureUrls];
        }
        
        if([pictureUrls count] == 1)
        {
            [_animationTimer invalidate];
            _pageCon.hidden = YES;
            
            _scrollView.contentSize = CGSizeMake(0 , _scrollView.frame.size.height);
            
            NetImageView *imageView = [[NetImageView alloc] initWithFrame:CGRectMake((_scrollView.frame.size.width - _imageWidth)/2 , 0, _imageWidth, _imageHeight)];
            imageView.tag = 0;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePress:)];
            [imageView addGestureRecognizer:singleTap];
            
            [imageView requestPic:[_pictureUrls objectAtIndex:0] size:CGSizeMake(_imageWidth, _imageHeight) placeHolder:YES];
            
            [_scrollView addSubview:imageView];
            
            return;
        }
        
        if([pictureUrls count] == 2)
        {
//            [_animationTimer invalidate];
            
            _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * 2, _scrollView.frame.size.height);
            
            for(int i = 0; i < [_pictureUrls count]; i++)
            {
                NetImageView *imageView = [[NetImageView alloc] initWithFrame:CGRectMake(i * horizontalSpace + _imageWidth * i + horizontalSpace/2, 0, _imageWidth, _imageHeight)];
                imageView.tag = i;
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePress:)];
                [imageView addGestureRecognizer:singleTap];
                
                [imageView requestPic:[_pictureUrls objectAtIndex:i] size:CGSizeMake(_imageWidth, _imageHeight) placeHolder:YES];
                
                [_scrollView addSubview:imageView];
            }
            
            return;
        }
    }
    
    int count = (int)[_pictureUrls count];
    
    _count = count;
    
    if(count < 1) return;
    
    _scrollView.contentSize = CGSizeMake(_imageWidth * startPage * 2 + horizontalSpace * (startPage * 2 - 1) + horizontalSpace , _scrollView.frame.size.height);
    
        for(int i = 0; i < count; i ++)
        {
            NetImageView *imageView = [[NetImageView alloc] initWithFrame:CGRectMake((startPage+i) * _imageWidth + (startPage+i) * horizontalSpace + horizontalSpace/2 , 0, _imageWidth, _imageHeight)];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePress:)];
            [imageView addGestureRecognizer:singleTap];
            
            [imageView requestPic:[_pictureUrls objectAtIndex:i] size:CGSizeMake(_imageWidth, _imageHeight) placeHolder:YES];
            
            [_scrollView addSubview:imageView];
            
            [_imageViews addObject:imageView];
        }
    
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width * (startPage), 0)];
    
    _last_page = _scrollView.contentOffset.x / (_imageWidth + horizontalSpace);
    _firstStartPage = _last_page;
    
    //卡位
    [self turnLeft:3];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if(_origCount > 2)
        
        [self scrollView_Cycle];
}

-(void)scrollView_Cycle
{
    NSUInteger page = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    
    NSUInteger pageSize = page - _last_page;
    
    if(page > _last_page)
    {
        if(_Num == 0)
        {
            pageSize = 1;
            
            _Num++;
        }
        [self turnRight: pageSize];
    }
    
    
    
    
    if(page < _last_page)
    {
        [self turnLeft:_last_page - page];
    }
    
    _last_page = page;
    
    
    if(page > _firstStartPage)
        
        _pageCon.currentPage =  (page % _firstStartPage) % _origCount;
    
    else if(page < _firstStartPage )
    {
        int currentPage = (int)page;
        int starPage = (int)_firstStartPage;
        
        if((currentPage - starPage) % _origCount == 0)
            _pageCon.currentPage = 0;
        else
        _pageCon.currentPage = (currentPage - starPage) % _origCount + _origCount;
    }
    
    else if(page == _firstStartPage)
        
        _pageCon.currentPage = 0;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(_origCount > 2)
        [self scrollView_Cycle];
    
    else if(_origCount == 2)
    {
        NSUInteger page = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
        
        if(page == 0)
            _pageCon.currentPage = 0;
        else if (page ==1)
            _pageCon.currentPage = 1;
    }
}

-(void)turnRight:(NSUInteger)pageSize
{
    
    for (int i = 0; i < pageSize; i++) {
        
        UIImageView *last = [_imageViews objectAtIndex:[_imageViews count] - 1];
        CGFloat next_X = last.frame.origin.x + _imageWidth + horizontalSpace;
        UIImageView *iv = [_imageViews objectAtIndex:0];
        CGRect frame = iv.frame;
        frame.origin.x = next_X;
        iv.frame = frame;
        //加入最后一个
        [_imageViews addObject:iv];
        
        //删除第一个
        [_imageViews removeObjectAtIndex:0];
        
    }
}

-(void)turnLeft:(NSUInteger)pageSize
{
    for (int i = 0; i < pageSize; i++) {
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        UIImageView *first = [_imageViews objectAtIndex:0];
        
        CGFloat pre_X = first.frame.origin.x - ( _imageWidth + horizontalSpace );
        UIImageView *iv = [_imageViews objectAtIndex:[_imageViews count] - 1];
        CGRect frame = iv.frame;
        frame.origin.x = pre_X;
        iv.frame = frame;
        //删除最后一个
        [_imageViews removeObjectAtIndex:[_imageViews count] - 1];
        
        //插入第一个
        [array addObject:iv];
        for(int c = 0; c < [_imageViews count]; c ++)
        {
            [array addObject:[_imageViews objectAtIndex:c]];
        }
        
        _imageViews = array;
    }
}

//图片点击事件
-(void)imagePress:(UIGestureRecognizer *)gestureRecognizer
{
    UIImageView *iv = (UIImageView *)[gestureRecognizer view];
    NSUInteger tagvalue = iv.tag;
    
    
    int value = tagvalue % _origCount;
    
    [_delegate CycleImageTap:value];
}

@end
