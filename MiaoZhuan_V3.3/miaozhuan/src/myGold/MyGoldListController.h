//
//  MyGoldListController.h
//  miaozhuan
//
//  Created by momo on 14-12-16.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyGoldListController : DotCViewController

//0.发广告消耗的，1.兑换商品消耗的，2.竞价广告消耗的，3.系统赠送的，4.易货商城的货款 5.流通记录 6.其他收入 7.发商家优惠信息消耗的 8.发招聘信息消耗的 9.发招商信息消耗的 10.拓展商家消耗的 11购买广告金币获得的
@property (nonatomic, assign) int cellType;

@end
