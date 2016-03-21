//
//  OwnSliverManagerViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "OwnSliverManagerViewController.h"
#import "OwnSilverManagerCell.h"
#import "SilverListViewController.h"
#import "CircurateViewController.h"
#import "LoveAccountViewController.h"
#import "WebhtmlViewController.h"
#import "RRLineView.h"
#import "FansHelpViewController.h"

@interface OwnSliverManagerViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UILabel *lblSliverTatol;
@property (nonatomic, retain) NSArray *showTitles;
@property (nonatomic, retain) NSArray *nums;
@end

@implementation OwnSliverManagerViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigateTitle:@"我的银元"];
    [self setupMoveFowardButtonWithTitle:@"银元说明"];
    [self setupMoveBackButton];
    
    RRLineView *linetop = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 60, 320, 0.5));
    [self.view addSubview:linetop];
    
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self setExtraCellLineHidden:_tableView];
    [self _initData];
    ADAPI_CustomerIntegral_GetCustomerIntegral([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleCustomerIntegral:)]);
}
#pragma mark - 网络请求回调
- (void)handleCustomerIntegral:(DelegatorArguments*)arguments
{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed)
    {
        NSString *total = [dic.data getString:@"RemainingIntegral"];
        _lblSliverTatol.text = total;
        NSString *companyIntegral = [dic.data getString:@"CompanyIntegral"];//公司爱心账户
        NSString *loveingIntegral = [dic.data getString:@"LovingHeartIntegral"];//自己爱心账户
        [[NSUserDefaults standardUserDefaults] setValue:loveingIntegral forKey:@"LovingHeartIntegral"];
        [[NSUserDefaults standardUserDefaults] setValue:companyIntegral forKey:@"CompanyIntegral"];
        [[NSUserDefaults standardUserDefaults] setValue:total forKey:@"RemainingIntegral"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _nums = nil;
        self.nums = @[
                  @[[dic.data getString:@"ThankfulFruitIntegral"], [dic.data getString:@"SeeAdvertIntegral"], [dic.data getString:@"SystemPresentIntegral"], [dic.data getString:@"ConsumptionIntegral"]],
                  @[@""],
                  @[[dic.data getString:@"LovingHeartIntegral"]]
                  ];
        [self.tableView reloadData];
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (void)_initData{
    _nums = STRONG_OBJECT(NSArray, init);
    self.showTitles = @[@[@"粉丝帮我赚的",@"看广告赚的",@"系统赠送的",@"消耗的银元"], @[@"银元流通"], @[@"爱心账户"]];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_showTitles count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
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
    RRLineView *linetop = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 9.5, 320, 0.5));
    [sectionView addSubview:linetop];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_showTitles[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    OwnSilverManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OwnSilverManagerCell" owner:self options:nil] firstObject];
    }
    
    cell.lblNum.hidden = (indexPath.section == 1);
    if (indexPath.section == 0 && indexPath.row == 3)
    {
        cell.lblNum.textColor = RGBCOLOR(240, 5, 0);
        cell.cellLines.left = 0;
    }
    if (!_nums.count) {
        cell.lblNum.text = @"0";
    } else {
        cell.lblNum.text = [_nums[indexPath.section] objectAtIndex:indexPath.row];
    }
    cell.lblTitle.text = [_showTitles[indexPath.section] objectAtIndex:indexPath.row];
    
    if (indexPath.section == 1) {
        cell.cellLines.left = 0;
    }
    if (indexPath.section == 2) {
        cell.cellLines.left = 0;
    }
    
    cell.cellLines.top = 49.5;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PUSH_VIEWCONTROLLER(FansHelpViewController);
        } else {
            SilverListViewController *silver = WEAK_OBJECT(SilverListViewController, init);
            silver.cellType = (int)indexPath.row;
            [UI_MANAGER.mainNavigationController pushViewController:silver animated:YES];
        }
    } else if (indexPath.section == 1) {
        //银元流通
        CircurateViewController *model = [[[CircurateViewController alloc] init] autorelease];
        [self.navigationController pushViewController:model animated:YES];
    } else {
        //爱心账户
        PUSH_VIEWCONTROLLER(LoveAccountViewController);
    }
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - 事件
//说明
- (void)onMoveFoward:(UIButton *)sender{
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.navTitle = @"银元说明";
    model.ContentCode = @"2aa60aad0f22a4e8b2773c06e2768701";
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_nums release];
    [_showTitles release];
    [_tableView release];
    [_lblSliverTatol release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setNums:nil];
    [self setShowTitles:nil];
    [self setTableView:nil];
    [self setLblSliverTatol:nil];
    [super viewDidUnload];
}
@end
