//
//  SilverListViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyYHMListController.h"
#import "BaseMyGoldCell.h"
#import "MJRefreshController.h"
#import "BaserHoverView.h"
#import "RRButton.h"
#import "JSONKit.h"
#import "RRAttributedString.h"
#import "AppPopView.h"
#import "UIView+expanded.h"
#import "RRLineView.h"
#import "IWGoldAdvertTableViewCell.h"
#import "IWExploitTableViewCell.h"
#import "WebhtmlViewController.h"

@interface MyYHMListController ()
{
    __block BOOL _isChoosed;
    
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UILabel *lblSilver;
@property (retain, nonatomic) IBOutlet UILabel *lblDj;
@property (retain, nonatomic) IBOutlet UILabel *lblTime;
@property (retain, nonatomic) IBOutlet UIButton *btnLeft;
@property (retain, nonatomic) IBOutlet UIButton *btnRight;
@property (retain, nonatomic) IBOutlet UIButton *btnChoose;

@property (nonatomic, retain) MJRefreshController *MJRefreshCon;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, assign) int type;
@property (nonatomic, retain) NSString * orderNumber;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) AppPopView *appPopView;
@property (nonatomic, retain) UIButton *curButton;
@property (nonatomic, retain) NSMutableArray *dataArray;


@property (retain, nonatomic) IBOutlet UIView *shooseView;

@property (retain, nonatomic) IBOutlet UIImageView *imgIcon;
@property (retain, nonatomic) IBOutlet UILabel *lblTIshi;
@property (retain, nonatomic) IBOutlet RRButton *btnRefresh;
@property (retain, nonatomic) IBOutlet UIView *hoverView;
@property (retain, nonatomic) IBOutlet UIButton *helpBtn;
@property (retain, nonatomic) IBOutlet UITextField *orderNumField;
@property (retain, nonatomic) IBOutlet UITextField *phoneNumField;
@property (retain, nonatomic) IBOutlet RRLineView *line;
@property (retain, nonatomic) IBOutlet UIView *topView;
@property (retain, nonatomic) IBOutlet UIImageView *topImg;

@end

@implementation MyYHMListController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupMoveBackButton];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"IWExploitTableViewCell" bundle:nil] forCellReuseIdentifier:@"IWExploitTableViewCell"];
//    [self.tableView registerNib:[UINib nibWithNibName:@"IWGoldAdvertTableViewCell" bundle:nil] forCellReuseIdentifier:@"IWGoldAdvertTableViewCell"];
    
    _line.top = 111.5;
    
    NSArray *titles = @[@"兑换获得的", @"易货消耗的", @"易货商城货款", @"其他收支"] ;
    [self setNavigateTitle:titles[_cellType - 13]];
    
    [_btnRefresh roundCornerBorder];
    
    _lblTime.text = [self formatDate:[NSDate date]];
    _btnRight.enabled = [self btnEnable];
    
    if ([[UIScreen mainScreen] bounds].size.height < 568)
    {
        _btnChoose.frame = CGRectMake(260, 361, 45, 45);
    }
    
    if (_cellType == YHHK_YHM)
    {
        _btnChoose.hidden = NO;
    }
    
    
    [self setExtraCellLineHidden:_tableView];
    
    [_MJRefreshCon release];
    _MJRefreshCon = nil;
    
    NSArray *names = @[@"BarterCode/ExchangeList", @"BarterCode/BuyProductList", @"BarterCode/SellProductList", @"BarterCode/GetOtherBalance"];
    
    _MJRefreshCon = [[MJRefreshController controllerFrom:_tableView name:names[_cellType - 13]] retain];
    
    NSArray *array = @[@"当月获得 ", @"当月消耗 ", @"当月货款 ", @"当月收支 "];
    
    NSString * str = [NSString stringWithFormat:@"%@0.00 易货码",array[_cellType - 13]];
    
    CGSize size = [UICommon getSizeFromString:str
                                     withSize:CGSizeMake(MAXFLOAT, 21)
                                     withFont:14];
    _lblSilver.width = size.width;
    NSAttributedString *attribute = [RRAttributedString setText:str
                                                          color:RGBCOLOR(240, 5, 0)
                                                          range:NSMakeRange(5, str.length - 5)];
    _lblSilver.attributedText = attribute;
    
    //是否显示冻结
    _lblDj.hidden = (_cellType == YHHK_YHM || _cellType == DHHD_YHM || _cellType == QT_YHM);
    
    if(_cellType == YHXH_YHM)
    {
        _lblDj.text = @"包含冻结 0.00 易货码";
        
    }
    
    [self _initTableView];
    
}

