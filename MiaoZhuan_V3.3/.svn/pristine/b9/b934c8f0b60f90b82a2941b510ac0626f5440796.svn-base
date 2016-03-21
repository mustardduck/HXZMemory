//
//  RecommandMerchantDetailViewController.m
//  miaozhuan
//
//  Created by Santiago on 15-1-12.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "RecommandMerchantDetailViewController.h"

@interface RecommandMerchantDetailViewController ()
@property (retain, nonatomic) IBOutlet UIWebView *mainWebView;

@end

@implementation RecommandMerchantDetailViewController
@synthesize mainWebView = _mainWebView;
@synthesize theUrl = _theUrl;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"推荐商家"];
    [self setupMoveBackButton];
    NSURL *url = [NSURL URLWithString:_theUrl];
    [_mainWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_mainWebView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainWebView:nil];
    [super viewDidUnload];
}
@end
