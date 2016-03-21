//
//  CROrderManagerViewController.m
//  miaozhuan
//
//  Created by abyss on 14/12/4.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CROrderManagerViewController.h"
#import "MJRefreshController.h"

#import "CRHolderView.h"

@interface CROrderManagerViewController () <UITableViewDataSource,UITableViewDelegate,OrderTableViewCellDelegate>
{
    MJRefreshController*    _MJRefreshCon;
}
@end

@implementation CROrderManagerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self refreshTableView];
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNav];
    
    [self loadTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)initNav
{
    NSString *navTitle = @"自行设置title";
    switch (self.type)
    {
        case CRENUM_OrderTypeDirectItem:
        {
            break;
        }
        case CRENUM_OrderTypeThankGiving:
        {
            navTitle = @"感恩果购买记录";
            break;
        }
        case CRENUM_OrderTypeEnterpriseVIP:
        {
            navTitle = @"商家VIP购买记录";
            break;
        }
        case CRENUM_OrderTypeGold:
        {
            navTitle = @"广告金币购买记录";
            break;
        }
        case CRENUM_OrderTypeUserVIP:
        {
            navTitle = @"用户VIP购买记录";
            break;
        }
        case CRENUM_OrderTypeDirectAdvert:
        {
            break;
        }
        case CRENUM_OrderTypeDirectGoldMall:
        {
            break;
        }
        default:
            break;
    }
    InitNav(navTitle);
}

- (void)loadTableView
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    NSString * refreshName = @"Order/List";
    _MJRefreshCon = [MJRefreshController controllerFrom:_tableView name:refreshName];
    
    __block CROrderManagerViewController *weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
     {
         DictionaryWrapper *dic =  @{@"service":[NSString stringWithFormat:@"api/%@",refreshName],
                                     @"parameters":
                                         @{
                                             @"OrderType":@(weakself.type),
                                             @"PageIndex":@(pageIndex),
                                             @"PageSize":@(pageSize)}}.wrapper;
         NSLog(@"%@",dic.dictionary);
         return dic;
     }];
     {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            if (controller.refreshCount == 0)
            {
                [self showHolderWithImg:@"028_a" text2:@"暂时没有对应数据"];
            }
            else
            {
                [self displayHoder:NO];
            }
        };
        
        [_MJRefreshCon setOnRequestDone:block];
        [_MJRefreshCon setPageSize:30];
        [_MJRefreshCon retain];
    }
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OrderTableViewCell";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"OrderTableViewCell" owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.data = [[CROrder alloc] initWithNetWrapper:[[_MJRefreshCon dataAtIndex:(int)indexPath.row] wrapper]];
    cell.delegate = self;
    cell.fatherIndex = indexPath;
    return cell;
}

- (void)orderDelete:(NSIndexPath *)deleteIndexPath
{
//    [_MJRefreshCon removeDataAtIndex:(int)deleteIndexPath.row andView:UITableViewRowAnimationFade];
    [self refreshTableView];
}

- (void)orderRefresh:(NSIndexPath *)refreshIndexPath
{
//    [_tableView reloadRowsAtIndexPaths:@[refreshIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self refreshTableView];
}

- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}
@end
