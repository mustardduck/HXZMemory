//
//  CRWebView.h
//  miaozhuan
//
//  Created by abyss on 15/1/15.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRWebView : UIWebView
@property (retain, nonatomic, readonly) NSString* url;
@property (retain, nonatomic, readonly) NSString* cookie;
@property (assign, nonatomic, readonly) float     cacheSize;

/**
 * @brief  设置Cookie
 */
- (void)setCookie;

/**
 * @brief  清除webview缓存
 */
- (void)clearCache;

/**
 * @brief  读取进入url
 * @param url url地址
 */
- (void)loadURL:(NSString*)url;

/**
 * @brief  初始化CRWebView
 * @param url url地址
 * @return CRWebView实例
 */
+ (CRWebView*) viewFrom:(NSString*)url;
@end