#pragma mark -- 说明
- (void)onMoveFoward:(UIButton*) sender{
    //    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    WebhtmlViewController *vc = [[WebhtmlViewController alloc] initWithNibName:NSStringFromClass([WebhtmlViewController class]) bundle:nil];
//    vc.ContentCode = @"34c0f9753f828f78202512c70eed503f";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_initTableView{
    
    [self createHoverViewWhenNoData];
    
    __block typeof(self) weakSelf = self;
    
    //0.兑换获得的 1.易货消耗的 2.易货商城货款
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        NSArray *names = @[@"BarterCode/ExchangeList", @"BarterCode/BuyProductList", @"BarterCode/SellProductList", @"BarterCode/GetOtherBalance"];
        
        NSDictionary * dic =@{@"SearchMonth":weakSelf.day, @"PageIndex":@(pageIndex), @"PageSize":@(pageSize)};
        NSMutableDictionary *pdic = [NSMutableDictionary dictionaryWithDictionary:dic];
        if (_cellType == YHHK_YHM)
        {
            [pdic setValue:weakSelf.orderNumber forKey:@"OrderNumber"];
            
            [pdic setValue:weakSelf.userName forKey:@"UserName"];
            
        }
        
        NSDictionary *pramaDic = @{@"service":[NSString stringWithFormat:@"api/%@",names[weakSelf.cellType - 13]],@"parameters":pdic};
        return pramaDic.wrapper;
    }];
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
    {
        if(netData.operationSucceed)
        {
            NSLog(@"%@___%d ___",netData.dictionary, netData.operationSucceed);
            DictionaryWrapper *dic = [[[netData.data getString:@"ExtraData"] objectFromJSONString] wrapper];
            NSArray *array = @[@"当月获得 ", @"当月消耗 ", @"当月货款 ", @"当月收支 ", ];
            
            NSString *str = @"";
            
            double monthTotalGold = [dic getDouble:@"TotalBarterCode"];
            
            if(monthTotalGold != 0)
            {
                str = [NSString stringWithFormat:@"%@%0.2f 易货码",array[_cellType - 13],monthTotalGold];
                
                CGSize size = [UICommon getSizeFromString:str
                                                 withSize:CGSizeMake(MAXFLOAT, 21)
                                                 withFont:14];
                _lblSilver.width = size.width;
                NSAttributedString *attribute = [RRAttributedString setText:str
                                                                      color:RGBCOLOR(240, 5, 0)
                                                                      range:NSMakeRange(5, str.length - 5)];
                _lblSilver.attributedText = attribute;
            }
            
            //是否显示冻结
            _lblDj.hidden = (_cellType == YHHK_YHM || _cellType == DHHD_YHM || _cellType == QT_YHM);
            if (!_lblDj.hidden) {
                if(_cellType == YHXH_YHM)
                {
                    _helpBtn.hidden = NO;
                    
                    double frozenGold = [dic getDouble:@"TotalBarterCodeFrozen"];
                    
                    if(frozenGold != 0)
                    {
                        _lblDj.text = [NSString stringWithFormat:@"包含冻结 %0.2f 易货码", frozenGold];
                    }
                }
            }
            else
            {
                _topView.height = 97;
                _topImg.height = 97;
                _line.top = 96.5;
                _tableView.top = 97;
                _hoverView.top = 97;
                
            }
            self.dataArray = [self configDateArray];
            [self.tableView reloadData];
            
            if(controller.refreshCount > 0)
            {
                _hoverView.hidden = YES;
                
//                if(_cellType == YHHK_YHM)
//                {
//                    _btnChoose.hidden = NO;
//                }
            }
            else
            {
                [weakSelf createHoverViewWhenNoData];
            }
        }
    };
    
    [_MJRefreshCon setOnRequestDone:block];
    [_MJRefreshCon setPageSize:50];
    
    [self refreshTableView];
    
    _tableView.panGestureRecognizer.delaysTouchesBegan = YES;
    [self setExtraCellLineHidden:_tableView];
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
    
