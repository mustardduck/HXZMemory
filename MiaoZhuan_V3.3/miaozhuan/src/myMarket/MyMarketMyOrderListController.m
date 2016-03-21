//
//  MyMarketMyOrderListController.m
//  miaozhuan
//
//  Created by momo on 14-12-26.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyMarketMyOrderListController.h"
#import "BaserHoverView.h"
#import "MJRefreshController.h"
#import "MyMarketMyOrderCell.h"
#import "RRAttributedString.h"
#import "MyMarketMyOrderDetailController.h"
#import "ConfirmOrderViewController.h"
#import "RRLineView.h"
#import "MallScanAdvertMain.h"
#import "ProductOrderMsgViewController.h"
#import "ZhiFuPwdQueRenViewController.h"
#import "ZhiFuPwdEditController.h"
#import "ZhiFuPwdYanZhengViewController.h"

@interface MyMarketMyOrderListController ()<UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    MJRefreshController * _MJRefreshCon;

    NSInteger _currentIndex;

}

@property (retain, nonatomic) IBOutlet RRLineView *line;


@end

@implementation MyMarketMyOrderListController

MTA_viewDidAppear()
MTA_viewDidDisappear()

-(void)viewWillAppear:(BOOL)animated
{
    [self initTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigateTitle:@"我的订单"];
    [self setupMoveBackButton];

    if(_queryType == 1)
    {
        [self waitToPay];
    }
    else if (_queryType == 2)
    {
        [self waitToShip];
    }
    else if (_queryType == 3)
    {
        [self waitToReceive];
    }

    [self fixView];
    
    NSString * refreshName = @"Mall/CustomerGetOrderList";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_mainTableView name:refreshName];
}

- (void) fixView
{
    _line.top = 39.5;
}

//0-全部，1-待付款，2-待发货，3-待收货，4-退换/售后

- (void)initTableView
{
//    NSString * refreshName = @"Mall/CustomerGetOrderList";
//    
//    _MJRefreshCon = [MJRefreshController controllerFrom:_mainTableView name:refreshName];
    
    __block MyMarketMyOrderListController * weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        NSDictionary * dic = @{@"service":[NSString stringWithFormat:@"%@%@", @"api/", refreshName ],
                               @"parameters":@{@"OrderType":[NSNumber numberWithInteger: weakself.queryType],
                                               @"pageIndex":@(pageIndex),
                                               @"pageSize":@(pageSize)}
                               };
        return dic.wrapper;
    }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            if(controller.refreshCount > 0 && netData.operationSucceed)
            {
                _mainTableView.hidden = NO;
            }
            else
            {
                [self createHoverViewWhenNoData];
            }
        };
        
        [_MJRefreshCon setOnRequestDone:block];
        [_MJRefreshCon setPageSize:50];
        [_MJRefreshCon retain];
    }
    
    [self refreshTableView];
    
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

- (void)createHoverViewWhenNoData{
    
    BaserHoverView * hover = (BaserHoverView *)[self.view viewWithTag:1111];
    
    if(!hover)
    {
        hover = WEAK_OBJECT(BaserHoverView, initWithTitle:@"抱歉" message:@"您没有相关的订单");
        
        hover.imgView.image = [UIImage imageNamed:@"nocashrecord"];
        
        hover.frame = _mainTableView.frame;
        
        hover.tag = 1111;
        
        [self.view addSubview:hover];
        
        [self.view sendSubviewToBack:hover];
        
    }
    
    _mainTableView.hidden = YES;
    
}

- (void) onMoveBack:(UIButton *)sender
{
    if(_isReturnMoney)
    {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[MallScanAdvertMain class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                break;
            }
            else if([vc isKindOfClass:[ProductOrderMsgViewController class]])
            {
                [self.navigationController popToViewController:vc animated:YES];
                break;
            }
        }
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelHandler:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        [HUDUtil showSuccessWithStatus: @"您的订单已取消！"];
        
        [self refreshTableView];

    }
    else
    {
        [HUDUtil showErrorWithStatus: wrapper.operationMessage];
    }
}

- (void)delayHandler:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        [HUDUtil showSuccessWithStatus:@"本订单已经延长收货7天"];
    }
    else
    {
        [HUDUtil showErrorWithStatus: wrapper.operationMessage];
    }
}

//- (void)ensureHandler:(DelegatorArguments*)arguments {
//    
//    DictionaryWrapper *wrapper = arguments.ret;
//    if (wrapper.operationSucceed) {
//    
//        [HUDUtil showSuccessWithStatus:@"确认收货成功"];
//
//        [self refreshTableView];
//    }
//    else
//    {
//        [HUDUtil showErrorWithStatus: wrapper.operationMessage];
//    }
//}

