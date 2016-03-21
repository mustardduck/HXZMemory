//
//  OrderTableViewCell.m
//  miaozhuan
//
//  Created by abyss on 14/12/4.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "RRAttributedString.h"

#import "ConfirmOrderViewController.h"
#import "BankChangStepTwoController.h"

@interface OrderTableViewCell ()
{
    CRENUM_OrderStatu _statu;
    NSString *_price;
    NSString *_num;
}
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UILabel *statuL;
@property (retain, nonatomic) IBOutlet UILabel *itemL;
@property (retain, nonatomic) IBOutlet UILabel *priceL;
@property (retain, nonatomic) IBOutlet UILabel *orderNum;
@property (retain, nonatomic) IBOutlet UIButton *bt_1;
@property (retain, nonatomic) IBOutlet UIButton *bt_2;
@end
@implementation OrderTableViewCell

- (void)awakeFromNib
{
    [_bt_1 setBorderWithColor:AppColor(204)];
    [_bt_1 setRoundCorner];
    [_bt_2 setBorderWithColor:AppColor(204)];
    [_bt_2 setRoundCorner];
    _cellLine.top = 239.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(CROrder *)data
{
    //    CROrder *order = [[CROrder alloc] initWithNetWrapper:@{@"OrderSerialNo":@"231231",
    //                                                          @"EnterpriseId":@1,
    //                                                          @"EnterpriseName":@"asdasd",
    //                                                          @"OrderType":@1,
    //                                                          @"OrderTime":@"",
    //                                                          @"OrderStatus":@(indexPath.row),
    //                                                          @"ItemCount":@1,
    //                                                          @"UnitPrice":@1,
    //                                                          @"OrderAmount":@1,
    //                                                          @"Postage":@0,
    //                                                          @"Title":@"lalala"
    //                                                           }.wrapper];
    _data = data;
    [_data retain];
    
    _statu = _data.OrderStatus;
    
    _title.text = _data.EnterpriseName;
    _itemL.text = _data.Title;
    _price = [NSString stringWithFormat:@"￥%.2lf",(double)_data.OrderAmount];
    if (_data.ItemCount > 0) _num = [NSString stringWithFormat:@"x %d",(int)_data.ItemCount];
    if (_data.OrderSerialNo.length > 0) _orderNum.text = [NSString stringWithFormat:@"订单号: %@",_data.OrderSerialNo];
    
    [self layoutByStatu:_statu];
}
- (void)layoutByStatu:(CRENUM_OrderStatu)statu
{
    DictionaryWrapper *dic = [_data.CROrderStatuDic getDictionaryWrapper:[NSString stringWithFormat:@"%d",1 << (int)_statu ]];
    _statuL.text = [dic getString:@"statu"];
    _priceL.text = [NSString stringWithFormat:@"%@\n%@",_num,_price];
    _priceL.attributedText = [RRAttributedString setText:_priceL.text color:AppColor(153) range:NSMakeRange(0, _num.length)];
    
    NSArray *buttonArray = [dic getArray:@"button"];
    if (buttonArray.count == 0)
    {
        _bt_1.hidden = YES;
        _bt_2.hidden = YES;
    }
    else if (buttonArray.count == 1)
    {
        [self setSELforButton:_bt_1 title:buttonArray[0]];
        _bt_2.hidden = YES;
    }
    else if (buttonArray.count == 2)
    {
        [self setSELforButton:_bt_1 title:buttonArray[0]];
        [self setSELforButton:_bt_2 title:buttonArray[1]];
    }
    
    [self.layer needsDisplay];
}

- (void)setSELforButton:(UIButton *)button title:(NSString *)title
{
    [button setTitle:title forState:UIControlStateNormal];
    if ([title isEqualToString:@"取消订单"])
    {
        [button addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
    }
    else if([title isEqualToString:@"去付款"])
    {
        [button addTarget:self action:@selector(payOrder) forControlEvents:UIControlEventTouchUpInside];

    }
    else if ([title isEqualToString:@"去转账"])
    {
        if(_statu == 9)//等待银行转账
        {
            [button addTarget:self action:@selector(payPOSOrder) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (_statu == 10)//等待快钱POS转账
        {
            [button addTarget:self action:@selector(payPOSOrder) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    else if([title isEqualToString:@"刷新状态"])
    {
        [button addTarget:self action:@selector(refreshOrder) forControlEvents:UIControlEventTouchUpInside];

    }
    else if([title isEqualToString:@"确认收货"])
    {
        [button addTarget:self action:@selector(getItem) forControlEvents:UIControlEventTouchUpInside];

    }
    else if([title isEqualToString:@"删除订单"])
    {
        [button addTarget:self action:@selector(deleteOrder) forControlEvents:UIControlEventTouchUpInside];

    }
    else if([title isEqualToString:@"联系客服"])
    {
        [button addTarget:self action:@selector(contact) forControlEvents:UIControlEventTouchUpInside];
        
    }

    else
    {
        NSLog(@"something wrong,please contact me");
    }
}

- (void)payPOSOrder
{
    PUSH_VIEWCONTROLLER(BankChangStepTwoController);
    
    model.orderId = _data.OrderSerialNo;
    
    model.orderType = _data.OrderType;
    
    model.itemCount = [NSString stringWithFormat:@"%d", _data.ItemCount];
    
    model.totalPay = [NSString stringWithFormat:@"%.2f", _data.OrderAmount];
    
    int orderType = _data.OrderType;
    NSString * orderTypeName = @"";
    
    if(orderType == CRENUM_OrderTypeBuy_DEJB)
    {
        orderTypeName = @"购买大额广告金币";
    }
    else if (orderType == CRENUM_OrderTypeDirectAdvert)
    {
        orderTypeName = @"购买红包广告条数";
    }
    else if (orderType == CRENUM_OrderTypeEnterpriseVIP)
    {
        orderTypeName = @"购买商家VIP";
    }else if (orderType == CRENUM_OrderTypeBuy_YHED)
    {
        orderTypeName = @"购买易货额度";
    }
    model.payFrom = orderTypeName;
    
    if(_statu == 9)//银行转账
    {
        //银行转账
        model.paymType = @"3";
    }
    else
    {
        model.paymType = @"7";
        model.isPOS = YES;
    }
}

- (void)payOrder
{
//    //购买数量
//    NSString *count = [NSString stringWithFormat:@"%d",(int)_data.ItemCount];
    //跳转去购买
    NSDictionary *dic = @{@"OrderType" : @(_data.OrderType),  @"OrderSerialNo" : _data.OrderSerialNo};
    ADAPI_Payment_ShowOrderToPay([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGoCommonOrderShow:)], dic);
}


- (void)handleGoCommonOrderShow:(DelegatorArguments *)arguments
{
    DictionaryWrapper *dic = arguments.ret;
    
    if (dic.operationSucceed)
    {
//        NSDictionary *dic = @{@"OrderType":@"3",@"ItemCount":@(_data.ItemCount),@"OrderSerialNo":_data.OrderSerialNo};
        NSDictionary *dic = @{@"OrderType":@(_data.OrderType),@"ItemCount":@(_data.ItemCount),@"OrderSerialNo":_data.OrderSerialNo};
        ConfirmOrderViewController *model = WEAK_OBJECT(ConfirmOrderViewController, init);
        model.type = 3;
        model.payDic = dic;
        model.orderInfoDic = arguments.ret.data;
        model.goodsInfo = @[@{@"name" :_data.Title,@"num" : [NSString stringWithFormat:@"%d",(int)_data.ItemCount]}];
        [[DotCUIManager instance].mainNavigationController pushViewController:model animated:YES];
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}


- (void)cancelOrder
{
    __block OrderTableViewCell* weakself = self;
    [AlertUtil showAlert:@"确认取消本订单吗" message:nil buttons:@[@"取消",@{
                                                              @"title":@"确认",
                                                              @"delegator" : ALERT_VIEW_DELEGATOR_BLOCK({
        [weakself cancelOrder_d];
    })
                                                              }]];
}

- (void)cancelOrder_d
{
    ADAPI_adv3_CancelOrder([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(isSuccess:)], _data.OrderSerialNo);
}

- (void)refreshOrder
{
    ADAPI_adv3_RefreshOrder([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(isSuccess:)], _data.OrderSerialNo);
}


- (void)deleteOrder
{
    __block OrderTableViewCell* weakself = self;
    [AlertUtil showAlert:@"确认要删除订单" message:nil buttons:@[@"取消",@{
                                                              @"title":@"确认",
                                                              @"delegator" : ALERT_VIEW_DELEGATOR_BLOCK({
        [weakself deleteOrder_d];
    })
                                                              }]];
}

- (void)deleteOrder_d
{
    ADAPI_adv3_DeleteOrder([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(isSuccess:)], _data.OrderSerialNo);
}

- (void)isSuccess:(DelegatorArguments *)arg
{
    if ([arg isEqualToOperation:ADOP_adv3_DeleteOrder])
    {
        //删除订单
        if (arg.ret.operationSucceed)
        {
            if (_delegate && [_delegate respondsToSelector:@selector(orderDelete:)])
            {
                [_delegate orderDelete:_fatherIndex];
            }
        }
    }
    else if ([arg isEqualToOperation:ADOP_adv3_RefreshOrder] || [arg isEqualToOperation:ADOP_adv3_CancelOrder])
    {
        //刷新订单
        if (arg.ret.operationSucceed)
        {
            NSString *ret = [arg.ret.data getString:@"OrderStatus"];
            _data.OrderSerialNo = ret;
            
            if (_delegate && [_delegate respondsToSelector:@selector(orderRefresh:)])
            {
                [_delegate orderRefresh:_fatherIndex];
            }
        }
    }
    
    
    if(!arg.ret.operationSucceed) [HUDUtil showErrorWithStatus:arg.ret.operationMessage];
}

- (void)getItem
{
    NSLog(@"确认收货");
}

- (void)contact
{
    [[UICommon shareInstance] makeCall:kServiceMobile];
}

- (void)dealloc
{
    _delegate = nil;
    [_data release];
    [_title release];
    [_statuL release];
    [_itemL release];
    [_priceL release];
    [_orderNum release];
    [_bt_2 release];
    [_bt_1 release];
    [_cellLine release];
    [super dealloc];
}

@end
