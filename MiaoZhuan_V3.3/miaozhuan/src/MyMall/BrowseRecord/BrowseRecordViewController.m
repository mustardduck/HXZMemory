//
//  BrowseRecordViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/25.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BrowseRecordViewController.h"
#import "MJRefreshController.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "BrowseRecordTableViewCell.h"
#import "MallHistory.h"
#import "CRDateCounter.h"
#import "CRSliverDetailViewController.h"
#import "Preview_Commodity.h"
#import "ModelSliverDetail.h"
#import "MallScanAdvertMain.h"

@interface BrowseRecordViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    MJRefreshController *_MJRefreshCon;
}
@property (retain, nonatomic) IBOutlet YFJLeftSwipeDeleteTableView *mainTableView;
@property (retain, nonatomic) IBOutlet UIButton *deleteBtn;
- (IBAction)touchUpInside:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *topView;
@property (retain, nonatomic) IBOutlet UIView *otherView;
- (IBAction)otherVIewBtn:(id)sender;

@end

@implementation BrowseRecordViewController

-(void)viewWillAppear:(BOOL)animated
{
    if (MallHistory_Manager.count == 0)
    {
        
    }
    else
    {
        _otherView.hidden = YES;
        
        [_mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _mainTableView.delegate = self;
        
        _mainTableView.dataSource = self;
        
        [_mainTableView reloadData];
    }
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"我的浏览记录");
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MallHistory_Manager.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BrowseRecordTableViewCell";
    
    BrowseRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BrowseRecordTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    MallHistoryWrapper* wrapper = [MallHistory_Manager getAdvertInfoForIndex:indexPath.row];
    
    [cell.cellImages requestCustom:wrapper.img width:cell.cellImages.width height:cell.cellImages.height];
    
    cell.cellTitle.text = wrapper.name;
    
    NSString * time = wrapper.time ? wrapper.time:@" ";
    
    NSDate *today = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter  alloc]  init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *todayTime = [formatter stringFromDate:today];
    
    NSString * celldodaytime = [UICommon formatDate:time];
    
    NSString *endStr = [UICommon format19Time:time];
    NSDate *date = [NSDate dateFromString:endStr];
    
    if ([date timeIntervalSinceNow] > -120)
    {
        time = @"刚刚";
    }
    else if ([celldodaytime isEqualToString:todayTime])
    {
        time = [NSString stringWithFormat:@"今天%@",[UICommon formatDate:time withRange:NSMakeRange(11, 5)]];
    }
    else
    {
        time = [UICommon formatTime:time];
    }
    [formatter release];
    
    cell.cellTime.text = time;
    
    if (wrapper.type == 1)
    {
        cell.cellTypeImage.image = [UIImage imageNamed:@"goodsForYinyuan"];
    }
    else
    {
        cell.cellTypeImage.image = [UIImage imageNamed:@"goodsForGold"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MallHistoryWrapper * wrapper =[MallHistory_Manager getAdvertInfoForIndex:indexPath.row];
    
    if (wrapper.type == 1)
    {
        PUSH_VIEWCONTROLLER(CRSliverDetailViewController);
        model.productId = wrapper.data.sdProductId;
        model.advertId = wrapper.data.sdAdvertId;
    }
    else
    {
        PUSH_VIEWCONTROLLER(Preview_Commodity);
        model.productId = wrapper.data.sdProductId;
        model.whereFrom = 1;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrowseRecordTableViewCell *cell = (BrowseRecordTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrowseRecordTableViewCell *cell = (BrowseRecordTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (IBAction)touchUpInside:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"要清空当前所有记录吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [MallHistory_Manager removeHistoryData];
        [_mainTableView reloadData];
        _otherView.hidden = NO;
    }
}

- (IBAction)otherVIewBtn:(id)sender
{
    for (UIViewController *vc in [DotCUIManager instance].mainNavigationController.viewControllers)
    {
        if ([vc isKindOfClass:[MallScanAdvertMain class]])
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 1;
            
            [((MallScanAdvertMain *)vc) swapPage:button];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_mainTableView release];
    [_deleteBtn release];
    [_topView release];
    [_otherView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setMainTableView:nil];
    [self setDeleteBtn:nil];
    [self setTopView:nil];
    [self setOtherView:nil];
    [super viewDidUnload];
}


@end
