//
//  AdsDetailViewController.h
//  miaozhuan
//
//  Created by 孙向前 on 14-10-23.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsDetailViewController : DotCViewController
//广告id
@property (nonatomic, copy) NSString *adId;
//其他入口（非循环看广告）
@property (nonatomic, assign) BOOL isMerchant;
@property (nonatomic, assign) BOOL notShow;

//客户咨询跳转过来
@property (nonatomic, assign) int comeformCounsel;
@end
