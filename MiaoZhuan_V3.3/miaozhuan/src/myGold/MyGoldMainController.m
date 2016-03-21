//
//  MyGoldMainController.m
//  miaozhuan
//
//  Created by momo on 14-12-16.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyGoldMainController.h"
#import "GetMoreGoldViewController.h"
#import "MyGoldListController.h"
#import "MyGoldCircurateViewController.h"
#import "BuyGoldViewController.h"
#import "UIView+expanded.h"
#import "WebhtmlViewController.h"
#import "VipPriviliegeViewController.h"
#import "CRString.h"
#import "RRLineView.h"
#import "ThankFulMechanismTableViewCell.h"

@interface MyGoldMainController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * arrTitle;
    
    DictionaryWrapper * dic;
    
    BOOL IsHasFirstAdvert;
    
    BOOL isHaveDuihuan;
    
    BOOL isHaveYihuo;
}

@property (retain, nonatomic) IBOutlet UIButton *otherIncomeBtn;
@property (retain, nonatomic) IBOutlet UILabel *otherIncomeLbl;
@property (retain, nonatomic) IBOutlet UITableView *mygoldTable;
@property (retain, nonatomic) IBOutlet UIView *goldHeaderView;

@end

@implementation MyGoldMainController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    InitNav(@"我的广告金币");
    [self setupMoveFowardButtonWithTitle:@"说明"];
    
    DictionaryWrapper * result =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    isHaveDuihuan = [result getBool:@"HasGoldOrder"];
    isHaveYihuo = [result getBool:@"HasMerchantGoldOrder"];
    
    if (isHaveYihuo == NO && isHaveDuihuan == NO)
    {
        arrTitle = [[NSArray arrayWithObjects:@[@"购买广告金币"],@[@"发银元广告消耗的",@"发竞价广告消耗的"],@[@"发商家优惠信息消耗的",@"发招聘信息消耗的",@"发招商信息消耗的"],@[@"系统赠送的"],@[@"购买广告金币获得的"],@[@"其他收支"],@[@"广告金币流通"],nil]retain];
    }
    else if (isHaveDuihuan == NO)
    {
        //没有兑换广告消耗的
        arrTitle = [[NSArray arrayWithObjects:@[@"购买广告金币"],@[@"发银元广告消耗的",@"发竞价广告消耗的"],@[@"发商家优惠信息消耗的",@"发招聘信息消耗的",@"发招商信息消耗的"],@[@"系统赠送的",@"易货商城的货款"],@[@"购买广告金币获得的"],@[@"其他收支"],@[@"广告金币流通"],nil]retain];
    }
    else if (isHaveYihuo == NO)
    {
        //没有易货商城的货款
        arrTitle = [[NSArray arrayWithObjects:@[@"购买广告金币"],@[@"发银元广告消耗的",@"兑换商品消耗的",@"发竞价广告消耗的"],@[@"发商家优惠信息消耗的",@"发招聘信息消耗的",@"发招商信息消耗的"],@[@"系统赠送的"],@[@"购买广告金币获得的"],@[@"其他收支"],@[@"广告金币流通"],nil]retain];
    }
    else
    {
        arrTitle = [[NSArray arrayWithObjects:@[@"购买广告金币"],@[@"发银元广告消耗的",@"兑换商品消耗的",@"发竞价广告消耗的"],@[@"发商家优惠信息消耗的",@"发招聘信息消耗的",@"发招商信息消耗的"],@[@"系统赠送的",@"易货商城的货款"],@[@"购买广告金币获得的"],@[@"其他收支"],@[@"广告金币流通"],nil]retain];
    }
    
    _mygoldTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_getMoreGoldBtn roundCornerBorder];
    
    
    
    int VipLevel = [result getInt:@"VipLevel"];
    
    int enterStatus = [result getInt:@"EnterpriseStatus"];
    
    if(VipLevel == 7 || enterStatus == 4)
    {
        _bugVIP7View.hidden = YES;
        
        ADAPI_CustomerGoldGetCustomerGoldSummary([self genDelegatorID:@selector(handleGetGoldSummary:)]);
    }
    else
    {
        _bugVIP7View.hidden = NO;
    }
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
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
    
    if (section == 0)
    {
        sectionView.frame = CGRectMake(0, 0, 320, 1);
        linetop.frame = CGRectMake(0, 0, 320, 0.5);
    }
    else
    {
        sectionView.frame = CGRectMake(0, 0, 320, 10);
        linetop.frame =CGRectMake(0, 9.5, 320, 0.5);
    }
    
    [sectionView addSubview:linetop];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        if (isHaveDuihuan == NO)
        {
            return 2;
        }
        else{
            return 3;
        }
    }
    else if (section == 2)
    {
        return 3;
    }
    else if (section == 3)
    {
        if (isHaveYihuo == NO)
        {
            return 1;
        }
        else
        {
            return 2;
        }
    }
    else if (section == 4)
    {
        return 1;
    }
    else if (section == 5)
    {
        return 1;
    }
    else
    {
        return 1;
    }
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
    
    cell.thankfullcellTitle.text = arrTitle[indexPath.section][indexPath.row];
    
    cell.cellLines.top = 49.5;
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.cellLines.left = 0;
        }
    }
    else if (indexPath.section == 1)
    {
        if (isHaveDuihuan == NO)
        {
            if (indexPath.row == 0)
            {
                cell.isThankFulcellLable.text = [NSString stringWithFormat:@"%.2f",[dic getFloat:@"SilverAdvertGold"]];
            }
            else if (indexPath.row == 1)
            {
                cell.isThankFulcellLable.text = [NSString stringWithFormat:@"%.2f",[dic getFloat:@"BindingAdvertGold"]];
                cell.cellLines.left = 0;
            }
        }
        else
        {
            if (indexPath.row == 0)
            {
                cell.isThankFulcellLable.text = [NSString stringWithFormat:@"%.2f",[dic getFloat:@"SilverAdvertGold"]];
            }
            else if (indexPath.row == 1)
            {
                cell.isThankFulcellLable.text = [NSString stringWithFormat:@"%.2f",[dic getFloat:@"BuyProductGold"]];
            }
            else if (indexPath.row == 2)
            {
                cell.isThankFulcellLable.text = [NSString stringWithFormat:@"%.2f",[dic getFloat:@"BindingAdvertGold"]];
                cell.cellLines.left = 0;
            }

        }
    }
    else if(indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            float temp = [dic getFloat:@"DiscountGold"];
            temp = floor(temp*100)/100;
            cell.isThankFulcellLable.text = [NSString stringWithFormat:@"%.2f",temp];
        }
        else if (indexPath.row == 1)
        {
            float temp = [dic getFloat:@"RecruitmentGold"];
            temp = floor(temp*100)/100;
            cell.isThankFulcellLable.text = [NSString stringWithFormat:@"%.2f",temp];
        }
        else if (indexPath.row == 2)
        {
            cell.isThankFulcellLable.text = [NSString stringWithFormat:@"%.2f",[dic getFloat:@"InvestmentGold"]];
            cell.cellLines.left = 0;
        }
    }
    else if (indexPath.section == 3)
    {
        if (isHaveYihuo == NO)
        {
            if (indexPath.row == 0)
            {
                cell.isThankFulcellLable.text = [NSString stringWithFormat:@"%.2f",[dic getFloat:@"SystemPresentGold"]];
                
                cell.cellLines.left = 0;
            }
        }
        else
        {
            if (indexPath.row == 0)
            {
                cell.isThankFulcellLable.text = [NSString stringWithFormat:@"%.2f",[dic getFloat:@"SystemPresentGold"]];
            }
            if (indexPath.row == 1)
            {
                cell.isThankFulcellLable.text = [NSString stringWithFormat:@"%.2f",[dic getFloat:@"SellProductGold"]];
                cell.cellLines.left = 0;
            }
        }
    }
    else if (indexPath.section == 4)
    {
        if (indexPath.row == 0)
        {
            cell.isThankFulcellLable.text = [NSString stringWithFormat:@"%.2f",[dic getFloat:@"BuyGold"]];
            cell.cellLines.left = 0;
        }
    }
    else if (indexPath.section == 5)
    {
        if (indexPath.row == 0)
        {
            cell.isThankFulcellLable.text = [NSString stringWithFormat:@"%.2f",[dic getFloat:@"OtherGold"]];
            cell.cellLines.left = 0;
        }
    }
    else if (indexPath.section == 6)
    {
        if (indexPath.row == 0)
        {
            cell.cellLines.left = 0;
        }
    }
    cell.cellJianTou.left = 300;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            PUSH_VIEWCONTROLLER(BuyGoldViewController);
            model.balanceGold = [_GoldMoneyLbl.text substringFromIndex:5];
        }
    }
    else if (indexPath.section == 1)
    {
        if (isHaveDuihuan == NO)
        {
            if (indexPath.row == 0)
            {
                PUSH_VIEWCONTROLLER(MyGoldListController);
                model.cellType = AdvertConsume;
            }
            else if (indexPath.row == 1)
            {
                PUSH_VIEWCONTROLLER(MyGoldListController);
                model.cellType = JingjiaADsConsume;
            }
        }
        else
        {
            if (indexPath.row == 0)
            {
                PUSH_VIEWCONTROLLER(MyGoldListController);
                model.cellType = AdvertConsume;
            }
            else if (indexPath.row == 1)
            {//兑换商品消耗的（金币订单最后完成时间）
                PUSH_VIEWCONTROLLER(MyGoldListController);
                model.cellType = DuihuanProdConsume;
            }
            else if (indexPath.row == 2)
            {
                PUSH_VIEWCONTROLLER(MyGoldListController);
                model.cellType = JingjiaADsConsume;
            }
        }
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            PUSH_VIEWCONTROLLER(MyGoldListController);
            model.cellType = DiscountGoldConsume;
        }
        else if (indexPath.row == 1)
        {
            PUSH_VIEWCONTROLLER(MyGoldListController);
            model.cellType = RecruitmentGoldConsume;
        }
        else if (indexPath.row == 2)
        {
            PUSH_VIEWCONTROLLER(MyGoldListController);
            model.cellType = InvestmentGoldConsume;
        }
    }
    else if (indexPath.section == 3)
    {
        if (isHaveYihuo == NO)
        {
            if (indexPath.row == 0)
            {
                PUSH_VIEWCONTROLLER(MyGoldListController);
                model.cellType = systemBonus;
            }
        }
        else
        {
            if (indexPath.row == 0)
            {
                PUSH_VIEWCONTROLLER(MyGoldListController);
                model.cellType = systemBonus;
            }
            else if (indexPath.row == 1)
            {
                PUSH_VIEWCONTROLLER(MyGoldListController);
                model.cellType = GoldMarketMoney;
            }
        }
    }
    else if (indexPath.section == 4)
    {
        if (indexPath.row == 0)
        {//易货商城的货款（商家金币订单最后完成时间）
            PUSH_VIEWCONTROLLER(MyGoldListController);
            model.cellType = GetBuyAdvertGold;
        }
    }
    else if (indexPath.section == 5)
    {
        if (indexPath.row == 0)
        {
            PUSH_VIEWCONTROLLER(MyGoldListController);
            model.cellType = OtherIncome;
        }
    }
    else if (indexPath.section == 6)
    {
        if (indexPath.row == 0)
        {
            MyGoldCircurateViewController *model = [[[MyGoldCircurateViewController alloc] init] autorelease];
            [self.navigationController pushViewController:model animated:YES];
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _mygoldTable)
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

- (void)handleGetGoldSummary:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        _mygoldTable.delegate = self;
        
        _mygoldTable.dataSource = self;
        
        dic = wrapper.data;
        
        [dic retain];
        
        NSString * tempStr = [NSString stringWithFormat:@"广告金币余额 %0.2f", [dic getDouble:@"RemainingGold"]];
        
        CRString *str = WEAK_OBJECT(CRString, initWithString: tempStr);
        [str setFont:Font(28) rangeStart:6 by:[tempStr length] - 6];
        [str setColor:AppColorRed rangeStart:6 by:[tempStr length] - 6];
        [str setFont:Font(16) rangeStart:0 by:6];
        [str setColor:AppColorBlack43 rangeStart:0 by:6];

        _GoldMoneyLbl.attributedText = str.attributedString;
        
        if(_GoldMoneyLbl.text.length)
        {
            [[NSUserDefaults standardUserDefaults] setValue:[_GoldMoneyLbl.text substringFromIndex:7] forKey:@"RemainingGold"];
        }
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        IsHasFirstAdvert = [dic getBool:@"IsHasFirstAdvert"];
        
        _goldHeaderView.frame = CGRectMake(0, 0, 320, 130);
        
        _mygoldTable.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 64 - 10);
        
        _mygoldTable.tableHeaderView = _goldHeaderView;
        
        [_mygoldTable reloadData];

    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onMoveFoward:(UIButton *)sender
{
    WebhtmlViewController *view = WEAK_OBJECT(WebhtmlViewController, init);
    view.navTitle = @"广告金币说明";
    view.ContentCode = @"008b8f6556f036deec5418901b69fe42";
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)touchUpInsideOnBtn:(id)sender
{
    if(sender == _getMoreGoldBtn)
    {
        PUSH_VIEWCONTROLLER(GetMoreGoldViewController);
        model.balanceGold = [_GoldMoneyLbl.text substringFromIndex:5];
    }
    else if (sender == _bugVIP7Btn)
    {
        PUSH_VIEWCONTROLLER(VipPriviliegeViewController);
    }
}

- (void)dealloc {
    
    [_getMoreGoldBtn release];
    [_GoldMoneyLbl release];
    [_bugVIP7View release];
    [_bugVIP7Btn release];
    [_mygoldTable release];
    [_goldHeaderView release];
    
    [dic release];
    [arrTitle release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}
@end
