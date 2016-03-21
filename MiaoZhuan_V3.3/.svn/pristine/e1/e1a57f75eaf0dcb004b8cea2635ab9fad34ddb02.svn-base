//
//  BannerDetailViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BannerDetailViewController.h"
#import "RRNavBarDrawer.h"

@interface BannerDetailViewController ()<UIWebViewDelegate,RRNavBarDrawerDelegate>{
    /** 是否已打开抽屉 */
    BOOL _isOpen;
    
    RRNavBarDrawer *navBarDrawer;
}

@property (retain, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BannerDetailViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithImage:@"more.png" In:@"morehover.png"];
    
    NSArray *array = @[@{@"normal":@"ads_home",@"hilighted":@"ads_homehover",@"title":@"首页"}];
    
    navBarDrawer = STRONG_OBJECT(RRNavBarDrawer, initWithView:self.view andInfoArray:array);
    navBarDrawer.delegate = self;
    
    [self loadWebView];
    
}

- (void)loadWebView
{

    if (![_urlStr hasPrefix:@"http://"]) {
        self.urlStr = [NSString stringWithFormat:@"http://%@",_urlStr];
    }
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (IBAction) onMoveFoward:(UIButton*) sender{
    _isOpen = !_isOpen;
    if (!_isOpen) {
        [navBarDrawer openNavBarDrawer];
    } else {
        [navBarDrawer closeNavBarDrawer];
    }
}

#pragma mark - rrnavbardrawer delegate
- (void)didClickItem:(RRNavBarDrawer *)drawer atIndex:(NSInteger)index{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - uiwebview delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //web title
    NSString *title =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self setNavigateTitle:title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [navBarDrawer release];
    [_urlStr release];
    [_webView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}
@end