//    _btnChoose.hidden = NO;
    _btnRefresh.hidden = !_isChoosed;
    if(_isChoosed && _cellType == YHHK_YHM)
    {
        _lblTIshi.text = @"没有符合条件的记录，请重新筛选";
        
        _imgIcon.image = [UIImage imageNamed:@"hold_1.png"];
    }
    else
    {
        NSArray *array = @[@"暂无兑换获得的易货码", @"暂无易货消耗的易货码", @"暂无易货商城的货款", @"暂无其他收支"];
        _lblTIshi.text = array[_cellType - 13];
        _imgIcon.image = [UIImage imageNamed:@"YHMicon"];
    }
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
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
    NSSortDescriptor *sorter = WEAK_OBJECT(NSSortDescriptor, initWithKey:@"date" ascending:NO);//yes升序  no降序
    NSMutableArray *sortDescriptors = WEAK_OBJECT(NSMutableArray, initWithObjects:&sorter count:1);
    return [NSMutableArray arrayWithArray:[configedArray sortedArrayUsingDescriptors:sortDescriptors]];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_cellType == YHHK_YHM)
    {
        return 106;
    }
    else {
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
    lblTime.backgroundColor = [UIColor clearColor];
    [view addSubview:lblTime];
    view.backgroundColor = AppColor(247);
    
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
    
    BaseMyGoldCell *cell = [BaseMyGoldCell createCell:_cellType WithData:array[indexPath.row]];
    
    if (_cellType == YHHK_YHM)
    {
        if ([array count] == indexPath.row +1)
        {
            RRLineView * line = [[RRLineView alloc] initWithFrame:CGRectMake(0, 105.5, 320, 0.5)];
            [cell.contentView addSubview:line];
        }
    }
    else {
        if ([array count] == indexPath.row +1)
        {
            RRLineView * line = [[RRLineView alloc] initWithFrame:CGRectMake(0, 79.5, 320, 0.5)];
            [cell.contentView addSubview:line];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    [self clearMoneyCount];
    
    _type = 0;
    _orderNumber = @"";
    _userName = @"";
    [self _initTableView];
    _isChoosed = NO;
}

- (void) clearMoneyCount
{
    NSArray *array = @[@"当月获得 ", @"当月消耗 ", @"当月货款 ", @"当月收支 "];
    NSString *str = [NSString stringWithFormat:@"%@0.00 易货码",array[_cellType - 13]];
    
    CGSize size = [UICommon getSizeFromString:str
                                     withSize:CGSizeMake(MAXFLOAT, 21)
                                     withFont:14];
    _lblSilver.width = size.width;
    NSAttributedString *attribute = [RRAttributedString setText:str
                                                          color:RGBCOLOR(240, 5, 0)
                                                          range:NSMakeRange(5, str.length - 5)];
    _lblSilver.attributedText = attribute;
    
    //是否显示冻结
    _lblDj.hidden = (_cellType == YHHK_YHM || _cellType == DHHD_YHM || _cellType == QT_YHM);
    if (!_lblDj.hidden) {
        if(_cellType == YHXH_YHM)
        {
            _helpBtn.hidden = NO;
            
            _lblDj.text = @"包含冻结 0.00 易货码";
        }
    }
}

//右
- (IBAction)rightClicked:(id)sender {
    _btnLeft.enabled = YES;
    NSString *dateStr = [self getMounthWithString:_lblTime.text orDate:nil next:YES];
    _lblTime.text = dateStr;
    _btnRight.enabled = [self btnEnable];
    self.day = [UICommon usaulFormatTime:[self formatDataStr:dateStr] formatStyle:@"yyyy-MM-dd hh:mm:ss"];
    
    [self clearMoneyCount];
    
    _type = 0;
    
    _orderNumber = @"";
    _userName = @"";
    [self _initTableView];
    _isChoosed = NO;
}
//求助问号
- (IBAction)helpClicked:(id)sender {
    if(_cellType == YHXH_YHM)
        [AlertUtil showAlert:@"" message:@"冻结易货码是用于兑换商品时所需消耗的易货码。若交易成功，则扣除易货码。若申请退货，则退回到该易货码账户中。" buttons:@[@"我知道了"]];
}
//重新筛选
- (IBAction)reChooseClicked:(id)sender {
//    _btnChoose.hidden = NO;
    [self chooseClicked:nil];
}
//筛选
- (IBAction)chooseClicked:(id)sender {
    if (!_appPopView)
    {
        __block typeof(self) weakSelf = self;
        _appPopView = [[AppPopView alloc] initWithAnimateUpOn:self frame:CGRectMake(0, 0, 320, _shooseView.height) left:^{} right:^{
            
            [weakSelf filterOkBtn];
            [_appPopView show:NO];
            _isChoosed = YES;
            [weakSelf _initTableView];
        }];
        [_appPopView.contentView addSubview:_shooseView];
        _appPopView.titleName = @"筛选";
    }
    [_appPopView show:YES];
}

//筛选完成
- (void) filterOkBtn
{
    self.orderNumber = _orderNumField.text;
    
    self.userName = _phoneNumField.text;
}

//筛选选项
- (IBAction)itemClicked:(UIButton *)sender {

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
    
    [_shooseView release];
    [_imgIcon release];
    [_lblTIshi release];
    [_btnRefresh release];
    [_hoverView release];
    [_btnChoose release];
    [_helpBtn release];
    [_orderNumField release];
    [_phoneNumField release];
    [_line release];
    [_topView release];
    [_topImg release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [self setLblSilver:nil];
    [self setLblDj:nil];
    [self setLblTime:nil];
    [self setBtnLeft:nil];
    [self setBtnRight:nil];
    
    [self setShooseView:nil];
    [self setImgIcon:nil];
    [self setLblTIshi:nil];
    [self setBtnRefresh:nil];
    [self setHoverView:nil];
    [self setBtnChoose:nil];
    [super viewDidUnload];
}
@end
