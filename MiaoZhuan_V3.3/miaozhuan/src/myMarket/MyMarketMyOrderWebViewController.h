//
//  MyMarketMyOrderWebViewController.h
//  miaozhuan
//
//  Created by momo on 14/12/30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DotCWebView.h"

@interface MyMarketMyOrderWebViewController : UIViewController
@property (retain, nonatomic) IBOutlet DotCWebView *webview;
@property (retain, nonatomic) NSString * urlString;
@end
