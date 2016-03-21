//
//  WatingShippingViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "WatingShippingViewController.h"
#import "WatingShippingTableViewCell.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "ShippingOrderDetailViewController.h"
#import "RRAttributedString.h"
#import "ChangeShippingAddressViewController.h"
#import "ShippingViewController.h"
#import "RRLineView.h"
@interface WatingShippingViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    BOOL _hasRefreshTable;
    
    MJRefreshController *_MJRefreshCon;
    
    NSString * _ExchangeStatus;
    
    DictionaryWrapper * cellData;
    
//    NSArray * OrderProducts;
}
@property (retain, nonatomic) IBOutlet UIView *searchBgView;
@property (retain, nonatomic) IBOutlet UITextField *searchTxt;
@property (retain, nonatomic) IBOutlet YFJLeftSwipeDeleteTableView *mainTableView;
@property (retain, nonatomic) IBOutlet RRLineView *lineSearch;
@property (retain, nonatomic) IBOutlet NSString *ExchangeStatus;
@property (retain, nonatomic) IBOutlet UIView *showView;
@end

@implementation WatingShippingViewController

-(void)viewWillAppear:(BOOL)animated
{
    if (_hasRefreshTable)
        [self refreshTableView];
}

-(void)hiddenKeyboard
{
    [self refreshTableView];
}

MTA_viewDidAppear(_hasRefreshTable = YES;)
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _searchTxt.text = @"";
    
    [self addDoneToKeyboard:_searchTxt];
    
    [_searchBgView setRoundCorner];
    
    _lineSearch.top = 39;
    
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    _mainTableView.frame = CGRectMake(0, 39, 320, [[UIScreen mainScreen] bounds].size.height - 103);
    
     //邮寄兑换
    if ([_orderType isEqualToString:@"1"])
    {
        if ([_dealState isEqualToString:@"1"])
        {
            InitNav(@"等待用户付款");
            _ExchangeStatus = @"-1";
            _searchTxt.enabled = NO;
        }
        else if ([_dealState isEqualToString:@"2"])
        {
            InitNav(@"等待发货");
            _ExchangeStatus = @"0";
        }
        else if ([_dealState isEqualToString:@"3"])
        {
            InitNav(@"交易成功");
            _ExchangeStatus = @"2";
        }
        else if ([_dealState isEqualToString:@"4"])
        {
            InitNav(@"交易关闭");
            _ExchangeStatus = @"3";
        }
        
        [self setTableviewLoad];
        
    }
    else
    {
        if ([_dealState isEqualToString:@"1"])
        {
            InitNav(@"等待用户付款");
            _ExchangeStatus = @"1";
//            [self.view addSubview:_showView];
        }
        else if ([_dealState isEqualToString:@"2"])
        {
            InitNav(@"等待发货");
            _ExchangeStatus = @"2";
        }
        else if ([_dealState isEqualToString:@"3"])
        {
            InitNav(@"已发货");
            _ExchangeStatus = @"3";
        }
        else if ([_dealState isEqualToString:@"5"])
        {
            InitNav(@"交易成功");
            _ExchangeStatus = @"5";
        }
        else if ([_dealState isEqualToString:@"6"])
        {
            InitNav(@"交易关闭");
            _ExchangeStatus = @"6";
        }
        [self setTableviewLoad];
    }
}

#pragma mark - tableView delegate

