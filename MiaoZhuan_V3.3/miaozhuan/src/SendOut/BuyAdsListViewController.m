//
//  BuyAdsListViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BuyAdsListViewController.h"
#import "MJRefreshController.h"
#import "BaserHoverView.h"
#import "BuyRecordsCell.h"
#import "ConfirmOrderViewController.h"
#import "BankChangStepTwoController.h"

@interface BuyAdsListViewController ()

@property (nonatomic, retain) MJRefreshController *MJRefreshCon;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BuyAdsListViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setNavigateTitle:@"购买记录"];
    [self _initTableView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView setTableFooterView:[self createTableFooterView]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:@"PayStatus" object:nil];
    
}

- (void)refresh:(NSNotification *)noti{
    if (noti.object) {
        [self refreshTableView];
    }
}

- (void)_initTableView{
    
    [_MJRefreshCon release];
    _MJRefreshCon = nil;
    NSString *refreshName = @"Order/List";
    _MJRefreshCon = [[MJRefreshController controllerFrom:_tableView name:refreshName] retain];
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        NSDictionary * dic =@{@"PageIndex":@(pageIndex), @"PageSize":@(pageSize),@"OrderType":@"6"};
        NSDictionary *pramaDic= @{@"service":[NSString stringWithFormat:@"api/%@",refreshName],@"parameters":dic};
        return pramaDic.wrapper;
    }];
    __block typeof(self) weakSelf = self;
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
    {
        NSLog(@"%@",netData.dictionary);
        if(controller.refreshCount > 0){
            weakSelf.tableView.hidden = NO;
        } else {
            [weakSelf createHoverViewWhenNoData];
        }
        
    };
    
    [_MJRefreshCon setOnRequestDone:block];
    [_MJRefreshCon setPageSize:20];
    
    [self refreshTableView];
    
//    _tableView.panGestureRecognizer.delaysTouchesBegan = YES;
    
}

//无数据hoverview
- (void)createHoverViewWhenNoData{
    BaserHoverView *hover = WEAK_OBJECT(BaserHoverView, initWithTitle:@"抱歉" message:@"没有相应购买记录");
    hover.frame = self.view.bounds;
    [self.view addSubview:hover];
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    BuyRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [BuyRecordsCell newInstance];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell createNewInstanceWithRow:indexPath.row dataDic:[_MJRefreshCon dataAtIndex:(int)indexPath.row]];
    [cell addAction:self withAction:@selector(buttonClicked:)];
    [cell.btnFollow setBackgroundImage:[UIImage imageNamed:@"buy_list_hilighted.png"] forState:UIControlStateHighlighted];
    [cell.btnFront setBackgroundImage:[UIImage imageNamed:@"buy_list_hilighted.png"] forState:UIControlStateHighlighted];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - actions
