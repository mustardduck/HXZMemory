//
//  MyCashStatement.m
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyCashStatement.h"

@interface MyCashStatement ()
@property (retain, nonatomic) IBOutlet DotCWebView *mainWebView;

@end

@implementation MyCashStatement
@synthesize mainWebView = _mainWebView;
@synthesize url= _url;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self.mainWebView loadURL:_url];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    [_mainWebView release];
    [_url release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainWebView:nil];
    self.url = nil;
    [super viewDidUnload];
}
@end
