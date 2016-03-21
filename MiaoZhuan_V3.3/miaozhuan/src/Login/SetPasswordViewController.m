//
//  SetPasswordViewController.m
//  miaozhuan
//
//  Created by apple on 14/10/22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "ThanksGivingViewController.h"
#import "PerfectInformationViewController.h"
#import "UIView+expanded.h"
#import "DelegatorManager.h"
#import "Redbutton.h"
#import "AppDelegate.h"

#import "LogonViewController.h"


@interface SetPasswordViewController ()<UIAlertViewDelegate>
@property (retain, nonatomic) IBOutlet UITextField *passwordTxtField;
@property (retain, nonatomic) IBOutlet Redbutton *finishRegistrationBtn;

- (IBAction)touchUpInsideBtn:(id)sender;
@end

@implementation SetPasswordViewController
@synthesize passwordTxtField = _passwordTxtField;
@synthesize finishRegistrationBtn = _finishRegistrationBtn;
@synthesize userName;
@synthesize validateCode;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    InitNav(@"注册2/2");
    
    [_finishRegistrationBtn roundCorner];
    _passwordTxtField.delegate = self;
    
    [self addDoneToKeyboard:_passwordTxtField];
}
-(void)hiddenKeyboard
{
    [_passwordTxtField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (_passwordTxtField == textField)
    {
        if ([toBeString length] > 20)
        {
            return NO;
        }
    }
    return YES;
}

- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _finishRegistrationBtn)
    {
        if ([_passwordTxtField.text isEqualToString:@""])
        {
            //为空
            [AlertUtil showAlert:@"" message:@"请设置密码" buttons:@[@"好的"]];
        }
        else if (_passwordTxtField.text.length < 4)
        {
            //长度不对
            [AlertUtil showAlert:@"" message:@"密码长度请设置为4-20位字符" buttons:@[@"好的"]];
            _passwordTxtField.text = @"";
        }
        else
        {
            [self hiddenKeyboard];
                        
            LGAPI_register([self genDelegatorID:@selector(HandleNotification:)], userName, _passwordTxtField.text);
            
        }
    }
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:LGOP_register])
    {
        [arguments logError];
        
        DictionaryWrapper *jasonData = arguments.ret;

        if (jasonData.operationSucceed)
        {
            [AlertUtil showAlert:@"恭喜" message:@"您已经完成注册！" buttons:@[@"好的"]];

            [APP_DELEGATE.persistConfig set:USER_INFO_NAME value: userName];
            
            [APP_DELEGATE.persistConfig set:USER_INFO_PASSWORD value: _passwordTxtField.text];
            
            [APP_DELEGATE onLoginRequestSucceed:arguments];
            
            /***以下两句代码决定是否感恩包,是感恩包，代码留下，非感恩包，两句代码注释掉***/
            
            NSString * urls = [NSString stringWithFormat:@"http://down.inkey.com/thanks/%@",userName];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urls]];

            /******/
            
            
            DictionaryWrapper* dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
            
            //手机是否感恩过
            if ([dic getBool:@"IsDeviceThankful"])
            {
                PUSH_VIEWCONTROLLER(PerfectInformationViewController);
            }
            else
            {
                PUSH_VIEWCONTROLLER(ThanksGivingViewController);
                model.type = @"1";
            }
        }
        else if(jasonData.operationPromptCode || jasonData.operationErrorCode)
        {
            APP_DELEGATE.userState = USER_STATE_LOGOUT;
            
            [AlertUtil showAlert:@"" message:jasonData.operationMessage buttons:@[@"好的"]];
            return;
        }
        else if (jasonData.operationDealWithCode)
        {
            APP_DELEGATE.userState = USER_STATE_LOGOUT;
            
            //跳转登陆
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:jasonData.operationMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"直接登录", nil];
            [alert show];
            [alert release];
            return;
        }
        else
        {
            APP_DELEGATE.userState = USER_STATE_LOGOUT;
        }
        
        _passwordTxtField.text = @"";
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        PUSH_VIEWCONTROLLER(LogonViewController);
        
        [APP_DELEGATE.persistConfig set:USER_INFO_NAME value: userName];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [_passwordTxtField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [_passwordTxtField release];
    [_finishRegistrationBtn release];
    [super dealloc];
}


@end
