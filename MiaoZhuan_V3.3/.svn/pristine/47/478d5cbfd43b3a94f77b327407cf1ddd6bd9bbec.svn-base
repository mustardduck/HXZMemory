//
//  GetCashViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "GetCashViewController.h"
#import "GetCashRecordCell.h"
#import "CashSection.h"
@interface GetCashViewController ()<UITableViewDataSource, UITableViewDelegate> {

    int _monthLimitCount;
}

@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (retain, nonatomic) IBOutlet UIView *tableHead;
@property (retain, nonatomic) IBOutlet UIView *tableHead2;
@property (retain, nonatomic) IBOutlet UIView *tableHead3;

@property (strong, nonatomic) NSString *searchMonth;
@property (assign, nonatomic) int monthes;
@property (assign, nonatomic) int years;
@property (assign, nonatomic) int nowMonth;
@property (assign, nonatomic) int nowYear;

@property (retain, nonatomic) IBOutlet UILabel *cashSum;
@property (retain, nonatomic) IBOutlet UILabel *showMonthChoosed1;
@property (retain, nonatomic) IBOutlet UILabel *showMonthChoosed2;
@property (retain, nonatomic) IBOutlet UILabel *showMonthChoosed3;

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) NSArray *originalArray;
@property (retain, nonatomic) IBOutlet UIButton *dateForwardBtn1;
@property (retain, nonatomic) IBOutlet UIButton *dateForwardBtn2;
@property (retain, nonatomic) IBOutlet UIButton *dateBackwardBtn1;
@property (retain, nonatomic) IBOutlet UIButton *dateBackwardBtn2;
@property (retain, nonatomic) IBOutlet UIButton *dateBackwardBtn3;


@property (retain, nonatomic) IBOutlet UIButton *screenViewBtn;

@property (retain, nonatomic) IBOutlet UIView *screenView;

@property (retain, nonatomic) IBOutlet UIButton *screenViewBtn1;
@property (retain, nonatomic) IBOutlet UIButton *screenViewBtn2;
@property (retain, nonatomic) IBOutlet UIButton *screenViewBtn3;
@property (retain, nonatomic) IBOutlet UIButton *screenViewBtn4;

@property (retain, nonatomic) IBOutlet UIImageView *littleCheckBtn;
@property (retain, nonatomic) IBOutlet UIView *backGroundView;

@property (retain, nonatomic) IBOutlet UIButton *reScreenBtn;


@end

@implementation GetCashViewController
@synthesize mainTable = _mainTable;
@synthesize tableHead = _tableHead;
@synthesize searchMonth = _searchMonth;
@synthesize monthes = _monthes;
@synthesize cashSum = _cashSum;
@synthesize tableHead2 = _tableHead2;
@synthesize showMonthChoosed1 = _showMonthChoosed1;
@synthesize showMonthChoosed2 = _showMonthChoosed2;
@synthesize dataSource = _dataSource;
@synthesize nowMonth = _nowMonth;
@synthesize nowYear = _nowYear;
@synthesize dateForwardBtn1 = _dateForwardBtn1;
@synthesize dateForwardBtn2 = _dateForwardBtn2;
@synthesize screenView = _screenView;
@synthesize originalArray = _originalArray;
@synthesize tableHead3 = _tableHead3;
@synthesize reScreenBtn = _reScreenBtn;
@synthesize showMonthChoosed3 = _showMonthChoosed3;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"提现记录"];
    [_mainTable registerNib:[UINib nibWithNibName:@"GetCashRecordCell" bundle:nil] forCellReuseIdentifier:@"GetCashRecordCell"];
    [self configMonths];
    
    self.dateForwardBtn1.enabled = NO;
    self.dateForwardBtn2.enabled = NO;
    [_mainTable setTableHeaderView:_tableHead2];
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    ADAPI_GetCashRecord([self genDelegatorID:@selector(getDataSourceList:)], _searchMonth);
    
    self.screenViewBtn1.layer.borderWidth = 0.5;
    self.screenViewBtn1.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];
    self.screenViewBtn1.layer.cornerRadius = 5;
    
    self.screenViewBtn2.layer.borderWidth = 0.5;
    self.screenViewBtn2.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    self.screenViewBtn2.layer.cornerRadius = 5;
    
    self.screenViewBtn3.layer.borderWidth = 0.5;
    self.screenViewBtn3.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    self.screenViewBtn3.layer.cornerRadius = 5;
    
    self.screenViewBtn4.layer.borderWidth = 0.5;
    self.screenViewBtn4.layer.borderColor = [RGBCOLOR(204, 204, 204)CGColor];
    self.screenViewBtn4.layer.cornerRadius = 5;
    
    self.reScreenBtn.layer.borderWidth = 0.5;
    self.reScreenBtn.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    self.reScreenBtn.layer.cornerRadius = 5;
    
    
    [self.view addSubview:_screenViewBtn];
    
    [self.view addSubview:_screenView];
    
    [self.view bringSubviewToFront:_screenViewBtn];
    [self.view bringSubviewToFront:_screenView];
    
    self.backGroundView.hidden = YES;
    _monthLimitCount = 0;
}

