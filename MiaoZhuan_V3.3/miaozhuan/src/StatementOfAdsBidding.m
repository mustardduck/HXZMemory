//
//  StatementOfAdsBidding.m
//  miaozhuan
//
//  Created by Santiago on 14-11-5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "StatementOfAdsBidding.h"

@interface StatementOfAdsBidding ()

@property (retain, nonatomic) IBOutlet DotCWebView *mainWebView;
@end

@implementation StatementOfAdsBidding

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
//    NSURL *url=[NSURL URLWithString:@"http://163liufuliang.blog.163.com/blog/static/3316518620132515136177/"];
//    
//    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
//    
//    [_mainWebView loadRequest:request];
    
    [_mainWebView setUserInteractionEnabled:YES];

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
