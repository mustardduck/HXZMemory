//
//  SilverListViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SilverListViewController.h"
#import "BaseSilverCell.h"
#import "MJRefreshController.h"
#import "BaserHoverView.h"
#import "RRButton.h"
#import "JSONKit.h"
#import "RRAttributedString.h"
#import "AppPopView.h"
#import "RRLineView.h"
#import "UIView+expanded.h"
@interface SilverListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    __block BOOL _isChoosed;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UILabel *lblSilver;
@property (retain, nonatomic) IBOutlet UILabel *lblDj;
@property (retain, nonatomic) IBOutlet UILabel *lblTime;
@property (retain, nonatomic) IBOutlet UIButton *btnLeft;
@property (retain, nonatomic) IBOutlet UIButton *btnRight;
@property (retain, nonatomic) IBOutlet UIButton *btnChoose;
@property (retain, nonatomic) IBOutlet UILabel *lblLost;

@property (nonatomic, retain) MJRefreshController *MJRefreshCon;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, assign) int type;
@property (nonatomic, retain) AppPopView *appPopView;
@property (nonatomic, retain) UIButton *curButton;
@property (nonatomic, retain) NSMutableArray *dataArray;

@property (retain, nonatomic) IBOutlet UIButton *btnFront;
@property (retain, nonatomic) IBOutlet UIButton *btnMiddle;
@property (retain, nonatomic) IBOutlet UIButton *btnLast;
@property (retain, nonatomic) IBOutlet UIView *shooseView;
@property (retain, nonatomic) IBOutlet UIButton *btnQuestion;

@property (retain, nonatomic) IBOutlet UIImageView *imgIcon;
@property (retain, nonatomic) IBOutlet UILabel *lblTIshi;
@property (retain, nonatomic) IBOutlet UIButton *btnRefresh;
@property (retain, nonatomic) IBOutlet UIView *hoverView;
@property (retain, nonatomic) IBOutlet RRLineView *lineView;

@end

@implementation SilverListViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    NSArray *titles = @[@"粉丝帮我赚的", @"看银元广告赚的", @"系统赠送的", @"消耗的银元", @"流通记录"];
    [self setNavigateTitle:titles[_cellType]];
    
    _lineView.top = 96.5;
    
    [_btnRefresh roundCornerBorder];
    
    _lblTime.text = [self formatDate:[NSDate date]];
    _btnRight.enabled = [self btnEnable];
    
    _lblDj.hidden = _btnQuestion.hidden = (_cellType != 3);
    if (_cellType == 3) {
        _lblDj.hidden = NO;
        _btnQuestion.hidden = NO;
    } else {
        _lblDj.hidden = YES;
        _btnQuestion.hidden = YES;
    }
    
    _lblLost.hidden = (_cellType != 4);
    _btnChoose.hidden = (_cellType != 4 && _cellType != 3);
    if (_cellType == 4) {
        [_btnFront setTitle:@"不限" forState:UIControlStateNormal];
        [_btnMiddle setTitle:@"获赠" forState:UIControlStateNormal];
        [_btnLast setTitle:@"赠送" forState:UIControlStateNormal];
    }
    
    [self setExtraCellLineHidden:_tableView];
    
    [_MJRefreshCon release];
    _MJRefreshCon = nil;
    NSArray *names = @[@"CustomerIntegral/GetCampaignIntegralList", @"CustomerIntegral/GetAdvertIntegralList", @"CustomerIntegral/GetSystemPresentIntegralList", @"CustomerIntegral/GetConsumedIntegralList", @"CustomerIntegral/GetTransferIntegralList"];
    _MJRefreshCon = [[MJRefreshController controllerFrom:_tableView name:names[_cellType]] retain];
    
    [self _initTableView];
}