- (void)viewWillAppear:(BOOL)animated {

    [self.screenView setOrigin:CGPointMake(0, [[UIScreen mainScreen] bounds].size.height - 65)];
}

- (void)getDataSourceList:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        DictionaryWrapper *item = wrapper.data;
        
        self.dataSource = nil;
        self.originalArray = nil;
        
        if ([[item getArray:@"Details"] count] > 0) {
            
            [_mainTable setTableHeaderView:_tableHead];
            self.dataSource = [item getArray:@"Details"];
            self.originalArray = [item getArray:@"Details"];
            self.cashSum.text = [NSString stringWithFormat:@"￥%.2f",[item getFloat:@"Total"]];
            [_mainTable reloadData];
        }else {
            
            [_mainTable setTableHeaderView:_tableHead2];
            [_mainTable reloadData];
        }
    }
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
    self.showMonthChoosed1.text = temp;
    self.showMonthChoosed2.text = temp;
    self.showMonthChoosed3.text = temp;
}

- (NSString*)getMonthStr:(int)months {

    if (months>9) {
        
        return [NSString stringWithFormat:@"%d",months];
    }else {
    
        return [NSString stringWithFormat:@"0%d",months];
    }
}

//重新筛选
- (IBAction)reScreen:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.screenView setOrigin:CGPointMake(0, [[UIScreen mainScreen] bounds].size.height - _screenView.frame.size.height - 65)];
    } completion:^(BOOL finished) {
        self.backGroundView.hidden = NO;
    }];
}

//showScreen
- (IBAction)showScreen:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{

        [self.screenView setOrigin:CGPointMake(0, [[UIScreen mainScreen] bounds].size.height - _screenView.frame.size.height - 65)];
    } completion:^(BOOL finished) {
        self.backGroundView.hidden = NO;
    }];
}
//取消确定
- (IBAction)operationOnScreenView:(UIButton*)sender {
    
    if (sender.tag == 101) {
        
    }else if(sender.tag == 102) {
        
        if ([_dataSource count] == 0) {
            
            [_mainTable setTableHeaderView:_tableHead3];
        }else {
        
            [_mainTable setTableHeaderView:_tableHead];
        }
        [_mainTable reloadData];
    }
    //view disppear
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.screenView setOrigin:CGPointMake(0, [[UIScreen mainScreen] bounds].size.height - 65)];
    } completion:^(BOOL finished) {
        
        self.backGroundView.hidden = YES;
    }];
}

