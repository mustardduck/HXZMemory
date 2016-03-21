//
//  PerfectInformationViewController.m
//  miaozhuan
//
//  Created by apple on 14/10/21.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PerfectInformationViewController.h"
#import "ThanksGivingViewController.h"
#import "UIView+expanded.h"
#import "UICommon.h"
#import "Redbutton.h"


@interface PerfectInformationViewController ()
{
    DatePickerViewController *datePickerView;
    
    NSArray * _birthdayPickerArray;
    
    NSArray * _revenuePickerArray;
    
    CGFloat offsetY;
    
    IndustryPicker *industryPicker;
    
    int btnTag;
    
    NSMutableArray * _textArray;
    
    NSString * _AnnualIncome;
    
    int tag;
}

@property (retain, nonatomic) IBOutlet UITextField *nameTxtField;
@property (retain, nonatomic) IBOutlet UILabel *sexTxtField;
@property (retain, nonatomic) IBOutlet UILabel *birthdayTxtField;
@property (retain, nonatomic) IBOutlet UILabel *revenueTxtField;
@property (retain, nonatomic) IBOutlet UIButton *sexBtn;
@property (retain, nonatomic) IBOutlet UIButton *birthdayBtn;
@property (retain, nonatomic) IBOutlet UIButton *revenueBtn;
@property (retain, nonatomic) IBOutlet Redbutton *nextBtn;

@property (retain, nonatomic) NSArray *birthdayPickerArray;
@property (retain, nonatomic) NSArray *revenuePickerArray;
@property (retain, nonatomic) NSString * AnnualIncome;

- (IBAction)touchUpInsideBtn:(id)sender;
@end

@implementation PerfectInformationViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"完善个人资料";
    
    self.navigationItem.hidesBackButton = YES;
    
    [self setupMoveFowardButtonWithTitle:@"跳过"];
    
    [_nextBtn roundCorner];
    
    [self addDoneToKeyboard:_nameTxtField];
    
    offsetY = [UICommon getIos4OffsetY];
    
    _birthdayPickerArray = [[NSArray alloc] initWithObjects:@"男",@"女", nil];
}

- (void)onMoveFoward:(UIButton *)sender
{
    tag = 1;
    
    [APP_DELEGATE gotoHome];
    
    [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".Gender" string:@"1"];
}


-(void)hiddenKeyboard
{
    [_nameTxtField resignFirstResponder];
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    //获取收入区间
    if ([arguments isEqualToOperation:ADOP_adv3_CustomerSurvey_GetQuestion])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            DictionaryWrapper* resultDic = wrapper.data;
        
            _revenuePickerArray = [resultDic getArray:@"Options"];
            
            [_revenuePickerArray retain];
            
            _textArray = WEAK_OBJECT(NSMutableArray, init);
            
            for (int i = 0; i< [_revenuePickerArray count]; i++)
            {
                [_textArray addObject:[[_revenuePickerArray[i] wrapper] getString:@"Text"]];
            }
            
            [self setPickerViewWith:@"收入区间"];
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
    //提交资料
    else if ([arguments isEqualToOperation:ADOP_adv3_PerfectInformation])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            int gender;
            
            if ([_sexTxtField.text isEqualToString:@"男"])
            {
                gender = 1;
            }
            else
            {
                gender = 2;
            }
            
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".Gender" string:[NSString stringWithFormat:@"%d",gender]];
            
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".TrueName" string:_nameTxtField.text];
            
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".Birthday" string:_birthdayTxtField.text];
            
            [APP_DELEGATE gotoHome];
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _nextBtn)
    {
//        if ([_nameTxtField.text isEqualToString:@""])
//        {
//            [AlertUtil showAlert:@"" message:@"请填写您的真实姓名" buttons:@[@"好的"]];
//        }
//        else if ([_birthdayTxtField.text isEqualToString:@""])
//        {
//            [AlertUtil showAlert:@"" message:@"请设置您的生日" buttons:@[@"好的"]];
//        }
//        else if ([_revenueTxtField.text isEqualToString:@""])
//        {
//            [AlertUtil showAlert:@"" message:@"请设置您的收入区间" buttons:@[@"好的"]];
//        }
//        else
//        {
            NSString * gender;
            
            if ([_sexTxtField.text isEqualToString:@"男"])
            {
                gender = @"1";
            }
            else
            {
                gender = @"2";
            }
            
            NSLog(@"--%@",_birthdayTxtField.text);

            NSLog(@"--_AnnualIncome%@",_AnnualIncome);
        
        if (_AnnualIncome == nil)
        {
            _AnnualIncome = @"";
        }
        
            
            //提交资料
            ADAPI_adv3_PerfectInformation([self genDelegatorID:@selector(HandleNotification:)], _nameTxtField.text, gender, _birthdayTxtField.text, _AnnualIncome);
        
//        }
    }
    else if (sender == _birthdayBtn)
    {
        [self setDatePickerView];
        
        datePickerView.picker.date = [NSDate date];
        
        datePickerView.view.tag = 200;
        
        [self.view addSubview:datePickerView.view];
        
        [self hiddenKeyboard];
    }
    else if (sender == _sexBtn)
    {
        [self setPickerViewWith:@"性别"];
        
        btnTag = 1;
        
        [self hiddenKeyboard];
    }
    else if (sender == _revenueBtn)
    {
        ADAPI_adv3_CustomerSurvey_GetQuestion([self genDelegatorID:@selector(HandleNotification:)], @"9", @"");
        btnTag = 2;
    }
}

