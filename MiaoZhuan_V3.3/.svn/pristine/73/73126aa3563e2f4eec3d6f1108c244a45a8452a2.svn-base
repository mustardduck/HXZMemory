//
//  StatementOfPublicBenifit.m
//  miaozhuan
//
//  Created by Santiago on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "StatementOfPublicBenifit.h"

@interface StatementOfPublicBenifit ()
@property (retain, nonatomic) IBOutlet DotCWebView *mainWebView;

@end

@implementation StatementOfPublicBenifit
@synthesize mainWebView = _mainWebView;
@synthesize Url = _Url;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupMoveBackButton];
    [self setTitle:@"说明"];
    [self.mainWebView loadURL:_Url];
    [_mainWebView setUserInteractionEnabled:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
