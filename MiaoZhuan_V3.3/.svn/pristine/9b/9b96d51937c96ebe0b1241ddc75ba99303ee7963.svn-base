//
//  ConfirmOrderViewController.h
//  miaozhuan
//
//  Created by 孙向前 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOrderViewController : UIViewController

@property (nonatomic, retain) NSDictionary *orderInfoDic;//订单信息

/**
 *  公共参数
 *  OrderSerialNo ： @""传空字符串即可
 *  OrderType : 1：直购商城 2：用户感恩果 3：商家VIP（年）4：金币 5：用户VI 6：直投广告 7：易货商城 8：兑换商城
 *  ItemCount : 购买数量
 * 
 *  7：易货商城 额外添加参数
 *  ProductId	商品编号
 *  ExchangeType 送货类型： 0：邮寄兑换 1：现场兑换
 *  Specification 规格
 *
 *  8：兑换商城 额外添加参数
 *  ProductId	商品编号
 *  AdvertId	广告编号
 *  ExchangeType 送货类型： 0：邮寄兑换 1：现场兑换
 */
@property (nonatomic, retain) NSDictionary *payDic;//支付数据

/**
 * type :1.兑换商城
 *      2.易货商城
 *      3.其他（自营商品）
 */
@property (nonatomic, assign) int type;
/**
 * goodsInfo 商品信息 @[@{@"name":@"iphone6",@"image":@"2"}]
 */
@property (nonatomic, retain) NSArray *goodsInfo;
@end
