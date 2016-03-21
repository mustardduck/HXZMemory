//
//  ThanksGivingViewController.m
//  miaozhuan
//
//  Created by apple on 14/10/21.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ThanksGivingViewController.h"
#import "PerfectInformationViewController.h"
#import "UIView+expanded.h"
#import "UICommon.h"
#import "MainViewController.h"
#import "Redbutton.h"

@interface ThanksGivingViewController ()<UIAlertViewDelegate,UITextFieldDelegate>
{
    NSString * autoPhoneNumber;
}
@property (retain, nonatomic) IBOutlet UITextField *phoneNumTxtField;
@property (retain, nonatomic) IBOutlet Redbutton *forThanksBtn;
@property (retain, nonatomic) IBOutlet UIView *showVIew;
@property (retain, nonatomic) IBOutlet UIView *succeedThanks;
@property (retain, nonatomic) IBOutlet UIView *errorThanks;
@property (retain, nonatomic) IBOutlet UILabel *forThanksPhoneLable;

- (IBAction)touchUpInsideBtn:(id)sender;
@end

@implementation ThanksGivingViewController
@synthesize phoneNumTxtField = _phoneNumTxtField;
@synthesize forThanksBtn = _forThanksBtn;
@synthesize showVIew = _showVIew;
@synthesize succeedThanks = _succeedThanks;
@synthesize errorThanks = _errorThanks;
@synthesize forThanksPhoneLable = _forThanksPhoneLable;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([_type isEqualToString:@"1"])
    {
        self.title = @"感恩";
        
        self.navigationItem.hidesBackButton = YES;
        
        [self setupMoveFowardButtonWithTitle:@"跳过"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleGetPhoneNum:) name:@"GetPhoneNum" object:nil];
    }
    else
    {
        self.navigationItem.hidesBackButton = NO;
        
        InitNav(@"感恩确认");
        
        DictionaryWrapper* dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
        
        //是否感恩
        if ([dic getBool:@"HasParent"])
        {
            [self.view addSubview:_succeedThanks];
            
            NSString *str = [[dic getString:@"ParentPhone"] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            
            _forThanksPhoneLable.text = str;
        }
        else
        {
            //手机是否感恩过
            if ([dic getBool:@"IsDeviceThankful"])
            {
                [self.view addSubview:_errorThanks];
            }
            else
            {
                
                NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                
               autoPhoneNumber = [defaults objectForKey:@"autoPhone"];
                [autoPhoneNumber retain];
                
                _phoneNumTxtField.text = autoPhoneNumber;
            }
        }
    }
    
    _phoneNumTxtField.delegate = self;
    
    [_forThanksBtn roundCorner];
    
//    if ([autoPhoneNumber isEqualToString:@""] || autoPhoneNumber == nil)
//    {
//        [self okbtnNo];
//    }
//    else
//    {
//        [self okbtnYes];
//    }
    
    [self addDoneToKeyboard:_phoneNumTxtField];
}

- (void)handleGetPhoneNum:(NSNotification *)noti
{
    NSLog(@"%@", noti.object);
    
    autoPhoneNumber = noti.object;
    
    [autoPhoneNumber retain];
    
    _phoneNumTxtField.text = autoPhoneNumber;
  
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    //保存感恩信息
    if ([arguments isEqualToOperation:ADOP_adv3_MemberCampaignSave])
    {
        [arguments logError];
        
        DictionaryWrapper * wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            DictionaryWrapper* resultDic = wrapper.data;
            
            NSLog(@"---保存感恩信息----%@",resultDic.dictionary);

            [AlertUtil showAlert:@"" message:@"恭喜您完成感恩！" buttons:@[@"好的"]];
            
            if ([_type isEqualToString:@"1"])
            {
                PUSH_VIEWCONTROLLER(PerfectInformationViewController);
            }
            else
            {
                [self.view addSubview:_succeedThanks];
                
                InitNav(@"感恩确认");
                
                NSString *str = [_phoneNumTxtField.text stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                
                _forThanksPhoneLable.text = str;
            }
            
            
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".HasParent" _Bool:YES];
            
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".ParentPhone" string:_phoneNumTxtField.text];
        }
        else if(wrapper.operationErrorCode || wrapper.operationPromptCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

- (void)onMoveFoward:(UIButton *)sender
{
    PUSH_VIEWCONTROLLER(PerfectInformationViewController);
    
    [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".HasParent" _Bool:NO];
    
    [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".ParentPhone" string:@""];
}

-(void)hiddenKeyboard
{
    [_phoneNumTxtField resignFirstResponder];
}


#pragma mark TextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (_phoneNumTxtField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11)
        {
            return NO;
        }
//        if ([toBeString length] >= 1)
//        {
//            [self okbtnYes];
//        }
//        else
//        {
//            [self okbtnNo];
//        }
    }
    return YES;
}

-(void) okbtnNo
{
    _forThanksBtn.backgroundColor = AppColorLightGray204;
    
    _forThanksBtn.userInteractionEnabled = NO;
}

-(void) okbtnYes
{
    _forThanksBtn.backgroundColor = AppColorRed;
    
    _forThanksBtn.userInteractionEnabled = YES;
}

- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _forThanksBtn)
    {
        if ([_phoneNumTxtField.text isEqualToString:@""])
        {
            [AlertUtil showAlert:@"" message:@"请先输入手机号" buttons:@[@"好的"]];
            return;
        }
        else if (_phoneNumTxtField.text.length < 11)
        {
            //号码位数不对
            [AlertUtil showAlert:@"" message:@"请填写正确手机号码" buttons:@[@"好的"]];
//            _phoneNumTxtField.text = @"";
            return;
        }
        else
        {
            NSString * title = [NSString stringWithFormat:@"感恩一旦提交就不能修改，您即将感恩的号码是%@,请确认？", _phoneNumTxtField.text];
            
            UIAlertView *tempAlertView = [[UIAlertView alloc] initWithTitle: @""
                                                                    message: title
                                                                   delegate: self
                                                          cancelButtonTitle: @"重填"
                                                          otherButtonTitles: @"确认",nil];
            [tempAlertView show];
            [tempAlertView release];
            return;
            
            [self hiddenKeyboard];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if ([autoPhoneNumber isEqualToString:_phoneNumTxtField.text])
        {
            ADAPI_adv3_MemberCampaignSave([self genDelegatorID:@selector(HandleNotification:)], @"1", _phoneNumTxtField.text);
        }
        else
        {
            ADAPI_adv3_MemberCampaignSave([self genDelegatorID:@selector(HandleNotification:)], @"2", _phoneNumTxtField.text);
        }
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [self hiddenKeyboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [autoPhoneNumber release];
    [_phoneNumTxtField release];
    [_forThanksBtn release];
    [_showVIew release];
    [_succeedThanks release];
    [_errorThanks release];
    [_forThanksPhoneLable release];
    [super dealloc];
}

@end
