//
//  MyMarketMyOrderDetailController.m
//  miaozhuan
//
//  Created by momo on 14/12/29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyMarketMyOrderDetailController.h"
#import "MyMarketMyOrderWebViewController.h"
#import "MyMarketMyOrderReturnProdController.h"
#import "DisagreeRerurnViewController.h"
#import "UIView+expanded.h"

@interface MyMarketMyOrderDetailController ()<UIAlertViewDelegate>
{
}

@property (retain, nonatomic) IBOutlet UIView *topReasonView;
@property (retain, nonatomic) NSDictionary * srcDic;

@end

@implementation MyMarketMyOrderDetailController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigateTitle:@"订单详情"];
    [self setupMoveBackButton];
    
    [_returnProdBtn roundCornerBorder];
    [_appealBtn roundCornerBorder];
    
    ADAPI_GoldMallOrderDetail([self genDelegatorID:@selector(orderDetailHandler:)], _orderNum, _productType);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        DisagreeRerurnViewController * view = WEAK_OBJECT(DisagreeRerurnViewController, init);
        
        view.orderId = [_srcDic.wrapper getInt:@"OrderId"];
        
        view.isMyOrder = YES;
        
        [self.navigationController pushViewController:view animated:YES];
    }
}

- (void) onMoveBack:(UIButton *)sender
{
    if (_Type == 1)
    {
        NSArray *vcs = self.navigationController.viewControllers;
        UIViewController *vc = vcs[2];
        [self.navigationController popToViewController:vc animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PayStatus" object:@(YES)];
        return;
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)orderDetailHandler:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {

        self.srcDic = wrapper.data;
        
        [self layoutDetailView];
    }
    else
    {
        [HUDUtil showErrorWithStatus: wrapper.operationMessage];
    }
}

- (void) layoutDetailView
{
    DictionaryWrapper * dic = _srcDic.wrapper;
    
    int orderState = [dic getInt:@"OrderStatus"];
    
    int orderType = [dic getInt:@"OrderType"];
    //订单类型 0-银元（邮寄），1-易货码
    
    NSString * orderPrice = @"";
    NSString * price = @"";
    NSString * deliveryCost = @"";
    
    switch (orderType) {
        case 0:
            orderPrice = [NSString stringWithFormat:@"%d银元", [dic getInt:@"TotalPrice"]];
            
            price = [NSString stringWithFormat:@"单价：%d银元", [dic getInt:@"Price"]];

            deliveryCost = @"运费：邮费到付 用户自理";
            
            _prodDetailLbl.hidden = YES;
            
            break;
        case 1:
            orderPrice = [NSString stringWithFormat:@"%0.2f易货码", [dic getDouble:@"TotalPrice"]];
            
            price = [NSString stringWithFormat:@"单价：%0.2f易货码", [dic getDouble:@"Price"]];

            deliveryCost = @"运费：商家包邮";

            _prodDetailLbl.text = [NSString stringWithFormat:@"颜色/规格：%@", [dic getString:@"SpecificationName"]];

            _prodDetailLbl.hidden = NO;
            
            break;
        default:
            break;
    }
    
    _topOrderPriceLbl.text = [NSString stringWithFormat:@"订单总金额：%@", orderPrice ];
    
    _topOrderNumber.text = [NSString stringWithFormat:@"订  单 号：%@", [dic getString:@"OrderNumber"]];
    
    NSString * date = [dic getString:@"CreateTime"];
    
    date = [UICommon format19Time:date];
    
    _topOrderDateLbl.text = [NSString stringWithFormat:@"交易时间：%@", date];
    
    _sentToLbl.text = [NSString stringWithFormat:@"收货人：%@", [dic getString:@"CustomerName"]];
    _mobileLbl.text = [dic getString:@"CustomerPhone"];
    _sentAddressLbl.text = [NSString stringWithFormat:@"收货地址：%@", [dic getString:@"ShippingAddress"]];

    NSString * picUrl = [dic.wrapper getString:@"PictureUrl"];
    [_prodImgView requestPic:picUrl placeHolder:NO];
    [_prodImgView setBorderWithColor:AppColor(220)];

    _compNameLbl.text = [dic getString:@"EnterpriseName"];
    _prodNameLbl.text = [dic getString:@"ProductName"];
    
    _priceLbl.text = price;
    
    _countLbl.text = [NSString stringWithFormat:@"数量：%@", [dic getString:@"Count"]];
    
    _totalPriceLbl.text = [NSString stringWithFormat:@"总价：%@", orderPrice];
    
    _orderPrice.text = [NSString stringWithFormat:@"订单金额：%@", orderPrice];

    _deliveryCostLbl.text = deliveryCost;


    _sellerTelLbl.text = [NSString stringWithFormat:@"卖家联系电话：%@", [dic getString:@"EnterprisePhone"]];

    if(orderState == 101)//未付款，等待付款
    {
        _topIcon.image = [UIImage imageNamed:@"myOrderIcon3"];
        _topTitle.text = @"待付款";
    }
    else if (orderState == 102)// 交易中
    {
        _topIcon.image = [UIImage imageNamed:@"myOrderIcon4"];
        _topTitle.text = @"交易处理中";
    }
    else if (orderState == 105)// 交易异常
    {
        _topIcon.image = [UIImage imageNamed:@"myOrderIcon5"];
        _topTitle.text = @"交易异常";
    }
    else if (orderState >= 200 && orderState <= 202)// 开始等待商家发货
    {
        _topIcon.image = [UIImage imageNamed:@"myOrderIcon6"];
        _topTitle.text = @"待发货";
        
        _returnProdBtn.hidden = NO;
        [_returnProdBtn setTitle:@"申请退款" forState:UIControlStateNormal];
        _returnProdBtn.top = 30;
    }
    else if (orderState == 203)// 待商家同意退款
    {
        _topIcon.image = [UIImage imageNamed:@"myOrderIcon7"];
        _topTitle.text = @"等待商家同意退款";
    }
    else if (orderState >= 300 && orderState <= 303)// 等待收货：商家将货发出，用户处于等待收货状态
    {
        _topIcon.image = [UIImage imageNamed:@"myOrderIcon8"];
        _topTitle.text = @"待收货";
        
        _logisticsView.hidden = NO;
        _logisticsCompLbl.text = [NSString stringWithFormat:@"物流公司：%@", [dic getString:@"ShippingName"]];
        
        _logisticsOrderNumberLbl.text = [NSString stringWithFormat:@"运单编号：%@", [dic getString:@"ShippingCode"]];
        
        _bottomView.top = _logisticsView.bottom;
        
        _returnProdBtn.hidden = NO;
        _appealBtn.hidden = NO;
    }
    else if (orderState == 901)//交易成功
    {
        _topIcon.image = [UIImage imageNamed:@"myOrderIcon1"];
        _topTitle.text = @"交易成功";
        _topTitle.textColor = [UIColor titleRedColor];
        
        _logisticsView.hidden = NO;
        _logisticsView.top = _topOrderView.bottom;
        
        _logisticsCompLbl.text = [NSString stringWithFormat:@"物流公司：%@", [dic getString:@"ShippingName"]];
        _logisticsOrderNumberLbl.text = [NSString stringWithFormat:@"运单编号：%@", [dic getString:@"ShippingCode"]];
        
        _bottomView.top = _logisticsView.bottom;
    }
    else if (orderState == 911) // 交易关闭(删除订单)
    {
        _topIcon.image = [UIImage imageNamed:@"myOrderIcon2"];
        _topTitle.text = @"交易关闭";
        
        _topReasonView.hidden = NO;
        _topReasonLbl.text = [NSString stringWithFormat:@"关闭原因：%@", [dic getString:@"CloseReason"]];
        
        _topOrderView.top = _topReasonView.bottom;
        
        _bottomView.top = _topOrderView.bottom;
    }
    
    _mainScrollView.contentSize = CGSizeMake(320, _bottomView.bottom);
}

- (IBAction)touchUpInsideOn:(id)sender
{
    if(sender == _logisticsBtn)
    {
        MyMarketMyOrderWebViewController * webview = WEAK_OBJECT(MyMarketMyOrderWebViewController, init);
        
        webview.urlString = @"http://www.kuaidi100.com/all/index.shtml?from=newindex";
        
        [self.navigationController pushViewController:webview animated:YES];
    }
    else if (sender == _sellTelBtn)
    {
        [[UICommon shareInstance]makeCall:[_sellerTelLbl.text substringFromIndex:7]];
    }
    else if (sender == _returnProdBtn)
    {
        int orderState = [_srcDic.wrapper getInt:@"OrderStatus"];
        
        MyMarketMyOrderReturnProdController * view = WEAK_OBJECT(MyMarketMyOrderReturnProdController, init);
        
        DictionaryWrapper * dic = _srcDic.wrapper;
        
        int orderType = [dic getInt:@"OrderType"];
        //订单类型 0-银元（邮寄），1-易货码
        
        if(orderType == 0)
        {
            view.totalPrice = [NSString stringWithFormat:@"%d", [dic getInt:@"TotalPrice"]];
        }
        else if(orderType == 1)
        {
            view.totalPrice = [NSString stringWithFormat:@"%0.2f", [dic getDouble:@"TotalPrice"]];
        }
        
        view.orderId = [dic getString:@"OrderId"];

        if(orderState >= 200 && orderState <= 202)//退款
        {
            view.isReturnMoney = YES;
            
            view.orderType = orderType;
            
            view.orderNo = [dic getString:@"OrderNumber"];
            
            if(![_srcDic.wrapper getBool:@"CanRefund"])
            {
                [HUDUtil showErrorWithStatus:[NSString stringWithFormat:@"还需%@后,您才能申请退款", [_srcDic.wrapper getString:@"RemainingTime"]]];

                return;
            }
        }
        
        [self.navigationController pushViewController:view animated:YES];

        
    }
    else if (sender == _appealBtn)
    {
        UIAlertView *tempAlertView = [[[UIAlertView alloc]
                                       initWithTitle:@"确认发起申诉？"
                                       message: @"您确认需要官方介入申诉结果吗"
                                       delegate: self
                                       cancelButtonTitle: @"取消"
                                       otherButtonTitles: @"确认", nil] autorelease];
        
        [tempAlertView show];

    }
}

- (void)dealloc {
    [_mainScrollView release];
    [_topIcon release];
    [_topTitle release];
    [_topOrderView release];
    [_topReasonLbl release];
    [_logisticsView release];
    [_bottomView release];
    [_sentToLbl release];
    [_sentAddressLbl release];
    [_mobileLbl release];
    [_compNameLbl release];
    [_prodNameLbl release];
    [_prodDetailLbl release];
    [_prodImgView release];
    [_priceLbl release];
    [_countLbl release];
    [_totalPriceLbl release];
    [_deliveryCostLbl release];
    [_orderPrice release];
    [_sellerTelLbl release];
    [_sellTelBtn release];
    [_logisticsBtn release];
    [_topOrderPriceLbl release];
    [_topOrderNumber release];
    [_topOrderDateLbl release];
    [_topPayNumberLbl release];
    [_logisticsCompLbl release];
    [_logisticsOrderNumberLbl release];
    [_returnProdBtn release];
    [_appealBtn release];
    [_topReasonView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainScrollView:nil];
    [self setTopIcon:nil];
    [self setTopTitle:nil];
    [self setTopOrderView:nil];
    [self setTopReasonLbl:nil];
    [self setLogisticsView:nil];
    [self setBottomView:nil];
    [self setSentToLbl:nil];
    [self setSentAddressLbl:nil];
    [self setMobileLbl:nil];
    [self setCompNameLbl:nil];
    [self setProdNameLbl:nil];
    [self setProdDetailLbl:nil];
    [self setProdImgView:nil];
    [self setPriceLbl:nil];
    [self setCountLbl:nil];
    [self setTotalPriceLbl:nil];
    [self setDeliveryCostLbl:nil];
    [self setOrderPrice:nil];
    [self setSellerTelLbl:nil];
    [self setSellTelBtn:nil];
    [self setLogisticsBtn:nil];
    [self setTopOrderPriceLbl:nil];
    [self setTopOrderNumber:nil];
    [self setTopOrderDateLbl:nil];
    [self setTopPayNumberLbl:nil];
    [self setLogisticsCompLbl:nil];
    [self setLogisticsOrderNumberLbl:nil];
    [self setReturnProdBtn:nil];
    [self setAppealBtn:nil];
    [super viewDidUnload];
}
@end
