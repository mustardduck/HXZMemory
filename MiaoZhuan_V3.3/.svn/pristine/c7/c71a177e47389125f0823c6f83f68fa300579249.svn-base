//
//  HelpViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 15-1-4.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "HelpViewController.h"
#import "UICommon.h"
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"

@interface HelpViewController ()<UIScrollViewDelegate>

{
    CGFloat screenWidth;
    CGFloat screenHeight;
    UIScrollView * _scrollView;
}

@end

@implementation HelpViewController

static const int IMAGECOUNT = 2;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    
    [self initScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initScrollView
{
    screenWidth = self.view.frame.size.width;
    screenHeight = self.view.frame.size.height;
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0 ,screenWidth,screenHeight + [UICommon getIos4OffsetY])];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(screenWidth * IMAGECOUNT, screenHeight + [UICommon getIos4OffsetY])];
    _scrollView.backgroundColor = [UIColor blackColor];
    
    CGFloat offsetY = [UICommon getIos4OffsetY];
    
    CGRect frame = CGRectMake(0, 0, 320, 480 + offsetY);
    
    UIImageView * helpView1 = [[UIImageView alloc] init];
    helpView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickhelpview)] autorelease];
    [helpView1 addGestureRecognizer:tap1];
    if(offsetY == 0)
    {
        helpView1.image = [UIImage imageNamed:@"one.png"];
    }
    else
    {
        helpView1.image = [UIImage imageNamed:@"one_568.png"];
    }
    
    helpView1.frame = frame;
    
    frame.origin.x = screenWidth;
    
    UIImageView * helpView2 = [[UIImageView alloc] init];
    helpView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickhelpview)] autorelease];
    [helpView2 addGestureRecognizer:tap2];
    if(offsetY == 0)
    {
        helpView2.image = [UIImage imageNamed:@"two.png"];
    }
    else
    {
        helpView2.image = [UIImage imageNamed:@"two_568.png"];
    }
    
    helpView2.frame = frame;
    
    frame.origin.x = screenWidth * (IMAGECOUNT - 1);
    
//    UIImageView * helpView3 = [[UIImageView alloc] init];
//    
//    if(offsetY == 0)
//    {
//        helpView3.image = [UIImage imageNamed:@"three.png"];
//    }
//    else
//    {
//        helpView3.image = [UIImage imageNamed:@"three_568.png"];
//    }
//    
//    helpView3.frame = frame;
//    
//    [helpView3 setUserInteractionEnabled:YES];
    
//    UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goButtonClicked)] autorelease];
//    [helpView3 addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *swipe = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)] autorelease];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [helpView2 addGestureRecognizer:swipe];
    
    UISwipeGestureRecognizer *swipe1 = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)] autorelease];
    swipe1.direction = UISwipeGestureRecognizerDirectionRight;
    [helpView2 addGestureRecognizer:swipe1];
    
    _scrollView.bounces = NO;
    
    [self.view addSubview:_scrollView];
    
    [_scrollView addSubview:helpView1];
    
    [_scrollView addSubview:helpView2];
    
//    [_scrollView addSubview:helpView3];
    
    [helpView1 release];
    
    [helpView2 release];
    
//    [helpView3 release];

}

- (void) clickhelpview{
    if (!_scrollView.contentOffset.x) {
        [_scrollView setContentOffset:CGPointMake(SCREENWIDTH, 0) animated:YES];
    } else {
         [self goButtonClicked];
    }
}

-(void)goButtonClicked
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"NotFirst"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    [login release];
}

- (void)swipe:(UISwipeGestureRecognizer *)swipe{
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
        {
            [self goButtonClicked];
        }
            break;
        case UISwipeGestureRecognizerDirectionRight:
        {
            _scrollView.scrollEnabled = YES;
            [_scrollView setContentOffset:CGPointMake(SCREENWIDTH, 0) animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)dealloc
{
    [_scrollView release];
    
    [super dealloc];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x/screenWidth == 1) {
        scrollView.scrollEnabled = NO;
    }

}


@end