- (void) setTableviewLoad
{
    NSString * refreshName = @"ExchangeManagement/GetSilverOrderList";
    
    NSString * refreshNameGold = @"GoldOrder/GetOrderList";
    
    __block WatingShippingViewController * weakself = self;
    
    //邮寄兑换
    if ([_orderType isEqualToString:@"1"])
    {
        _MJRefreshCon = [MJRefreshController controllerFrom:_mainTableView name:refreshName];
        
        [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
         {
             return @{
                      @"service":[NSString stringWithFormat:@"api/%@",refreshName],
                      @"parameters":
                          @{@"EnterpriseId":weakself.EnterpriseId,
                            @"ExchangeType":@"0",@"OrderStatus":weakself.ExchangeStatus,@"KeyWord":weakself.searchTxt.text,
                            @"PageIndex":@(pageIndex),
                            @"PageSize":@(pageSize)}}.wrapper;
         }];
        
    }
    else
    {
        //金币交易
        _MJRefreshCon = [MJRefreshController controllerFrom:_mainTableView name:refreshNameGold];
        
        [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
         {
             NSLog(@"----%@",@{
                               @"service":[NSString stringWithFormat:@"api/%@",refreshNameGold],
                               @"parameters":
                                   @{@"EnterpriseId":weakself.EnterpriseId,                            @"OrderStatus":weakself.ExchangeStatus,@"Keyword":weakself.searchTxt.text,
                                     @"PageIndex":@(pageIndex),
                                     @"PageSize":@(pageSize)}}.wrapper);
             return @{
                      @"service":[NSString stringWithFormat:@"api/%@",refreshNameGold],
                      @"parameters":
                          @{@"EnterpriseId":weakself.EnterpriseId,                            @"OrderStatus":weakself.ExchangeStatus,@"Keyword":weakself.searchTxt.text,
                            @"PageIndex":@(pageIndex),
                            @"PageSize":@(pageSize)}}.wrapper;
         }];
    }

    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            NSLog(@"%@",netData);
            if (netData.operationSucceed)
            {
                [weakself.searchTxt resignFirstResponder];
                
                if (controller.refreshCount == 0)
                {
//                    weakself.showView.hidden = NO;
                    [weakself.mainTableView reloadData];
                    weakself.mainTableView.tableFooterView = weakself.showView;
                }
                else
                {
//                    weakself.showView.hidden = YES;
                    weakself.mainTableView.tableFooterView = nil;
                }
            }
            else
            {
                [HUDUtil showErrorWithStatus:netData.operationMessage];
            }
        };
        
        [_MJRefreshCon setOnRequestDone:block];
        [_MJRefreshCon setPageSize:30];
        [_MJRefreshCon retain];
    }
    
    [self refreshTableView];
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}


