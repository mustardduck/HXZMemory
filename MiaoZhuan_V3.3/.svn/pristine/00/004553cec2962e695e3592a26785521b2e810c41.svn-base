//
//  AllSiteExchangeViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AllSiteExchangeViewController.h"
#import "CRSegHeader.h"
#import "MJRefreshController.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "CRDateCounter.h"
#import "AllSiteTableViewCell.h"
#import "RRAttributedString.h"
#import "RRLineView.h"

@interface AllSiteExchangeViewController ()<UITableViewDataSource,UITableViewDelegate,cr_SegHeaderDelegate>
{
    NSArray * arrayTitle;
    
    NSMutableArray * _contentArray;
    
    MJRefreshController *_MJRefreshCon;
    
    NSString * _ExchangeStatus;
    
    NSString * _ExtraData;
}
@property (retain, nonatomic) IBOutlet YFJLeftSwipeDeleteTableView *mainTableView;
@property (retain, nonatomic) IBOutlet CRSegHeader *topView;
@property (retain, nonatomic) IBOutlet UIView *showView;


@property(retain, nonatomic) NSMutableArray * contentArray;
@property(retain, nonatomic) NSString * ExchangeStatus;

@property(retain, nonatomic) NSString * ExtraData;

@end

@implementation AllSiteExchangeViewController

-(void)viewWillAppear:(BOOL)animated
{
    _mainTableView.frame = CGRectMake(0, 40, 320, [[UIScreen mainScreen] bounds].size.height - 104);
    
    _showView.frame = CGRectMake(0, 40, 320, [[UIScreen mainScreen] bounds].size.height - 104);
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"所有现场兑换订单");
    
    [self viewTitle];
    
    _ExchangeStatus = @"0";
    
    _ExtraData = [[NSString alloc] init];
    
    _ExtraData = @"";
    
    _topView.lineSize = 2;
    
    _topView.delegate = self;
    
    [self setTableviewLoad];
}

-(void) viewTitle
{
    NSString * titleOne = nil;
    if (_ExtraData && _ExtraData.length > 0)
    {
        titleOne = [NSString stringWithFormat:@"等待兑换(%@)",_ExtraData];
    }
    else
    {
        titleOne = @"等待兑换";
    }
    
    arrayTitle = [NSArray arrayWithObjects:titleOne,@"兑换成功",@"撤销的兑换", nil];
    
    
    [_topView setButtonArray:arrayTitle];
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
    [_mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    NSString * refreshName = @"ExchangeManagement/GetExchangeRecordList";
    
    __block AllSiteExchangeViewController * weakself = self;
    
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_mainTableView name:refreshName];
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
     {
         return @{
                  @"service":[NSString stringWithFormat:@"api/%@",refreshName],
                  @"parameters":
                      @{@"EnterpriseId":weakself.EnterpriseId,
                        @"ExchangeType":@"1",
                @"ExchangeStatus":weakself.ExchangeStatus,@"KeyWord":@"",
                        @"PageIndex":@(pageIndex),
                        @"PageSize":@(pageSize)}}.wrapper;
     }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            NSString *ret = [netData.data getString:@"ExtraData"];
            if (ret && ![ret isEqualToString:weakself.ExtraData])
            {
                weakself.ExtraData = ret;
                [weakself viewTitle];
            }
            
            NSArray *array = [[CRDateCounter shareInstance] dateCount:controller.refreshData forKey:@"OrderTime"];
            
            if (!weakself.contentArray)
            {
                weakself.contentArray = [NSMutableArray new];
            }
            [weakself.contentArray removeAllObjects];
            
            weakself.contentArray = [NSMutableArray arrayWithArray:array];
            [weakself.contentArray retain];
            
            if (weakself.contentArray.count == 0)
            {
                _showView.hidden = NO;
            }
            else
            {
                _showView.hidden = YES;
            }
            
            [weakself.mainTableView reloadData];
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
    return _contentArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 23;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    
    label.frame = CGRectMake(15, 0, 290, 23);
    
    label.backgroundColor = [UIColor clearColor];
    
    label.textColor = RGBACOLOR(153, 153, 153, 1);
    
    label.font = [UIFont systemFontOfSize:12];
    
    label.text = [[_contentArray[section][0] wrapper] getString:@"Date"];
    
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 23)] autorelease];
    
    sectionView.backgroundColor = RGBCOLOR(247, 247, 247);
    
    [sectionView addSubview:label];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)_contentArray[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AllSiteTableViewCell";
    
    AllSiteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"AllSiteTableViewCell" owner:nil options:nil].lastObject;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.layer.masksToBounds = YES;
    }
    
    DictionaryWrapper *dic = [[_contentArray[indexPath.section][indexPath.row] wrapper] getDictionaryWrapper:@"Data"];
    
    NSLog(@"---dic%@",dic);
    
    [cell.cellsiteImage requestCustom:[dic getString:@"PhotoUrl"] width:cell.cellsiteImage.width height:cell.cellsiteImage.height];
    
    cell.cellTitle.text = [dic getString:@"ProductName"];
    
    cell.cellPhoneandName.text = [NSString stringWithFormat:@"%@   %@",[dic getString:@"UserName"],[dic getString:@"TrueName"]];
    
    cell.cellNum.text = [NSString stringWithFormat:@"数量  %d",[dic getInt:@"Count"]];
    
    NSAttributedString * attributedString= [RRAttributedString setText:cell.cellNum.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 2)];
    
    cell.cellNum.attributedText = attributedString;
    
    cell.cellLine.top = 89.5;
    
    if ([_contentArray[indexPath.section] count] == indexPath.row + 1)
    {
        cell.cellLine.left = 0;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllSiteTableViewCell *cell = (AllSiteTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor = AppColor(220);
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllSiteTableViewCell *cell = (AllSiteTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc
{
    [_contentArray release];
    
    [_MJRefreshCon release];
    
    [_mainTableView release];
    [_topView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainTableView:nil];
    [self setTopView:nil];
    [super viewDidUnload];
}
@end
