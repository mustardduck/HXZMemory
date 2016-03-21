//
//  AddNextStepViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AddNextStepViewController.h"
#import "PeopleSettingViewController.h"
#import "RRDatePickerView.h"
#import "IndustryPicker.h"
#import "SendOutAreaViewController.h"
#import "AccurateService.h"
#import "AccurateManagerViewController.h"
#import "RRLineView.h"

@interface AddNextStepViewController ()<RRDatePickerDelegate, IndustryPickerDelegate, UITextFieldDelegate>{
    NSDate *_beginTime;
    int _row;
}
@property (retain, nonatomic) IBOutlet UIView *totalErrorView;
@property (retain, nonatomic) IBOutlet UILabel *lblTotalMsg;
@property (retain, nonatomic) IBOutlet UIView *mainView;
@property (retain, nonatomic) IBOutlet RRLineView *eline;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *lblArea;
@property (retain, nonatomic) IBOutlet UILabel *lblBeginTime;
@property (retain, nonatomic) IBOutlet UILabel *lblEndTime;
@property (retain, nonatomic) IBOutlet UILabel *lblPeople;
@property (retain, nonatomic) IBOutlet UITextField *txtPeoPleNum;
@property (retain, nonatomic) IBOutlet UILabel *lblTotalAds;

@property (nonatomic, retain) RRDatePickerView *datepicker;
@property (nonatomic, retain) IndustryPicker *pickerView;
@property (nonatomic, retain) NSDate *beginTime;
@end

@implementation AddNextStepViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigateTitle:@"新增红包广告"];
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"存入草稿"];

    [self _initDatePicker];
    [self _initPickerView];
    
    [self addDoneToKeyboard:_txtPeoPleNum];
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH, _scrollView.height);
    _scrollView.panGestureRecognizer.delaysTouchesBegan = YES;
    
    NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"TotalAdsNum"];
    _lblTotalAds.text = [NSString stringWithFormat:@"(当前剩余条数：%@条)", str];
    
    
    [self createErrorView];
}

#warning 3.2 修改添加顶部错误提示
- (void)createErrorView {
    
    if (_otherErrorMsg.length) {
        
        _totalErrorView.hidden = NO;
        _lblTotalMsg.text = _otherErrorMsg;
        
        CGSize size = [UICommon getSizeFromString:_otherErrorMsg withSize:CGSizeMake(290, MAXFLOAT) withFont:12];
        _lblTotalMsg.height = size.height;
        
        _totalErrorView.height = _lblTotalMsg.bottom + 15;
        
        _totalErrorView.top = 0;
        _mainView.top = _totalErrorView.bottom;
        
        _eline.top = _totalErrorView.height - 0.5;
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshPage];
}

- (int)countDayWithStartTime:(NSString *)start endTime:(NSString *)end{
    if (start.length && end.length) {
        NSDateFormatter *formatter = WEAK_OBJECT(NSDateFormatter, init);
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *sdate = [formatter dateFromString:start];
        NSDate *edate = [formatter dateFromString:end];
        NSTimeInterval interval = [edate timeIntervalSinceDate:sdate];
        return interval / (3600 * 24);
    }
    return 0;
}

- (void)refreshPage{

    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"SecondPage"];
    NSArray *options = [[NSUserDefaults standardUserDefaults] valueForKey:@"UploadData"];
    if (dic.count) {
        
        _txtPeoPleNum.text = [dic.wrapper getString:@"Count"];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ClearTime"]) {
            _lblBeginTime.text = _lblEndTime.text = @"未设置";
            
        } else {
            NSString *startTime = [UICommon formatTime:[dic.wrapper getString:@"StartTime"]];
            self.beginTime = [self formartTime:startTime];
            _lblBeginTime.text = [startTime length] ? startTime : @"未设置";
            NSString *endTime = [UICommon formatTime:[dic.wrapper getString:@"EndTime"]];
            int day = [self countDayWithStartTime:startTime endTime:endTime];
            _lblEndTime.text = day ? [NSString stringWithFormat:@"%d天后",day] : @"未设置";
        }
        
    }
    
    NSString *curtext = [[NSUserDefaults standardUserDefaults] valueForKey:@"CurText"];
    if (curtext.length) {
        _lblEndTime.text = curtext;
    }

    _lblArea.text = [options count] ? @"已设置" : @"未设置";
    
    
    int count = 0;
    NSArray *titles = [[NSUserDefaults standardUserDefaults] valueForKey:@"QuestionFields"];
    for (id title in titles) {
        BOOL flag = NO;
        if ([title isKindOfClass:[NSString class]]) {
            flag = [[NSUserDefaults standardUserDefaults] boolForKey:title];
        } else {
            flag = [[NSUserDefaults standardUserDefaults] boolForKey:[[title wrapper] getString:@"FieldName"]];
        }
        if (flag) {
            count++;
        }
    }
    if (count == titles.count) {
        _lblPeople.text = @"已设置";
    } else if (count > 0 && count < titles.count) {
        _lblPeople.text = @"未完成";
    } else {
        _lblPeople.text = @"未设置";
    }
    
}

