//
//  MySaleReturnAndAfterSaleViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MySaleReturnAndAfterSaleViewController.h"
#import "MySaleReturnCell.h"
#import "ChooseLoticticsViewController.h"
#import "SalesReturnDetailViewController.h"
#import "UserStartApealingViewController.h"
#import "ReturnSucceedViewController.h"
#import "ApealingViewController.h"
#import "ApealingResultViewController.h"
#import "MallScanAdvertMain.h"
#import "ProductOrderMsgViewController.h"
#import "MyMarketMyOrderDetailController.h"
#import "ZhiFuPwdEditController.h"
#import "ZhiFuPwdQueRenViewController.h"
#import "ZhiFuPwdYanZhengViewController.h"

#define kButtonTag_Confirmreceipt 1000

@interface MySaleReturnAndAfterSaleViewController ()<UITableViewDataSource, UITableViewDelegate, ChooseLoticsDelegate, UserStartApealDelegate,UIAlertViewDelegate> {
    BOOL isback;
}

@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (strong, nonatomic) MJRefreshController *mjCon;
@property (retain, nonatomic) IBOutlet UIView *nodataView;

@property (retain, nonatomic) NSString * orderNum;
@property (assign, nonatomic) int orderType;

@end

@implementation MySaleReturnAndAfterSaleViewController
@synthesize mainTable = _mainTable;
@synthesize mjCon = _mjCon;
@synthesize nodataView = _nodataView;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setRefreshItem ];
    [self setupMoveBackButton];
    [self setTitle:@"退货/售后"];
    [_mainTable registerNib:[UINib nibWithNibName:@"MySaleReturnCell" bundle:nil] forCellReuseIdentifier:@"MySaleReturnCell"];
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (isback) {
        [self refresh];
//    }
}

