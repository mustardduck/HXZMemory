//
//  RankListModelViewController.m
//  miaozhuan
//
//  Created by abyss on 14/10/22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RankListModelViewController.h"
#import "RankListTableViewCell.h"
#import "MJRefreshController.h"
#import "RRAttributedString.h"
#import "ScreeningListVC.h"
#import "CRHolderView.h"
#import "MerchantDetailViewController.h"

@interface RankListModelViewController () <UITableViewDataSource,UITableViewDelegate>
{
    DictionaryWrapper   *_rankDic;
    
    MJRefreshController *_MJRefreshCon;
    DictionaryWrapper *_dic;
    NSArray *_badFaithDic;
    
    BOOL _hasBottem;
    
    NSInteger _his1;
    NSInteger _his2;
}
@property (retain, nonatomic) NSArray * badFaithDic;
@end

@implementation RankListModelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _sectionId = 1;
    }
    return self;
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    InitNav([_topDic getString:@"Name"]);
     _searchView.hidden = YES;
    [self initTopView];
    [self initTableView];
    [self initBottomView];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)initBottomView
{
    _searchBtn.b_color = AppColorLightGray204;
    _searchBtn.h_color = AppColorBackground;
    if (_categregyId/100 == 1)
    {
        ADAPI_adv3_CustomerPosition([self genDelegatorID:@selector(rankResponse:)], _categregyId);
        _his2 = 101;
        _hasBottem = YES;
    }
    else
    {
        _bottmText.hidden = YES;
        _his2 = 202;
    }
}

- (void)rankResponse:(DelegatorArguments *)arg
{
    [arg logError];
    if (arg.ret.operationSucceed)
    {
        _rankDic = arg.ret.data;
        [_rankDic retain];
        [self setBottomPeriod:1];
    }
    else
    {
        [HUDUtil showErrorWithStatus:arg.ret.operationMessage];
    }
}

