//
//  PayStateViewController.h
//  guanggaoban
//
//  Created by 孙向前 on 14-4-2.
//  Copyright (c) 2014年 edwin good. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PayFinishDelegate;

@interface PayStateViewController : UIViewController

@property (nonatomic, copy) NSString * payFrom;//来源

@property (nonatomic, assign) BOOL isBankChange;//银行转账
//*  payType : 1：银联支付 2：支付宝支付 3：银行转账 4：微信 5：现金 6：现金支票 7：银行POS机刷卡 8：快钱支付
@property (nonatomic, assign) int payType;

//订单单号
@property (nonatomic, copy) NSString *orderNum;

//*  OrderType : 1：直购商城 2：用户感恩果 3：商家VIP（年）4：金币 5：用户VIP 6：直投广告 7：易货商城(易货商品) 8：兑换商城(银元商品) 9:大额金币购买 10:易货额度购买
@property (nonatomic, copy) NSString *orderType;

@property (nonatomic, retain)NSArray *goodsInfo;
@property (nonatomic, copy) NSString *totalPay;

@property (nonatomic, assign)BOOL isPost;

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *advertId;

@property (nonatomic, copy) NSString *payBonusLink;

@property (nonatomic, assign) id<PayFinishDelegate> delegate;

@end

@protocol PayFinishDelegate <NSObject>

//YES success , NO fail
- (void)payFinishWithStatus:(BOOL)status;

@end