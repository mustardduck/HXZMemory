//
//  GetMoreGoldViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/16.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "GetMoreGoldViewController.h"
#import "ThankFulMechanismTableViewCell.h"
#import "PurchaseGoldByCarrieroperatorViewController.h"
#import "BuyGoldViewController.h"
#import "VIPPrivilegeViewController.h"
#import "Share_Method.h"
#import "YinYuanAdvertMainController.h"
#import "RRLineView.h"

@interface GetMoreGoldViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * arrTitleOne;
    NSArray * arrTitleTwo;
    NSArray * arrTitleThree;
    
    DictionaryWrapper* dic;
    
    BOOL IsShowTips;
}

@property (retain, nonatomic) IBOutlet UITableView *mainTableView;
@property (retain, nonatomic) IBOutlet UIView *footview;

@end

@implementation GetMoreGoldViewController

-(void)viewWillAppear:(BOOL)animated
{
    ADAPI_CustomerGoldGetCustomerGoldSummary([self genDelegatorID:@selector(handleGetGoldSummary:)]);
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"获取更多广告金币");
    
    arrTitleOne = [[NSArray alloc]  initWithObjects:@"官方购买",@"向当地运营商购买",@"完成首发广告，奖励1000广告金币",@"推荐用户获得广告金币",@"购买商家VIP赠送广告金币", nil];
    
    arrTitleTwo = [[NSArray alloc] initWithObjects:@"官方购买",@"向当地运营商购买",@"购买商家VIP赠送广告金币",@"推荐用户获得广告金币",@"完成首发广告，奖励1000广告金币", nil];
    
    arrTitleThree = [[NSArray alloc] initWithObjects:@"官方购买",@"向当地运营商购买",@"推荐用户获得广告金币",@"购买商家VIP赠送广告金币",@"完成首发广告，奖励1000广告金币", nil];
    
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _mainTableView.scrollEnabled = NO;
    
    dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    [dic retain];
}

- (void)handleGetGoldSummary:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        DictionaryWrapper * result = wrapper.data;

        IsShowTips = [result getBool:@"IsHasFirstAdvert"];
        
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        [_mainTableView setTableFooterView:_footview];
        
        [_mainTableView reloadData];
    }
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ThankFulMechanismTableViewCell";
    ThankFulMechanismTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ThankFulMechanismTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    if (indexPath.row == 4)
    {
        cell.cellLines.left = 0;
        cell.cellLines.top = 49.5;
    }
    
    //判断是否商家
    int enterId = [dic getInt:@"EnterpriseStatus"];
    
    if (enterId != 4)
    {
        //没有创建商家
        cell.thankfullcellTitle.text = arrTitleThree[indexPath.row];
        
        if (indexPath.row == 4 || indexPath.row == 3)
        {
            cell.thankfullcellTitle.frame = CGRectMake(15, 14, 250, 21);
            
            cell.thankfullcellTitle.textColor = RGBCOLOR(204, 204, 204);
            
            cell.userInteractionEnabled = NO;
            
            cell.cellJianTou.image = [UIImage imageNamed:@"goldjiantouhui"];
        }
    }
    else
    {
        //是否完成发广告
        if (IsShowTips == YES)
        {
            cell.thankfullcellTitle.text = arrTitleTwo[indexPath.row];
            
            if (indexPath.row == 4)
            {
                cell.thankfullcellTitle.frame = CGRectMake(15, 14, 250, 21);
                
                cell.thankfullcellTitle.textColor = RGBCOLOR(204, 204, 204);
                
                cell.isThankFulcellLable.textColor = RGBCOLOR(204, 204, 204);
                
                cell.isThankFulcellLable.text = @"已完成";
                
                cell.userInteractionEnabled = NO;
                
                cell.cellJianTou.image = [UIImage imageNamed:@"goldjiantouhui"];
                
            }
            cell.thankfullcellTitle.font = Font(15);
        }
        else
        {
            cell.thankfullcellTitle.text = arrTitleOne[indexPath.row];
            
            if (indexPath.row == 2)
            {
                cell.thankfullcellTitle.frame = CGRectMake(15, 14, 250, 21);
            }
        }
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([dic getInt:@"EnterpriseStatus"] != 4)
    {
        //未创建商家
        if (indexPath.row == 0)
        {
            PUSH_VIEWCONTROLLER(BuyGoldViewController);
            model.balanceGold = _balanceGold;
        }
        else if (indexPath.row == 1)
        {
            PUSH_VIEWCONTROLLER(PurchaseGoldByCarrieroperatorViewController);
        }
        else if (indexPath.row == 2)
        {
            [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"db2a2d27268cc6a73ae4b216dcb25bf7"}];
        }
    }
    else
    {
        if (IsShowTips == YES)
        {
            if (indexPath.row == 0)
            {
                PUSH_VIEWCONTROLLER(BuyGoldViewController);
                model.balanceGold = _balanceGold;
            }
            else if (indexPath.row == 1)
            {
                PUSH_VIEWCONTROLLER(PurchaseGoldByCarrieroperatorViewController);
            }
            else if (indexPath.row == 2)
            {
                PUSH_VIEWCONTROLLER(VIPPrivilegeViewController);
            }
            else if (indexPath.row == 3)
            {
                [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"db2a2d27268cc6a73ae4b216dcb25bf7"}];
            }
        }
        else
        {
            if (indexPath.row == 0)
            {
                PUSH_VIEWCONTROLLER(BuyGoldViewController);
            }
            else if (indexPath.row == 1)
            {
                PUSH_VIEWCONTROLLER(PurchaseGoldByCarrieroperatorViewController);
            }
            else if (indexPath.row == 2)
            {
                //发广告
                PUSH_VIEWCONTROLLER(YinYuanAdvertMainController);
            }
            else if (indexPath.row == 3)
            {
                //分享
                [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"db2a2d27268cc6a73ae4b216dcb25bf7"}];
            }
            else if (indexPath.row == 4)
            {
                //商家vip
                PUSH_VIEWCONTROLLER(VIPPrivilegeViewController);
            }
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThankFulMechanismTableViewCell *cell = (ThankFulMechanismTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThankFulMechanismTableViewCell *cell = (ThankFulMechanismTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [arrTitleOne release];
    [arrTitleTwo release];
    [arrTitleThree release];
    [dic release];
    [_mainTableView release];
    [_footview release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setMainTableView:nil];
    [super viewDidUnload];
}
@end
