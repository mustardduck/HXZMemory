//
//  FansHelpViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 15-3-11.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "FansHelpViewController.h"
#import "Share_Method.h"
#import "FansListCell.h"
#import "LevelsCell.h"
#import "UserInfo.h"
#import "PhoneAuthenticationViewController.h"
#import "FansHelpRecordsViewController.h"
#import "ThankfulFruitViewController.h"
#import "MJRefreshController.h"
#import "JSONKit.h"
#import "RRAttributedString.h"
#import "UI_PickerView.h"

@interface FansHelpViewController ()<UITableViewDataSource, UITableViewDelegate, UI_PickViewDelegate>
{
    NSArray *dataArray;
    NSString *startTime;
    NSString *endTime;
    UI_PickerView *picker;
    BOOL isStart;
    BOOL isSearch;
}
@property (retain, nonatomic) IBOutlet RRLineView *line_s;
@property (retain, nonatomic) IBOutlet UILabel *lblTishi;
@property (retain, nonatomic) IBOutlet UIView *searchView;

@property (retain, nonatomic) IBOutlet UILabel *lblFansNum;
@property (retain, nonatomic) IBOutlet UILabel *ownSliverNum;
@property (retain, nonatomic) IBOutlet UILabel *loseSilverNum;
@property (retain, nonatomic) IBOutlet UIView *fansView;
@property (retain, nonatomic) IBOutlet UITableView *fansLevelTable;

@property (retain, nonatomic) IBOutlet UIView *noFansView;

@property (retain, nonatomic) IBOutlet UIView *recordView;
@property (retain, nonatomic) IBOutlet UIView *noRecordView;
@property (retain, nonatomic) IBOutlet UIButton *btnLeft;
@property (retain, nonatomic) IBOutlet UILabel *lblTime;
@property (retain, nonatomic) IBOutlet UILabel *lblSilverNum;
@property (retain, nonatomic) IBOutlet UIButton *btnRight;
@property (retain, nonatomic) IBOutlet UITableView *tableview;

@property (retain, nonatomic) IBOutlet UIButton *btnSilverTotal;
@property (retain, nonatomic) IBOutlet UIButton *btnSIlverDetail;
@property (retain, nonatomic) IBOutlet UIView *redLine;

@property (retain, nonatomic) IBOutlet UIView *unlockView;
@property (retain, nonatomic) IBOutlet UILabel *lblNotice;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) IBOutlet UIView *alertView;
@property (retain, nonatomic) IBOutlet UIButton *btnShare;
@property (retain, nonatomic) IBOutlet RRLineView *imgTotalLine;

@property (retain, nonatomic) IBOutlet UIButton *btnStartTime;
@property (retain, nonatomic) IBOutlet UIButton *btnEndTime;
@property (retain, nonatomic) IBOutlet UIButton *btnClear;
@property (retain, nonatomic) IBOutlet UIButton *btnSearch;


@property (nonatomic, retain) NSArray *fansArray;
@property (nonatomic, retain) MJRefreshController *MJRefreshCon;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, assign) int currentUnlockLevel;

@end