- (NSString *)getNumbers:(NSString *)originalString
{
    NSMutableString *strippedString = [NSMutableString
                                       stringWithCapacity:originalString.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet
                               characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
            
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    return strippedString;
}

- (void)setBottomPeriod:(int)period
{
    if (!_rankDic) return;
    NSString *rank;
    switch (period) {
        case 1:
        {
            rank = [_rankDic getString:@"TotalRank"];
            break;
        }
        case 2:
        {
            rank = [_rankDic getString:@"MonthRank"];
            break;
        }
        case 3:
        {
            rank = [_rankDic getString:@"WeekRank"];
            break;
        }
            
        default:
            break;
    }
    NSString *numbers = [self getNumbers:rank];
    if (!numbers)
    {
        _bottmText.text = rank;
    }
    else
    {
        NSRange range = [rank rangeOfString:numbers];
        _bottmText.attributedText = [RRAttributedString setText:rank color:AppColorRed range:range];
    }
}

- (void)initTopView
{
    _top.hidden = YES;
    if(_categregyId == 301) _top.hidden = NO;
    [_bt1 setTitle:[_topDic getString:@"TotalRankName"] forState:UIControlStateNormal];
    [_bt2 setTitle:[_topDic getString:@"MonthRankName"] forState:UIControlStateNormal];
    [_bt3 setTitle:[_topDic getString:@"WeekRankName"] forState:UIControlStateNormal];
}

- (void)initTableView
{
    _tableView.top = 41;
    if (_categregyId == 301) _tableView.top = 61;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSString * refreshName = @"Top/GetTopList";
    _MJRefreshCon = [MJRefreshController controllerFrom:_tableView name:refreshName];
    
    __block RankListModelViewController * weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        DictionaryWrapper *dic =  @{@"service":[NSString stringWithFormat:@"%@%@", @"api/", refreshName ],
                                    @"parameters":
                                        @{@"type":[weakself.topDic getString:@"Type"],
                                          @"period":@(weakself.sectionId),
                                          @"date":[NSString stringWithFormat:@"%@",[NSDate date]],
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
                weakself.tableView.hidden = NO;
                if(weakself.categregyId >= 300)
                {
                    weakself.badFaithDic = [[netData getArray:@"Data"] retain];

                }
                weakself.labelShow.hidden = YES;
                [self displayHoder:NO];
                if (_hasBottem) weakself.bottmText.hidden = NO;
            }
            else
            {
                weakself.bottmText.hidden = YES;
                weakself.tableView.hidden = YES;
                weakself.labelShow.hidden = NO;
//                if (weakself.sectionId == 0)
//                {
                    [weakself showHolderDefault];
                    [weakself setHolderDefaultHight:42];
//                }
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

//- (void)badEnterprise:(DelegatorArguments*)arguments
//{
//    [arguments logError];
//    DictionaryWrapper *wrapper = arguments.ret;
//    if (wrapper.operationSucceed)
//    {
//        _badFaithDic = [[wrapper getArray:@"Value"] retain];
//        [_tableView reloadData];
//    }
//}

//- (void)customerPosition:(DelegatorArguments*)arguments
//{
//    [arguments logError];
//    DictionaryWrapper *wrapper = arguments.ret;
//    if (wrapper.operationSucceed)
//    {
//        [_rankDic retain];
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _MJRefreshCon.refreshCount;
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
    
    _dic = [_MJRefreshCon dataAtIndex:indexPath.row];
    if (_dic == nil)
    {
        _dic = ((NSDictionary *)_badFaithDic[indexPath.row]).wrapper;
    }

    //不同榜单适配
    [self fitDifferentList:cell];
    
    if (indexPath.row < 3) cell.rankL.textColor = AppColorRed;
    cell.rankL.text = [NSString stringWithFormat:@"%.2d",[_dic getInteger:@"Rank"]];
    
    [cell.headImg setRoundCorner:11];
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
    
    cell.numL.text = [_dic getString:@"Value"];
    CGFloat left = cell.icon.right;
    if([cell.numL.text hasPrefix:@"￥"] || _categregyId == 301)
    {
        left = cell.headImg.right;
        cell.icon.hidden = YES;
        left += 2;
    }
    cell.numL.left = left + 5;
    
    if (_categregyId/100 == 3) cell.numL.left += 3;
    return cell;
}

- (void)getVipcon:(RankListTableViewCell *)cell vipLevel:(NSInteger)level
{
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
        _top.backgroundColor = AppColorBackground;
    }
    if (_categregyId == 101) cell.icon.image = [UIImage imageNamed:@"rank-04"];
    else if (_categregyId == 102) cell.icon.image = [UIImage imageNamed:@"rank-05"];
    else if (_categregyId == 203) cell.icon.image = [UIImage imageNamed:@"rank-06"];
}

//判断是否是周一
-(BOOL)weekDayWithDate
{
    NSDate *fromdate=[NSDate date];
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    NSDateComponents *weekDayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:fromdate];
    
    NSInteger mDay = [weekDayComponents weekday];
    
    if(mDay == 2) //星期一
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//判断是否是月一
-(BOOL)monthDayWithDate
{
    NSDate*date = [NSDate date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    
    // 年月日获得
    comps =[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit) fromDate:date];
    
    NSInteger day = [comps day];
    
    if(day == 1) //本月第一天
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//点击进入商家详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (_categregyId) {
            
            //粉丝数量榜
        case 101:
            //银元数量榜
        case 102:
            //商品兑换榜
        case 103:
            //赚取现金榜
        case 104:
            return;
            
        default:
            break;
    }
    
    DictionaryWrapper *dic = [_MJRefreshCon dataAtIndex:indexPath.row];
    if (dic == nil)
    {
        dic = ((NSDictionary *)_badFaithDic[indexPath.row]).wrapper;
    }
    
    PUSH_VIEWCONTROLLER(MerchantDetailViewController);
    
    model.enId = [dic getString:@"EnterpriseId"];
    
    model.comefrom = @"0";
    
    dic = nil;
    [dic release];
}


- (void)dealloc
{
    [_badFaithDic release];
    [_rankDic release];
    [_topDic release];
    [_MJRefreshCon release];
    [_tableView release];
    [_top release];
    [_bt1 release];
    [_bt2 release];
    [_bt3 release];
    [_bottmText release];
    [_labelShow release];
    [_searchBtn release];
    [_searchLabel release];
    [_searchView release];
    [_line release];
    CRDEBUG_DEALLOC();
    [super dealloc];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setTop:nil];
    [self setBt1:nil];
    [self setBt2:nil];
    [self setBt3:nil];
    [self setBottmText:nil];
    [self setLabelShow:nil];
    [self setSearchBtn:nil];
    [self setSearchLabel:nil];
    [self setSearchView:nil];
    [super viewDidUnload];
}
- (IBAction)phoneCall:(id)sender
{
    [[UICommon shareInstance] makeCall:kServiceMobile];
}