- (NSDate *)formartTime:(NSString *)time{
    NSDateFormatter *formatter = WEAK_OBJECT(NSDateFormatter, init);
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter dateFromString:time];
}

- (void)_initPickerView{
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:7];
    for (int i = 1; i <= 7; i++) {
        NSString *str = [NSString stringWithFormat:@"%d天后", i];
        [temp addObject:str];
    }
    _pickerView = STRONG_OBJECT(IndustryPicker, initWithStyle:self pickerData:temp);
    _pickerView.delegate = self;
    _pickerView.fullBtn.hidden = YES;
    _pickerView.top = self.view.bottom;
    [self.view addSubview:_pickerView];
}

- (void)_initDatePicker{
    _datepicker = STRONG_OBJECT(RRDatePickerView, initWithTitle:@"");
    _datepicker.top = self.view.bottom;
    _datepicker.delegate = self;
    [self.view addSubview:_datepicker];
}

#pragma mark - RRDatePickerDelegate
- (void)clickSelectDatePickerWithDate:(NSDate *)date {
    NSLog(@"%@",date);
    
    self.beginTime = date;
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IsChanged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ClearTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self hiddenPicker];
    NSString *dateStr = [UICommon usaulFormatTime:date formatStyle:@"yyyy-MM-dd HH:mm"];
    if ([_datepicker.titleItem.title isEqualToString:@"选择日期"]) {
        _lblBeginTime.text = dateStr;
        self.beginTime = date;
    }
    [self saveSecondPage];
}
- (void)clickCancelDatePickerWithDate:(NSDate *)date{
    NSLog(@"%@",date);
    [self hiddenPicker];
}

- (void)getDateFromDatePickerWithDate:(NSString *)formatDate{
    _lblBeginTime.text = formatDate;
}

#pragma mark - IndustryPickerDelegate
- (void)pickerIndustryOk:(IndustryPicker *)picker{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IsChanged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ClearTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self hiddenPickerview];
    _row = (int)picker.index + 1;
    _lblEndTime.text = picker.curText;
    if (picker.curText.length) {
        [[NSUserDefaults standardUserDefaults] setValue:picker.curText forKey:@"CurText"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [self saveSecondPage];
}

- (void)pickerIndustryCancel:(IndustryPicker *)picker{
    [self hiddenPickerview];
}

#pragma mark - UITextFiledDelegaate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@"0"]) {
        textField.text = @"";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self saveData];
    return YES;
}

- (void)saveData{
    [self saveSecondPage];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IsChanged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 事件
- (NSString *)countDate:(int)dayCount{
    NSTimeInterval interval = dayCount * 24 *60 * 60;
    if (_beginTime) {
        NSDate *date = WEAK_OBJECT(NSDate, initWithTimeInterval:interval sinceDate:_beginTime);
        return [UICommon usaulFormatTime:date formatStyle:@"yyyy-MM-dd HH:mm"];
    }
    return @"";
}
//投放区域
- (IBAction)areaClicked:(id)sender {
    [self.view endEditing:YES];
    SendOutAreaViewController *areaVC = WEAK_OBJECT(SendOutAreaViewController, init);
    areaVC.block = ^(NSArray *value) {
        NSLog(@"%@",value);
    };
    [UI_MANAGER.mainNavigationController pushViewController:areaVC animated:YES];
}
//开始时间
- (IBAction)beginTimeClicked:(id)sender {
    [self hiddenPickerview];
    [self.view endEditing:YES];
    _datepicker.titleItem.title = @"选择日期";
    [_datepicker setMinDate:[NSDate date]];
    [UIView animateWithDuration:.3 animations:^{
        _datepicker.top = self.view.height - _datepicker.height;
    }];
}
//结束时间
- (IBAction)endTimeClicked:(id)sender {
    [self hiddenPicker];
    [self.view endEditing:YES];
    [UIView animateWithDuration:.3 animations:^{
        _pickerView.top = self.view.height - _pickerView.height;
    }];
}
//接收广告人群
- (IBAction)acceptClicked:(id)sender {
    [self.view endEditing:YES];
    PUSH_VIEWCONTROLLER(PeopleSettingViewController);
}
//隐藏datepicker
- (void)hiddenPicker{
    [UIView animateWithDuration:.3 animations:^{
        _datepicker.top = self.view.height;
    }];
}
//隐藏pickerview
- (void)hiddenPickerview{
    [UIView animateWithDuration:.3 animations:^{
        _pickerView.top = self.view.height;
    }];
}
//隐藏键盘
- (void)hiddenKeyboard{
    [self.view endEditing:YES];
    if (_txtPeoPleNum.text.length && [_txtPeoPleNum.text intValue] < 100) {
        _txtPeoPleNum.text = @"100";
    }
    
    NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"TotalAdsNum"];
    if ([str intValue] < [_txtPeoPleNum.text intValue]) {
        [HUDUtil showErrorWithStatus:@"剩余条数不足，请先购买广告条数"];
        return;
    }
    
    [self saveData];
    
}
//提交
- (IBAction)commitButtonClicked:(id)sender {
    
    [self.view endEditing:YES];
    if ([self checkInputData]) {
        [AccurateService commitWithDelegator:self selector:@selector(handleAdsCommit:)];
    }
}
//判断数据正确性
- (BOOL)checkInputData{
    if ([_lblArea.text isEqualToString:@"未设置"]) {
        [HUDUtil showErrorWithStatus:@"请设置投放区域"];return NO;
    }
    if ([_txtPeoPleNum.text isEqualToString:@""]) {
        [HUDUtil showErrorWithStatus:@"请填写投放人数"];return NO;
    }
    NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"TotalAdsNum"];
    if ([str intValue] < [_txtPeoPleNum.text intValue]) {
        [HUDUtil showErrorWithStatus:@"剩余条数不足，请先购买广告条数"];
        [_txtPeoPleNum becomeFirstResponder];
        return NO;
    }
    if ([_lblBeginTime.text isEqualToString:@"未设置"]) {
        [HUDUtil showErrorWithStatus:@"请请设置开始时间"];return NO;
    }
    if ([_lblEndTime.text isEqualToString:@"未设置"]) {
        [HUDUtil showErrorWithStatus:@"请设置结束时间"];return NO;
    }
    return YES;
}
- (void)onMoveFoward:(UIButton *)sender{
    //存入草稿箱
//    if ([_lblArea.text isEqualToString:@"未设置"] && [_txtPeoPleNum.text isEqualToString:@""] && [_lblBeginTime.text isEqualToString:@"未设置"] && [_lblEndTime.text isEqualToString:@"未设置"] && [_lblPeople.text isEqualToString:@"未设置"]) {
//        [HUDUtil showErrorWithStatus:@"暂无可保存内容"];return;
//    }
    [self.view endEditing:YES];
    [self saveSecondPage];
    [AccurateService saveDraftBoxWithDelegator:self selector:@selector(handleAdsSave:)];
}

