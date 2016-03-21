//
//  ProductOrderMsgViewController.m
//  miaozhuan
//
//  Created by abyss on 14/12/5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ProductOrderMsgViewController.h"
#import "MJRefreshController.h"
#import "ProductOrderMsgTableViewCell.h"
#import "CRSegHeader.h"
#import "CRDateCounter.h"
#import "MyMarketMyOrderListController.h"

@interface ProductOrderMsgViewController () <UITableViewDataSource,UITableViewDelegate,cr_SegHeaderDelegate,cr_NCCellDelegate>
{
    MJRefreshController *_MJRefreshCon;
}
@property (retain, nonatomic) IBOutlet CRSegHeader *header;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ProductOrderMsgViewController

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
    if (_type == CRENUM_NCContentTypeTradeMsg)
    {
        _requestType = 111;
        InitNav(@"交易消息");
        _tableView.height += 40;
        //用户交易
    }
    else if(_type == CRENUM_NCContentTypeLiveOrder)
    {
        _requestType = 213;
        InitNav(@"现场订单");
        _tableView.height += 40;
        //现场邮寄
    }
    else
    {
        InitNav(@"邮寄订单");
        _header.delegate = self;
        _header.height = 40;
        if(_type & CRENUM_NCContentTypePostOrder)
        {
            _requestType = 211;
            //商家邮寄兑换
        }
        else
        {
            _requestType = 212;
            _header.autoawakIndex = 1;
            //商家邮寄退货
        }
        _header.buttonArray = @[@"交易消息",@"退货消息"];
    }
}

- (void)button:(UIButton *)button didBetouch:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        _requestType = 211;
        _type = CRENUM_NCContentTypePostOrder;
    }
    else
    {
        _requestType = 212;
        _type = CRENUM_NCContentTypePostOrderRefund;
    }
    [self refreshTableView];
}

- (void)configureTableView
{
    _tableView.backgroundColor = AppColorBackground;
    self.view.backgroundColor = AppColorBackground;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    _tableView.height += 15;
    UIView* view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 320, 10));
    view.backgroundColor = AppColorBackground;
    _tableView.tableFooterView = view;
    _tableView.top = _header.bottom;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    NSString * refreshName = @"Message/ProductOrderMsg";
    _MJRefreshCon = [MJRefreshController controllerFrom:_tableView name:refreshName];
    
    __block ProductOrderMsgViewController *weakself = self;
    
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
            CRHolderFast_MJ([weakself showHolderWithImg:@"028_a" text2:@"您暂时没有消息哦"];);
            [weakself setHolderDefaultHight:40];
            [_tableView reloadData];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductOrderMsgTableViewCell *cell = (ProductOrderMsgTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return 190 + cell.exFloat;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductOrderMsgTableViewCell";
    ProductOrderMsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ProductOrderMsgTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
        [cell.itemImg setBorderWithColor:AppColor(220)];
    }
    cell.type = _type;
    cell.fatherIndex = indexPath;
    cell.delegate = self;
    
    DictionaryWrapper *data = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
    cell.data = data;
    
    cell.MsgIds = [data getString:@"MsgId"];
    cell.deleteType = _requestType;
    cell.timeL.text = [[CRDateCounter shareInstance] crmz_formatDateFromStr:[data getString:@"MsgDate"]];
    cell.statuL.text = [data getString:@"Title"];
    cell.CRcontent = [[[NSAttributedString alloc] initWithString:[data getString:@"Description"]] autorelease];
    
    DictionaryWrapper *itemData = [data getDictionaryWrapper:@"RelatedDataInfo"];
    cell.titleL.text = [itemData getString:@"ProductName"];
    cell.colorL.text = [itemData getString:@"ProductSpec"];
    
    int type = [itemData getInt:@"ProductType"];
    NSString *price = [itemData getString:@"TotalPrice"];
//    if (1 == type) [price stringByAppendingString:@"银元"];
//    if (2 == type) [price stringByAppendingString:@"金币"];
    cell.priceL.text = price;
    
    [cell.itemImg requestIcon:[itemData getString:@"PictureUrl"]];
    
    return cell;
}

- (void)cell:(ProductOrderMsgTableViewCell *)cell DidBeDelete:(NSIndexPath *)indexPath
{
    [_MJRefreshCon refreshWithLoading];
//    [_MJRefreshCon removeDataAtIndex:(int)indexPath.row andView:UITableViewRowAnimationFade];
//    if (_MJRefreshCon.refreshCount == 0) [self showHolderWithImg:@"028_a" text2:@"暂时没有消息哦"];

}


@end
