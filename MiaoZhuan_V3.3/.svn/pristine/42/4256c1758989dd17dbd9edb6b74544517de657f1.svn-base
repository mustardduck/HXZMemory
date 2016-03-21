//
//  ScreenDeclareVC.m
//  guanggaoban
//
//  Created by CQXianMai on 14-8-10.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import "ScreenDeclareVC.h"
#import "ScreeningListType.h"

@interface ScreenDeclareVC ()

@end

@implementation ScreenDeclareVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.webViewType = screen_Declare;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initNavItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *urlStr = nil;
    switch (self.webViewType) {
        case screen_Declare:
            urlStr = @"http://www.zdit.cn/files/about-top.html";
            break;
        case normal_Question:
            urlStr = @"http://cdn.www.zdit.cn/storage/faq/index.html";
            break;
        default:
            break;
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webUI loadRequest:request];
    // 需要解码webView数据时采用下面方法
//    [NSURLConnection connectionWithRequest:request delegate:self];
//    [[CustomLoadingView sharedInstance] setTitleText:@"亲，数据正在加载中..."];
//    [[CustomLoadingView sharedInstance] startAnimating];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.webUI = nil;
    [super dealloc];
}

- (void)initNavItem
{
    switch (self.webViewType) {
        case screen_Declare:
            [self setNavigateTitle:@"说明"];
            break;
         case normal_Question:
            [self setNavigateTitle:@"常见问题"];
        default:
            break;
    }
    [self setupMoveBackButton];
}

//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    [[CustomLoadingView sharedInstance] stopAnimating];
//    NSString *responseVal = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    [self.webUI netLoadHtml:[responseVal netDecoder]];
//    [responseVal release];
//}
@end
