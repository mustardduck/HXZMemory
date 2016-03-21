//
//  DetailYiHuoEDuViewController.m
//  miaozhuan
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "DetailYiHuoEDuViewController.h"
#import "MJRefreshController.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "DetailYiHuoEDuTableViewCell.h"
#import "RRAttributedString.h"
#import "JSONKit.h"

@interface DetailYiHuoEDuViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    MJRefreshController *_MJRefreshCon;
}
@property (retain, nonatomic) IBOutlet YFJLeftSwipeDeleteTableView *tableview;
@property (retain, nonatomic) IBOutlet UIView *topview;
@property (retain, nonatomic) IBOutlet UILabel *topLable;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineone;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *linetwo;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *linethree;
@property (retain, nonatomic) IBOutlet UIView *noview;

@end

@implementation DetailYiHuoEDuViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"易货额度明细");
    
    _lineone.constant = 0.5;
    
    _linetwo.constant = 0.5;
    
    _linethree.constant = 0.5;
    
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
//    [_tableview setTableHeaderView:_topview];
    
    [self setTableviewLoad];
}

#pragma mark - tableView delegate

- (void) setTableviewLoad
{
    NSString * refreshName = @"BarterQuota/List";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_tableview name:refreshName];
    
    __block DetailYiHuoEDuViewController * weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
     {
         return @{
                  @"service":[NSString stringWithFormat:@"api/%@",refreshName],
                  @"parameters":
                      @{@"SearchMonth":@"2015-01-01",
                        @"PageIndex":@(pageIndex),
                        @"PageSize":@(pageSize)}}.wrapper;
     }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            NSLog(@"%@",netData);

            if (netData.operationSucceed)
            {
//                DictionaryWrapper *dic = [[[netData.data getString:@"ExtraData"] objectFromJSONString] wrapper];
//                
//                _topLable.text = [NSString stringWithFormat:@"已消耗易货额度  %@", [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[dic getDouble:@"ConsumeBarterQuota"]withAppendStr:nil]];
                
//                NSAttributedString * string = [RRAttributedString setText:_topLable.text color:RGBCOLOR(34,34,34) range:NSMakeRange(0, 7)];
//                
//                _topLable.attributedText = string;
                
                if (controller.refreshCount == 0)
                {
                    _noview.hidden = NO;
                }
                else
                {
                    _noview.hidden = YES;
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
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    [self refreshTableView];
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}


#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DetailYiHuoEDuTableViewCell";
    
    DetailYiHuoEDuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DetailYiHuoEDuTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    if (indexPath.row +1 == _MJRefreshCon.refreshCount)
    {
        cell.lineLeft.constant = 0;
    }
    
    cell.dataDic = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


- (void)dealloc {
    [_tableview release];
    [_topview release];
    [_topLable release];
    [_lineone release];
    [_linetwo release];
    [_linethree release];
    [_noview release];
    [super dealloc];
}
@end