//选择筛选条件
- (IBAction)chooseScreenKey:(UIButton*)sender {
    
    switch (sender.tag) {
            //不限
        case 1:{
            self.screenViewBtn1.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];
            self.screenViewBtn2.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
            self.screenViewBtn3.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
            self.screenViewBtn4.layer.borderColor = [RGBCOLOR(204, 204, 204)CGColor];
            [self.littleCheckBtn setOrigin:CGPointMake(102 - 6, 77)];
            self.dataSource = _originalArray;
            break;}
            
            //处理中
        case 2:{
            self.screenViewBtn1.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
            self.screenViewBtn2.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];
            self.screenViewBtn3.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
            self.screenViewBtn4.layer.borderColor = [RGBCOLOR(204, 204, 204)CGColor];
            [self.littleCheckBtn setOrigin:CGPointMake(202 - 6, 77)];
            
            NSMutableArray *tempArray = WEAK_OBJECT(NSMutableArray, init);
            
            for (int i = 0; i < [_originalArray count]; i++) {
                
                DictionaryWrapper *item =  [_originalArray[i] wrapper];
                if ([item getInt:@"State"] == 0) {
                    
                    [tempArray addObject:item.dictionary];
                }
            }
            self.dataSource = [NSArray arrayWithArray:tempArray];
            break;}
            //已转款
        case 3:{
            self.screenViewBtn1.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
            self.screenViewBtn2.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
            self.screenViewBtn3.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];
            self.screenViewBtn4.layer.borderColor = [RGBCOLOR(204, 204, 204)CGColor];
            [self.littleCheckBtn setOrigin:CGPointMake(303 - 6, 77)];
            
            NSMutableArray *tempArray = WEAK_OBJECT(NSMutableArray, init);
            
            for (int i = 0; i < [_originalArray count]; i++) {
                
                DictionaryWrapper *item =  [_originalArray[i] wrapper];
                if ([item getInt:@"State"] == 1) {
                    
                    [tempArray addObject:item.dictionary];
                }
            }
            self.dataSource = [NSArray arrayWithArray:tempArray];
            break;}
            
            //转款失败
        case 4:{
            self.screenViewBtn1.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
            self.screenViewBtn2.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
            self.screenViewBtn3.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
            self.screenViewBtn4.layer.borderColor = [RGBCOLOR(240, 5, 0)CGColor];
            [self.littleCheckBtn setOrigin:CGPointMake(102 - 6, 121)];
            
            NSMutableArray *tempArray = WEAK_OBJECT(NSMutableArray, init);
            
            for (int i = 0; i < [_originalArray count]; i++) {
                
                DictionaryWrapper *item =  [_originalArray[i] wrapper];
                if ([item getInt:@"State"] == 2) {
                    
                    [tempArray addObject:item.dictionary];
                }
            }
            self.dataSource = [NSArray arrayWithArray:tempArray];
            break;}
        default:
            break;
    }
}


//时间往后
- (IBAction)timeBack:(id)sender {
    [self chooseScreenKey:_screenViewBtn1];
    self.monthes--;
    if (_monthes < 1) {
        
        self.monthes = 12;
        self.years--;
    }
    
    if (_years <= _nowYear || _monthes <= _nowMonth) {
        
        self.dateForwardBtn1.enabled = YES;
        self.dateForwardBtn2.enabled = YES;
    }
    
    self.searchMonth = [NSString stringWithFormat:@"%d-%@-01T12:00:00",_years,[self getMonthStr:_monthes]];
    
    NSString *temp = [NSString stringWithFormat:@"%d年%@月",_years,[self getMonthStr:_monthes]];
    self.showMonthChoosed1.text = temp;
    self.showMonthChoosed2.text = temp;
    self.showMonthChoosed3.text = temp;
    NSLog(@"%@",_searchMonth);
    ADAPI_GetCashRecord([self genDelegatorID:@selector(getDataSourceList:)], _searchMonth);
    _monthLimitCount ++;
    
    if (_monthLimitCount > 4) {
        
        self.dateBackwardBtn1.enabled = NO;
        self.dateBackwardBtn2.enabled = NO;
        self.dateBackwardBtn3.enabled = NO;
    }
}

