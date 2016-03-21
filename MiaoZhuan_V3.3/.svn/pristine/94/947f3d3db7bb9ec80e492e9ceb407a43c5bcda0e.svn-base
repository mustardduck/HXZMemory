//
//  CashFromRedPacketViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//
#import "CashFromRedPacketViewController.h"
#import "CashFromRedPocketCell.h"
#import "CashSection.h"

@interface CashFromRedPacketViewController () <UITableViewDelegate, UITableViewDataSource> {

    int _monthLimits;
}
@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (retain, nonatomic) IBOutlet UIView *tableHead;
@property (retain, nonatomic) IBOutlet UIView *tableHead2;
@property (strong, nonatomic) MJRefreshController *mjCon;
@property (strong, nonatomic) NSString *searchMonth;
@property (retain, nonatomic) IBOutlet UILabel *choosedMonthLabel1;
@property (retain, nonatomic) IBOutlet UILabel *choosedMonthLabel2;
@property (assign, nonatomic) int monthes;
@property (assign, nonatomic) int years;
@property (assign, nonatomic) int nowMonth;
@property (assign, nonatomic) int nowYear;
@property (retain, nonatomic) IBOutlet UILabel *allAccountLabel;
@property (strong, nonatomic) NSMutableArray *dateArray;
@property (strong, nonatomic) NSMutableArray *configedDataSource;
@property (retain, nonatomic) IBOutlet UIButton *dateForwardBtn1;
@property (retain, nonatomic) IBOutlet UIButton *dateForwardBtn2;
@property (retain, nonatomic) IBOutlet UIButton *dateBackWardBtn1;
@property (retain, nonatomic) IBOutlet UIButton *dateBackWardBtn2;
@property (retain, nonatomic) IBOutlet UIView *UILineView1;
@property (retain, nonatomic) IBOutlet UIView *UILineView2;
@end

@implementation CashFromRedPacketViewController
@synthesize tableHead = _tableHead;
@synthesize mainTable = _mainTable;
@synthesize mjCon = _mjCon;
@synthesize searchMonth = _searchMonth;
@synthesize choosedMonthLabel1 = _choosedMonthLabel1;
@synthesize choosedMonthLabel2 = _choosedMonthLabel2;
@synthesize monthes = _monthes;
@synthesize years = _years;
@synthesize dateArray = _dateArray;
@synthesize configedDataSource = _configedDataSource;
@synthesize dateForwardBtn1 = _dateForwardBtn1;
@synthesize dateForwardBtn2 = _dateForwardBtn2;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"看红包广告赚的"];
    [_mainTable setTableHeaderView:_tableHead];

    UIView *temp =  WEAK_OBJECT(UIView, init);
    [temp setBackgroundColor:[UIColor clearColor]];
    [_mainTable setTableFooterView:temp];
    
    
    
    [_mainTable registerNib:[UINib nibWithNibName:@"CashFromRedPocketCell" bundle:nil] forCellReuseIdentifier:@"CashFromRedPocketCell"];
    
    self.configedDataSource = WEAK_OBJECT(NSMutableArray, init);
    self.dateArray = WEAK_OBJECT(NSMutableArray, init);
    [self configMonths];
    [self getDataByMonthStr];
    self.dateForwardBtn1.enabled = NO;
    self.dateForwardBtn2.enabled = NO;
    [self.UILineView1 setFrame:CGRectMake(0, 104.5, 320, 0.5)];
    [self.UILineView2 setFrame:CGRectMake(0, 105, 320, 0.5)];
    _monthLimits = 0;
}

- (void)configMonths{
    
    NSString* month;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM"];
    month = [formatter stringFromDate:[NSDate date]];
    
    NSString* year;
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy"];
    year = [formatter1 stringFromDate:[NSDate date]];
    
    self.monthes = [month intValue];
    self.years = [year intValue];
    self.nowYear = [year intValue];
    self.nowMonth = [month intValue];
    
    self.searchMonth = [NSString stringWithFormat:@"%@-%@-01T12:00:00",year,month];
    
    //初始化label
    NSString *temp = [NSString stringWithFormat:@"%d年%@月",_years,[self getMonthStr:_monthes]];
    self.choosedMonthLabel1.text = temp;
    self.choosedMonthLabel2.text = temp;
}

- (NSString*)getMonthStr:(int)months {
    
    if (months>9) {
        
        return [NSString stringWithFormat:@"%d",months];
    }else {
        
        return [NSString stringWithFormat:@"0%d",months];
    }
}

