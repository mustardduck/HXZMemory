//
//  CashFromFansViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CashFromFansViewController.h"
#import "CashFromFansCell.h"
#import "CashSection.h"
#import "FansLayerCell.h"
#import "PhoneAuthenticationViewController.h"
#import "UserInfo.h"
#import "FansHelpRecordsViewController.h"
#import "Share_Method.h"
#import "UICommon.h"
#import "UI_PickerView.h"
#import "ThankfulFruitViewController.h"
#import "RRAttributedString.h"

@interface CashFromFansViewController () <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,UI_PickViewDelegate> {

    int _monthLimitsCount;
    BOOL _isCashFromFansWhole;
    NSArray *_fansDataArray;
    UI_PickerView *_pickerView;
    id _currentDatePickerUI;
    BOOL _clearingText;
    BOOL _firstLoadData;
}

@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (retain, nonatomic) IBOutlet UITableView *anotherTable;

@property (retain, nonatomic) IBOutlet UIButton *button_ShareToGetMoreMoney;
@property (retain, nonatomic) IBOutlet UILabel *label_SearchLine;

@property (retain, nonatomic) IBOutlet UIButton *wholeCategoryBtn;
@property (retain, nonatomic) IBOutlet UIButton *detailBtn;
@property (retain, nonatomic) IBOutlet UIView *redlineView;
@property (retain, nonatomic) IBOutlet UIView *view_header;

@property (retain, nonatomic) IBOutlet UILabel *label_AlertDateSetCount;

@property (retain, nonatomic) IBOutlet UIView *tableHead;
@property (strong, nonatomic) MJRefreshController *mjCon;
@property (strong, nonatomic) NSString *searchMonth;
@property (retain, nonatomic) IBOutlet UIView *tableHead2;
@property (retain, nonatomic) IBOutlet UIView *tableHead3;

@property (retain, nonatomic) IBOutlet UILabel *fansNumber;


@property (retain, nonatomic) IBOutlet UIView *tableFoot;
@property (retain, nonatomic) IBOutlet UILabel *tableFootLabel1;
@property (retain, nonatomic) IBOutlet UILabel *tableFootLabel2;

@property (retain, nonatomic) IBOutlet UILabel *chooseMonthLabel1;
@property (retain, nonatomic) IBOutlet UILabel *chooseMonthLabel2;
@property (assign, nonatomic) int monthes;
@property (assign, nonatomic) int years;
@property (assign, nonatomic) int nowMonthes;
@property (assign, nonatomic) int nowYear;
@property (retain, nonatomic) IBOutlet UILabel *allAccountLabel;
@property (strong, nonatomic) NSMutableArray *configedDataSource;
@property (retain, nonatomic) IBOutlet UIButton *dateForwardBtn1;
@property (retain, nonatomic) IBOutlet UIButton *dateForwardBtn2;
@property (retain, nonatomic) IBOutlet UIButton *dateBackwardBtn1;
@property (retain, nonatomic) IBOutlet UIButton *dateBackwardBtn2;

@property (assign, nonatomic) NSString* wholeAccount;

@property (retain, nonatomic) IBOutlet UIView *noFansView;


@property (retain, nonatomic) IBOutlet UIView *UILineView1;
@property (retain, nonatomic) IBOutlet UIView *uiLineView2;
@property (retain, nonatomic) IBOutlet UIView *uiLineView3;
@property (retain, nonatomic) IBOutlet UIView *uiLineView4;
@property (retain, nonatomic) IBOutlet UIView *uilineView5;
@property (retain, nonatomic) IBOutlet UIView *view_dateChoose;
@property (retain, nonatomic) IBOutlet UITextField *tf_BeginTime;
@property (retain, nonatomic) IBOutlet UITextField *tf_EndTime;

@property (retain, nonatomic) IBOutlet UIView *alertView;
@property (retain, nonatomic) IBOutlet UILabel *alertLable;
@property (retain, nonatomic) IBOutlet UIButton *alertBtnOne;
@property (retain, nonatomic) IBOutlet UIButton *alertBtnTwo;
@property (retain, nonatomic) IBOutlet UILabel *alertNeedNumLable;
@property (retain, nonatomic) IBOutlet UIView *lineVIewOne;
@property (retain, nonatomic) IBOutlet UIView *lineViewTwo;

@property (retain, nonatomic) IBOutlet UIButton *bgBtnView;