@implementation FansHelpViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (picker) {
        [picker remove];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigateTitle:@"粉丝帮我赚的"];
    [self setupMoveBackButton];
    
    _lblTime.text = [self formatDate:[NSDate date]];
    _btnRight.enabled = [self btnEnable];
    
    _btnClear.hidden = YES;
    [self setBtnTitleColor:RGBCOLOR(204, 204, 204)];
    
    _fansLevelTable.panGestureRecognizer.delaysTouchesBegan = YES;
    _scrollview.panGestureRecognizer.delaysTouchesBegan = YES;
    
    _imgTotalLine.top = 39.5;
    
    //粉丝等级
    [self loadData];
    
    if (![UICommon getIos4OffsetY]) {
        [_scrollview setContentSize:CGSizeMake(SCREENWIDTH, SCREENHEIGHT + 230)];
    } else {
        [_scrollview setContentSize:CGSizeMake(SCREENWIDTH, SCREENHEIGHT + 50)];
    }
    
    [_MJRefreshCon release];
    _MJRefreshCon = nil;
    _MJRefreshCon = [[MJRefreshController controllerFrom:_tableview name:@"CustomerIntegral/GetCampaignIntegralList"] retain];
    
    [self initTableView];
    
    if (!USER_MANAGER.IsPhoneVerified) {
        self.noFansView.hidden = NO;
    }
    
    [_btnShare setRoundCorner];
    
    [_searchView setRoundCorner:5];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)initTableView
{
    NSString * refreshName = @"CustomerIntegral/GetCampaignIntegralList";
    __block __typeof(self)weakself = self;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"service":[NSString stringWithFormat:@"%@%@", @"api/", refreshName]}];
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        self.day = self.day.length ? self.day : @"";
        [dic setValue:@{@"PageIndex":@(pageIndex), @"PageSize":@(pageSize), @"SearchMonth":self.day} forKey:@"parameters"];
        return dic.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
    {
        NSLog(@"%@",netData);
        if(netData.data)
        {
            if (![netData.data getInt:@"PageIndex"]) {
            
                DictionaryWrapper *dic = [[[netData.data getString:@"ExtraData"] objectFromJSONString] wrapper];
                NSString *temp = [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[dic getDouble:@"MonthTotalIntegral"] withAppendStr:nil];
                NSString *str = [NSString stringWithFormat:@"当月赚的 %@银元" ,temp];
                
                NSAttributedString *attribute = [RRAttributedString setText:str
                                                                      color:RGBCOLOR(240, 5, 0)
                                                                      range:NSMakeRange(5, str.length - 5)];
                weakself.lblSilverNum.attributedText = attribute;
            }
            
            if (![[netData.data getArray:@"PageData"] count]) {
                [weakself.noRecordView setHidden:NO];
            } else {
                [weakself.noRecordView setHidden:YES];
            }
            
            dataArray = [[weakself configDateArray] retain];
            [weakself.tableview reloadData];
            
        }
        else
        {
            [weakself.noRecordView setHidden:NO];
        }
    };
    
    [_MJRefreshCon setOnRequestDone:block];
    [_MJRefreshCon setPageSize:30];
    
    [self refreshTableView];
    
}
- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

