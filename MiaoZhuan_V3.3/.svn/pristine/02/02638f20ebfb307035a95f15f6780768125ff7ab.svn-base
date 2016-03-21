//
//  LogonViewController.m
//  miaozhuan
//
//  Created by apple on 14/10/22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "LogonViewController.h"
#import "ForgetPasswordViewController.h"
#import "UIView+expanded.h"
#import "UICommon.h"
#import "ControlViewController.h"
#import "AppDelegate.h"
#import "Redbutton.h"
#import "OpenUDID.h"
#import "RRLineView.h"
#import "LoginViewController.h"
@interface LogonViewController ()
@property (retain, nonatomic) IBOutlet UITextField *phoneNumberTxtField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTxtfield;
@property (retain, nonatomic) IBOutlet Redbutton *lononBtn;
@property (retain, nonatomic) IBOutlet UIButton *forgetPwdBtn;

- (IBAction)touchUpInsideBtn:(id)sender;
@property (retain, nonatomic) IBOutlet RRLineView *lineImage;

@end

@implementation LogonViewController

@synthesize phoneNumberTxtField = _phoneNumberTxtField;
@synthesize passwordTxtfield = _passwordTxtfield;
@synthesize lononBtn = _lononBtn;
@synthesize forgetPwdBtn = _forgetPwdBtn;


-(void)viewWillAppear:(BOOL)animated
{
    NSString* userName = [APP_DELEGATE.persistConfig getString:USER_INFO_NAME];
    NSString* userPassword = [APP_DELEGATE.persistConfig getString:USER_INFO_PASSWORD];
    
    _phoneNumberTxtField.text = userName;
    _passwordTxtfield.text = userPassword;
    
    NSLog(@"--%@",[OpenUDID value]);
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"%@",[DotCUIManager instance].mainNavigationController.viewControllers);
    
    InitNav(@"登录");
    
    [_lononBtn roundCorner];
    
    _phoneNumberTxtField.delegate = self;
    _passwordTxtfield.delegate = self;
    
    _lineImage.top = 99.5;
    
    [self addDoneToKeyboard:_phoneNumberTxtField];
    [self addDoneToKeyboard:_passwordTxtfield];
}

- (void)onMoveBack:(UIButton *)sender
{
    PUSH_VIEWCONTROLLER(LoginViewController);
}

-(void)hiddenKeyboard
{
    [_phoneNumberTxtField resignFirstResponder];
    [_passwordTxtfield resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (_phoneNumberTxtField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11)
        {
            return NO;
        }
    }
    else if (_passwordTxtfield == textField)
    {
        if ([toBeString length] > 20) {
            return NO;
        }
    }
    return YES;
}

- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _forgetPwdBtn)
    {
        PUSH_VIEWCONTROLLER(ForgetPasswordViewController);
    }
    else if(sender == _lononBtn)
    {
        if ([_phoneNumberTxtField.text isEqualToString:@""])
        {
            [AlertUtil showAlert:@"" message:@"请先输入手机号" buttons:@[@"好的"]];
        }
        else if (_phoneNumberTxtField.text.length < 11)
        {
            [AlertUtil showAlert:@"" message:@"请输入正确手机号" buttons:@[@"好的"]];
        }
        else if ([_passwordTxtfield.text isEqualToString:@""])
        {
            [AlertUtil showAlert:@"" message:@"请输入密码" buttons:@[@"好的"]];
        }
        else
        {
            [self hiddenKeyboard];
            
            LGAPI_login([self genDelegatorID:@selector(HandleNotification:)], _phoneNumberTxtField.text, _passwordTxtfield.text, LOGIN_FROM_MANUAL);
        }
    }
}


- (void)HandleNotification:(DelegatorArguments *)arguments
{
    DictionaryWrapper *jasonData = arguments.ret;
    
    [arguments logError];
    
    if (jasonData.operationSucceed)
    {
        DictionaryWrapper* resultDic =  jasonData.data;
        
        NSLog(@"---resultdic----%@",resultDic.dictionary);
        
        [APP_DELEGATE onLoginRequestSucceed:arguments];
        
        [APP_DELEGATE gotoHome];
        
        [self sendToken];
        
    }
    else if(jasonData.operationPromptCode || jasonData.operationErrorCode)
    {
        APP_DELEGATE.userState = USER_STATE_LOGOUT;
        [AlertUtil showAlert:@"" message:jasonData.operationMessage buttons:@[@"好的"]];
        return;
    }
    else
    {
        [HUDUtil showErrorWithStatus:@"网络不给力,请检查后重试"];
        APP_DELEGATE.userState = USER_STATE_LOGOUT;
    }
}

- (void)sendToken
{
    NSString *a = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    NSString *b = [[NSUserDefaults standardUserDefaults] valueForKey:@"appid"];
    NSString *c = [[NSUserDefaults standardUserDefaults] valueForKey:@"userid"];
    NSString *d = [[NSUserDefaults standardUserDefaults] valueForKey:@"channelid"];
    NSString *e = [[NSUserDefaults standardUserDefaults] valueForKey:@"PushVersion"];
    
    if (!a||!b||!c||!d||!e) return;
    ADAPI_adv3_push_Update([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(responseReport:)],
                           a,
                           b,
                           c,
                           d,
                           e);
    //更新设备信息
}

- (void)responseReport:(DelegatorArguments *)arg
{
    NSLog(@"%@",arg.ret);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hiddenKeyboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [_phoneNumberTxtField release];
    [_passwordTxtfield release];
    [_lononBtn release];
    [_forgetPwdBtn release];
    [_lineImage release];
    [super dealloc];
}

@end