- (void)_initTableView{
    
    __block typeof(self) weakSelf = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        NSArray *names = @[@"CustomerIntegral/GetCampaignIntegralList", @"CustomerIntegral/GetAdvertIntegralList", @"CustomerIntegral/GetSystemPresentIntegralList", @"CustomerIntegral/GetConsumedIntegralList", @"CustomerIntegral/GetTransferIntegralList"];
        
        NSDictionary * dic =@{@"SearchMonth":weakSelf.day, @"PageIndex":@(pageIndex), @"PageSize":@(pageSize)};
        NSMutableDictionary *pdic = [NSMutableDictionary dictionaryWithDictionary:dic];
        if (weakSelf.cellType == 3 || weakSelf.cellType == 4) {
            [pdic setValue:@(weakSelf.type) forKey:@"Type"];
        }
        
        NSDictionary *pramaDic = @{@"service":[NSString stringWithFormat:@"api/%@",names[weakSelf.cellType]],@"parameters":pdic};
        return pramaDic.wrapper;
    }];
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
    {
        NSLog(@"%@___%d ___",netData.dictionary, netData.operationSucceed);
        if ([netData.data isKindOfClass:[NSNull class]]) {
            return;
        }
        
        if (netData.operationSucceed) {
            if (![netData.data getInt:@"PageIndex"]) {
                
                DictionaryWrapper *dic = [[[netData.data getString:@"ExtraData"] objectFromJSONString] wrapper];
                NSArray *array = @[@"当月赚的 ", @"当月赚的 ", @"当月获赠 ", @"当月消耗 ", @"当月赠送 "];
                NSArray *keys = @[@"MonthTotalIntegral", @"MonthTotalIntegral", @"MonthTotalIntegral", @"MonthTotalIntegral", @"MonthGiftedToIntegral"];
                NSString *str = @"";
                if (!_cellType) {
                    NSString *temp = [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[dic getDouble:keys[weakSelf.cellType]] withAppendStr:nil];
                    str = [NSString stringWithFormat:@"%@ %@银元",array[weakSelf.cellType],temp];
                } else {
                    str = [NSString stringWithFormat:@"%@ %d银元",array[weakSelf.cellType],[dic getInt:keys[weakSelf.cellType]]];
                }
                
                CGSize size = [UICommon getSizeFromString:str
                                                 withSize:CGSizeMake(MAXFLOAT, 21)
                                                 withFont:14];
                weakSelf.lblSilver.width = size.width;
                NSAttributedString *attribute = [RRAttributedString setText:str
                                                                      color:RGBCOLOR(240, 5, 0)
                                                                      range:NSMakeRange(5, str.length - 5)];
                weakSelf.lblSilver.attributedText = attribute;
                
                //是否显示冻结
                weakSelf.lblDj.hidden = weakSelf.cellType != 3;
                if (!weakSelf.lblDj.hidden) {
                    weakSelf.lblDj.hidden = NO;
                    weakSelf.lblDj.left = weakSelf.lblSilver.right;
                    weakSelf.lblDj.text = [NSString stringWithFormat:@"（包含冻结%d银元）",[dic getInt:@"MonthFrozenIntegral"]];
                }
                
                if (weakSelf.cellType == 4) {
                    NSString *str = [NSString stringWithFormat:@"获赠  %d银元", [dic getInt:@"MonthGiftedFromIntegral"]];
                    NSAttributedString *attrStr = [RRAttributedString setText:str color:AppColorRed range:NSMakeRange(3, str.length - 3)];
                    _lblLost.attributedText = attrStr;
                }
                
            }
            
            self.dataArray = [self configDateArray];
            [self.tableView reloadData];
            if(controller.refreshCount > 0)
            {
                weakSelf.hoverView.hidden = YES;
            }
            else
            {
                [weakSelf createHoverViewWhenNoData];
            }

        } else {
            [HUDUtil showErrorWithStatus:netData.operationMessage];
            return;
        }
        
    };
    
    [_MJRefreshCon setOnRequestDone:block];
    [_MJRefreshCon setPageSize:30];
    
    [self refreshTableView];
    
    _tableView.panGestureRecognizer.delaysTouchesBegan = YES;
    [self setExtraCellLineHidden:_tableView];
}

