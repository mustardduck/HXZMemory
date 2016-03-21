//
//  AdvertMsgViewController.m
//  miaozhuan
//
//  Created by abyss on 14/12/5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AdvertMsgViewController.h"
#import "MJRefreshController.h"
#import "ProductOrderMsgTableViewCell.h"
#import "CRSegHeader.h"
#import "CRDateCounter.h"

@interface AdvertMsgViewController () <UITableViewDataSource,UITableViewDelegate,cr_SegHeaderDelegate,cr_NCCellDelegate>
{
    MJRefreshController *_MJRefreshCon;
}
@property (retain, nonatomic) IBOutlet CRSegHeader *header;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation AdvertMsgViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getMyRequestType];
    [self configureTableView];
    InitNav(@"广告播放消息");
}

- (void)getMyRequestType
{
    _header.delegate = self;
    _header.height = 40;
    _header.buttonArray = @[@"银元广告",@"红包广告",@"竞价广告"];
    if(_type & CRENUM_NCContentTypeSilverAdvert)
    {
        _requestType = 231;
    }
    else if (_type & CRENUM_NCContentTypeGoldAdvert)
    {
        _requestType = 232;
        _header.autoawakIndex = 1;
    }
    else
    {
        _requestType = 233;
        _header.autoawakIndex = 3;
    }
}

- (void)button:(UIButton *)button didBetouch:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        _requestType = 231;
        _type = CRENUM_NCContentTypeSilverAdvert;
    }
    else if (buttonIndex == 1)
    {
        _requestType = 232;
        _type = CRENUM_NCContentTypeGoldAdvert;
    }
    else if (buttonIndex == 2)
    {
        _requestType = 233;
        _type = CRENUM_NCContentTypeBiddingAdvert;
    }
    [self refreshTableView];
}

- (void)configureTableView
{
    _tableView.backgroundColor = AppColorBackground;
    self.view.backgroundColor = AppColorBackground;
    UIView* view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 320, 10));
    view.backgroundColor = AppColorBackground;
    _tableView.tableFooterView = view;
    _tableView.top = _header.bottom;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    NSString * refreshName = @"Message/AdvertMsg";
    _MJRefreshCon = [MJRefreshController controllerFrom:_tableView name:refreshName];
    
    __block AdvertMsgViewController *weakself = self;
    
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
    return 110 + cell.exFloat - 0.5;
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
        cell.line.left = 0;
    }
    cell.fatherIndex = indexPath;
    cell.delegate = self;
    
    DictionaryWrapper *data = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
    cell.type = _type;
    cell.data = data;
    cell.deleteType = _requestType;
    cell.MsgIds = [data getString:@"MsgId"];
//    NSString *t = [[CRDateCounter shareInstance] crmz_formatDateFromStr:[data getString:@"MsgDate"]];
    cell.timeL.text = [[CRDateCounter shareInstance] crmz_formatDateFromStr:[data getString:@"MsgDate"]];
    cell.statuL.text = [data getString:@"Title"];
    cell.CRcontent = [[[NSAttributedString alloc] initWithString:[data getString:@"Description"]] autorelease];
    
    return cell;
}

- (void)cell:(ProductOrderMsgTableViewCell *)cell DidBeDelete:(NSIndexPath *)indexPath
{
    [_MJRefreshCon refreshWithLoading];
    //    [_MJRefreshCon removeDataAtIndex:(int)indexPath.row andView:UITableViewRowAnimationFade];
    //     if (_MJRefreshCon.refreshCount == 0) [self showHolderWithImg:@"028_a" text2:@"暂时没有消息哦"];
}

@end
