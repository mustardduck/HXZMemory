//
//  ExchangeMangerEntranceViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/4.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ExchangeMangerEntranceViewController.h"
#import "ExchangeMangerEntranceTableViewCell.h"
#import "MJRefreshController.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "NetImageView.h"
#import "SceneExangeMangerViewController.h"
#import "ExchangeMangerViewController.h"
#import "WebhtmlViewController.h"

@interface ExchangeMangerEntranceViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    MJRefreshController *_MJRefreshCon;
}
@property (retain, nonatomic) IBOutlet YFJLeftSwipeDeleteTableView *exchangeTableView;
@property (retain, nonatomic) IBOutlet UIView *showView;

@end

@implementation ExchangeMangerEntranceViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"店小二专用入口");
    
//    [self setupMoveFowardButtonWithTitle:@"说明"];
    
    [_exchangeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self setTableviewLoad];
}

//- (IBAction) onMoveFoward:(UIButton*) sender
//{
//    PUSH_VIEWCONTROLLER(WebhtmlViewController);
//    model.navTitle = @"说明";
//    model.ContentCode = @"086b983bf0f22b58591c5cf24f91a1be";
//}

#pragma mark - tableView delegate

- (void) setTableviewLoad
{
    NSString * refreshName = @"ExchangeManagement/GetExchangeAddressList";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_exchangeTableView name:refreshName];
    
    __block ExchangeMangerEntranceViewController * weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
     {
         return @{
                  @"service":[NSString stringWithFormat:@"api/%@",refreshName],
                  @"parameters":
                      @{@"PageIndex":@(pageIndex),
                        @"PageSize":@(pageSize)}}.wrapper;
     }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            if (netData.operationSucceed)
            {
                if (controller.refreshCount == 0)
                {
                    
                }
                else
                {
                    _showView.hidden = YES;
                }
            }
            else
            {
                [HUDUtil showErrorWithStatus:netData.operationMessage];
            }
        };
        
        [_MJRefreshCon setOnRequestDone:block];
        [_MJRefreshCon setPageSize:50];
        [_MJRefreshCon retain];
    }
    
    _exchangeTableView.delegate = self;
    _exchangeTableView.dataSource = self;
    
    [self refreshTableView];
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ExchangeMangerEntranceTableViewCell";
    
    ExchangeMangerEntranceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ExchangeMangerEntranceTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    [cell.cellImages requestPic:[[_MJRefreshCon dataAtIndex:(int)indexPath.row]getString:@"LogoUrl"] placeHolder:YES];
    
    cell.cellTitle.text = [[_MJRefreshCon dataAtIndex:(int)indexPath.row]getString:@"AddressDetail"];
    
    cell.cellContent.text = [[_MJRefreshCon dataAtIndex:(int)indexPath.row]getString:@"EnterpriseName"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果是兑换管理员专用入口进入，就从这里传商家id，如果是商城进入，传商家id
    
    PUSH_VIEWCONTROLLER(ExchangeMangerViewController);
    
    model.ExchangeAddressId = [NSString stringWithFormat:@"%d",[[_MJRefreshCon dataAtIndex:(int)indexPath.row]getInt:@"ExchangeAddressId"]];
    
    model.EnterpriseId =[NSString stringWithFormat:@"%d",[[_MJRefreshCon dataAtIndex:(int)indexPath.row]getInt:@"EnterpriseId"]];

    model.type = @"1";//兑换管理员专用入口
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExchangeMangerEntranceTableViewCell *cell = (ExchangeMangerEntranceTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExchangeMangerEntranceTableViewCell *cell = (ExchangeMangerEntranceTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_exchangeTableView release];
    [_showView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setExchangeTableView:nil];
    [self setShowView:nil];
    [super viewDidUnload];
}
@end