//配置时间并排序
- (NSMutableArray*)configDateArray {
    
    //时间set
    NSMutableSet* dateSet = WEAK_OBJECT(NSMutableSet, init);
    WDictionaryWrapper* dataIndex = WEAK_OBJECT(WDictionaryWrapper, init);
    NSMutableArray* configedArray = WEAK_OBJECT(NSMutableArray, init);
    
    for (NSDictionary *dic in _MJRefreshCon.refreshData) {
        
        DictionaryWrapper *wrapper = dic.wrapper;
        
        //配置元素日期
        NSString *dateStr;
        NSArray *array = [[wrapper getString:@"RecordTime"] componentsSeparatedByString:@"T"];
        if ([array count] == 2) {
            
            dateStr = array[0];
        }
        //配置日期字典
        if ([dateSet containsObject:dateStr]) {
            
            NSMutableArray *multaTempArray = [dataIndex get:dateStr];
            NSArray *resultArray = [multaTempArray arrayByAddingObject:dic];
            [dataIndex set:dateStr value:resultArray];
        }else {
            
            [dateSet addObject:dateStr];
            [dataIndex set:dateStr value:[NSArray arrayWithObject:dic]];
        }
    }
    //配置结果数组
    for (NSString *string in dateSet) {
        
        WDictionaryWrapper *item = WEAK_OBJECT(WDictionaryWrapper, init);
        [item set:@"date" string:string];
        [item set:@"subArray" value:[dataIndex get:string]];
        [configedArray addObject:item.dictionary];
    }
    //原始数组 configedArray
    //排序
    NSSortDescriptor *sorter = WEAK_OBJECT(NSSortDescriptor, initWithKey:@"date" ascending:NO);
    NSMutableArray *sortDescriptors = WEAK_OBJECT(NSMutableArray, initWithObjects:&sorter count:1);
    return [NSMutableArray arrayWithArray:[configedArray sortedArrayUsingDescriptors:sortDescriptors]];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
//无数据hoverview
- (void)createHoverViewWhenNoData{
    _hoverView.hidden = NO;
    NSArray *array = @[@"暂无粉丝帮我赚的银元", @"暂无看广告赚的银元", @"暂无系统赠送的银元", @"暂无消耗的银元", @"暂无流通记录"];
    
    if (_isChoosed && (_cellType == 4 || _cellType == 3)) {
        _btnChoose.hidden = YES;
        _btnRefresh.hidden = NO;
        _lblTIshi.text = @"没有符合条件的记录，请重新筛选";
    } else {
        _lblTIshi.text = array[_cellType];
    }
}
- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_cellType == 1) {
        return 102;
    } else {
        return 80;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 22));
    UILabel *lblTime = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(15, 0, SCREENWIDTH, 22));
    lblTime.font = Font(11);
    lblTime.textColor = AppColorGray153;
    lblTime.text = [[_dataArray[section] wrapper] getString:@"date"];
    [view addSubview:lblTime];
    view.backgroundColor = RGBCOLOR(247, 247, 247);
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[_dataArray[section] wrapper] getArray:@"subArray"].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [[_dataArray[indexPath.section] wrapper] getArray:@"subArray"];
    BaseSilverCell *cell = [BaseSilverCell createCell:_cellType WithData:array[indexPath.row]];
    
    if (_cellType == 1)
    {
        if ([array count] == indexPath.row +1)
        {
            RRLineView * line = [[RRLineView alloc] initWithFrame:CGRectMake(0, 101.5, 320, 0.5)];
            [cell.contentView addSubview:line];
        }
    }
    else
    {
        if ([array count] == indexPath.row +1)
        {
            RRLineView * line = [[RRLineView alloc] initWithFrame:CGRectMake(0, 79.5, 320, 0.5)];
            [cell.contentView addSubview:line];
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - 事件
//获取上个月、下个月
- (NSString *)getMounthWithString:(NSString *)mounth  orDate:(NSDate *)date next:(BOOL)next{
    
    NSDate *curDate = nil;
    NSDateFormatter *formatter = WEAK_OBJECT(NSDateFormatter, init);
    [formatter setDateFormat:@"yyyy年MM月"];
    if (mounth.length) {
        curDate = [formatter dateFromString:mounth];
    } else {
        curDate = date;
    }
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSMonthCalendarUnit | NSYearCalendarUnit fromDate:curDate];
    
    if (next) {
        //下个月
        [components setMonth:([components month] + 1)];
        NSDate *thisMonth = [cal dateFromComponents:components];
        return [formatter stringFromDate:thisMonth];
    } else {
        //上个月
        [components setMonth:([components month] - 1)];
        NSDate *lastMonth = [cal dateFromComponents:components];
        return [formatter stringFromDate:lastMonth];
    }
}

- (BOOL)checkAboveSixMonth:(NSString *)month{
    
    NSString *dateStr=month;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月"];
    NSDate *fromdate=[format dateFromString:dateStr];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    NSLog(@"fromdate=%@",fromDate);
    [format release];
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSLog(@"enddate=%@",localeDate);
    NSDateComponents *components = [gregorian components:unitFlags fromDate:fromDate toDate:localeDate options:0];
    NSInteger months = [components month];
    
    return months >= 6;
}

- (NSDate *)getFirstDay:(NSDate *)date{
    NSDate *now = date;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal
                               components:NSYearCalendarUnit | NSMonthCalendarUnit
                               fromDate:now];
    comps.day = 1;
    NSDate *firstDay = [cal dateFromComponents:comps];
    return firstDay;
}