- (void)saveSecondPage{
    
    NSString *correct = [self getTheCorrectNum:_txtPeoPleNum.text];
    _txtPeoPleNum.text = correct;
    
    NSString *beginTime = [_lblBeginTime.text isEqualToString:@"未设置"] ? @"" : _lblBeginTime.text;
    
    NSString *endTime = @"";
    if (_lblEndTime.text.length > 2) {
        NSString *str = [_lblEndTime.text substringToIndex:_lblEndTime.text.length - 2];
        endTime = [self countDate:[str intValue]];
    }
    NSDictionary *dic = @{
                          @"Count":correct,
                          @"StartTime":beginTime,
                          @"EndTime":endTime
                          };
    [[NSUserDefaults standardUserDefaults] setValue:dic forKey:@"SecondPage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(NSString*) getTheCorrectNum:(NSString*)tempString

{
    if (!tempString.length) {
        return @"";
    }
    
    while ([tempString hasPrefix:@"0"])
        
    {
        
        tempString = [tempString substringFromIndex:1];
        
    }
    
    return tempString;
    
}

#pragma mark - 网络请求回调
- (void)handleAdsSave:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"IsChanged"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setValue:[dic.data getString:@"DirectAdvertId"] forKey:@"CurrentDirectAdId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSDictionary *history = [[NSUserDefaults standardUserDefaults] valueForKey:@"FirstPage"];
        NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:history];
        [temp setValue:[dic.data getString:@"DirectAdvertId"] forKey:@"DirectAdvertId"];
        [[NSUserDefaults standardUserDefaults] setValue:temp forKey:@"FirstPage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [HUDUtil showSuccessWithStatus:@"保存成功"];
        
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (void)handleAdsCommit:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        NSLog(@"%@", [dic getDictionary:@"Data"]);
        [AccurateService clearData];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"IsChanged"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [HUDUtil showSuccessWithStatus:@"提交成功"];
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[AccurateManagerViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                break;
            }
        }
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}
#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_otherErrorMsg release];
    [_beginTime release];
    [_datepicker release];
    [_pickerView release];
    [_scrollView release];
    [_lblArea release];
    [_lblBeginTime release];
    [_lblEndTime release];
    [_lblPeople release];
    [_txtPeoPleNum release];
    [_lblTotalAds release];
    [_totalErrorView release];
    [_lblTotalMsg release];
    [_mainView release];
    [_eline release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setScrollView:nil];
    [self setLblArea:nil];
    [self setLblBeginTime:nil];
    [self setLblEndTime:nil];
    [self setLblPeople:nil];
    [self setTxtPeoPleNum:nil];
    [self setLblTotalAds:nil];
    [super viewDidUnload];
}
@end
