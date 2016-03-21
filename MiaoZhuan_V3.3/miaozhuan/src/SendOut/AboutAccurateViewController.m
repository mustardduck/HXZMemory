//
//  AboutAccurateViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-13.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AboutAccurateViewController.h"

@interface AboutAccurateViewController ()<UIWebViewDelegate>

@property (retain, nonatomic) IBOutlet DotCWebView *webView;
@property (nonatomic, copy) NSString *firstLoadUrl;//第一次加载的url
@property (nonatomic, assign) BOOL isFirstLoad;//第一次加载的url
@property (nonatomic, assign) BOOL canBack;

@end

@implementation AboutAccurateViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    _isFirstLoad = NO;
    _canBack = YES;
    [self setupMoveBackButton];
    
    
    if (!_url.length) {
        ADAPI_DirectAdvert_Intro([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleIntro:)]);
    } else {
        [_webView loadURL:[self formatUrl:_url]];
    }
    
}

- (NSString *)formatUrl:(NSString *)url{
    
    if (!url.length) {
        return @"";
    }
    if ([[url lowercaseString] hasPrefix:@"http://"]) {
        return url;
    } else {
        return [NSString stringWithFormat:@"http://%@", url];
    }
}

- (void)handleIntro:(DelegatorArguments *)arguments {
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed) {
        NSLog(@"%@",[dic.data getString:@"Url"]);
        [_webView loadURL:[self formatUrl:[dic.data getString:@"Url"]]];
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (void)onClicked:(UIButton *)sender{
    if (sender.tag == 1) {
        //返回
        if (_canBack) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [_webView goBack];
        }
    } else {//关闭
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)setnavItem:(BOOL)flag{
    self.navigationItem.leftBarButtonItems = nil;
    if (!flag) {
        [self setupMoveBackButtonWithTitles:@[@"返回",@"关闭"]];
    } else {
        [self setupMoveBackButton];
    }
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    int cacheSizeMemory = 4*1024*1024;
    int cacheSizeDisk = 32*1024*1024;
    NSURLCache *sharedCache = [[NSURLCache alloc]initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:sharedCache];
    
    NSString *url = webView.request.URL.absoluteString;
    
    if (!_isFirstLoad) {
        self.firstLoadUrl = url;
        _isFirstLoad = YES;
    }
    
    _canBack = [url isEqualToString:_firstLoadUrl];
    [self setnavItem:_canBack];
    
    //web title
    NSString *title =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self setNavigateTitle:title];
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    _webView.delegate = nil;
    [_firstLoadUrl release];
    [_url release];
    [_webView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}
@end
