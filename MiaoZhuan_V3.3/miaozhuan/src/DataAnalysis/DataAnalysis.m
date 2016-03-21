//
//  DataAnalysis.m
//  miaozhuan
//
//  Created by abyss on 14/11/4.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DataAnalysis.h"
#import "DataAnalysisCell.h"
#import "MyDataViewController.h"
#import "DataAdvertViewController.h"
#import "VIPPrivilegeViewController.h"
#import "CRHolderView.h"
#import "WebhtmlViewController.h"

#import "UserInfo.h"

@class DataAdvertViewController;
@interface DataAnalysis () <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_myData;
    NSMutableArray *_netData;
}
@property (retain, nonatomic) IBOutlet UIButton *yanshi;
@end

@implementation DataAnalysis

- (IBAction)yanshiBt:(id)sender
{
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.ContentCode = @"8d4471482f03456a7ff387aa1a56ea4b";
}

@synthesize noVipView = _noVipView;

- (void)dealloc
{
    [_tableView release];
    [_noVipView release];
    [_myData release];
    [_netData release];
    CRDEBUG_DEALLOC();
    
    [_yanshi release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    ADAPI_adv3_Snap([self genDelegatorID:@selector(dataAnalysis:)]);
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    InitNav(@"数据分析");
    [self initData];
    [_yanshi setBorderWithColor:AppColorRed];
    [_yanshi setRoundCorner];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    _tableView.backgroundColor = AppColorBackground;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)dataAnalysis:(DelegatorArguments *)arg
{
    [arg logError];
    DictionaryWrapper *wrapper = arg.ret;
    if (wrapper.operationSucceed)
    {
         _noVipView.hidden = YES;
        
        
        DictionaryWrapper *dic = wrapper.data;
        if (!_netData)
        {
            _netData = [NSMutableArray new];
        }
        [_netData addObject:@[[dic getString:@"PV"],[dic getString:@"CV"]]];
        [_netData addObject:@[[dic getString:@"Count"],[dic getString:@"Silver"]]];
        [_netData addObject:@[[dic getString:@"OnlineAdvert"],[dic getString:@"Total"]]];
        [_tableView reloadData];
    }
    else
    {
        _noVipView.hidden = NO;
        if (wrapper.code == 30066)
        {
            _noVipView.hidden = YES;
            [self showHolderWithImg:nil text2:@"今天的数据请在明天凌晨后查看"];
        }
        
//        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void)initData
{
    _myData = @[@{@"pic":@"037",@"title":@"我的商家(商家详情)",@"text1":@"昨日访问量",@"text2":@"昨日访客"},
                @{@"pic":@"036",@"title":@"银元广告",@"text1":@"昨天播出数",@"text2":@"昨日消耗银元"},
                @{@"pic":@"035",@"title":@"红包广告",@"text1":@"在播广告数",@"text2":@"已达到量"},
                ];
    [_myData retain];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setNoVipView:nil];
    [super viewDidUnload];
}

#pragma mark - tableview delegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataAnalysisCell *cell = (DataAnalysisCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataAnalysisCell *cell = (DataAnalysisCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            PUSH_VIEWCONTROLLER(MyDataViewController);
            break;
        }
        case 1:
        {
            PUSH_VIEWCONTROLLER(DataAdvertViewController);
            model.type = DataCategroyYin;
            break;
        }
        case 2:
        {
            PUSH_VIEWCONTROLLER(DataAdvertViewController);
            model.type = DataCategroyZhi;
            break;
        }
            
        default:
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DataAnalysisCell";
    DataAnalysisCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DataAnalysisCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.img.image = [UIImage imageNamed:[_myData[indexPath.row] objectForKey:@"pic"]];
    cell.titleL.text = [_myData[indexPath.row] objectForKey:@"title"];
    cell.text1.text = [_myData[indexPath.row] objectForKey:@"text1"];
    cell.text2.text = [_myData[indexPath.row] objectForKey:@"text2"];
    cell.data1.text = _netData[indexPath.row][0];
    cell.data2.text = _netData[indexPath.row][1];
    return cell;
}

- (IBAction)buyVip:(id)sender
{
    PUSH_VIEWCONTROLLER(VIPPrivilegeViewController);
}
@end