- (void)setRefreshItem {
#warning 待服务端修改确认
    NSString *refreshName = @"api/Mall/CustomerGetOrderList";
    self.mjCon = [MJRefreshController controllerFrom:_mainTable name:refreshName];
    
    [self.mjCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK {
        return @{
                    @"service":refreshName,
                 @"parameters":@{
                    @"PageIndex":@(pageIndex),
                     @"PageSize":@(pageSize),
                   @"OrderType":@"4"}
                 }.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE {
    
        if (!netData.operationSucceed) {
            
            if(netData.operationMessage && netData.operationMessage != nil && ![netData.operationMessage isEqualToString:@""])
            [HUDUtil showErrorWithStatus:netData.operationMessage];
             self.nodataView.hidden = NO;
        }else {
        
            if (_mjCon.refreshCount == 0) {
                
                self.nodataView.hidden = NO;
            }else {
                
                self.nodataView.hidden = YES;
            }
        }
        [_mainTable reloadData];
    };
    [self.mjCon setOnRequestDone:block];
    [self.mjCon setPageSize:10];
    [self.mjCon refreshWithLoading];
}

- (void) onMoveBack:(UIButton *)sender
{
    if(_isMyOrder)
    {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[MallScanAdvertMain class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                break;
            }
        }
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[ProductOrderMsgViewController class]]) {
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

- (void)confirmToReturn:(UIButton*)sender {
    
    ChooseLoticticsViewController *temp = WEAK_OBJECT(ChooseLoticticsViewController, init);
    temp.delagate = self;
    temp.orderId = (int)sender.tag;
    [self.navigationController pushViewController:temp animated:YES];
}

- (void)startApeal:(UIButton*)sender {
    
    UserStartApealingViewController *temp = WEAK_OBJECT(UserStartApealingViewController, init);
    temp.orderId = (int)sender.tag;
    temp.delegate = self;
    [self.navigationController pushViewController:temp animated:YES];
}

-(void) confirmreceipt:(UIButton *) sender
{
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"确认收货吗" message:@"点击“确认”则代表你确认本货品无误交易将成功结束" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//    alert.tag = sender.tag;
//    [alert show];
//    [alert release];
    
    //3.3需求
    //先判断是否最新版本，随后判断是否设置支付密码
    
    NSString *OrVersion = [[NSUserDefaults standardUserDefaults] valueForKey:@"OrVersion"];
    
    NSString *Downurl = [[NSUserDefaults standardUserDefaults] valueForKey:@"Downurl"];
    
    DictionaryWrapper * dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
//    if ([OrVersion isEqualToString:@"1"])
//    {
         int index = (int)sender.tag - kButtonTag_Confirmreceipt;
        //不需要升级、判断是否设置支付密码
        if ([dic getInt:@"SetPayPwdStatus"] == 0)
        {
            //未设置
            PUSH_VIEWCONTROLLER(ZhiFuPwdYanZhengViewController);
            model.orderId = [[_mjCon dataAtIndex:index] getString:@"OrderId"];
            model.isTuiHuo = YES;
            model.type = @"3";
            model.orderNum = [[_mjCon dataAtIndex:index] getString:@"OrderNo"];
            model.orderType = _orderType;
            model.zhifuPwdFromType = ZhifuPWD_ReturnShouHuo;
        }
        else
        {
            ZhiFuPwdQueRenViewController *next = WEAK_OBJECT(ZhiFuPwdQueRenViewController, init);
            next.OrderId = [[_mjCon dataAtIndex:index] getString:@"OrderId"];
            next.isTuiHuo = YES;
            next.type = @"3";
            next.orderNum = [[_mjCon dataAtIndex:index] getString:@"OrderNo"];
            next.orderType = [[_mjCon dataAtIndex:index] getInt:@"OrderType"];
            [UI_MANAGER.mainNavigationController pushViewController:next animated:YES];
        }
//    }
//    if ([OrVersion isEqualToString:@"2"])
//    {
//        [AlertUtil showAlert:@""
//                     message:@"为确保你的账户安全，我们加入了支付密码。请升级到最新版本后继续使用！"
//                     buttons:@[@"暂不升级",@{ @"title":@"马上升级",
//                                          @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Downurl]];
//        })}]];
//    }
//    else if ([OrVersion isEqualToString:@"3"])
//    {
//        [AlertUtil showAlert:@""
//                     message:@"为确保你的账户安全，我们加入了支付密码。请升级到最新版本后继续使用！"
//                     buttons:@[@{ @"title":@"确定",
//                                  @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Downurl]];
//        })}]];
//    }

}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 1)
//    {
//        int index = (int)alertView.tag - kButtonTag_Confirmreceipt;
//        NSLog(@"-----%@",[_mjCon dataAtIndex:index]);
//      
//        self.orderNum = [[[_mjCon dataAtIndex:index] getString:@"OrderId"] retain];
//        
//        _orderType = [[_mjCon dataAtIndex:index] getInt:@"OrderType"];
//        
//        ADAPI_GoldMallEnsure([self genDelegatorID:@selector(HandleNotification:)], [[_mjCon dataAtIndex:index]getString:@"OrderId"]);
//    }
//}

//- (void)HandleNotification:(DelegatorArguments *)arguments
//{
//    if ([arguments isEqualToOperation:ADOP_GoldMallEnsure])
//    {
//        [arguments logError];
//        
//        DictionaryWrapper *wrapper = arguments.ret;
//        
//        if (wrapper.operationSucceed)
//        {
//            [self refresh];
//            
//            PUSH_VIEWCONTROLLER(MyMarketMyOrderDetailController);
//            
//            model.orderNum = self.orderNum;
//
//            model.productType = _orderType;
//            
//        }
//        else if (wrapper.operationPromptCode)
//        {
//            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
//        }
//    }
//}


#pragma mark -ChooseLogicticsDelegate&&UserStartApealingDelegate
- (void)refresh {

    [_mjCon refreshWithLoading];
}

#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _mjCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MySaleReturnCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"MySaleReturnCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DictionaryWrapper *wrapper = [_mjCon dataAtIndex:(int)indexPath.row];
    
    cell.startReturnBtn.tag = [wrapper getInt:@"OrderId"];
    [cell.startReturnBtn addTarget:self action:@selector(confirmToReturn:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.startApealBtn.tag = [wrapper getInt:@"OrderId"];
    [cell.startApealBtn addTarget:self action:@selector(startApeal:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.confirmreceiptBtn.tag = indexPath.row + kButtonTag_Confirmreceipt;
    [cell.confirmreceiptBtn addTarget:self action:@selector(confirmreceipt:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.companyName.text = [wrapper getString:@"EnterpriseName"];
    int orderStatus = [wrapper getInt:@"OrderStatus"];
    //921退货成功
    //501用户发起仲裁502商家发起仲裁
    //941仲裁完毕
    
    //401用户发起退货
    //402商家同意退货        显示 view1
    //403商家不同意退货      显示 view2
    //404用户快递发回货物
    switch (orderStatus) {
            
        case 401:
            
            cell.statusString.text = @"待商家同意退货";
            cell.timeLeftString.hidden = NO;
            [cell.statusString setOrigin:CGPointMake(162, 23)];
            break;
            
        case 402:
            
            cell.statusString.text = @"商家同意，待退货";
            cell.timeLeftString.hidden = NO;
            [cell.statusString setOrigin:CGPointMake(162, 23)];
            break;
            
        case 403:
            
            cell.statusString.text = @"商家不同意退货";
            cell.timeLeftString.hidden = NO;
            [cell.statusString setOrigin:CGPointMake(162, 23)];
            break;
            
        case 404:
            
            cell.statusString.text = @"待商家确认货品";
            cell.timeLeftString.hidden = NO;
            [cell.statusString setOrigin:CGPointMake(162, 23)];
            break;
            
        case 501:
            
            cell.statusString.text = @"申诉中";
            cell.timeLeftString.hidden = YES;
            [cell.statusString setOrigin:CGPointMake(162, 29)];
            break;
            
        case 502:
            
            cell.statusString.text = @"申诉中";
            cell.timeLeftString.hidden = YES;
            [cell.statusString setOrigin:CGPointMake(162, 29)];
            break;
            
        case 941:
            
            cell.statusString.text = @"申诉结束";
            cell.timeLeftString.hidden = YES;
            [cell.statusString setOrigin:CGPointMake(162, 29)];
            break;
        case 931:
            cell.statusString.text = @"退货成功";
            cell.timeLeftString.hidden = YES;
            [cell.statusString setOrigin:CGPointMake(162, 29)];
            break;
        case 921:
            cell.statusString.text = @"退款成功";
            cell.timeLeftString.hidden = YES;
            [cell.statusString setOrigin:CGPointMake(162, 29)];
            break;
            
        default:
            break;
    }
    
    cell.timeLeftString.text = [wrapper getString:@"RemainingTime"];
    
    [cell.productImage requestPicture:[wrapper getString:@"PictureUrl"]];
    cell.productImage.layer.borderColor = [RGBCOLOR(197, 197, 197) CGColor];
    cell.productImage.layer.borderWidth = 0.5;
    
    cell.productIntroduce.text = [wrapper getString:@"ProductName"];
    cell.productCount.text = [NSString stringWithFormat:@"x%d",[wrapper getInt:@"Count"]];
    cell.productPrice.text = [NSString stringWithFormat:@"%.2f易货码",[wrapper getFloat:@"Price"]];
    cell.orderNumber.text = [NSString stringWithFormat:@"订单编号:%@",[wrapper getString:@"OrderNo"]];
    cell.orderPriceRight.text = [NSString stringWithFormat:@"%.2f易货码",[wrapper getFloat:@"TotalPrice"]];
    cell.returnPriceRight.text = [NSString stringWithFormat:@"%.2f易货码",[wrapper getFloat:@"ReturnAmount"]];
    //55
    CGSize size = [[NSString stringWithFormat:@"%.2f易货码",[wrapper getFloat:@"ReturnAmount"]] sizeWithFont:cell.returnPriceRight.font constrainedToSize:CGSizeMake(MAXFLOAT, 12) lineBreakMode:NSLineBreakByWordWrapping];
    [cell.returnPriceRight setFrame:CGRectMake(320-size.width-30, 212, size.width + 15, 12)];
    [cell.returnPriceLeft setFrame:CGRectMake(320-size.width-15-55-3, 212, 55, 12)];
    
    CGSize size2 = [[NSString stringWithFormat:@"%.2f易货码",[wrapper getFloat:@"TotalPrice"]] sizeWithFont:cell.returnPriceRight.font constrainedToSize:CGSizeMake(MAXFLOAT, 12) lineBreakMode:NSLineBreakByWordWrapping];
    [cell.orderPriceRight setFrame:CGRectMake(320-size.width-15-55-5-30-size2.width, 212, size2.width + 15, 12)];
    [cell.orderPriceLeft setFrame:CGRectMake(320-size.width-15-55-5-15-size2.width-55, 212, 55, 12)];
    
    //401用户发起退货
    //402商家同意退货        显示 view1
    //403商家不同意退货      显示 view2
    //404用户快递发回货物
    if (orderStatus == 402) {
        
        cell.view1.hidden = YES;
        cell.view2.hidden = NO;
        cell.UILineView9.hidden = YES;
    }else if (orderStatus == 403){
    
        cell.view1.hidden = NO;
        cell.view2.hidden = YES;
        cell.UILineView9.hidden = YES;
        cell.startReturnBtn.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];
    }else {
    
        cell.view1.hidden = YES;
        cell.view2.hidden = YES;
        cell.UILineView9.hidden = NO;
    }
    
    if (orderStatus == 501||orderStatus == 502){
        
        cell.UILineView4.hidden = YES;
        cell.UILineView41.hidden = NO;
        cell.returnPriceLeft.hidden = YES;
        cell.returnPriceRight.hidden = YES;
        cell.orderPriceLeft.hidden = YES;
        cell.orderPriceRight.hidden = YES;
        cell.UILineView9.hidden = YES;
    }else {
        
        cell.UILineView4.hidden = NO;
        cell.UILineView41.hidden = YES;
        cell.returnPriceLeft.hidden = NO;
        cell.returnPriceRight.hidden = NO;
        cell.orderPriceLeft.hidden = NO;
        cell.orderPriceRight.hidden = NO;
    }
    

    [cell.UILineView5 setOrigin:CGPointMake(cell.UILineView5.frame.origin.x, 49.75)];
    [cell.UILineView7 setOrigin:CGPointMake(cell.UILineView7.frame.origin.x, 49.75)];
    [cell.UILineView9 setOrigin:CGPointMake(0, 244.75)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    DictionaryWrapper *wrapper = [_mjCon dataAtIndex:(int)indexPath.row];
    int orderStatus = [wrapper getInt:@"OrderStatus"];
    
    if (orderStatus <= 499 && orderStatus >=400) {
        isback = YES;
        SalesReturnDetailViewController *temp = WEAK_OBJECT(SalesReturnDetailViewController, init);
        temp.type = 1;
        temp.orderId = [wrapper getInt:@"OrderId"];
        temp.status = [wrapper getInt:@"OrderStatus"];
        temp.creatTime = [wrapper getString:@"CreateTime"];
        [self.navigationController pushViewController:temp animated:YES];
    }
    if (orderStatus == 931) {
        ReturnSucceedViewController *temp = WEAK_OBJECT(ReturnSucceedViewController, init);
        temp.titleString = @"如还有其他疑问，请与商家协商";
        [self.navigationController pushViewController:temp animated:YES];
    }
    
    if (orderStatus >=500 && orderStatus <=599) {
        
        PUSH_VIEWCONTROLLER(ApealingViewController);
    }
    
    if (orderStatus == 941) {
        
        ApealingResultViewController *temp = WEAK_OBJECT(ApealingResultViewController, init);
        temp.orderId = [wrapper getInt:@"OrderId"];
        [self.navigationController pushViewController:temp animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DictionaryWrapper *wrapper = [_mjCon dataAtIndex:(int)indexPath.row];
    int orderStatus = [wrapper getInt:@"OrderStatus"];
    
    if (orderStatus == 402 || orderStatus == 403) {
        
        return 295;
    }else if (orderStatus == 501||orderStatus == 502){

        return 193;
    }else{
     
        return 245;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *temp = WEAK_OBJECT(UIView, init);
    return temp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    
    [_mjCon release];
    [_mainTable release];
    [_nodataView release];
    [super dealloc];
}
- (void)viewDidUnload {
    
    [self setMjCon:nil];
    [self setMainTable:nil];
    [super viewDidUnload];
}
@end