#pragma mark UIPickerView

-(void) setDatePickerView
{
    datePickerView = [[DatePickerViewController alloc]initWithNibName:@"DatePickerViewController" bundle:nil];
    
    datePickerView.view.frame = CGRectMake(0, 0, 320, 460 + offsetY);
    
    datePickerView.delegate = self;
}

-(void) setPickerViewWith :(NSString *) title
{
    if ([title isEqualToString:@"性别"])
    {
        industryPicker = [[IndustryPicker alloc]initWithStyle:self pickerData:_birthdayPickerArray];
        
        [industryPicker initwithtitles:1];
    }
    else
    {
        industryPicker = [[IndustryPicker alloc]initWithStyle:self pickerData:_textArray];
        
        [industryPicker initwithtitles:2];
    }
    
    industryPicker.frame = CGRectMake(0, 0, 320, 460 + offsetY);
    
    industryPicker.delegate = self;
    
    [self.view addSubview:industryPicker];
}


- (void) selectDateCallBack:(NSDate*)date
{
    [datePickerView.view removeFromSuperview];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString* text = [dateFormatter stringFromDate:date];
    
    if (datePickerView.view.tag == 200)
    {
        _birthdayTxtField.text = text;
    }
}

- (void) cancelDateCallBack:(NSDate*)date
{
    [datePickerView.view removeFromSuperview];
}

- (void)pickerIndustryOk:(IndustryPicker *)picker
{
    if (btnTag == 1)
    {
         _sexTxtField.text = picker.curText;
    }
    else
    {
         _revenueTxtField.text = picker.curText;
        
        _AnnualIncome = [NSString stringWithFormat:@"%d",[[_revenuePickerArray[picker.index]wrapper]getInt:@"Id"]];
        [_AnnualIncome retain];
    }
    [picker removeFromSuperview];
    
    [industryPicker release];
    
    industryPicker = nil;
}

- (void)pickerIndustryCancel:(IndustryPicker *)picker
{
    [picker removeFromSuperview];
    
    [industryPicker release];
    
    industryPicker = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    
    if (tag == 1)
    {
        
    }
    else
    {
        [_AnnualIncome release];
        
        [datePickerView release];
        
        [_revenuePickerArray release];
        
        _revenuePickerArray = nil;
    }
    
    [_nameTxtField release];
    
    [_sexTxtField release];
    
    [_birthdayTxtField release];
    
    [_revenueTxtField release];
    
    [_sexBtn release];
    
    [_birthdayBtn release];
    
    [_revenueBtn release];
    
    [_nextBtn release];
    
    [_birthdayPickerArray release];
    
    _birthdayPickerArray = nil;
    
    
    [super dealloc];
}


@end