#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _MJRefreshCon.refreshCount;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    else
    {
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)] autorelease];
    
    RRLineView *linetop = WEAK_OBJECT(RRLineView, init);
    linetop.frame = CGRectMake(0, 9.5, 320, 0.5);
    [sectionView addSubview:linetop];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_orderType isEqualToString:@"1"])
    {
        if ([_dealState isEqualToString:@"1"] || [_dealState isEqualToString:@"3"] || [_dealState isEqualToString:@"4"])
        {
            return 180;
        }
        else
        {
            return 230;
        }
    }
    else
    {
        if ([_dealState isEqualToString:@"1"] || [_dealState isEqualToString:@"5"] || [_dealState isEqualToString:@"6"])
        {
            return 180;
        }
        else if([_dealState isEqualToString:@"2"])
        {
            if ([[_MJRefreshCon dataAtIndex:(int)indexPath.section] getInt:@"OrderStatus"] == 203)
            {
                return 255;
            }
            else
            {
                return 230;
            }
        }
        else
        {
            return 230;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WatingShippingTableViewCell";
    
    WatingShippingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"WatingShippingTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
   
    cell.cellLineTwo.top = 229.5;
    
    cell.cellGoodsImage.frame = CGRectMake(15, 66, 49.5, 49.5);
    
    //邮寄兑换
    if ([_orderType isEqualToString:@"1"])
    {
        if ([_dealState isEqualToString:@"1"] || [_dealState isEqualToString:@"3"]|| [_dealState isEqualToString:@"4"])
        {
            cell.cellLastTwoLine.left = 0;
            
            cell.cellLastTwoLine.top = 179.5;
        }
        if ([_dealState isEqualToString:@"2"])
        {
            cell.cellArgeeTuihuoBtn.hidden = YES;
            cell.cellArgeeTuiHuoLable.hidden = YES;
        }
        
        //通用
        cell.cellUserName.text = [NSString stringWithFormat:@"用户：%@",[[_MJRefreshCon dataAtIndex:(int)indexPath.section]getString:@"CustomerName"]];
        
        NSString * time = [[_MJRefreshCon dataAtIndex:(int)indexPath.section]getString:@"PayDate"];
        
        time = [UICommon format19Time:time];
        
        NSString * times = time.length>0?[time substringFromIndex:5]:@"";
        
        cell.cellEndTime.text = [NSString stringWithFormat:@"下单时间：%@",times];
        
        //商品信息
        NSArray * OrderProducts = [[_MJRefreshCon dataAtIndex:(int)indexPath.section] getArray:@"OrderProducts"];
        
        [cell.cellGoodsImage requestCustom:[[[OrderProducts objectAtIndex:0]wrapper] getString:@"PictureUrl"] width:cell.cellGoodsImage.width height:cell.cellGoodsImage.height];
        
        cell.cellGoodsName.text = [[[OrderProducts objectAtIndex:0]wrapper] getString:@"ProductName"];
        
        int price = [[[OrderProducts objectAtIndex:0]wrapper]getInt:@"UnitPrice"];
        
        int num = [[[OrderProducts objectAtIndex:0]wrapper]getInt:@"Qty"];
        
        cell.cellGoodsNumPrice.text = [NSString stringWithFormat:@"%d x %d",price,num];
        
        NSString * pricestr = [NSString stringWithFormat:@"%d",price];
        
        NSAttributedString * attributedStringorderNumPrice = [RRAttributedString setText:cell.cellGoodsNumPrice.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(pricestr.length +1, 1)];
        
        cell.cellGoodsNumPrice.attributedText = attributedStringorderNumPrice;
        
        //邮费计算
        int money = [[_MJRefreshCon dataAtIndex:(int)indexPath.section]getInt:@"OrderAmount"];
        
        NSString *strMoney = [NSString stringWithFormat:@"%d",money];
    
        NSString *tempStr = [NSString stringWithFormat:@"所需银元 %@（邮费到付 用户自理）",strMoney];
        
        NSMutableAttributedString *attributeString = WEAK_OBJECT(NSMutableAttributedString, initWithString:tempStr);
        
        NSMutableDictionary *attDic = WEAK_OBJECT(NSMutableDictionary, init);
        
        [attDic setValue:RGBCOLOR(240, 5, 0) forKey:NSForegroundColorAttributeName];
    
        [attributeString setAttributes:attDic range:NSMakeRange(5, strMoney.length)];
        
        [attDic setValue:RGBCOLOR(153, 153, 153) forKey:NSForegroundColorAttributeName];
        
        [attributeString setAttributes:attDic range:NSMakeRange(tempStr.length - 11, 11)];

        cell.cellNeedmoney.attributedText = attributeString;
    }
    else
    {
        //金币交易管理
        if ([_dealState isEqualToString:@"1"] || [_dealState isEqualToString:@"5"]|| [_dealState isEqualToString:@"6"])
        {
            cell.cellLastTwoLine.left = 0;
            
            cell.cellLastTwoLine.top = 179.5;
        }
        if ([_dealState isEqualToString:@"3"])
        {
            //已发货
            cell.cellShippingLable.text = @"延长收货";
            cell.cellShippingLable.textColor = RGBCOLOR(34, 34, 34);
            cell.cellShipping.layer.borderColor = [RGBCOLOR(153, 153, 153) CGColor];
            
            cell.cellArgeeTuihuoBtn.hidden = YES;
            cell.cellArgeeTuiHuoLable.hidden = YES;
            
            cell.cellChanggeAddressBtn.hidden = YES;
            cell.cellChchangeAddressLable.hidden = YES;
        }
        if ([_dealState isEqualToString:@"2"])
        {
            //等待发货
            if ([[_MJRefreshCon dataAtIndex:(int)indexPath.section] getInt:@"OrderStatus"] == 203)
            {
                //申请退货
                cell.cellResultView.frame = CGRectMake(0, 25, 320, 230);
                cell.cellShengTime.text = [[_MJRefreshCon dataAtIndex:(int)indexPath.section] getString:@"LeftCloseTime"];
            }
            else
            {
                cell.cellArgeeTuihuoBtn.hidden = YES;
                cell.cellArgeeTuiHuoLable.hidden = YES;
            }
        }
       
        NSArray *OrderProducts = [[_MJRefreshCon dataAtIndex:(int)indexPath.section]getArray:@"OrderProducts"];
        
        if ([OrderProducts count] == 0) return cell ;
        
        //订单相关信息
        cell.cellUserName.text = [NSString stringWithFormat:@"用户：%@",[[_MJRefreshCon dataAtIndex:(int)indexPath.section]getString:@"UserName"]];
        
        NSString * time = [[_MJRefreshCon dataAtIndex:(int)indexPath.section]getString:@"PayDate"];
        
        time = [UICommon format19Time:time];
        
        NSString * times = time.length>0?[time substringFromIndex:5]:@"";
        
        cell.cellEndTime.text = [NSString stringWithFormat:@"下单时间：%@",times];
        
        
        //商品信息
        [cell.cellGoodsImage requestCustom:[[[OrderProducts objectAtIndex:0]wrapper] getString:@"PictureUrl"] width:cell.cellGoodsImage.width height:cell.cellGoodsImage.height];
        
        cell.cellGoodsName.text = [[[OrderProducts objectAtIndex:0]wrapper] getString:@"ProductName"];
        
        NSString * ProdutSpce = [[[OrderProducts objectAtIndex:0]wrapper] getString:@"ProdutSpce"];
        
        float price = [[[OrderProducts objectAtIndex:0]wrapper] getFloat:@"UnitPrice"];
        
        int num = [[[OrderProducts objectAtIndex:0]wrapper] getInt:@"Qty"];
        
        NSString * pricestr = [NSString stringWithFormat:@"%.2f",price];
        
        NSString * numStr = [NSString stringWithFormat:@"%d",num];
        
        NSString * ProdutSpceAndNumPrice = [NSString stringWithFormat:@"%@     %.2f x %d",ProdutSpce,price,num];
        
        NSMutableAttributedString *attributeStringProdutSpce = WEAK_OBJECT(NSMutableAttributedString, initWithString:ProdutSpceAndNumPrice);
        
        NSMutableDictionary *attDicOne = WEAK_OBJECT(NSMutableDictionary, init);
        
        [attDicOne setValue:RGBCOLOR(240, 5, 0) forKey:NSForegroundColorAttributeName];
        
        [attributeStringProdutSpce setAttributes:attDicOne range:NSMakeRange(ProdutSpce.length + 5, pricestr.length)];
        
        [attDicOne setValue:RGBCOLOR(153, 153, 153) forKey:NSForegroundColorAttributeName];
        
        [attributeStringProdutSpce setAttributes:attDicOne range:NSMakeRange(ProdutSpce.length + pricestr.length + 6, 1)];
        
        [attDicOne setValue:RGBCOLOR(240, 5, 0) forKey:NSForegroundColorAttributeName];
        
        [attributeStringProdutSpce setAttributes:attDicOne range:NSMakeRange(ProdutSpce.length + pricestr.length + 8, numStr.length)];
        
        cell.cellGoodsNumPrice.attributedText = attributeStringProdutSpce;

        //订单金额
        float money = [[_MJRefreshCon dataAtIndex:(int)indexPath.section]getFloat:@"OrderAmount"];
        //邮费
        float DeliveryPrice = [[_MJRefreshCon dataAtIndex:(int)indexPath.section]getFloat:@"DeliveryPrice"];
        
        NSString *strMoney = [NSString stringWithFormat:@"%.2f",money];
        
        NSString *strDeliveryPrice = [NSString stringWithFormat:@"(包含运费%.2f)",DeliveryPrice];
        
        
        NSString *tempStr = [NSString stringWithFormat:@"总价 %@%@",strMoney,strDeliveryPrice];
        
        //总价字体变色
        NSMutableAttributedString *attributeString = WEAK_OBJECT(NSMutableAttributedString, initWithString:tempStr);
        
        NSMutableDictionary *attDic = WEAK_OBJECT(NSMutableDictionary, init);
        
        [attDic setValue:RGBCOLOR(240, 5, 0) forKey:NSForegroundColorAttributeName];
        
        [attributeString setAttributes:attDic range:NSMakeRange(3, strMoney.length)];
        
        [attDic setValue:RGBCOLOR(153, 153, 153) forKey:NSForegroundColorAttributeName];
        
        [attributeString setAttributes:attDic range:NSMakeRange(strMoney.length + 3, strDeliveryPrice.length)];
        
        cell.cellNeedmoney.attributedText = attributeString;
    }

    //高度设置
    if (cell.cellGoodsName.text.length <=18)
    {
        cell.cellGoodsName.frame = CGRectMake(78, 75, 227, 13);
        
        cell.cellGoodsNumPrice.frame = CGRectMake(78, 96, 227, 13);
    }
    
     //按钮点击事件
    [cell.cellChanggeAddressBtn addTarget:self action:@selector(changeAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.cellChanggeAddressBtn.tag = indexPath.section;
    
    [cell.cellShipping addTarget:self action:@selector(shippingBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.cellShipping.tag = indexPath.section;
    
    [cell.cellArgeeTuihuoBtn addTarget:self action:@selector(argeeTuiHuoBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.cellArgeeTuihuoBtn.tag = indexPath.section;
    
    return cell;
}

- (void)argeeTuiHuoBtn:(UIButton *)button
{
    //同意退货
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"同意退款吗" message:@"如同意，本订单将关闭，系统返回用户易货码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"同意", nil];
    alert.tag = button.tag;
    [alert show];
    [alert release];

}

- (void)changeAddressBtn:(UIButton *)button
{
    //更改收货地址
    PUSH_VIEWCONTROLLER(ChangeShippingAddressViewController);
    model.orderType =  _orderType;
    
    if ([_orderType isEqualToString:@"1"])
    {
        model.OrderNumber = [[_MJRefreshCon dataAtIndex:(int)button.tag]getString:@"OrderNumber"];
    }
    else
    {
        model.OrderNumber = [[_MJRefreshCon dataAtIndex:(int)button.tag]getString:@"OrderId"];
    }
}

-(void) shippingBtn:(UIButton *) button
{
    //发货
    if ([_orderType isEqualToString:@"1"])
    {
        PUSH_VIEWCONTROLLER(ShippingViewController);
        model.OrderNumber = [[_MJRefreshCon dataAtIndex:(int)button.tag]getString:@"OrderNumber"];
        model.orderType =  _orderType;
        model.EnterpriseId = _EnterpriseId;
    }
    else
    {
        if ([_dealState isEqualToString:@"2"])
        {
            //发货
            PUSH_VIEWCONTROLLER(ShippingViewController);
            model.OrderNumber = [[_MJRefreshCon dataAtIndex:(int)button.tag]getString:@"OrderId"];
            model.orderType =  _orderType;
            model.EnterpriseId = _EnterpriseId;
        }
        else if ([_dealState isEqualToString:@"3"])
        {
            //延迟收货
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"确定延长收货吗" message:@"如确定，将延长7天收货时间" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = button.tag;
            [alert show];
            [alert release];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if ([_dealState isEqualToString:@"3"])
        {
            ADAPI_adv3_GoldOrder_EnterpriseOrderOperate([self genDelegatorID:@selector(HandleNotification:)], [[_MJRefreshCon dataAtIndex:(int)alertView.tag]getString:@"OrderId"], @"8");
        }
        else if ([_dealState isEqualToString:@"2"])
        {
            ADAPI_adv3_GoldOrder_EnterpriseOrderOperate([self genDelegatorID:@selector(HandleNotification:)], [[_MJRefreshCon dataAtIndex:(int)alertView.tag]getString:@"OrderId"], @"5");
        }
    }
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_GoldOrder_EnterpriseOrderOperate])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"确定"]];
            
            [self refreshTableView];
        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PUSH_VIEWCONTROLLER(ShippingOrderDetailViewController);
    model.EnterpriseId = _EnterpriseId;
    model.OrderType = _orderType;
    model.dealState = _dealState;
    
    if ([_orderType isEqualToString:@"1"])
    {
        model.EnterOrderNumber = [[_MJRefreshCon dataAtIndex:(int)indexPath.section]getString:@"OrderNumber"];
    }
    else
    {
        model.EnterOrderNumber = [[_MJRefreshCon dataAtIndex:(int)indexPath.section]getString:@"OrderId"];
        model.IsApplayReturn = [[_MJRefreshCon dataAtIndex:(int)indexPath.section]getInt:@"OrderStatus"];    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _mainTableView)
    {
        CGFloat sectionHeaderHeight = 10;
        
        if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y >= sectionHeaderHeight)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_MJRefreshCon release];
    _MJRefreshCon = nil;
    
    [cellData release];
    
    cellData = nil;
    
    [_searchBgView release];
    [_searchTxt release];
    [_mainTableView release];
    [_showView release];
    [_lineSearch release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setSearchBgView:nil];
    [self setSearchTxt:nil];
    [self setMainTableView:nil];
    [self setShowView:nil];
    [super viewDidUnload];
}
@end
