//
//  CRPopWebView.m
//  miaozhuan
//
//  Created by Abyss on 15-3-10.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "CRPopWebView.h"
#import "CRWebSupporter.h"

@implementation CRPopWebView

- (void)showUrl:(NSString *)url
{
    DotCWebView* ret = [[DotCWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ret.delegate = self;
    ret.opaque = NO;
    ret.backgroundColor = [UIColor clearColor];
    for (UIView *aView in [ret subviews])
    {
        aView.backgroundColor = [UIColor clearColor];
        if ([aView isKindOfClass:[UIScrollView class]])
        {
            ((UIScrollView *)aView).scrollEnabled = NO;
            [(UIScrollView *)aView setShowsVerticalScrollIndicator:NO]; //右侧的滚动条 （水平的类似）
            
            for (UIView *shadowView in aView.subviews)
            {
                shadowView.backgroundColor = [UIColor clearColor];
                if ([shadowView isKindOfClass:[UIImageView class]])
                {
                    shadowView.hidden = YES;  //上下滚动出边界时的黑色的图片 也就是拖拽后的上下阴影
                }
            }
        }
    }
    [ret loadURL:url];
    [APP_DELEGATE.window addSubview:ret];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"URL :%@", [request URL]);
    NSString *requestURl = [[request URL] absoluteString];
    
    [CRWebSupporter responeseEventFor:requestURl];
    
    return YES;
}
@end
