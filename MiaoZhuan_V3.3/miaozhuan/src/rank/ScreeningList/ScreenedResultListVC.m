//
//  ScreenedResultListVC.m
//  guanggaoban
//
//  Created by CQXianMai on 14-8-10.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import "ScreenedResultListVC.h"
//#import "FansCountListCell.h"
//#import "ScreenResListCell.h"
//#import "LoginManager.h"
#import "RankListTableViewCell.h"
#import "UIView+expanded.h"
#import "MJRefreshController.h"
#import "CRHolderView.h"

@interface ScreenedResultListVC ()
{
    MJRefreshController *_MJRefreshCon;
    
    NSInteger _nameType;
    NSInteger _timeType;
    NSString *_markDate;
    
    DictionaryWrapper *_dic;
    NSInteger _categregyId;
    NSInteger _type;
}
@end

@implementation ScreenedResultListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNavItem];
    
    _type           = [self.searchDic.wrapper getInt:@"period"];
    _categregyId    =  [self.searchDic.wrapper getInt:@"type"];
    
    _markDate   = [[_searchDic valueForKey:@"startDay"] retain];
    _nameType   = [[_searchDic valueForKey:@"type"] integerValue];
    _timeType   = [[_searchDic valueForKey:@"period"] integerValue];
    
    _selectResultList.tableHeaderView = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 320, 30));
    [self layoutView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [_MJRefreshCon release];
    _MJRefreshCon = nil;
    [_markDate release];
    _markDate = nil;
    [_searchDic release];
    _searchDic = nil;
    
    [_rankInfoLbl release];
    [_selectResultList release];
    [_noDataLbl release];
    [super dealloc];
}

- (void)initNavItem
{
    [self setNavigateTitle:@"历史榜单"];
    [self setupMoveBackButton];
}

- (void)layoutView
{
    self.rankInfoLbl.text = _rankInfoStr;
    self.noDataLbl.hidden = YES;
    
    NSString * refreshName = @"Top/GetTopList";
    _MJRefreshCon = [MJRefreshController controllerFrom:_selectResultList name:refreshName];
    
    __block ScreenedResultListVC * weakself = self;
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        DictionaryWrapper *dic =  @{@"service":[NSString stringWithFormat:@"%@%@", @"api/", refreshName ],
                                    @"parameters":
                                        @{@"type":[weakself.searchDic.wrapper getString:@"type"],
                                          @"period":@(_type == 1?_type = 2:_type),
                                          @"date":[weakself.searchDic.wrapper getString:@"startDay"],
                                          @"pageIndex":@(pageIndex),
                                          @"pageSize":@(pageSize)}}.wrapper;
        NSLog(@"%@",dic.dictionary);
        return dic;
    }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            NSLog(@"%@",netData.dictionary);
            if(controller.refreshCount > 0)
            {
                weakself.selectResultList.hidden = NO;
                [self displayHoder:NO];
            }
            else
            {
                CRHolderFast_MJ_Default();
                [self setHolderDefaultHight:30];
                weakself.selectResultList.hidden = YES;
            }
        };
        
        
        
        [_MJRefreshCon setOnRequestDone:block];
        [_MJRefreshCon setPageSize:50];
        [_MJRefreshCon retain];
    }
    
    [self refreshTableView];
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MJRefreshCon.refreshCount;
}

//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = AppColor(220);
//    return YES;
//}
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor whiteColor];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"RankListTableViewCell";
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    RankListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RankListTableViewCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    _dic = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
    
    //不同榜单适配
    [self fitDifferentList:cell];
    
    if (indexPath.row < 3) cell.rankL.textColor = AppColorRed;
    cell.rankL.text = [NSString stringWithFormat:@"%.2d",(int)[_dic getInteger:@"Rank"]];
    
    [cell.headImg setRoundCorner:11.f];
//    [cell.headImg setBorderWithColor:AppColor(220)];
//    [cell.headImg requestIcon:[_dic getString:@"PictureUrl"]];
    [cell.headImg requestPic:[_dic getString:@"PictureUrl"] placeHolder:NO];
    
    NSString * name = [_dic getString:@"Title"];
    if(name.length > 5)
    {
        if (_categregyId/100 > 1 && name.length > 12)
        {
            name = [name substringToIndex:11];
            name = [name stringByAppendingString:@"..."];
        }
        else if(_categregyId/100 == 1) name = [name substringToIndex:5];
    }
    
    cell.titleL.text = name;
    
    NSString *tmp = [UICommon hidePhoneText:[_dic getString:@"Phone"]];
    cell.phoneL.text = [NSString stringWithFormat:@"(%@)",tmp];
    if (tmp == nil) cell.phoneL.text = @"";
    cell.phoneL.left = AppGetTextWidth(cell.titleL) + 4;
    cell.vipIcon.left = AppGetTextWidth(cell.phoneL) + 2;
    
    [self getVipcon:(RankListTableViewCell *)cell vipLevel:[_dic getInt:@"VipLevel"]];
//    if (_categregyId/100 == 3) cell.vipIcon.left = AppGetTextWidth(cell.titleL) + 4;
//    
    cell.numL.text = [_dic getString:@"Value"];
    CGFloat left = cell.icon.right;
    if([cell.numL.text hasPrefix:@"￥"] || _categregyId == 301)
    {
        left = cell.headImg.right;
        cell.icon.hidden = YES;
        left += 2;
    }
    cell.numL.left = left + 5;
    return cell;
}

- (void)getVipcon:(RankListTableViewCell *)cell vipLevel:(NSInteger)level
{
//    if (_categregyId == 301 || _categregyId == 203)
//    {
//        cell.vipIcon.image = level == 0?[UIImage imageNamed:@"fatopvip"]:[UIImage imageNamed:@"fatopviphover"];
//        cell.vipIcon.width = cell.vipIcon.height;
//    }
//    else
//    {
//        NSString *vipName = [NSString stringWithFormat:@"VIP%d",level];
//        cell.vipIcon.image = [UIImage imageNamed:vipName];
//        cell.vipIcon.width = 2 * cell.vipIcon.height;
//    }
    
    if (_categregyId /100 > 1)
    {
        cell.vipIcon.image = level == 0?[UIImage imageNamed:@"fatopvip"]:[UIImage imageNamed:@"fatopviphover"];
        cell.vipIcon.width = cell.vipIcon.height;
        cell.titleL.textColor = level == 0?AppColor(43):AppColorRed;
        cell.phoneL.hidden = YES;
        cell.vipIcon.left = AppGetTextWidth(cell.titleL) + 2;
        //        if (_categregyId == 301)  cell.numL.font = Font(15);
    }
    else
    {
        NSString *vipName = [NSString stringWithFormat:@"VIP%d",level];
        cell.vipIcon.image = [UIImage imageNamed:vipName];
        cell.vipIcon.width = 2 * cell.vipIcon.height;
    }
}

- (void)fitDifferentList:(RankListTableViewCell *)cell
{
    if (_categregyId/100 == 3)
    {
//        _top.backgroundColor = AppColorBackground;
//        cell.phoneL.hidden = YES;
//        cell.vipIcon.left = AppGetTextWidth(cell.titleL) + 10;
//        cell.numL.font = Font(15);
    }
    if (_categregyId == 101) cell.icon.image = [UIImage imageNamed:@"rank-04"];
    else if (_categregyId == 102) cell.icon.image = [UIImage imageNamed:@"rank-05"];
    else if (_categregyId == 203) cell.icon.image = [UIImage imageNamed:@"rank-06"];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