- (void)buttonClicked:(UIButton *)button{
    __block typeof(self) weakself = self;
    if (button.tag >= 2000000 && button.tag < 3000000) {
        //取消
        [AlertUtil showAlert:@"取消订单"
                     message:@"确认取消本订单吗？"
                     buttons:@[
                               @"取消",
                               @{
                                   @"title":@"确定",
                                   @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                   ({
            int row = button.tag % 2000000;
            NSString *orderSerialNo = [[weakself.MJRefreshCon dataAtIndex:row] getString:@"OrderSerialNo"];
            ADAPI_Order_Cancel([GLOBAL_DELEGATOR_MANAGER addDelegator:weakself selector:@selector(handleCancleOrder:)], @{@"OrderSerialNo":orderSerialNo});
                                    })
                                   }
                               ]];
        
    } else if (button.tag >= 3000000 && button.tag < 4000000) {
        //去付款
        int row = button.tag % 3000000;
        //订单编号
        NSString *serialNo = [[[_MJRefreshCon dataAtIndex:row] wrapper] getString:@"OrderSerialNo"];
        //跳转去购买
        NSDictionary *dic = @{@"OrderType" : @"6", @"OrderSerialNo" : serialNo};
        ADAPI_Payment_ShowOrderToPay([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGoCommonOrderShow:)], dic);
    }
    else if (button.tag >= 4000000 && button.tag < 5000000) {
        //银行转账
        int row = button.tag % 4000000;
        PUSH_VIEWCONTROLLER(BankChangStepTwoController);
        model.orderId = [[[_MJRefreshCon dataAtIndex:row] wrapper] getString:@"OrderSerialNo"];
        //*  OrderType : 1：直购商城 2：用户感恩果 3：商家VIP（年）4：金币 5：用户VIP 6：直投广告 7：易货商城(易货商品) 8：兑换商城(银元商品) 9:大额金币购买 10:易货额度购买
        NSDictionary * dic = [_MJRefreshCon dataAtIndex:row];
        model.orderType = [dic.wrapper getInt:@"OrderType"];
        model.itemCount = [dic.wrapper getString:@"ItemCount"];
        model.totalPay = [dic.wrapper getString:@"OrderAmount"];
        model.payFrom = @"购买红包广告条数";
        model.paymType = @"3";
    }
    else if (button.tag >= 5000000 && button.tag < 6000000) {
        //POS转账
        int row = button.tag % 5000000;
        PUSH_VIEWCONTROLLER(BankChangStepTwoController);
        model.orderId = [[[_MJRefreshCon dataAtIndex:row] wrapper] getString:@"OrderSerialNo"];
        NSDictionary * dic = [_MJRefreshCon dataAtIndex:row];
        model.orderType = [dic.wrapper getInt:@"OrderType"];
        model.itemCount = [dic.wrapper getString:@"ItemCount"];
        model.totalPay = [dic.wrapper getString:@"OrderAmount"];
        model.payFrom = @"购买红包广告条数";
        model.paymType = @"7";
        model.isPOS = YES;
    }
    else if (button.tag >= 7000000 && button.tag < 8000000){
        //刷新
        int row = button.tag % 7000000;
        NSString *orderSerialNo = [[self.MJRefreshCon dataAtIndex:row] getString:@"OrderSerialNo"];
        ADAPI_Order_Refresh([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleRefreshOrder:)], @{@"OrderSerialNo":orderSerialNo});
    } else if (button.tag >= 1000000 && button.tag < 2000000){
        //删除
        [AlertUtil showAlert:@"删除订单"
                     message:@"订单删除后将不能恢复，确定吗？"
                     buttons:@[
                               @"取消",
                               @{
                                   @"title":@"确定",
                                   @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                   ({
            int row = button.tag % 1000000;
            NSString *orderSerialNo = [[weakself.MJRefreshCon dataAtIndex:row] getString:@"OrderSerialNo"];
            ADAPI_Order_Delete([GLOBAL_DELEGATOR_MANAGER addDelegator:weakself selector:@selector(handleDeleteOrder:)], @{@"OrderSerialNo":orderSerialNo});
                                    })
                                   }
                               ]];
    } else if (button.tag >= 8000000) {
        [[UICommon shareInstance] makeCall:kServiceMobile];
    }
}

- (UIView *)createTableFooterView{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10));
//    RRLineView *lineTop = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 0, 320, 0));
    view.backgroundColor = AppColorBackground;
//    [view addSubview:lineTop];
    return view;
}

//取消订单
- (void)handleCancleOrder:(DelegatorArguments *)arguments{
    DictionaryWrapper *dic = arguments.ret;
    if (dic.operationSucceed) {
        [HUDUtil showSuccessWithStatus:@"您的订单已取消!"];
        [self refreshTableView];
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
    }
}

//刷新订单
- (void)handleRefreshOrder:(DelegatorArguments *)arguments{
    DictionaryWrapper *dic = arguments.ret;
    if (dic.operationSucceed) {
        [HUDUtil showSuccessWithStatus:@"状态已刷新!"];
        [self refreshTableView];
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
    }
}

//删除订单
- (void)handleDeleteOrder:(DelegatorArguments *)arguments{
    DictionaryWrapper *dic = arguments.ret;
    if (dic.operationSucceed) {
        [HUDUtil showSuccessWithStatus:@"删除订单成功!"];
        [self refreshTableView];
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
    }
}
#pragma mark - 购买
- (void)handleGoCommonOrderShow:(DelegatorArguments *)arguments{
    DictionaryWrapper *dic = arguments.ret;
    if (dic.operationSucceed) {
        PUSH_VIEWCONTROLLER(ConfirmOrderViewController);
        model.type = 3;
        model.goodsInfo = @[@{@"name" : [dic.data getString:@"ProductName"], @"num" : @"1"}];
        model.payDic = @{@"OrderSerialNo" : [[dic.data getString:@"OrderSerialNo"] length] ? [dic.data getString:@"OrderSerialNo"] : @"", @"OrderType" : @"6", @"ItemCount" : [dic.data getString:@"ItemCount"]};
        model.orderInfoDic = dic.data;
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
