//
//  CurrencyCirculationMsgViewController.m
//  miaozhuan
//
//  Created by abyss on 14/12/5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CurrencyCirculationMsgViewController.h"
#import "CRSegHeader.h"
#import "ProductOrderMsgTableViewCell.h"
#import "CRDateCounter.h"
#import "RRAttributedString.h"

@interface CurrencyCirculationMsgViewController ()<UITableViewDataSource,UITableViewDelegate,cr_SegHeaderDelegate,cr_NCCellDelegate>
{
    MJRefreshController *_MJRefreshCon;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet CRSegHeader *header;
@end

@implementation CurrencyCirculationMsgViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getMyRequestType];
    [self configureTableView];
}

- (void)getMyRequestType
{
    _header.height = 0;
    _requestType = 301;
    InitNav(@"货币流通消息");
}

- (void)configureTableView
{
    _tableView.backgroundColor = AppColorBackground;
    self.view.backgroundColor = AppColorBackground;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    UIView* view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 320, 10));
    view.backgroundColor = AppColorBackground;
    _tableView.tableFooterView = view;
    _tableView.top = _header.bottom;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    NSString * refreshName = @"Message/CurrencyCirculationMsg";
    _MJRefreshCon = [MJRefreshController controllerFrom:_tableView name:refreshName];
    
    __block CurrencyCirculationMsgViewController *weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
     {
         return
         @{@"service":[NSString stringWithFormat:@"api/%@",refreshName],
           @"parameters":@{
                   @"Type":@(weakself.requestType),
                   @"PageIndex":@(pageIndex),
                   @"PageSize":@(pageSize)}
           }.wrapper;
     }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            NSLog(@"%@",netData);
            CRHolderFast_MJ([weakself showHolderWithImg:@"028_a" text2:@"您暂时没有消息哦"];);
            [weakself setHolderDefaultHight:40];
            [_tableView reloadData];
            if (controller.refreshCount == 0)
            {
                _tableView.backgroundColor = AppColorWhite;
                self.view.backgroundColor =  AppColorWhite;
                view.backgroundColor = AppColorWhite;
            }
            else
            {
                _tableView.backgroundColor = AppColorBackground;
                self.view.backgroundColor = AppColorBackground;
                view.backgroundColor = AppColorBackground;
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

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductOrderMsgTableViewCell *cell = (ProductOrderMsgTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return 110 + cell.exFloat - 0.5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *currencyStr = nil;
    static NSString *CellIdentifier = @"ProductOrderMsgTableViewCell";
    ProductOrderMsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ProductOrderMsgTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
        cell.line.left = 0;
    }
    cell.fatherIndex = indexPath;
    cell.delegate = self;
    
    DictionaryWrapper *data = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
    cell.type = _type;
    cell.data = data;
    currencyStr = [NSString stringWithFormat:@"TA还留言道: %@",[[data getDictionaryWrapper:@"RelatedDataInfo"] getString:@"UserContent"]];
    cell.deleteType = _requestType;
    cell.MsgIds = [data getString:@"MsgId"];
    cell.timeL.text = [[CRDateCounter shareInstance] crmz_formatDateFromStr:[data getString:@"MsgDate"]];
    cell.statuL.text = [data getString:@"Title"];
    
    NSString *contentStr = [data getString:@"Description"];
    cell.contentL.text = [NSString stringWithFormat:@"%@\n%@",contentStr,currencyStr];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3.f];
    NSMutableAttributedString *str = (NSMutableAttributedString *)[RRAttributedString setText:cell.contentL.text color:AppColor(204) range:NSMakeRange(contentStr.length, 8)];
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    [paragraphStyle release];
    
    cell.CRcontent = str;
    
    return cell;
}

- (void)cell:(ProductOrderMsgTableViewCell *)cell DidBeDelete:(NSIndexPath *)indexPath
{
    [_MJRefreshCon refreshWithLoading];
    //    [_MJRefreshCon removeDataAtIndex:(int)indexPath.row andView:UITableViewRowAnimationFade];
    //     if (_MJRefreshCon.refreshCount == 0) [self showHolderWithImg:@"028_a" text2:@"暂时没有消息哦"];
}


- (void)dealloc
{
    [_tableView release];
    [_header release];
    [super dealloc];
}
- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setHeader:nil];
    [super viewDidUnload];
}
@end
