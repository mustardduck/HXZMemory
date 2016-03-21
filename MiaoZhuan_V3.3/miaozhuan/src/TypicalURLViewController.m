//
//  TypicalURLViewController.m
//  miaozhuan
//
//  Created by Santiago on 15-1-26.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "TypicalURLViewController.h"

@interface TypicalURLViewController ()

@end

@implementation TypicalURLViewController
@synthesize mainWebView = _mainWebView;
@synthesize Url = _Url;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    
    _mainWebView.scalesPageToFit = YES;
    
    NSURL *url;
    
    if ([_Url containsString:@"http://"]) {
        
        url = [[NSURL alloc]initWithString:_Url];
    }else {
    
        url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://%@",_Url]];
    }
    
    [_mainWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_Url release];
    [_mainWebView release];
    [super dealloc];
}
@end
