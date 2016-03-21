//
//  MyMallViewController.m
//  miaozhuan
//
//  Created by abyss on 14/12/19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyMallViewController.h"
#import "MyMallTableViewCell.h"
#import "RedPoint.h"
#import "MyCollectionViewController.h"
#import "ShippingAddressMangerViewController.h"
#import "MySiteChangeViewController.h"
#import "MyMarketMyOrderListController.h"
#import "CheckAddressViewController.h"
#import "MySaleReturnAndAfterSaleViewController.h"
#import "BrowseRecordViewController.h"
#import "RRLineView.h"

@interface MyMallViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSArray * arrTitle;
    
    NSArray * arrImage;
    
    NSArray * arrContent;
    
    BOOL _pageCount;
    DictionaryWrapper * result;
}
@property (retain, nonatomic) IBOutlet UIScrollView *myMallScroller;
@property (retain, nonatomic) IBOutlet UITableView *myMallTableView;
@property (retain, nonatomic) IBOutlet UIView *myMallTop;
@property (retain, nonatomic) IBOutlet UIButton *myOrderAllBtn;
@property (retain, nonatomic) IBOutlet UIButton *watingPayMoneyBtn;
@property (retain, nonatomic) IBOutlet UIButton *watingShippingBtn;
@property (retain, nonatomic) IBOutlet UIButton *watingShouHuoBtn;
@property (retain, nonatomic) IBOutlet UIButton *saleAfterBtn;
@property (retain, nonatomic) IBOutlet RedPoint *watingPayMoneyNum;
@property (retain, nonatomic) IBOutlet RedPoint *watingShippingNum;
@property (retain, nonatomic) IBOutlet RedPoint *watingShouHuoNum;
@property (retain, nonatomic) IBOutlet RedPoint *saleAfterNum;
@property (retain, nonatomic) IBOutlet UIButton *callBtn;
@property (retain, nonatomic) IBOutlet UIView *showVIew;
@property (retain, nonatomic) IBOutlet UIView *lineviewOne;
@property (retain, nonatomic) IBOutlet UIView *lineviewTwo;
@property (retain, nonatomic) IBOutlet UIView *lineviewThree;

- (IBAction)touchUpInsideBtn:(id)sender;
@end

@implementation MyMallViewController

- (void)dealloc
{
    CRDEBUG_DEALLOC();
    
    [arrTitle release];
    [arrImage release];
    [arrContent release];
    [result release];
    
    [_myMallTableView release];
    [_myMallScroller release];
    [_myMallTop release];
    [_myOrderAllBtn release];
    [_watingPayMoneyBtn release];
    [_watingShippingBtn release];
    [_watingShouHuoBtn release];
    [_saleAfterBtn release];
    [_watingPayMoneyNum release];
    [_watingShippingNum release];
    [_watingShouHuoNum release];
    [_saleAfterNum release];
    [_callBtn release];
    [_showVIew release];
    [_lineviewOne release];
    [_lineviewTwo release];
    [_lineviewThree release];
    [super dealloc];
}

- (void) viewWillAppear:(BOOL)animated
{
    ADAPI_adv3_Order_CountOrders([self genDelegatorID:@selector(HandleNotification:)]);
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_Order_CountOrders])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            result = wrapper.data;
            [result retain];
            
            [self setResult:result];
            
            _myMallTableView.delegate = self;
            
            _myMallTableView.dataSource = self;
            
            _myMallTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            [_myMallTableView reloadData];
            
            _myMallTableView.tableHeaderView = _myMallTop;
            
            _showVIew.hidden = YES;
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _pageCount ++;
    [MTA trackPageViewBegin:NSStringFromClass([self class])];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_pageCount > 0)
    {
        [MTA trackPageViewEnd:NSStringFromClass([self class])];
        _pageCount --;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrTitle = [[NSArray arrayWithObjects:@[@"我的现场兑换"],@[@"我的收藏",@"我的浏览记录"],@[@"收货地址管理"],nil]retain];
    
    arrImage = [[NSArray arrayWithObjects:@[@"myMallChange"],@[@"myMallFavrite",@"myMallrecord"],@[@"myMallAddressmanger"], nil]retain];
    
    arrContent = [[NSArray arrayWithObjects:@[@"兑换商城的现场兑换订单"],@[@"收藏那些感兴趣的商品",@"记录最近20条浏览足迹"],@[@""],nil]retain];
    
    _lineviewOne.frame = CGRectMake(80, 15, 0.5, 35);
    
    _lineviewTwo.frame = CGRectMake(160, 15, 0.5, 35);
    
    _lineviewThree.frame = CGRectMake(240, 15, 0.5, 35);
    
    
    _watingPayMoneyBtn.frame = CGRectMake(0, 0.5, 80, 65.5);
    
    _watingShippingBtn.frame = CGRectMake(80.5, 0.5, 79.5, 65.5);
    
    _watingShouHuoBtn.frame = CGRectMake(160.5, 0.5, 79.5, 65.5);
    
    _saleAfterBtn.frame = CGRectMake(240.5, 0.5, 80, 65.5);
    
    if ([[UIScreen mainScreen] bounds].size.height < 568)
    {
        [_myMallScroller setContentSize:CGSizeMake(320, 650)];
    }
    else
    {
        [_myMallScroller setContentSize:CGSizeMake(320, 470)];
    }
}

