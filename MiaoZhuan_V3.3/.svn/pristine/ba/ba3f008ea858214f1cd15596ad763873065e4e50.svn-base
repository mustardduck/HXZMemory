//
//  MySiteChangeViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/26.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MySiteChangeViewController.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "CRSegHeader.h"
#import "CRDateCounter.h"
#import "MySiteChangeTableViewCell.h"
#import "RRAttributedString.h"
#import "DetailSiteChangeViewController.h"

@interface MySiteChangeViewController ()<UITableViewDataSource,UITableViewDelegate,cr_SegHeaderDelegate>
{
    NSArray * arrayTitle;
    
    MJRefreshController *_MJRefreshCon;
    
    NSString * _ExchangeStatus;
    
    BOOL _hasRefreshTable;
}
@property (retain, nonatomic) IBOutlet CRSegHeader *topView;
@property (retain, nonatomic) IBOutlet UIView *showView;
@property (retain, nonatomic) IBOutlet YFJLeftSwipeDeleteTableView *mainTableVIew;

@property (retain, nonatomic) NSString * ExchangeStatus;
@end

@implementation MySiteChangeViewController

-(void)viewWillAppear:(BOOL)animated
{
    _mainTableVIew.frame = CGRectMake(0, 40, 320, [[UIScreen mainScreen] bounds].size.height - 104);
    
    _showView.frame = CGRectMake(0, 40, 320, [[UIScreen mainScreen] bounds].size.height - 104);
    
    if (_hasRefreshTable)
        [self refreshTableView];
}


MTA_viewDidAppear(_hasRefreshTable = YES;)
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"我的现场兑换");
    
    arrayTitle = [NSArray arrayWithObjects:@"等待兑换",@"兑换成功",@"撤销的兑换", nil];
    
    [_topView setButtonArray:arrayTitle];
    
    _topView.lineSize = 2;
    
    _topView.delegate = self;
    
    _ExchangeStatus = @"0";
    
    [self setTableviewLoad];

}

- (void)button:(UIButton *)button didBetouch:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        _ExchangeStatus = @"0";
    }
    else if (buttonIndex == 1)
    {
        _ExchangeStatus = @"2";
    }
    else
    {
        _ExchangeStatus = @"3";
    }
    
    [self refreshTableView];
}


#pragma mark - tableView delegate

- (void) setTableviewLoad
{
    [_mainTableVIew setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    NSString * refreshName = @"ExchangeManagement/CustomerGetExchangeRecords";
    
    __block MySiteChangeViewController * weakself = self;
    
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_mainTableVIew name:refreshName];
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
     {
         return @{
                  @"service":[NSString stringWithFormat:@"api/%@",refreshName],
                  @"parameters":
                      @{@"ExchangeStatus":weakself.ExchangeStatus,
                        @"PageIndex":@(pageIndex),
                        @"PageSize":@(pageSize)}}.wrapper;
     }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            if (controller.refreshCount == 0)
            {
                _showView.hidden = NO;
            }
            else
            {
                _showView.hidden = YES;
                _mainTableVIew.delegate = self;
                _mainTableVIew.dataSource = self;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MySiteChangeTableViewCell";
    
    MySiteChangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MySiteChangeTableViewCell" owner:nil options:nil].lastObject;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.layer.masksToBounds = YES;
    }

    DictionaryWrapper *cellData = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
    
    [cell.cellShippingImage requestCustom:[cellData getString:@"PictureUrl"] width:cell.cellShippingImage.width height:cell.cellShippingImage.height];
  
    cell.cellTitle.text = [cellData getString:@"ProductName"];
   
    cell.cellLine.top = 109.5;
    
    NSString * time  =[cellData getString:@"OrderTime"];
    
    time = [UICommon format19Time:time];
    
    cell.cellTime.text = time;
    
    cell.cellMoney.text = [NSString stringWithFormat:@"所需银元 %@",[cellData getString:@"TotalPrice"]];
    
    if (cell.cellTitle.text.length <= 13)
    {
        cell.cellTitle.frame = CGRectMake(105, 19, 200, 25);
        cell.cellTime.frame = CGRectMake(105, 49, 200, 12);
        cell.cellMoney.frame = CGRectMake(105, 66, 200, 15);
    }
    
    NSAttributedString * attributedString= [RRAttributedString setText:cell.cellMoney.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
    
    cell.cellMoney.attributedText = attributedString;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PUSH_VIEWCONTROLLER(DetailSiteChangeViewController);
    model.OrderNo = [[_MJRefreshCon dataAtIndex:(int)indexPath.row]getString:@"OrderNo"];
    model.ProductName = [[_MJRefreshCon dataAtIndex:(int)indexPath.row]getString:@"ProductName"];
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    MySiteChangeTableViewCell *cell = (MySiteChangeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor = AppColor(220);
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    MySiteChangeTableViewCell *cell = (MySiteChangeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [arrayTitle release];
    [_MJRefreshCon release];
    _MJRefreshCon = nil;
    [_showView release];
    [_mainTableVIew release];
    [_topView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setShowView:nil];
    [self setMainTableVIew:nil];
    [self setTopView:nil];
    [super viewDidUnload];
}
@end