//时间往前
- (IBAction)timeForward:(id)sender {
    
    [self chooseScreenKey:_screenViewBtn1];
    self.monthes++;
    if (_monthes>12) {
        
        self.monthes = 1;
        self.years++;
    }
    
    if (_years == _nowYear && _monthes >= _nowMonth) {
        
        self.dateForwardBtn1.enabled = NO;
        self.dateForwardBtn2.enabled = NO;
    }
    
    self.searchMonth = [NSString stringWithFormat:@"%d-%@-01T12:00:00",_years,[self getMonthStr:_monthes]];
    
    NSString *temp = [NSString stringWithFormat:@"%d年%@月",_years,[self getMonthStr:_monthes]];
    self.showMonthChoosed1.text = temp;
    self.showMonthChoosed2.text = temp;
    self.showMonthChoosed3.text = temp;
    ADAPI_GetCashRecord([self genDelegatorID:@selector(getDataSourceList:)], _searchMonth);
    _monthLimitCount --;
    
    if (_monthLimitCount <= 4) {
        
        self.dateBackwardBtn1.enabled = YES;
        self.dateBackwardBtn2.enabled = YES;
        self.dateBackwardBtn3.enabled = YES;
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_dataSource count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CashSection *temp = [[NSBundle mainBundle] loadNibNamed:@"CashSection" owner:nil options:nil].firstObject;
    [temp setDate:[[_dataSource[section] wrapper] getString:@"CreateTime"]];
    NSString *str = [[_dataSource[section] wrapper] getString:@"CreateTime"];
    NSArray *array = [str componentsSeparatedByString:@"T"];
    [temp setDate:array[0]];
    return temp;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 23;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GetCashRecordCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"GetCashRecordCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DictionaryWrapper *item = [_dataSource[indexPath.section] wrapper];
    
    cell.bankName.text = [item getString:@"BankName"];
    cell.tailNumber.text = [NSString stringWithFormat:@"尾号%@",[item getString:@"AccountNumberEnd"]];
    cell.accountName.text = [item getString:@"AccountName"];
    
    CGSize bankNameSize = [[item getString:@"BankName"] sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 18) lineBreakMode:NSLineBreakByWordWrapping];
    [cell.bankName setFrame:CGRectMake(79, 15, bankNameSize.width, 18)];
    [cell.tailNumber setFrame:CGRectMake(cell.bankName.frame.origin.x + cell.bankName.frame.size.width + 8, 15, 100, 18)];
    
    NSString *str = [item getString:@"CreateTime"];
    NSArray *arr = [str componentsSeparatedByString:@"T"];
    NSArray *arr1 = [arr[1] componentsSeparatedByString:@"."];
    cell.treatTime.text = arr1[0];
    
    cell.orderNumber.text = [NSString stringWithFormat:@"订单编号：%@",[item getString:@"OrderNumber"]];
    cell.amount.text = [NSString stringWithFormat:@"-￥%.2f",[item getFloat:@"Amount"]];
    
    switch ([item getInt:@"State"]) {
        case 0:
            
            cell.state.text = @"处理中";
            break;
        case 1:
            
            cell.state.text = @"已转款";
            break;
        case 2:
            
            cell.state.text = @"转款失败";
            break;
            
        default:
            break;
    }
    
    cell.UILineView2 = WEAK_OBJECT(UIView, init);
    [cell.UILineView2 setBackgroundColor:RGBCOLOR(204, 204, 204)];
    
    if ([_dataSource count] - 1 == indexPath.section) {
        
        [cell.UILineView2 setFrame:CGRectMake(0, 100.5, 320,0.5)];
    }else {
    
        [cell.UILineView2 setFrame:CGRectMake(0, 100.5, 320,0.5)];
    }
    
    [cell addSubview:cell.UILineView2];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 101;
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
    
    [_originalArray release];
    [_dataSource release];
    [_searchMonth release];
    [_mainTable release];
    [_tableHead release];
    [_cashSum release];
    [_tableHead2 release];
    [_showMonthChoosed1 release];
    [_showMonthChoosed2 release];
    [_dateForwardBtn1 release];
    [_dateForwardBtn2 release];
    [_screenView release];
    [_screenViewBtn1 release];
    [_screenViewBtn2 release];
    [_screenViewBtn3 release];
    [_screenViewBtn4 release];
    [_screenViewBtn release];
    [_littleCheckBtn release];
    [_backGroundView release];
    [_dateBackwardBtn1 release];
    [_dateBackwardBtn2 release];
    [_dateBackwardBtn3 release];
    [_tableHead3 release];
    [_reScreenBtn release];
    [_showMonthChoosed3 release];
    [super dealloc];
}
@end
