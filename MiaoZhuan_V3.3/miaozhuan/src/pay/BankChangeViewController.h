//
//  BankChangeViewController.h
//  guanggaoban
//
//  Created by 孙向前 on 14-4-2.
//  Copyright (c) 2014年 edwin good. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankChangeViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, copy)NSString *orderId;
@property (nonatomic, copy)NSString *totalPay;
@property (nonatomic, retain)NSArray *goodsinfo;
@property (nonatomic, assign) BOOL isPos;

//*  OrderType : 1：直购商城 2：用户感恩果 3：商家VIP（年）4：金币 5：用户VIP 6：直投广告 7：易货商城(易货商品) 8：兑换商城(银元商品) 9:大额金币购买 10:易货额度购买
@property (nonatomic, assign) int orderType;

@property (nonatomic, copy) NSString *itemCount;

@end
