//
//  CROrder.h
//  miaozhuan
//
//  Created by abyss on 14/12/4.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CROrderDefine.h"

@interface CROrder : NSObject

@property (retain ,nonatomic) DictionaryWrapper* wrapper;
@property (assign ,nonatomic) NSString *OrderSerialNo;                          //订单单号
@property (assign ,nonatomic) NSUInteger EnterpriseId;                          //卖家商家编号
@property (retain ,nonatomic) NSString* EnterpriseName;                         //卖家商家名称
@property (assign ,nonatomic) CRENUM_OrderType OrderType;
@property (retain ,nonatomic) NSString* OrderTime;                              //订单时间
@property (assign ,nonatomic) CRENUM_OrderStatu OrderStatus;
@property (assign ,nonatomic) NSUInteger ItemCount;                             //数量
@property (assign ,nonatomic) CGFloat UnitPrice;                                //单价
@property (assign ,nonatomic) double OrderAmount;                              //订单总价，不包括邮费
@property (assign ,nonatomic) CGFloat Postage;                                  //邮费
@property (retain ,nonatomic) NSString* Title;                                  //商品名
@property (retain ,nonatomic) DictionaryWrapper* CROrderStatuDic;
- (instancetype)initWithNetWrapper:(DictionaryWrapper *)wrapper;

- (void)orderEventWith:(CRENUM_ButtonTarget)event;
@end
