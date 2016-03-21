//
//  MyMarketMyOrderWebViewController.m
//  miaozhuan
//
//  Created by momo on 14/12/30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyMarketMyOrderWebViewController.h"

@interface MyMarketMyOrderWebViewController ()

@end

@implementation MyMarketMyOrderWebViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    InitNav(@"查询物流");
    
    NSURL *url =[NSURL URLWithString: _urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_webview release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setWebview:nil];
    [super viewDidUnload];
}
@end
