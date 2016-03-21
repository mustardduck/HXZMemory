//
//  CROrder.m
//  miaozhuan
//
//  Created by abyss on 14/12/4.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CROrder.h"

@implementation CROrder
NSDictionary *CROrderStatuDic;
- (instancetype)initWithNetWrapper:(DictionaryWrapper *)wrapper
{
    self = [super init];
    if (self)
    {
        _wrapper = wrapper;
        [_wrapper retain];
        _OrderSerialNo = [wrapper getString:@"OrderSerialNo"];
        _EnterpriseId = [wrapper getInt:@"EnterpriseId"];
        _EnterpriseName = [wrapper getString:@"EnterpriseName"];
        [_EnterpriseName retain];
        _OrderType = [wrapper getInt:@"OrderType"];
        _OrderTime = [UICommon format19Time:[wrapper getString:@"OrderTime"]];
        [_OrderTime retain];
        int statu = [wrapper getInt:@"OrderStatus"];
        if (statu == 101)
        {
            _OrderStatus = 0;
        }
        else if (statu == 102)
        {
            _OrderStatus = 1;
        }
        else if (statu == 201)
        {
            _OrderStatus = 2;
        }
        else if (statu == 301)
        {
            _OrderStatus = 3;
        }
        else if (statu == 901)
        {
            _OrderStatus = 4;
        }
        else if (statu == 911)
        {
            _OrderStatus = 5;
        }
        else if (statu == 105)
        {
            _OrderStatus = 6;
        }
        else if (statu == 103)
        {
            _OrderStatus = 7;
        }
        else if (statu == 104)// 银行转账审核失败
        {
            _OrderStatus = 8;
        }
        else if (statu == 106)// 等待银行转账
        {
            _OrderStatus = 9;
        }
        else if (statu == 107)// 等待POS转账
        {
            _OrderStatus = 10;
        }
        else if (statu == 108)// POS转账(审核中)
        {
            _OrderStatus = 11;
        }
        else if (statu == 109)// POS转账(审核失败)
        {
            _OrderStatus = 12;
        }
        else
        {
            _OrderStatus = 6;
            NSString *error = [NSString stringWithFormat:@"未知状态：%d",statu];
            [HUDUtil showErrorWithStatus:error];
        }
        NSLog(@"%d -- 》 %lu",statu,_OrderStatus);
        
        
        _ItemCount = [wrapper getInt:@"ItemCount"];
        _UnitPrice = [wrapper getDouble:@"UnitPrice"];
        self.OrderAmount = [[wrapper getString:@"OrderAmount"] doubleValue] ;
        _Postage = [wrapper getDouble:@"Postage"];
        _Title = [wrapper getString:@"Title"];
        [_Title retain];
        _CROrderStatuDic = [self CROrderStatuDic];
    }
    return self;
}

- (DictionaryWrapper *)CROrderStatuDic
{
    return              @{@"1":@{@"statu":@"等待付款",@"button":@[@"去付款",@"取消订单"]},
                          @"2":@{@"statu":@"处理中\n请等待",@"button":@[@"刷新状态"]},
                          @"4":@{@"statu":@"已付款\n等待商家发货",@"button":@[]},
                          @"8":@{@"statu":@"商家已发货\n等待确认",@"button":@[@"确认收货"]},
                          @"16":@{@"statu":@"交易成功",@"button":@[@"删除订单"]},
                          @"32":@{@"statu":@"交易关闭",@"button":@[@"删除订单"]},
                          @"64":@{@"statu":@"交易异常\n请联系客服",@"button":@[@"联系客服"]},
                          @"128":@{@"statu":@"银行转账审核中",@"button":@[@"联系客服"]},
                          @"256":@{@"statu":@"银行转账审核失败",@"button":@[@"删除订单"]},//8
                          @"512":@{@"statu":@"等待银行转账",@"button":@[@"去转账",@"取消订单"]},//momo-9
                          @"1024":@{@"statu":@"等待快钱POS转账",@"button":@[@"去转账",@"取消订单"]},
                          @"2048":@{@"statu":@"审核中",@"button":@[@"联系客服"]},//11
                          @"4096":@{@"statu":@"审核失败",@"button":@[@"删除订单"]}//12
                          }.wrapper;
}

- (void)orderEventWith:(CRENUM_ButtonTarget)event
{
    if(event == CRENUM_ButtonTargetCancelOrder)
        ADAPI_adv3_CancelOrder([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(isSuccess:)], self.OrderSerialNo);
    else if(event == CRENUM_ButtonTargetDeleteOrder)
        ADAPI_adv3_DeleteOrder([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(isSuccess:)], self.OrderSerialNo);
}

- (void)isSuccess:(DelegatorArguments *)arg
{
    [arg logError];
    if (arg.ret.operationSucceed)
    {
        NSLog(@"success");
    }
}

- (void)dealloc
{
    [_EnterpriseName release];
    [_OrderTime release];
    [_Title release];
    [super dealloc];
}

@end
