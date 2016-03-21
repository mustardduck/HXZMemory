//
//  MerchantDetailViewController.h
//  miaozhuan
//
//  Created by 孙向前 on 14-10-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DotCViewController.h"

@interface MerchantDetailViewController : DotCViewController

//商家编号
@property (nonatomic, copy) NSString *enId;

/**
 *来源：
    0:其它
    1:银元广告详情页
    2:红包广告详情页
    3:兑换商城详情页
    4:易货商城详情页
    5:直购商城详情页
    6:竞价商家
     7:招聘信息详情页
     8:招商信息详情页
     9:优惠信息详情页
 */
@property (nonatomic, copy) NSString *comefrom;

- (IBAction)touchUpInsideOn:(id)sender;

@end