- (void)getDataByMonthStr {

    NSString *refreshName = @"api/CustomerCash/EarnedByAdvert";

    self.mjCon = [MJRefreshController controllerFrom:_mainTable name:refreshName];
    
    [self.mjCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK {
        return @{
                 @"service":refreshName,
              @"parameters":@{
                         @"PageIndex":@(pageIndex),
                          @"PageSize":@(pageSize),
                       @"SearchMonth":_searchMonth}
                 }.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE {
    
        if (netData.operationSucceed) {
            
            if (_mjCon.refreshCount > 0) {
                
                [self.mainTable setTableHeaderView:_tableHead];
                
                NSString *nstring = [netData.data getString:@"ExtraData"];
                NSArray *array = [nstring componentsSeparatedByString:@":"];
                
                if ([array count] == 2) {

                    self.allAccountLabel.text = [NSString stringWithFormat:@"￥%.2f",[array[1] floatValue]];
                }
                
            }else {
            
                [self.mainTable setTableHeaderView:_tableHead2];
            }
        }else {
        
            [self.mainTable setTableHeaderView:_tableHead2];
        }
        
        self.configedDataSource = [self configDateArray];
        [_mainTable reloadData];
    };
    
    [self.mjCon setOnRequestDone:block];
    [self.mjCon setPageSize:10];
    [self.mjCon refreshWithLoading];
}

//配置时间并排序
- (NSMutableArray*)configDateArray {

    //时间set
    NSMutableSet* dateSet = WEAK_OBJECT(NSMutableSet, init);
    WDictionaryWrapper* dataIndex = WEAK_OBJECT(WDictionaryWrapper, init);
    NSMutableArray* configedArray = WEAK_OBJECT(NSMutableArray, init);
    
    for (NSDictionary *dic in _mjCon.refreshData) {
        
        DictionaryWrapper *wrapper = dic.wrapper;
        
        //配置元素日期
        NSString *dateStr;
        NSArray *array = [[wrapper getString:@"Time"] componentsSeparatedByString:@"T"];
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

- (IBAction)timeBack:(id)sender {
    
    self.monthes--;
    if (_monthes<1) {
        
        self.monthes = 12;
        self.years--;
    }
    
    if (_years <= _nowYear||_monthes <= _nowMonth) {
        
        self.dateForwardBtn1.enabled = YES;
        self.dateForwardBtn2.enabled = YES;
    }
    
    self.searchMonth = [NSString stringWithFormat:@"%d-%@-01T12:00:00",_years,[self getMonthStr:_monthes]];
    NSString *temp = [NSString stringWithFormat:@"%d年%@月",_years,[self getMonthStr:_monthes]];
    self.choosedMonthLabel1.text = temp;
    self.choosedMonthLabel2.text = temp;
    [self.mjCon refreshWithLoading];
    
    _monthLimits ++;
    
    if (_monthLimits > 4) {
        
        self.dateBackWardBtn1.enabled = NO;
        self.dateBackWardBtn2.enabled = NO;
    }
}

- (IBAction)timeForwrad:(id)sender {

    self.monthes++;
    if (_monthes>12) {
        
        self.monthes = 1;
        self.years++;
    }
    
    if (_years == _nowYear&&_monthes >= _nowMonth) {
        
        self.dateForwardBtn1.enabled = NO;
        self.dateForwardBtn2.enabled = NO;
    }
    
    self.searchMonth = [NSString stringWithFormat:@"%d-%@-01T12:00:00",_years,[self getMonthStr:_monthes]];
    
    NSString *temp = [NSString stringWithFormat:@"%d年%@月",_years,[self getMonthStr:_monthes]];
    self.choosedMonthLabel1.text = temp;
    self.choosedMonthLabel2.text = temp;
    
    [self.mjCon refreshWithLoading];
    
    _monthLimits --;
    
    if (_monthLimits <= 4) {
        
        self.dateBackWardBtn1.enabled = YES;
        self.dateBackWardBtn2.enabled = YES;
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[[_configedDataSource[section] wrapper] getArray:@"subArray"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CashFromRedPocketCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"CashFromRedPocketCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DictionaryWrapper *wrapper = [[[_configedDataSource [indexPath.section]wrapper] getArray:@"subArray"][indexPath.row] wrapper];
    
    [cell.adsPic requestPicture:[wrapper getString:@"IconUrl"]];
    cell.adsPic.layer.borderWidth = 0.5;
    cell.adsPic.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    cell.adsName.text = [wrapper getString:@"Name"];
    NSString *timeString = [wrapper getString:@"Time"];
    NSArray *array = [timeString componentsSeparatedByString:@"T"];
    
    if ([array count] == 2) {
        
        NSString *timeDetail = array[1];
        NSArray *arrayDetail = [timeDetail componentsSeparatedByString:@"."];
        if ([arrayDetail count] == 2) {
            
            cell.seeAdsTime.text = arrayDetail[0];
        }
    }
    cell.moneyAcount.text = [NSString stringWithFormat:@"+￥%0.2f",[wrapper getFloat:@"Amount"]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [_configedDataSource count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CashSection *temp = [[NSBundle mainBundle] loadNibNamed:@"CashSection" owner:nil options:nil].firstObject;
    [temp setDate:[[_configedDataSource[section]wrapper] getString:@"date"]];
    return temp;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 23;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 102;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *temp = WEAK_OBJECT(UIView, init);
    [temp setBackgroundColor:RGBCOLOR(153, 153, 153)];
    return temp;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.000001;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_dateArray release];
    [_searchMonth release];
    [_mainTable release];
    [_tableHead release];
    [_mjCon release];
    [_choosedMonthLabel1 release];
    [_choosedMonthLabel2 release];
    [_tableHead2 release];
    [_allAccountLabel release];
    [_dateForwardBtn1 release];
    [_dateForwardBtn2 release];
    [_UILineView1 release];
    [_UILineView2 release];
    [_dateBackWardBtn1 release];
    [_dateBackWardBtn2 release];
    [super dealloc];
}
@end