@end

@implementation CashFromFansViewController
@synthesize mainTable =  _mainTable;
@synthesize tableHead = _tableHead;
@synthesize mjCon = _mjCon;
@synthesize searchMonth = _searchMonth;
@synthesize tableHead2 = _tableHead2;
@synthesize tableHead3 = _tableHead3;
@synthesize chooseMonthLabel1 = _chooseMonthLabel1;
@synthesize chooseMonthLabel2 = _chooseMonthLabel2;
@synthesize monthes = _monthes;
@synthesize years = _years;
@synthesize nowMonthes = _nowMonthes;
@synthesize nowYear = _nowYear;
@synthesize allAccountLabel = _allAccountLabel;
@synthesize configedDataSource = _configedDataSource;
@synthesize dateForwardBtn1 = _dateForwardBtn1;
@synthesize dateForwardBtn2 = _dateForwardBtn2;
@synthesize wholeAccount = _wholeAccount;
@synthesize tableFoot = _tableFoot;
@synthesize tableFootLabel1 = _tableFootLabel1;
@synthesize tableFootLabel2 = _tableFootLabel2;
@synthesize fansNumber = _fansNumber;
@synthesize anotherTable = _anotherTable;
@synthesize redlineView = _redlineView;
@synthesize wholeCategoryBtn = _wholeCategoryBtn;
@synthesize detailBtn = _detailBtn;
@synthesize noFansView = _noFansView;
@synthesize UILineView1 = _UILineView1;
@synthesize uiLineView2 = _uiLineView2;
@synthesize uiLineView3 = _uiLineView3;
@synthesize uiLineView4 = _uiLineView4;
@synthesize uilineView5 = _uilineView5;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"粉丝帮我赚的"];
    [_mainTable setTableHeaderView:_tableHead3];
    [_anotherTable setTableHeaderView:_tableHead];
    [_mainTable setTableFooterView:_tableFoot];
    
    _mainTable.hidden = YES;
    _anotherTable.hidden = YES;
    
     _bgBtnView.hidden = YES;
    
    _alertView.layer.masksToBounds = YES;
    _alertView.layer.cornerRadius = 8.0;
    _alertView.layer.borderWidth = 0.5;
    _alertView.layer.borderColor = [[UIColor clearColor] CGColor];
    
    
    [_mainTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.configedDataSource = WEAK_OBJECT(NSMutableArray, init);
    [self configMonths];
    [self getDataByMonthStr];
    self.dateForwardBtn1.enabled = NO;
    self.dateForwardBtn2.enabled = NO;
    _monthLimitsCount = 0;
    _isCashFromFansWhole = YES;
    _fansDataArray = WEAK_OBJECT(NSArray, init);
    ADAPI_MemberCampaign_Summary([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSummary:)], @"2", @"", @"");
    
    [_UILineView1 setFrame:CGRectMake(0, 39.5, 320, 0.5)];
    [_uiLineView2 setFrame:CGRectMake(0, 0, 320, 0.5)];
    [_uiLineView3 setFrame:CGRectMake(0, 49.5, 320, 0.5)];
    [_uiLineView4 setFrame:CGRectMake(0, 0, 320, 0.5)];
    [_uilineView5 setSize:CGSizeMake(320, 0.5)];
    
    self.view_dateChoose.layer.borderColor = [RGBACOLOR(204, 204, 204, 1)CGColor];
    self.view_dateChoose.layer.borderWidth = 0.5f;
    self.view_dateChoose.layer.cornerRadius = 5.f;
    self.view_dateChoose.layer.masksToBounds = YES;
    
    _label_SearchLine.width = 0.5f;
    
    [self.button_ShareToGetMoreMoney setBackgroundImage:[[UIImage imageNamed:@"ads_invate"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.button_ShareToGetMoreMoney setBackgroundImage:[[UIImage imageNamed:@"ads_invatehover"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
    self.button_ShareToGetMoreMoney.layer.cornerRadius = 5.;
    self.button_ShareToGetMoreMoney.layer.masksToBounds = YES;
    
    [_tf_EndTime setClearButtonMode:UITextFieldViewModeAlways];
    
}


//小数点后面四位，不用四舍五入
- (NSString *)getFourCoutDigital:(NSString*)originalString {

    NSMutableString *resultString = WEAK_OBJECT(NSMutableString, init);
    
    NSArray *array = [originalString componentsSeparatedByString:@"."];
    
    NSString *stringAfterDot = array[1];
    
    stringAfterDot = [stringAfterDot substringToIndex:4];
    
    [resultString appendString:array[0]];
    [resultString appendString:@"."];
    [resultString appendString:stringAfterDot];
    return resultString;
}

//请求回调
- (void)handleSummary:(DelegatorArguments *)arguments {
    DictionaryWrapper *ret = [arguments ret];
    [HUDUtil dismiss];
    if (ret.operationSucceed) {
        
        //判断有无粉丝
        _mainTable.hidden = NO;
        _fansDataArray = [[ret.data getArray:@"Details"] retain];
        
        if (_fansDataArray.count) {
            
            //判断是否进行了手机认证
            if (USER_MANAGER.IsPhoneVerified) {
                
                self.noFansView.hidden = YES;
                if(!_firstLoadData){
                    _firstLoadData = YES;
                    _fansNumber.text = [NSString stringWithFormat:@"%@个",[[_fansDataArray[0] wrapper] getString:@"FansCount"]];
                }
                
                NSString *EarnCashByFans = [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[ret.data getDouble:@"EarnCashByFans"] withAppendStr:nil];
                NSString *CashMiss = [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[ret.data getDouble:@"CashMiss"] withAppendStr:nil];
                _tableFootLabel1.text = [NSString stringWithFormat:@"%@",EarnCashByFans];
                _tableFootLabel2.text = [NSString stringWithFormat:@"%@",CashMiss];
                [_mainTable reloadData];
            }

        }
        return;
    }
    //设置显示的View
    self.noFansView.hidden = NO;
    [self.view bringSubviewToFront:_noFansView];
}


- (IBAction)alertBtnTouch:(id)sender
{
    if (sender == _alertBtnOne)
    {
        [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"b48f4584ef5fb324cf5c4a803ed8e575"}];
    }
    else if (sender == _alertBtnTwo)
    {
        PUSH_VIEWCONTROLLER(ThankfulFruitViewController);
    }
    
    _bgBtnView.hidden = YES;
    [_alertView removeFromSuperview];
}


- (IBAction)bgBtn:(id)sender
{
    _bgBtnView.hidden = YES;
    
    [_alertView removeFromSuperview];
}

- (IBAction)wholeFansList:(id)sender {
    
    [_mainTable setTableHeaderView:_tableHead3];
    _isCashFromFansWhole = YES;
    
    _mainTable.hidden = NO;
    _anotherTable.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [_redlineView setFrame:CGRectMake(30, 37, 100, 3)];
    }];
    
    [_wholeCategoryBtn setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
    [_wholeCategoryBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    
    [_detailBtn setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
    [_detailBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    if ([_fansDataArray count] == 0 || !USER_MANAGER.IsPhoneVerified) {
        
        _noFansView.hidden = NO;
    }
}

- (IBAction)detailList:(id)sender {
    
    _isCashFromFansWhole = NO;
    _mainTable.hidden = YES;
    _anotherTable.hidden = NO;
    [_anotherTable reloadData];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [_redlineView setFrame:CGRectMake(190, 37, 100, 3)];
    }];
    
    [_wholeCategoryBtn setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
    [_wholeCategoryBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [_detailBtn setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
    [_detailBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    
    _noFansView.hidden = YES;
}

- (IBAction)shareToDevelopeFans:(id)sender {
    
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
    
//    if ([_fansDataArray count] == 0) {
//        
//        [HUDUtil showErrorWithStatus:@"您当前没有粉丝"];
//        return;
//    }
//    
    [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"b48f4584ef5fb324cf5c4a803ed8e575"}];
}

- (IBAction)checkYourFans:(id)sender {
    
    PUSH_VIEWCONTROLLER(FansHelpRecordsViewController);
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
    self.nowMonthes = [month intValue];
    self.nowYear = [year intValue];
    
    self.searchMonth = [NSString stringWithFormat:@"%@-%@-01T12:00:00",year,month];
    //初始化label
    NSString *temp = [NSString stringWithFormat:@"%d年%@月",_years,[self getMonthStr:_monthes]];
    self.chooseMonthLabel1.text = temp;
    self.chooseMonthLabel2.text = temp;
}

- (NSString*)getMonthStr:(int)months {
    
    if (months>9) {
        
        return [NSString stringWithFormat:@"%d",months];
    }else {
        
        return [NSString stringWithFormat:@"0%d",months];
    }
}

- (void)getDataByMonthStr{

    NSString *refreshName = @"api/CustomerCash/EarnedByFans";
    
    self.mjCon = [MJRefreshController controllerFrom:_anotherTable name:refreshName];
    
    [self.mjCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK {
        return @{
                 @"service":refreshName,
              @"parameters":@{
                     @"PageIndex":@(pageIndex),
                      @"PageSize":@(pageSize),
                   @"searchMonth":_searchMonth
                     }
                 }.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE {
    
        if (netData.operationSucceed) {
            
            if (_mjCon.refreshCount > 0) {
                
                _anotherTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                [_anotherTable setTableHeaderView:_tableHead];
                
                NSString *nstring = [netData.data getString:@"ExtraData"];
                NSArray *array = [nstring componentsSeparatedByString:@":"];
                
                if ([array count] == 2) {
                    
                    self.allAccountLabel.text = [self getFourCoutDigital:array[1]];
                    
                    self.wholeAccount = [array[1] copy];
                    
                }else {
                    
                    self.allAccountLabel.text = nstring;
                }
            }else {
                _anotherTable.separatorStyle = UITableViewCellSeparatorStyleNone;
                [_anotherTable setTableHeaderView:_tableHead2];
            }
        }
        
        self.configedDataSource = [self configDateArray];
        [_anotherTable reloadData];
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
    
    if (_years <= _nowYear||_monthes<=_nowMonthes) {
        
        self.dateForwardBtn1.enabled = YES;
        self.dateForwardBtn2.enabled = YES;
    }
    
    self.searchMonth = [NSString stringWithFormat:@"%d-%@-01T12:00:00",_years,[self getMonthStr:_monthes]];
    
    NSString *temp = [NSString stringWithFormat:@"%d年%@月",_years,[self getMonthStr:_monthes]];
    self.chooseMonthLabel1.text = temp;
    self.chooseMonthLabel2.text = temp;

    [self.mjCon refreshWithLoading];
    
    _monthLimitsCount ++;
    if (_monthLimitsCount > 4) {
        
        self.dateBackwardBtn1.enabled = NO;
        self.dateBackwardBtn2.enabled = NO;
    }
}

- (IBAction)timeForward:(id)sender {
    
    self.monthes++;
    if (_monthes>12) {
        
        self.monthes = 1;
        self.years++;
    }
    
    if (_years == _nowYear&&_monthes >= _nowMonthes) {
        
        self.dateForwardBtn1.enabled = NO;
        self.dateForwardBtn2.enabled = NO;
    }
    
    self.searchMonth = [NSString stringWithFormat:@"%d-%@-01T12:00:00",_years,[self getMonthStr:_monthes]];
    
    NSString *temp = [NSString stringWithFormat:@"%d年%@月",_years,[self getMonthStr:_monthes]];
    self.chooseMonthLabel1.text = temp;
    self.chooseMonthLabel2.text = temp;
    [self.mjCon refreshWithLoading];
    
    _monthLimitsCount --;
    if (_monthLimitsCount <= 4) {
        
        self.dateBackwardBtn1.enabled = YES;
        self.dateBackwardBtn2.enabled = YES;
    }
}


#pragma mark - UITableDelagete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_isCashFromFansWhole) {
        
        return [_fansDataArray count];
    }else {
    
        return [[[_configedDataSource[section] wrapper] getArray:@"subArray"] count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_isCashFromFansWhole) {
        
        return 1;
    }else {
    
        if ([_wholeAccount floatValue] > 0) {
            
            self.allAccountLabel.text = [self getFourCoutDigital:_wholeAccount];
        }else {
            
            self.allAccountLabel.text = @"￥0.00";
        }
        return [_configedDataSource count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_isCashFromFansWhole) {
        
        return 45;
    }else {
    
        return 80;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (_isCashFromFansWhole) {
        [_mainTable registerNib:[UINib nibWithNibName:@"FansLayerCell" bundle:nil] forCellReuseIdentifier:@"FansLayerCell"];
        FansLayerCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"FansLayerCell" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([_fansDataArray count] > indexPath.row) {
            
            DictionaryWrapper *wrapper = [_fansDataArray[indexPath.row] wrapper];
            
            BOOL isLocked = ![wrapper getBool:@"IsUnLocked"];
            int number1 = [wrapper getInt:@"VerifyCount"];
            int number2 = [wrapper getInt:@"FansCount"];
            float number3 = [wrapper getDouble:@"CashEarnByFans"];
            [cell setupCellWith:number1 qualifiedNumber:number2 cashNumber:number3 isLocked:isLocked];
        }
        if(indexPath.row == _fansDataArray.count - 1){
            cell.label_line.left = 0.f;
            cell.label_line.width = SCREENWIDTH;
        }else{
            cell.label_line.left = 15.f;
            cell.label_line.width = SCREENWIDTH - 15.f;
        }
        
        return cell;
    }else {
        [_anotherTable registerNib:[UINib nibWithNibName:@"CashFromFansCell" bundle:nil] forCellReuseIdentifier:@"CashFromFansCell"];
        CashFromFansCell *cell = [_anotherTable dequeueReusableCellWithIdentifier:@"CashFromFansCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        DictionaryWrapper *wrapper = [[[_configedDataSource [indexPath.section]wrapper] getArray:@"subArray"][indexPath.row] wrapper];
        [cell.headPic requestPicture:[wrapper getString:@"IconUrl"]];
        cell.headPic.layer.cornerRadius = 5;
        cell.headPic.layer.borderWidth = 0.5;
        cell.headPic.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
        cell.headPic.layer.masksToBounds = YES;
        
        cell.nameLabel.text = [wrapper getString:@"Name"];
        cell.acountLabel.text = [NSString stringWithFormat:@"+￥%.4f",[wrapper getFloat:@"Amount"]];
        CGSize size = [[wrapper getString:@"Name"] sizeWithFont:cell.nameLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, cell.nameLabel.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
        [cell.nameLabel setFrame:CGRectMake(73, 23, size.width, 15)];
        [cell.vipIcon setFrame:CGRectMake(73+size.width+2,23, 30, 15)];
        
        switch ([wrapper getInt:@"Vip"]) {
            case 0:
                
                [cell.vipIcon setImage:[UIImage imageNamed:@"NO_VIP.png"]];
                break;
            case 1:
                [cell.vipIcon setImage:[UIImage imageNamed:@"VIP1.png"]];
                break;
            case 2:
                [cell.vipIcon setImage:[UIImage imageNamed:@"VIP2.png"]];
                break;
            case 3:
                [cell.vipIcon setImage:[UIImage imageNamed:@"VIP3.png"]];
                break;
            case 4:
                [cell.vipIcon setImage:[UIImage imageNamed:@"VIP4.png"]];
                break;
            case 5:
                [cell.vipIcon setImage:[UIImage imageNamed:@"VIP5.png"]];
                break;
            case 6:
                [cell.vipIcon setImage:[UIImage imageNamed:@"VIP6.png"]];
                break;
            case 7:
                [cell.vipIcon setImage:[UIImage imageNamed:@"VIP7.png"]];
                break;
                
            default:
                break;
        }
        switch ([wrapper getInt:@"Level"]) {
            case 0:
                
                break;
            case 1:
                
                cell.fromFansLevelLabel.text = @"来自第一层粉丝";
                break;
            case 2:
                
                cell.fromFansLevelLabel.text = @"来自第二层粉丝";
                break;
            case 3:
                
                cell.fromFansLevelLabel.text = @"来自第三层粉丝";
                break;
            case 4:
                
                cell.fromFansLevelLabel.text = @"来自第四层粉丝";
                break;
            case 5:
                
                cell.fromFansLevelLabel.text = @"来自第五层粉丝";
                break;
            case 6:
                
                cell.fromFansLevelLabel.text = @"来自第六层粉丝";
                break;
                
            default:
                break;
        }
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (_isCashFromFansWhole) {
        
        return nil;
    }else {
    
        CashSection *temp = [[NSBundle mainBundle] loadNibNamed:@"CashSection" owner:nil options:nil].firstObject;
        [temp setDate:[[_configedDataSource[section]wrapper] getString:@"date"]];
        return temp;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (_isCashFromFansWhole) {
        
        return 0;
    }else {
    
        return 23;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *temp = WEAK_OBJECT(UIView, init);
    [temp setBackgroundColor:RGBCOLOR(153, 153, 153)];
    return temp;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.000001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isCashFromFansWhole) {
       
        
        DictionaryWrapper* dicsss =[_fansDataArray[indexPath.row] wrapper];
        
        BOOL IsUnLocked = [dicsss getBool:@"IsUnLocked"];
        
        if (IsUnLocked) {
            return;
        }
        _bgBtnView.hidden = NO;

        int countlockedLayer = 0;
        for (int i = 0; i < [_fansDataArray count]; i++) {
            DictionaryWrapper* dicsss =[_fansDataArray[i] wrapper];
            
            BOOL IsUnLocked = [dicsss getBool:@"IsUnLocked"];
            if (IsUnLocked) {
                countlockedLayer++;
            }
        }
        
        
        int needNum =  indexPath.row + 1 - countlockedLayer;
        
        _alertNeedNumLable.text = [NSString stringWithFormat:@"还需%d个合格粉丝",needNum];
        
        _alertLable.text = [NSString stringWithFormat:@"才能获取第%d层的感恩银元",indexPath.row + 1];
        
        NSAttributedString * attributedString = [RRAttributedString setText:_alertNeedNumLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(2, 1)];
        
        _alertNeedNumLable.attributedText = attributedString;
        
        NSAttributedString * attributedStringTwo = [RRAttributedString setText:_alertLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(5, 1)];
        
        _alertLable.attributedText = attributedStringTwo;
        
        [self.view addSubview:_alertView];
        
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            _alertView.frame = CGRectMake(15, 95, _alertView.width, _alertView.height);
        }
        else
        {
            _alertView.frame = CGRectMake(15, 135, _alertView.width, _alertView.height);
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL) checkField :(NSDate *)astartDate endDate : (NSDate *)aendDate
{
    if ( astartDate && aendDate) {
        
        NSTimeInterval aa = [aendDate timeIntervalSinceDate:astartDate];
        
        if (aa < 0) {
            
            [HUDUtil showErrorWithStatus:@"结束时间不能早于开始时间"];
            
            return YES;
        }
    }
    return NO;
}

#pragma mark -- 搜索时间区间内数据
- (IBAction)searchWithTimeSet:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    if(_tf_BeginTime.text.length == 0 && _tf_EndTime.text.length == 0){
        
        _label_AlertDateSetCount.text = @"你直接发展的粉丝构成了第一层, 他们再发展的粉丝构成了其他层，统计如下:";
        _label_AlertDateSetCount.height = 34.f;
        _label_AlertDateSetCount.top = 140.f;
    }else{
        
        if(_tf_BeginTime.text.length == 0){
            NSString* dateText = [dateFormatter stringFromDate:[self getMinDate]];
            _tf_BeginTime.text = dateText;
        }else if (_tf_EndTime.text.length == 0){
            NSString* dateText = [dateFormatter stringFromDate:[self getMaxDate]];
            _tf_EndTime.text = dateText;
        }
        _tf_BeginTime.font = [UIFont systemFontOfSize:14.f];
        _tf_EndTime.font = [UIFont systemFontOfSize:14.f];
        _label_AlertDateSetCount.text = [NSString stringWithFormat:@"你直接发展的粉丝构成了第一层，他们再发展的粉丝构成了其他层，累积截至%@至%@统计如下:",_tf_BeginTime.text,_tf_EndTime.text];
        _label_AlertDateSetCount.top = 125.f;
        _label_AlertDateSetCount.height = 54.f;
        
    }
    [_mainTable reloadData];
    
    if([self checkField:[dateFormatter dateFromString:_tf_BeginTime.text] endDate:[dateFormatter dateFromString:_tf_EndTime.text]]){
        return;
    }
    [HUDUtil showWithStatus:@"正在搜索..."];
    ADAPI_MemberCampaign_Summary([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSummary:)], @"2", _tf_BeginTime.text, _tf_EndTime.text);
}

#pragma mark -- 获取最大时间
-(NSDate *)getMaxDate{
    NSDate *date = [NSDate date];
    date = [date dateByAddingTimeInterval:-60*60*24];//当前系统时间－1天
//    if(_tf_EndTime.text.length > 0 && ![_currentDatePickerUI isEqual:_tf_EndTime]){
//        NSDateFormatter *dateFormatter = WEAK_OBJECT(NSDateFormatter, init);
//        
//        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
//        
//        date= [dateFormatter dateFromString:_tf_EndTime.text];
//    }
    return date;
}

#pragma mark -- 获取最小时间
-(NSDate *)getMinDate{
    NSDate *date = [NSDate date];
    date = [date dateByAddingTimeInterval:- 90*(60*60*24)];//当前系统时间－90天
//    if(_tf_BeginTime.text.length > 0 && ![_currentDatePickerUI isEqual:_tf_BeginTime]){
//        NSDateFormatter *dateFormatter = WEAK_OBJECT(NSDateFormatter, init);
//        
//        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
//        
//        date= [dateFormatter dateFromString:_tf_BeginTime.text];
//    }
    return date;
}

#pragma mark -- uitextfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(_clearingText){
        _clearingText = NO;
        return NO;
    }
    if ([textField isEqual: _tf_BeginTime])
    {
        NSDate *mindate = [self getMinDate];
        NSDate *maxdate = [self getMaxDate];
        
        [_pickerView remove];
        _pickerView =[[UI_PickerView alloc] initDatePickWithDate:maxdate maxDate:maxdate minDate:mindate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        _currentDatePickerUI = _tf_BeginTime;
        [_pickerView setDelegate:self];
        [_pickerView show];
        
    }
    else if ([textField isEqual: _tf_EndTime])
    {
        NSDate *mindate = [self getMinDate];
        NSDate *maxdate = [self getMaxDate];
        
        [_pickerView remove];
        _pickerView =[[UI_PickerView alloc] initDatePickWithDate:maxdate maxDate:maxdate minDate:mindate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        _currentDatePickerUI = _tf_EndTime;
        [_pickerView setDelegate:self];
        [_pickerView show];
        
    }
    return NO;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    _tf_BeginTime.text = @"";
    _clearingText = YES;
    [_tf_EndTime setFont:[UIFont systemFontOfSize:16.f]];    
    [_tf_BeginTime setFont:[UIFont systemFontOfSize:16.f]];
    return YES;
}

#pragma mark -- datepicker delegate
-(void)toobarDonBtnHaveClick:(UI_PickerView *)pickView resultString:(NSString *)resultString{
    NSLog(@"resultString :%@", resultString);
    
    UITextField *tf = _currentDatePickerUI;
    [tf setFont:[UIFont systemFontOfSize:14.f]];
    [tf setText:resultString];
    _currentDatePickerUI = nil;
}

- (void)dealloc {
    [_searchMonth release];
    [_mjCon release];
    [_mainTable release];
    [_tableHead release];
    [_tableHead2 release];
    [_chooseMonthLabel1 release];
    [_chooseMonthLabel2 release];
    [_allAccountLabel release];
    [_dateForwardBtn1 release];
    [_dateForwardBtn2 release];
    [_dateBackwardBtn1 release];
    [_dateBackwardBtn2 release];
    [_tableHead3 release];
    [_tableFoot release];
    [_tableFootLabel1 release];
    [_tableFootLabel2 release];
    [_fansNumber release];
    [_fansDataArray release];
    [_anotherTable release];
    [_redlineView release];
    [_wholeCategoryBtn release];
    [_detailBtn release];
    [_UILineView1 release];
    [_uiLineView2 release];
    [_uiLineView3 release];
    [_uiLineView4 release];
    [_noFansView release];
    [_uilineView5 release];
    [_wholeAccount release];
    [_view_dateChoose release];
    [_tf_BeginTime release];
    [_tf_EndTime release];
    [_button_ShareToGetMoreMoney release];
    [_label_SearchLine release];
    [_label_AlertDateSetCount release];
    [_view_header release];
    [_alertView release];
    [_alertLable release];
    [_alertBtnOne release];
    [_alertBtnTwo release];
    [_alertNeedNumLable release];
    [_lineVIewOne release];
    [_lineViewTwo release];
    [_bgBtnView release];
    [super dealloc];
}

//
//@property (retain, nonatomic) IBOutlet UIView *alertView;
//@property (retain, nonatomic) IBOutlet UILabel *alertLable;
//@property (retain, nonatomic) IBOutlet UIButton *alertBtnOne;
//@property (retain, nonatomic) IBOutlet UIButton *alertBtnTwo;
//@property (retain, nonatomic) IBOutlet UILabel *alertNeedNumLable;
//@property (retain, nonatomic) IBOutlet UIView *lineVIewOne;
//@property (retain, nonatomic) IBOutlet UIView *lineViewTwo;

@end
