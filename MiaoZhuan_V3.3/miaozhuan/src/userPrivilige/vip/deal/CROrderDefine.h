//
//  CROrderDefine.h
//  miaozhuan
//
//  Created by abyss on 14/12/1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

//100~199：处于付款流程中
//101: 未付款，等待付款
//102: 交易处理中：客户端告诉服务端，交易成功，服务端还没有收到支付方的回调时。
//103：银行转账审核中
//104：银行转账审核失败
//105：支付异常：客户端告诉服务端交易成功，但服务端收到支付方的消息是交易失败。此状态需要后台手工处理
//- 付款完成后，要不是901，要不是201，没有付款完成的状态
//- 付款未完成，商家和用户都可以撤消订单，跳到911
//
//200~299：等待发货
//201：开始等待商家发货
//202：等待超过3天：此时用户可以申请撤单
//203：等待超过3天后，用户已申请撤单
//- 商家同意，或商家3天未响应，状态为921
//
//300~399：等待收货
//301：等待收货：商家将货发出，用户处于等待收货状态
//302：等待收货：用户等待时间还剩下三天及以下，并且未发起过延迟收货
//303：等待收货：用户发起延迟收货
//- 如用户已无法再次发起延迟收货，并且订单时间快结束了，用户可以提出仲裁，跳到501
//- 用户确认收货，跳到901
//
//400~499：处于退货流程中
//401：用户发起退货
//402：商家同意退货：商家3天未响应，或商家主动同意退货。
//403：商家不同意退货
//- 用户可以发起仲裁，跳到501
//
//404：用户快递发回货物
//- 用户快递发回货物，7天之后商家未操作，视为退款成功，跳到931
//- 商家不予退货，可以发起仲裁，跳到501
//
//500~599：仲裁流程
//501：用户发起仲裁
//502：商家发起仲裁
//
//900~999：交易结束状态
//901: 交易成功

//911：交易关闭：发货以前，可以关闭交易，有如下情况：
//（a）：48小时未付款，关闭
//（b）：付款前，用户撤消
//（c）：付款前，商家撤消
//
//921：退款成功
//（d）：发货前，用户申请撤单，商家接受
//（e）：用户申请撤单，商家3天未响应
//
//931: 退货成功
//
//941：仲裁结束
//- 仲裁结果不纳入正常订单数据里面

//订单类型
typedef NS_ENUM(NSUInteger, CRENUM_OrderType)
{
    CRENUM_OrderTypeDirectItem = 1,                 //直购商品
    CRENUM_OrderTypeThankGiving,                    //用户感恩果
    CRENUM_OrderTypeEnterpriseVIP,                  //商家VIP（年）3
    CRENUM_OrderTypeGold,                           //金币 4
    CRENUM_OrderTypeUserVIP,                        //用户VIP 5
    CRENUM_OrderTypeDirectAdvert,                   //直投广告 6
    CRENUM_OrderTypeDirectGoldMall,                 //易货商城(易货商品) 7
    CRENUM_OrderTypeDuiHuandMall,                   //兑换商城(银元商品) 8
    CRENUM_OrderTypeBuy_DEJB,                       //大额金币购买 9
    CRENUM_OrderTypeBuy_YHED                        //易货额度购买 10
};

//订单状态
typedef NS_ENUM(NSUInteger, CRENUM_OrderStatu)
{
    CRENUM_OrderStatuUnPay              = 1 << 0, //未付款，等待付款
    CRENUM_OrderStatuDeeling            = 1 << 1, //交易处理中
    CRENUM_OrderStatuPayed              = 1 << 2, //已付款，未发货
    CRENUM_OrderStatuGivenItem          = 1 << 3, //已发货
    CRENUM_OrderStatuSuccess            = 1 << 4, //交易成功
    CRENUM_OrderStatuClose              = 1 << 5, //交易关闭
    CRENUM_OrderStatuFalse              = 1 << 6, //支付异常
    CRENUM_OrderStatuExExaming          = 1 << 7, //银行转账审核中
    CRENUM_OrderStatuExFaild            = 1 << 8, //银行转账审核失败
};

typedef NS_ENUM(NSUInteger, CRENUM_ButtonTarget)
{
    CRENUM_ButtonTargetCancelOrder = 1,
    CRENUM_ButtonTargetPayOrder,
    CRENUM_ButtonTargetRefreshOrder,
    CRENUM_ButtonTargetDeleteOrder,
    CRENUM_ButtonTargetContact,
    CRENUM_ButtonTargetGotItem,
};