- (void)remindHandler:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        [HUDUtil showSuccessWithStatus:@"已成功提醒卖家"];
    }
    else
    {
        [HUDUtil showErrorWithStatus: wrapper.operationMessage];
    }
}

- (void)deleteHandler:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        [HUDUtil showErrorWithStatus: @"删除订单成功"];

        [self refreshTableView];
    }
    else
    {
        [HUDUtil showErrorWithStatus: wrapper.operationMessage];
    }
}

- (void)refreshHandler:(DelegatorArguments*)arguments {
    //订单状态：0-待付款，1-待发货，2-待商家同意退款，3-待收货，4-交易成功，5-交易关闭，6-交易异常，7-交易处理中
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        [HUDUtil showSuccessWithStatus:@"状态已刷新"];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
        
        MyMarketMyOrderCell *cell = (MyMarketMyOrderCell *)[_mainTableView cellForRowAtIndexPath:indexPath];
        
        [self changeCellStatus:cell withDic:wrapper.data andIndex:_currentIndex];
        
    }
    else
    {
        [HUDUtil showErrorWithStatus: wrapper.operationMessage];
    }
}

- (void) selectAll
{
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.left = 15;
        
        _lineView.width = 47;
    }];
    
    _allBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    _waitToShipBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _waitToPayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _waitToReceiveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [_allBtn setTitleColor:[UIColor titleRedColor] forState:UIControlStateNormal];
    [_waitToShipBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    [_waitToPayBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    [_waitToReceiveBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    
    self.queryType = 0;
}

- (void)waitToPay
{
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.left = 80 + 9;
        _lineView.width = 62;
    }];
    
    _waitToPayBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    _waitToShipBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _allBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _waitToReceiveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [_waitToPayBtn setTitleColor:[UIColor titleRedColor] forState:UIControlStateNormal];
    [_waitToShipBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    [_allBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    [_waitToReceiveBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    
    self.queryType = 1;
}

- (void) waitToShip
{
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.left = 80 * 2 + 9;
        _lineView.width = 62;
    }];
    
    _waitToShipBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    _waitToPayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _allBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _waitToReceiveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [_waitToShipBtn setTitleColor:[UIColor titleRedColor] forState:UIControlStateNormal];
    [_waitToPayBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    [_allBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    [_waitToReceiveBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    
    self.queryType = 2;
}

- (void) waitToReceive
{
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.left = 80 * 3 + 9;
        _lineView.width = 62;
    }];
    
    _waitToReceiveBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    _waitToShipBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _allBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _waitToPayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [_waitToReceiveBtn setTitleColor:[UIColor titleRedColor] forState:UIControlStateNormal];
    [_waitToShipBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    [_allBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    [_waitToPayBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    
    self.queryType = 3;
}

- (IBAction)touchUpInsideOn:(id)sender
{
    if(sender == _allBtn)
    {
        [self selectAll];
    }
    else if (sender == _waitToPayBtn)
    {
        [self waitToPay];
    }
    else if (sender == _waitToShipBtn)
    {
        [self waitToShip];
    }
    else if (sender == _waitToReceiveBtn)
    {
        [self waitToReceive];
    }
    
    [self refreshTableView];
}

- (void) goToBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if(btn.tag >= 10000 && btn.tag < 20000)//去付款
    {
        //现在没有待付款状态
    }
    else if(btn.tag >= 20000 && btn.tag < 30000)//去订单详情
    {
        _currentIndex = btn.tag - 20000;
        
        NSDictionary *dic = [_MJRefreshCon dataAtIndex:_currentIndex];
        
        MyMarketMyOrderDetailController * view = WEAK_OBJECT(MyMarketMyOrderDetailController, init);
        
        view.orderNum = [dic.wrapper getString:@"OrderNo"];
        
        view.productType = [dic.wrapper getInt:@"OrderType"];
        
        [self.navigationController pushViewController:view animated:YES];
        
    }
    else if (btn.tag == 3)//异常
    {
        [[UICommon shareInstance]makeCall:@"400-019-3588"];

    }
    else if (btn.tag >= 40000 && btn.tag < 50000)//刷新
    {
        _currentIndex = btn.tag - 40000;
        
        DictionaryWrapper *dic = [_MJRefreshCon dataAtIndex:_currentIndex];
        
        ADAPI_GoldMallRefresh([self genDelegatorID:@selector(refreshHandler:)], [dic getString:@"OrderNo"], [dic getInt:@"OrderType"]);
        
    }
    else if (btn.tag >= 50000 && btn.tag < 60000)//删除订单
    {
        UIAlertView *tempAlertView = [[[UIAlertView alloc]
                                       initWithTitle:@"确认删除订单？"
                                       message: @"删除之后将无法恢复"
                                       delegate: self
                                       cancelButtonTitle: @"取消"
                                       otherButtonTitles: @"确认", nil] autorelease];
        
        tempAlertView.tag = btn.tag;
        
        [tempAlertView show];
    }
    else if (btn.tag >= 60000 && btn.tag < 70000)//取消订单
    {
        UIAlertView *tempAlertView = [[[UIAlertView alloc]
                                       initWithTitle:nil
                                       message: @"确认取消本订单吗？"
                                       delegate: self
                                       cancelButtonTitle: @"取消"
                                       otherButtonTitles: @"确认", nil] autorelease];
        
        tempAlertView.tag = btn.tag;
        
        [tempAlertView show];
        
    }
    else if (btn.tag >= 70000 && btn.tag < 80000)//提醒发货
    {
        _currentIndex = btn.tag - 70000;
        
        DictionaryWrapper *dic = [_MJRefreshCon dataAtIndex:_currentIndex];

        ADAPI_GoldMallRemind([self genDelegatorID:@selector(remindHandler:)], [dic getString:@"OrderNo"], [dic getInt:@"OrderType"]);
    }
    else if (btn.tag >= 80000 && btn.tag < 90000)//延长收货
    {
        UIAlertView *tempAlertView = [[[UIAlertView alloc]
                                       initWithTitle:@"确认延长收货时间？"
                                       message: @"每笔订单只能延长1次哟"
                                       delegate: self
                                       cancelButtonTitle: @"取消"
                                       otherButtonTitles: @"确认", nil] autorelease];
        
        tempAlertView.tag = btn.tag;
        
        [tempAlertView show];
        
    }
    else if (btn.tag >= 90000 && btn.tag < 100000)//确认收货
    {
//        UIAlertView *tempAlertView = [[[UIAlertView alloc]
//                                       initWithTitle:@"确认收货吗"
//                                       message: @"点击\"确认\"则代表您确认本货品无误,交易将成功结束"
//                                       delegate: self
//                                       cancelButtonTitle: @"取消"
//                                       otherButtonTitles: @"确认", nil] autorelease];
//        
//        tempAlertView.tag = btn.tag;
//        
//        [tempAlertView show];
        
        
        //3.3需求
        //先判断是否最新版本，随后判断是否设置支付密码
        
        NSString *OrVersion = [[NSUserDefaults standardUserDefaults] valueForKey:@"OrVersion"];
        
        NSString *Downurl = [[NSUserDefaults standardUserDefaults] valueForKey:@"Downurl"];
        
        DictionaryWrapper * dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
        
//        if ([OrVersion isEqualToString:@"1"])
//        {
            //不需要升级、判断是否设置支付密码
            if ([dic getInt:@"SetPayPwdStatus"] == 0)
            {
                //未设置
                PUSH_VIEWCONTROLLER(ZhiFuPwdYanZhengViewController);
                model.zhifuPwdFromType = ZhifuPWD_MyOrderShouHuo;
                model.orderId = [[_MJRefreshCon dataAtIndex:_currentIndex] getString:@"OrderId"];
                model.type = @"3";
                
                [[NSUserDefaults standardUserDefaults] setObject:@{
                                                                   @"OrderId":[[_MJRefreshCon dataAtIndex:_currentIndex] getString:@"OrderId"],
                                                                   @"type":@"3",
                                                                   }
                                                          forKey:@"ConfirmPayPasswordInfo"];
            }
            else
            {
                ZhiFuPwdQueRenViewController *next = WEAK_OBJECT(ZhiFuPwdQueRenViewController, init);
                next.OrderId = [[_MJRefreshCon dataAtIndex:_currentIndex] getString:@"OrderId"];
                next.type = @"3";
                [UI_MANAGER.mainNavigationController pushViewController:next animated:YES];
            }
//        }
//        if ([OrVersion isEqualToString:@"2"])
//        {
//            [AlertUtil showAlert:@""
//                         message:@"为确保你的账户安全，我们加入了支付密码。请升级到最新版本后继续使用！"
//                         buttons:@[@"暂不升级",@{ @"title":@"马上升级",
//                                              @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Downurl]];
//            })}]];
//        }
//        else if ([OrVersion isEqualToString:@"3"])
//        {
//            [AlertUtil showAlert:@""
//                         message:@"为确保你的账户安全，我们加入了支付密码。请升级到最新版本后继续使用！"
//                         buttons:@[@{ @"title":@"确定",
//                                      @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Downurl]];
//            })}]];
//        }

    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex)
    {
        if(alertView.tag >= 60000 && alertView.tag < 70000 && buttonIndex == 1)//取消订单
        {
            _currentIndex = alertView.tag - 60000;
            
            ADAPI_GoldMallCancel([self genDelegatorID:@selector(cancelHandler:)], [[_MJRefreshCon dataAtIndex:_currentIndex] getString:@"OrderId"]);
        }
        else if(alertView.tag >= 50000 && alertView.tag < 60000 && buttonIndex == 1)//删除订单
        {
            _currentIndex = alertView.tag - 50000;
            
            DictionaryWrapper * dic = [_MJRefreshCon dataAtIndex:_currentIndex];
            
            ADAPI_GoldMallDelete([self genDelegatorID:@selector(deleteHandler:)], [dic getString:@"OrderNo"], [dic getInt:@"OrderType"]);

        }
        else if(alertView.tag >= 80000 && alertView.tag < 90000 && buttonIndex == 1)//延迟
        {
            _currentIndex = alertView.tag - 80000;
            
            ADAPI_GoldMallDelay([self genDelegatorID:@selector(delayHandler:)], [[_MJRefreshCon dataAtIndex:_currentIndex] getString:@"OrderId"]);
            
        }
//        else if(alertView.tag >= 90000 && alertView.tag < 100000 && buttonIndex == 1)//确认
//        {
//            _currentIndex = alertView.tag - 90000;
//            
//            ADAPI_GoldMallEnsure([self genDelegatorID:@selector(ensureHandler:)], [[_MJRefreshCon dataAtIndex:_currentIndex] getString:@"OrderId"]);
//            
//        }
    }
}

#pragma mark UITableViewDelegate and UITableViewDatasource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    MyMarketMyOrderCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"MyMarketMyOrderCell"];
    
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyMarketMyOrderCell"
                                                     owner:self
                                                   options:nil];
        cell = nib[0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setCellHandler:self withAction:@selector(goToBtn:)];
    }
    
    NSDictionary *dic = [_MJRefreshCon dataAtIndex:row];
    
    [cell initWithDic:dic];
    
    cell.compBtn.tag = 20000 + row;
    
    [self changeCellStatus:cell withDic:dic andIndex:row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void) changeCellStatus:(MyMarketMyOrderCell *)cell withDic:(NSDictionary *)dic andIndex:(int) row
{
    
    int orderState = [dic.wrapper getInt:@"OrderStatus"];
    
    [cell.BtnTwo setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    
    [cell.BtnTwo setRoundCorner:5.0];
    
    cell.bottomLbl.hidden = YES;
    
    cell.bottomBtnView.hidden = NO;

    if(orderState == 101)//未付款，等待付款
    {
        cell.statusView.hidden = YES;
        
        cell.paySuccessLbl.hidden = NO;
        
        cell.paySuccessLbl.text = @"待付款";
        cell.BtnOne.tag = 60000 + row;
        
        cell.BtnTwo.tag = 10000 + row;
        
        cell.BtnOne.hidden = NO;
        
        cell.BtnTwo.hidden = NO;
        
        [cell.BtnTwo setTitle:@"取消订单" forState:UIControlStateNormal];
        
        [cell.BtnTwo setTitle:@"去付款" forState:UIControlStateNormal];
        
    }
    else if (orderState == 102)// 交易中
    {
        cell.paySuccessLbl.hidden = YES;
        
        cell.statusView.hidden = NO;
        
        cell.statusOneLbl.text = @"处理中";
        
        cell.statusTwoLbl.text = @"请等待";
        
        cell.BtnOne.hidden = YES;
        
        cell.BtnTwo.hidden = NO;
        
        [cell.BtnTwo setTitle:@"刷新状态" forState:UIControlStateNormal];
        
        cell.BtnTwo.tag = 40000 + row;
    }
    else if (orderState == 105)// 交易异常
    {
        cell.paySuccessLbl.hidden = YES;
        
        cell.statusView.hidden = NO;
        
        cell.statusOneLbl.text = @"交易异常";
        
        cell.statusTwoLbl.text = @"请联系客服";
        
        cell.BtnOne.hidden = YES;
        
        cell.BtnTwo.hidden = NO;
        
        [cell.BtnTwo setTitle:@"联系客服" forState:UIControlStateNormal];
        
        cell.BtnTwo.tag = 3;
    }
    else if (orderState >= 200 && orderState <= 202)// 开始等待商家发货
    {
        cell.statusView.hidden = YES;
        
        cell.paySuccessLbl.hidden = NO;
        
        cell.paySuccessLbl.text = @"待发货";
        
        cell.bottomBtnView.hidden = NO;
        
        cell.BtnOne.hidden = YES;
        
        cell.BtnTwo.tag = 70000 + row;
        
        cell.BtnTwo.hidden = NO;
        
        [cell.BtnTwo setTitle:@"提醒发货" forState:UIControlStateNormal];
    }
    else if (orderState == 203)// 待商家同意退款
    {
        cell.statusView.hidden = NO;
        
        cell.paySuccessLbl.hidden = YES;
        
        cell.statusOneLbl.text = @"待商家同意退款";
                
        cell.statusTwoLbl.text = [dic.wrapper getString:@"RemainingTime"];
        
        cell.statusTwoLbl.textColor = AppColor(153);
        
        cell.bottomBtnView.hidden = YES;
        
        cell.bottomLbl.hidden = NO;
        
        NSString * moneyReturn = @"";
        
        int orderType = [dic.wrapper getInt:@"OrderType"];

        if(orderType == 0)//订单类型 0-银元（邮寄），1-易货码
        {
            cell.bottomLbl.text = [NSString stringWithFormat:@"交易金额：%d银元       退款金额：%d银元", [dic.wrapper getInt:@"TotalPrice" ], [dic.wrapper getInt:@"ReturnAmount"]];
            
            moneyReturn = [NSString stringWithFormat:@"%d", [dic.wrapper getInt:@"ReturnAmount"]];
        }
        else if (orderType == 1)
        {
            cell.bottomLbl.text = [NSString stringWithFormat:@"交易金额：%0.2f易货码       退款金额：%0.2f易货码", [dic.wrapper getDouble:@"TotalPrice" ], [dic.wrapper getDouble:@"ReturnAmount"]];
            
            moneyReturn = [NSString stringWithFormat:@"%0.2f", [dic.wrapper getDouble:@"ReturnAmount"]];
        }
        
        NSAttributedString * attributedString= [RRAttributedString setText:cell.bottomLbl.text color:AppColor(34) range:NSMakeRange(0, cell.bottomLbl.text.length - moneyReturn.length - 2)];
        
        cell.bottomLbl.attributedText = attributedString;
    }
    else if (orderState >= 300 && orderState <= 399)// 等待收货
    {
        cell.statusView.hidden = YES;
        
        cell.paySuccessLbl.hidden = NO;
        
        cell.paySuccessLbl.text = @"待收货";
        
        cell.BtnOne.hidden = NO;
        cell.BtnOne.tag = 80000 + row;
        [cell.BtnOne setTitle:@"延长收货" forState:UIControlStateNormal];
        
        cell.BtnTwo.tag = 90000 + row;
        cell.BtnTwo.hidden = NO;
        [cell.BtnTwo setTitle:@"确认收货" forState:UIControlStateNormal];
        
        [cell.BtnTwo setTitleColor:[UIColor titleRedColor] forState:UIControlStateNormal];
        
        [cell.BtnTwo setRoundCorner:5.0 withBorderColor:[UIColor titleRedColor]];
    }
    else if (orderState == 901)//交易成功
    {
        cell.statusView.hidden = YES;
        
        cell.paySuccessLbl.hidden = NO;
        
        cell.paySuccessLbl.text = @"交易成功";
        
        cell.BtnOne.hidden = YES;
        
        cell.BtnTwo.hidden = NO;
        
        [cell.BtnTwo setTitle:@"删除订单" forState:UIControlStateNormal];
        
        cell.BtnTwo.tag = 50000 + row;
    }
    else if (orderState == 911) // 交易关闭(删除订单)
    {
        cell.statusView.hidden = YES;
        
        cell.paySuccessLbl.hidden = NO;
        
        cell.paySuccessLbl.text = @"交易关闭";
        
        cell.BtnOne.hidden = YES;
        
        cell.BtnTwo.hidden = NO;
        
        [cell.BtnTwo setTitle:@"删除订单" forState:UIControlStateNormal];
        
        cell.BtnTwo.tag = 50000 + row;
    }
}

- (void)dealloc {
    [_allBtn release];
    [_waitToPayBtn release];
    [_waitToShipBtn release];
    [_waitToReceiveBtn release];
    [_lineView release];
    [_mainTableView release];
    [_line release];
    [super dealloc];
}
@end
