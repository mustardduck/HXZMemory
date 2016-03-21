//
//  MyCashHomeViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyCashHomeViewController.h"
#import "MyCashStatement.h"
#import "PrepareToGetCashViewController.h"
#import "GetCashViewController.h"
#import "CashFromRedPacketViewController.h"
#import "CashFromFansViewController.h"
#import "PublicBenifitAccountViewController.h"
#import "ThankFulMechanismTableViewCell.h"
#import "WebhtmlViewController.h"
#import "RRLineView.h"
#import "MyGoldListController.h"

@interface MyCashHomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * arrTitle;
    
    DictionaryWrapper * dic;
}
@property (retain, nonatomic) IBOutlet UITableView *mainTableView;

@property (retain, nonatomic) IBOutlet UILabel *cashBalance;

@end

@implementation MyCashHomeViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"我的现金");
    
    [self setupMoveFowardButtonWithTitle:@"现金说明"];
    
    arrTitle = [[NSArray arrayWithObjects:@[@"申请提现",@"提现记录",@"看红包广告赚的",@"粉丝帮我赚的",@"拓展商家赚的",@"其他收支"],@[@"爱心账户"],nil]retain];
    
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {

    ADAPI_CashStatement([self genDelegatorID:@selector(getUrl:)]);
}

- (void)getUrl:(DelegatorArguments*)arguments
{
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        _mainTableView.dataSource = self;
        
        _mainTableView.delegate = self;
        
        dic = wrapper.data;
        
        [dic retain];
        
        double x = [dic getFloat:@"Balance"];
        x = x*100;
        double y = floor(x);
        y = y/100;
        _cashBalance.text = [NSString stringWithFormat:@"¥%.2f",y];
        
        [_mainTableView reloadData];
    }
    else if(wrapper.operationErrorCode || wrapper.operationPromptCode)
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
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
    UIView *sectionView = [[[UIView alloc] init]autorelease];
    
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
        return 6;
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
    
    if (indexPath.section == 0)
    {
        cell.cellLines.top = 49.5;
        if (indexPath.row == 0)
        {
            cell.isThankFulcellLable.text = @"";
        }
        else if (indexPath.row == 1)
        {
            cell.isThankFulcellLable.text = [NSString stringWithFormat:@"¥%.2f",[dic getFloat:@"CashOut"]];
        }
        else if (indexPath.row == 2)
        {
            cell.isThankFulcellLable.text = [NSString stringWithFormat:@"¥%.2f",[dic getFloat:@"EarnedByAdvert"]];
        }
        else if (indexPath.row == 3)
        {
            float temp = [dic getFloat:@"EarnedByFans"];
            temp = floor(temp*100)/100;
            cell.isThankFulcellLable.text = [NSString stringWithFormat:@"¥%.2f",temp];
        }
        else if (indexPath.row == 4)
        { //拓展商家赚的现金
            cell.isThankFulcellLable.text = [NSString stringWithFormat:@"¥%.2f",[dic getFloat:@"EarnedByExploit"]];
        }
        else if (indexPath.row == 5)
        {
            cell.isThankFulcellLable.text = [NSString stringWithFormat:@"¥%.2f",[dic getFloat:@"OtherIncomeCash"]];
            cell.cellLines.left = 0;
        }
    }
    else
    {
        
        double x = [dic getFloat:@"LoveMoney"];
        x = x*100;
        double y = floor(x);
        y = y/100;
        cell.isThankFulcellLable.text = [NSString stringWithFormat:@"¥%.2f",y];
        cell.cellLines.left = 0;
        cell.cellLines.top = 49.5;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            PrepareToGetCashViewController *temp = WEAK_OBJECT(PrepareToGetCashViewController, init);
            temp.dicDataSource = dic.dictionary;
            [self.navigationController pushViewController:temp animated:YES];
        }
        else if (indexPath.row == 1)
        {
            PUSH_VIEWCONTROLLER(GetCashViewController);
        }
        else if (indexPath.row == 2)
        {
            PUSH_VIEWCONTROLLER(CashFromRedPacketViewController);
        }
        else if (indexPath.row == 3)
        {
            PUSH_VIEWCONTROLLER(CashFromFansViewController);
        }
        else if (indexPath.row == 4)
        {
            MyGoldListController * view = WEAK_OBJECT(MyGoldListController, init);
            
            view.cellType = ExploitGoldConsume;
            
            [self.navigationController pushViewController:view animated:YES];
        }
        else if (indexPath.row == 5)
        {
            PUSH_VIEWCONTROLLER(MyGoldListController);
            
            model.cellType = QT_MONEY;
        }
    }
    else
    {
        PUSH_VIEWCONTROLLER(PublicBenifitAccountViewController);
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


- (IBAction) onMoveFoward:(UIButton*) sender
{
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.navTitle = @"现金说明";
    model.ContentCode = @"40a4878ddfa3c97f9414527a4d3f87df";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [dic release];
    [_cashBalance release];
    [_mainTableView release];
    [super dealloc];
}
@end