- (void)loadData{
    
    NSString *sTime = [_btnStartTime titleForState:UIControlStateNormal];
    sTime = [sTime isEqualToString:@"开始时间"] ? @"" : sTime;
    
    NSString *eTime = [_btnEndTime titleForState:UIControlStateNormal];
    eTime = [eTime isEqualToString:@"结束时间"] ? @"" : eTime;
    
    if (sTime.length && !eTime.length) {
        
        NSDate *date = [[NSDate date] dateByAddingTimeInterval:-(60*60*24)];
        NSString *dateS = [UICommon usaulFormatTime:date formatStyle:@"yyyy-MM-dd"];
        eTime = endTime = dateS;
        [_btnEndTime setTitle:eTime forState:UIControlStateNormal];
        [_btnEndTime setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
    }
    
    if (!sTime.length && eTime.length) {
        
        NSDate *date = [[NSDate date] dateByAddingTimeInterval:-90 * (60*60*24)];
        NSString *dateS = [UICommon usaulFormatTime:date formatStyle:@"yyyy-MM-dd"];
        sTime = startTime = dateS;
        [_btnStartTime setTitle:sTime forState:UIControlStateNormal];
        [_btnStartTime setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
    }
    
    ADAPI_MemberCampaign_Summary([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSummary:)], @"1", sTime, eTime);
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

#pragma mark - UITableViewDelegate/UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    BOOL flag = [tableView isEqual:_tableview];
    if (flag) {
        return 22;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 22));
    UILabel *lblTime = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(15, 0, SCREENWIDTH, 22));
    lblTime.font = Font(11);
    lblTime.textColor = AppColorGray153;
    lblTime.text = [[dataArray[section] wrapper] getString:@"date"];
    [view addSubview:lblTime];
    view.backgroundColor = RGBCOLOR(247, 247, 247);
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    BOOL flag = [tableView isEqual:_tableview];
    if (flag) {
        return dataArray.count;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL flag = [tableView isEqual:_tableview];
    if (flag) {
        return 80;
    } else {
        return 45;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    BOOL flag = [tableView isEqual:_tableview];
    if (flag) {
        return [[[dataArray[section] wrapper] getArray:@"subArray"] count];
    } else {
        return _fansArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier;
    BOOL flag = [tableView isEqual:_tableview];
    identifier = flag ? @"tableview" : @"fansTable";
    
    if (flag) {
        
        FansListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FansListCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            RRLineView * line = [[RRLineView alloc] initWithFrame:CGRectMake(0, 79.5, 320, 0.5)];
            [cell.contentView addSubview:line];
        }
        
        NSArray *temp = [[dataArray[indexPath.section] wrapper] getArray:@"subArray"];
        cell.dataDic = [temp[indexPath.row] dictionary];
        
        return cell;
    } else {
        
        LevelsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LevelsCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.lineView.top = 44.5;
        if (indexPath.row == 5) {
            cell.lineView.left = 0;
            cell.lineView.width = SCREENWIDTH;
        } else {
            cell.lineView.left = 15;
            cell.lineView.width = SCREENWIDTH - 15;
        }
        
        cell.btnUnlock.tag = indexPath.row + 1;
        [cell.btnUnlock addTarget:self action:@selector(unlockClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.dataDic = [_fansArray[indexPath.row] wrapper];
        
        BOOL flag = [[_fansArray[indexPath.row] wrapper] getBool:@"IsUnLocked"];
        if (flag) {
            _currentUnlockLevel = indexPath.row + 1;
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
    return view;
}

#pragma mark - actions
//请求回调
- (void)handleSummary:(DelegatorArguments *)arguments {
    DictionaryWrapper *ret = [arguments ret];
    if (ret.operationSucceed) {
    
        //判断有无粉丝
        self.fansArray = [ret.data getArray:@"Details"];
        if (!self.fansArray.count) {
            [_noFansView setHidden:NO];
            _fansView.hidden = YES;
            return;
        }
        
        if ((startTime.length && endTime.length) || (!startTime.length && !endTime.length)) {
            NSString *str = startTime.length ? @"你直接发展的粉丝构成了第一层，他们再发展的粉丝构成了其他层，累积截至%@至%@统计如下:" : @"你直接发展的粉丝构成了第一层，他们再发展的粉丝构成了其他层，累积截至昨日统计如下:";
            
            if (startTime.length) {
                
                str = [NSString stringWithFormat:str,startTime, endTime];
            }
            
            _lblTishi.text = str;
            
            CGSize size = [UICommon getSizeFromString:str withSize:CGSizeMake(290, MAXFLOAT) withFont:14];
            _lblTishi.height = size.height;
            
            _line_s.top = _fansLevelTable.top = _lblTishi.bottom + 10;
            _ownSliverNum.top = _fansLevelTable.bottom + 13;
            _loseSilverNum.top = _ownSliverNum.bottom + 3;
            
            if (![UICommon getIos4OffsetY]) {
                [_scrollview setContentSize:CGSizeMake(SCREENWIDTH, SCREENHEIGHT + (startTime.length ? 250 : 230))];
            } else {
                [_scrollview setContentSize:CGSizeMake(SCREENWIDTH, SCREENHEIGHT + (startTime.length ? 70 : 50))];
            }
            
        }
        
        if (!isSearch) {
            _lblFansNum.text = [NSString stringWithFormat:@"%@个", [[self.fansArray[0] wrapper] getString:@"FansCount"]];
        }
        
        NSString *total = [NSString stringWithFormat:@"已获得银元总数：%.2f", [ret.data getDouble:@"EarnByFans"]];
        NSAttributedString *totalAttStr = [RRAttributedString setText:total color:AppColor(34) range:NSMakeRange(8, total.length - 8)];
        _ownSliverNum.attributedText = totalAttStr;
        
        NSString *lose = [NSString stringWithFormat:@"已损失银元总数：%.2f", [ret.data getDouble:@"Miss"]];
        NSAttributedString *loseAttStr = [RRAttributedString setText:lose color:AppColor(34) range:NSMakeRange(8, lose.length - 8)];
        _loseSilverNum.attributedText = loseAttStr;
        
        [self.fansLevelTable reloadData];
        
    } else if (ret.code == 32061) {
        
        self.noFansView.hidden = NO;
        return;

        
    } else if (ret.code == 32062) {
        //无粉丝
        self.noFansView.hidden = NO;
        return;
    }
}
//粉丝详情
- (IBAction)fansListClicked:(id)sender {
    PUSH_VIEWCONTROLLER(FansHelpRecordsViewController);
}
//分享
- (IBAction)shareClicked:(id)sender {
    
    //判断是否进行了手机认证
    if (!USER_MANAGER.IsPhoneVerified) {
        [AlertUtil showAlert:@"" message:@"您尚未通过手机认证，暂时无法分享" buttons:@[
                                                                       @{
                                                                           @"title":@"去认证",
                                                                           @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                                                           ({
            PUSH_VIEWCONTROLLER(PhoneAuthenticationViewController);
        })
                                                                           },@"取消"
                                                                       
                                                                       ]];
        return;
    }
    
    [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"b48f4584ef5fb324cf5c4a803ed8e575"}];
}
//银元总计。银元明细
- (IBAction)menuClicked:(UIButton *)sender {
    
    _btnSIlverDetail.selected = _btnSilverTotal.selected = NO;
    sender.selected = YES;
    
    BOOL flag = [sender isEqual:_btnSilverTotal];
    float x = flag ? 30 : 190;
    [UIView animateWithDuration:.3 animations:^{
        _redLine.left = x;
    }];
    
    _fansView.hidden = !flag;
    _recordView.hidden = flag;
    
    if (!flag) {
        NSLog(@"%@",_MJRefreshCon.refreshData);
        [self.tableview reloadData];
    }
    
}
//点击解锁
- (void)unlockClicked:(UIButton *)button{
    
    NSInteger index = button.tag - 1;
    
    _unlockView.hidden = NO;
    
    NSString *str = [NSString stringWithFormat:@"还需%d个合格粉丝才能获取第%d层的感恩银元", index - _currentUnlockLevel + 1, index+1];
    
    _lblNotice.text = str;
    [_alertView setRoundCorner];
    
}
//隐藏unlockview
- (IBAction)hiddenUnlockView:(id)sender {
    _unlockView.hidden = YES;
}
//要求粉丝
- (IBAction)inviteFansClicked:(id)sender {
    [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"b48f4584ef5fb324cf5c4a803ed8e575"}];
   
    _unlockView.hidden = YES;
}
//购买感恩果
- (IBAction)buyGanEnGuoClicked:(id)sender {
    PUSH_VIEWCONTROLLER(ThankfulFruitViewController);
    _unlockView.hidden = YES;
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
    
    [self initTableView];
}
//右
- (IBAction)rightClicked:(id)sender {
    _btnLeft.enabled = YES;
    NSString *dateStr = [self getMounthWithString:_lblTime.text orDate:nil next:YES];
    _lblTime.text = dateStr;
    _btnRight.enabled = [self btnEnable];
    self.day = [UICommon usaulFormatTime:[self formatDataStr:dateStr] formatStyle:@"yyyy-MM-dd hh:mm:ss"];
    
    [self initTableView];
}

- (void)createDatePicker {
    if (picker) {
        [picker show]; return;
    }
    picker = [[UI_PickerView alloc] initDatePickWithDate:[[NSDate date] dateByAddingTimeInterval:-1 * (60*60*24)]
                                                 maxDate:[[NSDate date] dateByAddingTimeInterval:-1 * (60*60*24)]
                                                 minDate:[[NSDate date] dateByAddingTimeInterval:- 90 * (60*60*24)]
                                          datePickerMode:UIDatePickerModeDate
                                      isHaveNavControler:NO];
    picker.delegate = self;
    [picker show];
}

- (BOOL)checkDate{
    
    if (startTime.length && endTime.length) {
        
        if ([startTime isEqualToString:endTime]) {
            return YES;
        }
        
        NSDate *sdate = [UICommon dateShortFromString:startTime];
        NSDate *edate = [UICommon dateShortFromString:endTime];
        if ([sdate compare:edate] == NSOrderedDescending) {
            return NO;
        }
    }
    return YES;
}

//开始时间
- (IBAction)startTimeClicked:(id)sender {
    isStart = YES;
    [self createDatePicker];
}
//结束时间
- (IBAction)endTimeClicked:(id)sender {
    isStart = NO;
    [self createDatePicker];
}
//清除
- (IBAction)clearClicked:(id)sender {
    
    if (picker) {
        [picker remove];
    }
    startTime = @"";
    endTime = @"";
    [self setBtnTitleColor:RGBCOLOR(204, 204, 204)];
    _btnClear.hidden = YES;
}
//搜索
- (IBAction)searchClicked:(id)sender {
    if (picker) {
        [picker remove];
    }
    isSearch = YES;
    [self loadData];
}

- (void)toobarDonBtnHaveClick:(UI_PickerView *)pickView resultString:(NSString *)resultString {
    
    if (isStart) {
        startTime = resultString;
        if (![self checkDate]) {
            [HUDUtil showErrorWithStatus:@"结束时间不能小于开始时间"];return;
        }
        [_btnStartTime setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
        [_btnStartTime setTitle:resultString forState:UIControlStateNormal];
    } else {
        endTime = resultString;
        if (![self checkDate]) {
            [HUDUtil showErrorWithStatus:@"结束时间不能小于开始时间"];return;
        }
        [_btnEndTime setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
        [_btnEndTime setTitle:resultString forState:UIControlStateNormal];
    }
    
    if (_btnStartTime.titleLabel.text.length && _btnEndTime.titleLabel.text.length) {
        _btnClear.hidden = NO;
    }
    
}

- (void)setBtnTitleColor:(UIColor *)color{
    
    [_btnEndTime setTitleColor:color forState:UIControlStateNormal];
    [_btnStartTime setTitleColor:color forState:UIControlStateNormal];
    
    [_btnStartTime setTitle:@"开始时间" forState:UIControlStateNormal];
    [_btnEndTime setTitle:@"结束时间" forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [picker release];
    [_alertView release];
    
    [_fansArray release];
    [_lblFansNum release];
    [_tableview release];
    [_ownSliverNum release];
    [_loseSilverNum release];
    [_fansView release];
    [_noFansView release];
    [_recordView release];
    [_noRecordView release];
    [_btnLeft release];
    [_lblTime release];
    [_lblSilverNum release];
    [_btnRight release];
    [_btnSilverTotal release];
    [_btnSIlverDetail release];
    [_redLine release];
    [_fansLevelTable release];
    [_unlockView release];
    [_lblNotice release];
    [_scrollview release];
    [_btnShare release];
    [_imgTotalLine release];
    [_searchView release];
    [_btnStartTime release];
    [_btnEndTime release];
    [_btnClear release];
    [_btnSearch release];
    [_lblTishi release];
    [_line_s release];
    [super dealloc];
}
@end
