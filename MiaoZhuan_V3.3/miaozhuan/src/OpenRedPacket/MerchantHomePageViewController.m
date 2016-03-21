//
//  MerchantHomePageViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-12-23.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MerchantHomePageViewController.h"

@interface MerchantHomePageViewController ()
@property (retain, nonatomic) IBOutlet UIWebView *mainWebView;
@end

@implementation MerchantHomePageViewController
@synthesize mainWebView = _mainWebView;
@synthesize merchantLinkUrl = _merchantLinkUrl;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"商家官网"];
    [self loadWebView];
}

- (void)loadWebView
{
    if (![_merchantLinkUrl hasPrefix:@"http://"]) {
        _merchantLinkUrl = [NSString stringWithFormat:@"http://%@",_merchantLinkUrl];
    }
    NSURL *url = [NSURL URLWithString:_merchantLinkUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_mainWebView loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_mainWebView release];
    [super dealloc];
}
@end
