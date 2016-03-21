//
//  DataInformationJumpViewController.m
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DataInformationJumpViewController.h"
#import "MJRefreshController.h"
#import "DataImformationJumpItemTableViewCell.h"
#import "CRDateCounter.h"
#import "UserInfo.h"
#import "CRHolderView.h"

@interface DataInformationJumpViewController () <UITableViewDelegate,UITableViewDataSource>
{
    MJRefreshController *_MJRefreshCon;
    
    NSMutableArray *_data;
}
@end

@implementation DataInformationJumpViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    NSString *navtitle = self.type?@"到达用户列表":@"收到广告用户列表";
    InitNav(navtitle);
    _data = [NSMutableArray new];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // Do any additional setup after loading the view from its nib.
}

- (void)initTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    _tableView.panGestureRecognizer.delaysTouchesBegan = YES;
//    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    NSString * refreshName = self.type? @"api/VipEnterpriseAnalysis/DirectAdvertCV":@"api/VipEnterpriseAnalysis/SilverAdvertPV";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_tableView name:refreshName];
    
        __block DataInformationJumpViewController *weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
     {
         NSDictionary *dic;
         if (!weakself.type)
         {
             dic =@{@"PageIndex":@(pageIndex), @"PageSize":@(pageSize),@"SilverAdvertId":@(weakself.advertID)};
         }
         else
         {
             dic =@{@"PageIndex":@(pageIndex), @"PageSize":@(pageSize),@"DirectAdvertId":@(weakself.advertID)};
         }
         NSDictionary *pramaDic= @{@"service":refreshName,@"parameters":dic};
         NSLog(@"%@",pramaDic);
         return pramaDic.wrapper;
     }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            CRHolderFast_MJ_Default();
            NSArray *array = [[CRDateCounter shareInstance] dateCount:controller.refreshData forKey:@"CreateTime"];
            if (!array) return;
            [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
            [weakself.data removeAllObjects];
            weakself.data = [NSMutableArray arrayWithArray:array];
            [weakself.data retain];
            [weakself.tableView reloadData];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataImformationJumpItemTableViewCell *cell = (DataImformationJumpItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataImformationJumpItemTableViewCell *cell = (DataImformationJumpItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 23.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 320, 23));
    view.backgroundColor = AppColor(247);
    
    UILabel *label = WEAK_OBJECT(UILabel, initWithFrame:view.bounds);
    label.left = 15;
    label.textColor = AppColor(153);
    label.font = Font(12);
    label.text = [_data[section][0] objectForKey:@"Date"];
    [view addSubview:label];
    
    if (section != 0)
    {
        UIView* view1 = WEAK_OBJECT(UIView
                                   , initWithFrame:CGRectMake(0, 0, 320, 0.5));
        view1.backgroundColor = AppColor(204);
        [view addSubview:view1];
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _data.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)_data[section]).count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DataImformationJumpItemTableViewCell";
    DataImformationJumpItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DataImformationJumpItemTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.img requestMiddle:nil];
        [cell.img setBorderWithColor:AppColor(197)];
        [cell.img setRoundCorner:11.f];
    }
    
    if (((NSArray *)_data[indexPath.section]).count == indexPath.row + 1)
    {
        cell.line.left = 0;
    }
    
    DictionaryWrapper *cellData = [[_data[indexPath.section][indexPath.row] wrapper] getDictionaryWrapper:@"Data"];
    
    if ([cellData getString:@"LocationString"].length < 2)
    {
        cell.timeL.top     = 42;
        cell.icon.hidden   = YES;
    }
    
    {
        cell.vipIcon.image = [USER_MANAGER getVipPic:0];
        cell.titleL.text = [cellData getString:@"Name"];
        cell.phoneL.text = [NSString stringWithFormat:@"(%@)",[cellData getString:@"Account"]];
        cell.placeL.text = [cellData getString:@"LocationString"];
        
        NSString *last = (!_type)?@"收看":@"到达";
        cell.timeL.text  = [NSString stringWithFormat:@"于 %@ %@",[UICommon formatTime:[cellData getString:@"CreateTime"]],last];
        
        [cell.img requestIcon:[cellData getString:@"PictureUrl"]];
        
        if([cellData getBool:@"IsRead"])
            cell.isRead.hidden = NO;
        else
            cell.isRead.hidden = YES;
    }
    
    {
        cell.phoneL.left    = AppGetTextWidth(cell.titleL) + 1;
        cell.vipIcon.left   = AppGetTextWidth(cell.phoneL) + 1;
        cell.vipIcon.image  = [USER_MANAGER getVipPic:[cellData getInt:@"VipLevel"]];
        
//        cell.timeL.top      = AppGetTextHeight(cell.placeL) + 5;
    }
    
    
    if (indexPath.row == ((NSArray *)_data[indexPath.section]).count && [SystemUtil aboveIOS7_0])
    {
        cell.separatorInset = UIEdgeInsetsMake(0, -15, 0, 0);
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _tableView)
    {
        CGFloat sectionHeaderHeight = 20;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y>=sectionHeaderHeight)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_tableView release];
    CRDEBUG_DEALLOC();
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
