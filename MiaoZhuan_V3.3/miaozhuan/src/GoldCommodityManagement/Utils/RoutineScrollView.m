//
//  RoutineScrollView.m
//  miaozhuan
//
//  Created by xm01 on 15-1-16.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "RoutineScrollView.h"
#import "NetImageView.h"
#import "UIImageView+WebCache.h"
#import "PreviewViewController.h"
#import "Preview_Commodity.h"

#import "SMPageControl.h"


@interface RoutineScrollView()<UIScrollViewDelegate>
{
    CGRect _frame;
    
}
@property(nonatomic, retain)   UIScrollView   *scrollView;
@property(nonatomic, readonly) NSArray        *pictures;
@property (nonatomic, retain)  SMPageControl  *pageControl;

@end

@implementation RoutineScrollView


-(id)initWithParameters:(CGRect)frame  pictures:(NSArray *)pictures
{
    self = [super init];
    if(self)
    {
        _frame = frame;
        _pictures = pictures;
        self.view.frame = frame;
    }
    
    return self;
}

- (void) dealloc
{
    [super dealloc];
    [_scrollView release];
    [_pictures release];
    [_pageControl release];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    
    self.scrollView = nil;
    self.pageControl = nil;
}



-(void)refReshScrollView:(NSArray *)pictures
{
    _pictures = pictures;
    
    if(!_pictures || [_pictures count] < 1)
        return;
    
    _pageControl.numberOfPages = [_pictures count];
    
    //如果只有一张图片
    if(_pictures && [_pictures count] == 1)
    {
        _pageControl.hidden = YES;
        
        [_scrollView setContentSize:CGSizeMake(_frame.size.width, _frame.size.height)];
        
        NetImageView *imageView = [[NetImageView alloc] initWithFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height)];
        
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewImage)];
        [imageView addGestureRecognizer:singleTap];
        [singleTap release];
        imageView.zoom = 0.45f;
        if(_pictures && [_pictures count] > 0)
        {
            NSDictionary *dic = [_pictures objectAtIndex:0];
            
            [imageView requestPic:[dic.wrapper getString:@"PictureUrl"] size:CGSizeMake(320, 300) placeHolder:YES];
        }
        else
            [imageView requestPic:@"" size:CGSizeMake(320, 300) placeHolder:YES];
        
        [_scrollView addSubview:imageView];
        
        imageView = nil;
        [imageView release];
        
        return;
    }
    
    // 创建四个图片 imageview
    for (int i = 0;i<[_pictures count];i++)
    {
        NetImageView *view = [[NetImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewImage)];
        [view addGestureRecognizer:singleTap];
        [singleTap release];
        view.frame = CGRectMake((_frame.size.width * i) + _frame.size.width, 0, _frame.size.width, _frame.size.height);
        view.zoom = 0.45f;
        if(_pictures && [_pictures count] > 0)
        {
            NSDictionary *dic = [_pictures objectAtIndex:i];
            [view requestPic:[dic.wrapper getString:@"PictureUrl"] size:CGSizeMake(320, 300) placeHolder:YES];
        }
        else
            [view requestPic:@"" size:CGSizeMake(320, 300) placeHolder:YES];
        
        [_scrollView addSubview:view];
        
        view = nil;
        [view release];
    }
    
    // 取数组最后一张图片 放在第0页
    
    NetImageView *imageView = [[NetImageView alloc] initWithFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height)];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewImage)];
    [imageView addGestureRecognizer:singleTap0];
    [singleTap0 release];
    imageView.zoom = 0.45f;
    if(_pictures && [_pictures count] > 0)
    {
        NSDictionary *dic = [_pictures objectAtIndex:([_pictures count]-1)];
        [imageView requestPic:[dic.wrapper getString:@"PictureUrl"] size:CGSizeMake(320, 300) placeHolder:YES];
    }
    else
        [imageView requestPic:@"" size:CGSizeMake(320, 300) placeHolder:YES];
    [_scrollView addSubview:imageView];
    
    imageView = nil;
    [imageView release];
    
    
    // 取数组第一张图片 放在最后1页
    
    imageView = [[NetImageView alloc] initWithFrame:CGRectMake((_frame.size.width * ([_pictures count] + 1)) , 0, _frame.size.width, _frame.size.height)];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewImage)];
    [imageView addGestureRecognizer:singleTap1];
    [singleTap1 release];
    if(_pictures && [_pictures count] > 0)
    {
        NSDictionary *dic = [_pictures objectAtIndex:0];
        
        [imageView requestPic:[dic.wrapper getString:@"PictureUrl"] size:CGSizeMake(320, 300) placeHolder:YES];
    }
    else
        [imageView requestPic:@"" size:CGSizeMake(320, 300) placeHolder:YES];
    
    [_scrollView addSubview:imageView];// 添加第1页在最后 循环
    
    imageView = nil;
    [imageView release];
    
    [_scrollView setContentSize:CGSizeMake(_frame.size.width * ([_pictures count] + 2), _frame.size.height)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    [self.scrollView scrollRectToVisible:CGRectMake(_frame.size.width,0,_frame.size.width,_frame.size.height) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页
}


MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 定时器 循环
    //    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    // 初始化 scrollview
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height)];
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    
    _pageControl = [[SMPageControl alloc] initWithFrame:CGRectMake(110, 280, 100, 20)];
    [_pageControl setPageIndicatorImage:[UIImage imageNamed:@"001"]];
    [_pageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"002"]];
    _pageControl.indicatorMargin = 6.0f;   //间距
    
    [self.view addSubview:_pageControl];
}
// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pagewidth/([_pictures count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    _pageControl.currentPage = page;
}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ ([_pictures count]+2)) / pagewidth) + 1;
    //    int currentPage_ = (int)self.scrollView.contentOffset.x/320; // 和上面两行效果一样
    //    NSLog(@"currentPage_==%d",currentPage_);
    if (currentPage==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(_frame.size.width * [_pictures count],0,_frame.size.width,_frame.size.height) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([_pictures count]+1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(_frame.size.width,0,_frame.size.width,_frame.size.height) animated:NO]; // 最后+1,循环第1页
    }
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    NSInteger page = _pageControl.currentPage; // 获取当前的page
    [self.scrollView scrollRectToVisible:CGRectMake(_frame.size.width*(page+1),0,_frame.size.width,_frame.size.height) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
// 定时器 绑定的方法
- (void)runTimePage
{
    NSInteger page = _pageControl.currentPage; // 获取当前的page
    page++;
    page = page > 3 ? 0 : page ;
    _pageControl.currentPage = page;
    [self turnPage];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)previewImage
{
    if(_pictures && [_pictures count] >0 )
    {
        PreviewViewController *temp = WEAK_OBJECT(PreviewViewController, init);
        temp.dataArray = _pictures;
        temp.currentPage = _pageControl.currentPage;
        
        Preview_Commodity *obj = (Preview_Commodity *)_previe_obj;
//        [obj.navigationController pushViewController:temp animated:YES];
        [obj.navigationController presentModalViewController:temp animated:YES];
    }
}

@end
