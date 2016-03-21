//
//  BankChangStepTwoController.h
//  miaozhuan
//
//  Created by momo on 15/6/9.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankChangStepTwoController : UIViewController

@property (nonatomic, copy)NSString *orderId;
//*  OrderType : 1：直购商城 2：用户感恩果 3：商家VIP（年）4：金币 5：用户VIP 6：直投广告 7：易货商城(易货商品) 8：兑换商城(银元商品) 9:大额金币购买 10:易货额度购买
@property (nonatomic, assign) int orderType;
@property (nonatomic, copy) NSString *itemCount;
@property (nonatomic, copy)NSString *totalPay;
@property (nonatomic, copy) NSString * payFrom;
//*  PaymentType : 1：银联支付 2：支付宝支付 3：银行转账 4：微信 5：现金 6：现金支票 7：银行POS机刷卡 8：快钱支付
@property (nonatomic, copy) NSString * paymType;
@property (nonatomic, assign) BOOL isPOS;

@end