-(void) setResult:(DictionaryWrapper *) dic
{
    if ([dic getInt:@"PendingPaymentCount"] == 0)
    {
        _watingPayMoneyNum.hidden = YES;
    }
    else
    {
        _watingPayMoneyNum.num = [dic getInt:@"PendingPaymentCount"];
    }
    
    if ([dic getInt:@"PendingDeliveryCount"] == 0) {
        _watingShippingNum.hidden = YES;
    }
    else
    {
        _watingShippingNum.num = [dic getInt:@"PendingDeliveryCount"];
    }
    
    if ([dic getInt:@"PendingReceiveCount"] == 0) {
        _watingShouHuoNum.hidden = YES;
    }
    else
    {
        _watingShouHuoNum.num = [dic getInt:@"PendingReceiveCount"];
    }
    
    
    if ([dic getInt:@"AfterSalesCount"] == 0) {
        _saleAfterNum.hidden = YES;
    }
    else
    {
        _saleAfterNum.num = [dic getInt:@"AfterSalesCount"];
    }
}


- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _myOrderAllBtn)
    {
        //查看全部订单
        
        MyMarketMyOrderListController * view = WEAK_OBJECT(MyMarketMyOrderListController, init);
        
        view.queryType = 0;

        [UI_MANAGER.mainNavigationController pushViewController:view animated:YES];
        
    }
    else if(sender == _watingPayMoneyBtn)
    {
        //待付款
        
        MyMarketMyOrderListController * view = WEAK_OBJECT(MyMarketMyOrderListController, init);
        
        view.queryType = 1;
        
        [UI_MANAGER.mainNavigationController pushViewController:view animated:YES];
    }
    else if (sender == _watingShippingBtn)
    {
        //待发货
        
        MyMarketMyOrderListController * view = WEAK_OBJECT(MyMarketMyOrderListController, init);
        
        view.queryType = 2;
        
        [UI_MANAGER.mainNavigationController pushViewController:view animated:YES];
    }
    else if (sender == _watingShouHuoBtn)
    {
        //待收货
        
        MyMarketMyOrderListController * view = WEAK_OBJECT(MyMarketMyOrderListController, init);
        
        view.queryType = 3;
        
        [UI_MANAGER.mainNavigationController pushViewController:view animated:YES];
    }
    else if (sender == _saleAfterBtn)
    {
        //退货/售后
        MySaleReturnAndAfterSaleViewController *temp = WEAK_OBJECT(MySaleReturnAndAfterSaleViewController, init);
        [UI_MANAGER.mainNavigationController pushViewController:temp animated:YES];
    }
    else if (sender == _callBtn)
    {
        //拨打
        [[UICommon shareInstance]makeCall:@"400-019-3588"];
    }
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)] autorelease];
    RRLineView *linetop = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 9.5, 320, 0.5));
    [sectionView addSubview:linetop];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        return 50;
    }
    else
    {
        return 60;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyMallTableViewCell";
    MyMallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MyMallTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    if (indexPath.section == 2)
    {
        cell.cellImages.frame = CGRectMake(10, 13, 24, 24);
        
        cell.cellTitle.frame = CGRectMake(46, 17, 254, 16);
        
        cell.cellJiantou.frame = CGRectMake(297, 18, 8, 13);
        
        RRLineView * line = [[RRLineView alloc] initWithFrame:CGRectMake(0, 49.5, 320, 0.5)];
        
        line.image = [UIImage imageNamed:@"line.png"];
        
        [cell.contentView addSubview:line];
        
        cell.cellContent.hidden = YES;
    }
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            cell.cellLine.left = 46;
        }
    }
    
    cell.cellLine.top  = 59.5;
    
    cell.cellTitle.text = arrTitle[indexPath.section][indexPath.row];
    
    cell.cellImages.image = [UIImage imageNamed:arrImage[indexPath.section][indexPath.row]];
    
    cell.cellContent.text = arrContent[indexPath.section][indexPath.row];
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        //我的现场兑换
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(MySiteChangeViewController, init) animated:YES];
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            //我的收藏
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(MyCollectionViewController, init) animated:YES];
        }
        else if (indexPath.row == 1)
        {
            //我的浏览记录
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(BrowseRecordViewController, init) animated:YES];
        }
    }
    else
    {
        //收货地址管理
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(ShippingAddressMangerViewController, init) animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMallTableViewCell *cell = (MyMallTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMallTableViewCell *cell = (MyMallTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