- (NSString *)formatDate:(NSDate *)date{
    self.day = [UICommon usaulFormatTime:[self getFirstDay:date] formatStyle:@"yyyy-MM-dd hh:mm:ss"];
    NSDateFormatter *formatter = WEAK_OBJECT(NSDateFormatter, init);
    [formatter setDateFormat:@"yyyy年MM月"];
    return [formatter stringFromDate:date];
}

- (NSDate *)formatDataStr:(NSString *)dateStr{
    NSDateFormatter *formatter = WEAK_OBJECT(NSDateFormatter, init);
    [formatter setDateFormat:@"yyyy年MM月"];
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}

//禁用右边button
- (BOOL)btnEnable{
    NSString *dateStr1 = [self getMounthWithString:_lblTime.text orDate:nil next:NO];
    NSString *dateStr2 = [self getMounthWithString:@"" orDate:[NSDate date] next:NO];
    if ([dateStr1 isEqualToString:dateStr2]) {
        return NO;
    }
    return YES;
}

//左
- (IBAction)leftClicked:(id)sender {
    NSString *dateStr = [self getMounthWithString:_lblTime.text orDate:nil next:NO];
    if ([self checkAboveSixMonth:dateStr]) {
        _btnLeft.enabled = NO;
        return;
    }
    _lblTime.text = dateStr;
    _btnRight.enabled = [self btnEnable];
    self.day = [UICommon usaulFormatTime:[self formatDataStr:dateStr] formatStyle:@"yyyy-MM-dd hh:mm:ss"];

    [self _initTableView];
}
//右
- (IBAction)rightClicked:(id)sender {
    _btnLeft.enabled = YES;
    NSString *dateStr = [self getMounthWithString:_lblTime.text orDate:nil next:YES];
    _lblTime.text = dateStr;
    _btnRight.enabled = [self btnEnable];
    self.day = [UICommon usaulFormatTime:[self formatDataStr:dateStr] formatStyle:@"yyyy-MM-dd hh:mm:ss"];

    [self _initTableView];
}
//求助问号
- (IBAction)helpClicked:(id)sender {
    [AlertUtil showAlert:@"" message:@"冻结银元是用于兑换商品时所需消耗的银元。若交易成功，则扣除银元。若撤销订单，则返回到该银元账户中" buttons:@[@"我知道了"]];
}
//重新筛选
- (IBAction)reChooseClicked:(id)sender {
//    [self _initTableView];
    _btnChoose.hidden = NO;
    [self chooseClicked:nil];
}
//筛选
- (IBAction)chooseClicked:(id)sender {
    if (!_appPopView)
    {
        __block typeof(self) weakSelf = self;
        _appPopView = [[AppPopView alloc] initWithAnimateUpOn:self frame:CGRectMake(0, 0, 320, _shooseView.height) left:^{} right:^{
            [_appPopView show:NO];
            _isChoosed = YES;
            [weakSelf _initTableView];
        }];
        [_appPopView.contentView addSubview:_shooseView];
        _appPopView.titleName =@"筛选";
    }
    [_appPopView show:YES];
}
//筛选选项
- (IBAction)itemClicked:(UIButton *)sender {
    _btnFront.selected = _btnMiddle.selected = _btnLast.selected = NO;
    sender.selected = YES;
    if (_cellType == 4) {
        _type = (int)sender.tag;
        if (_type == 1) {
            _type = 2;
        } else if (_type == 2){
            _type = 1;
        }
    } else {
        _type = (int)sender.tag;
    }
}
#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_appPopView release];
    [_MJRefreshCon release];
    [_day release];
    [_tableView release];
    [_lblSilver release];
    [_lblDj release];
    [_lblTime release];
    [_btnLeft release];
    [_btnRight release];
    [_btnFront release];
    [_btnMiddle release];
    [_btnLast release];
    [_shooseView release];
    [_imgIcon release];
    [_lblTIshi release];
    [_btnRefresh release];
    [_hoverView release];
    [_btnChoose release];
    [_btnQuestion release];
    [_lblLost release];
    [_lineView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [self setLblSilver:nil];
    [self setLblDj:nil];
    [self setLblTime:nil];
    [self setBtnLeft:nil];
    [self setBtnRight:nil];
    [self setBtnFront:nil];
    [self setBtnMiddle:nil];
    [self setBtnLast:nil];
    [self setShooseView:nil];
    [self setImgIcon:nil];
    [self setLblTIshi:nil];
    [self setBtnRefresh:nil];
    [self setHoverView:nil];
    [self setBtnChoose:nil];
    [self setBtnQuestion:nil];
    [self setLblLost:nil];
    [self setLineView:nil];
    [super viewDidUnload];
}
@end