- (IBAction)topBar:(UIButton *)sender
{
    [self displayHoder:NO];
    if (sender == _bt1)
    {
        [UIView animateWithDuration:0.3 animations:^{
                _line.left = 15;
        }];
        [_bt1 setTitleColor:AppColorRed forState:UIControlStateNormal];
        _bt1.titleLabel.font = Font(17);
        [_bt2 setTitleColor:AppColorBlack43 forState:UIControlStateNormal];
        _bt2.titleLabel.font = Font(14);
        [_bt3 setTitleColor:AppColorBlack43 forState:UIControlStateNormal];
        _bt3.titleLabel.font = Font(14);
        
        [self setBottomPeriod:1];
        _sectionId = 1;
        
        _searchView.hidden = YES;
        
        [self refreshTableView];
    }
    else if (sender == _bt2)
    {
        _his1 = 2;
        [UIView animateWithDuration:0.3 animations:^{
            _line.left = 120;
        }];
        [_bt2 setTitleColor:AppColorRed forState:UIControlStateNormal];
        [_bt1 setTitleColor:AppColorBlack43 forState:UIControlStateNormal];
        [_bt3 setTitleColor:AppColorBlack43 forState:UIControlStateNormal];
        _bt2.titleLabel.font = Font(17);
        _bt1.titleLabel.font = Font(14);
        _bt3.titleLabel.font = Font(14);
        
        [self setBottomPeriod:2];
        _sectionId = 2;
        
        _searchLabel.text = @"每月第一天的榜单需要隔天才能查看";
        
        BOOL month = [self monthDayWithDate];
        if(month)
        {
            _searchView.hidden = NO;
            [_searchBtn setTitle:@"查看上月完整榜单" forState:UIControlStateNormal];
        }
        else
        {
            _searchView.hidden = YES;
            [self refreshTableView];
        }
    
    }
    else if (sender == _bt3)
    {
        _his1 = 3;
        [UIView animateWithDuration:0.3 animations:^{
            _line.left = 225;
        }];
        _bt3.titleLabel.font = Font(17);
        _bt1.titleLabel.font = Font(14);
        _bt2.titleLabel.font = Font(14);
        [_bt3 setTitleColor:AppColorRed forState:UIControlStateNormal];
        [_bt1 setTitleColor:AppColorBlack43 forState:UIControlStateNormal];
        [_bt2 setTitleColor:AppColorBlack43 forState:UIControlStateNormal];
        
        [self setBottomPeriod:3];
        _sectionId = 3;
        
        _searchLabel.text = @"每周一的榜单需要隔天才能查看";
        BOOL week = [self weekDayWithDate];
        if(week)
        {
            _searchView.hidden = NO;
            [_searchBtn setTitle:@"查看上周完整榜单" forState:UIControlStateNormal];
        }
        else
        {
            _searchView.hidden = YES;
            [self refreshTableView];
        }
    }
    [_tableView setContentOffset:CGPointMake(0, 0)];
}

- (IBAction)buttonTouch:(id)sender
{
    PUSH_VIEWCONTROLLER(ScreeningListVC);
    model.dataListArr = _hisData;
    model.period = _his1;
    model.type = _his2;
}
@end
