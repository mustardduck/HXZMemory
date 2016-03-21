//
//  SetUpNewPwdViewController.m
//  miaozhuan
//
//  Created by apple on 14/10/22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SetUpNewPwdViewController.h"
#import "UIView+expanded.h"
#import "UICommon.h"
#import "otherButton.h"
#import "Redbutton.h"
#import "LogonViewController.h"
#import "RRAttributedString.h"
#import "RRLineView.h"

@interface SetUpNewPwdViewController ()
{
    NSString * tel;
}
@property (retain, nonatomic) IBOutlet UILabel *strLable;
@property (retain, nonatomic) IBOutlet UILabel *phoneNumLable;
@property (retain, nonatomic) IBOutlet UITextField *identifyingCodeTxtField;
@property (retain, nonatomic) IBOutlet otherButton *rebloggingBtn;
@property (retain, nonatomic) IBOutlet UITextField *newpwdTxtfield;

@property (retain, nonatomic) IBOutlet UIButton *showBtn;
@property (retain, nonatomic) IBOutlet Redbutton *finishBtn;

@property (retain, nonatomic) IBOutlet UILabel *rebloggingLable;
@property (retain, nonatomic) IBOutlet UILabel *secCountLable;

- (IBAction)touchUpInsideBtn:(id)sender;
@property (retain, nonatomic) IBOutlet RRLineView *lineImageOne;
@property (retain, nonatomic) IBOutlet RRLineView *lineImageTwo;

@end

@implementation SetUpNewPwdViewController


- (void)viewWillDisappear:(BOOL)animated
{
    
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setRoundLoad];
    
    _lineImageOne.top = 49.5;
    _lineImageTwo.top = 49.5;
}

-(void) setRoundLoad
{
    [_rebloggingBtn roundCornerBorder];
    
    [_finishBtn roundCorner];
    
    [self addDoneToKeyboard:_identifyingCodeTxtField];
    
    [self addDoneToKeyboard:_newpwdTxtfield];
    
    _rebloggingBtn.h_color = AppColor(229);
    
    _rebloggingBtn.n_color = AppColorWhite;
    
    [_rebloggingBtn addTimer:60];
    
    NSString *String1 ;
    
    if ([_type isEqualToString:@"1"])
    {
        String1 = [[NSString alloc] initWithString:_phone];
        
        InitNav(@"设置新密码");
        
         [_rebloggingBtn startTimer];
        
        [_finishBtn setTitle:@"确认提交" forState:UIControlStateNormal];
        [_finishBtn setTitle:@"确认提交" forState:UIControlStateHighlighted];
    }
    else
    {
        _strLable.hidden = YES;
        
        _phoneNumLable.hidden = YES;
        
        [_finishBtn setTitle:@"确认修改" forState:UIControlStateNormal];
        [_finishBtn setTitle:@"确认修改" forState:UIControlStateHighlighted];
        
        InitNav(@"修改密码");
        
        String1 = [[NSString alloc] initWithString:[APP_DELEGATE.persistConfig getString:USER_INFO_NAME]];
    }
    
    tel = [APP_DELEGATE.persistConfig getString:USER_INFO_NAME];
    
    [tel retain];
    
    NSString *str = [String1 stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    _phoneNumLable.text = [NSString stringWithFormat:@"已发送验证码到您的手机  %@",str];

    NSAttributedString * attributedStringorderNumPrice = [RRAttributedString setText:_phoneNumLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 13)];
    
    _phoneNumLable.attributedText = attributedStringorderNumPrice;
    
    [String1 release];
}

-(void)hiddenKeyboard
{
    [_identifyingCodeTxtField resignFirstResponder];
    [_newpwdTxtfield resignFirstResponder];
}

- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _showBtn)
    {
        if (_showBtn.tag == 1)
        {
            [_showBtn setImage:[UIImage imageNamed:@"Visible"] forState:UIControlStateNormal];
            [_showBtn setImage:[UIImage imageNamed:@"Visible_hover"] forState:UIControlStateHighlighted];
            
            _showBtn.tag = 2;
            _newpwdTxtfield.secureTextEntry = NO;
        }
        else if (_showBtn.tag == 2)
        {
            [_showBtn setImage:[UIImage imageNamed:@"Invisible"] forState:UIControlStateNormal];
            [_showBtn setImage:[UIImage imageNamed:@"Invisible_hover"] forState:UIControlStateHighlighted];
            _showBtn.tag = 1;
            _newpwdTxtfield.secureTextEntry = YES;
        }
    }
    else if (sender == _rebloggingBtn)
    {
        if ([_type isEqualToString:@"1"])
        {
            ADAPI_adv3_GetPhoneCode([self genDelegatorID:@selector(HandleNotification:)], _phone, _imageCode, @"1", @"1",@"");
        }
        else
        {
            ADAPI_adv3_GetPhoneCode([self genDelegatorID:@selector(HandleNotification:)], tel, @"", @"5", @"1",@"");
        }
    }
    else if (sender == _finishBtn)
    {
        if ([_identifyingCodeTxtField.text isEqualToString:@""])
        {
            [HUDUtil showErrorWithStatus:@"请输入验证码"];
            return;
        }
        else if ([_newpwdTxtfield.text isEqualToString:@""])
        {
            [HUDUtil showErrorWithStatus:@"请输入新密码"];
            return;
        }
        else if (_newpwdTxtfield.text.length < 4)
        {
            [HUDUtil showErrorWithStatus:@"请输入4-20位密码"];
            return;
        }
        else if (_newpwdTxtfield.text.length >20)
        {
            [HUDUtil showErrorWithStatus:@"请输入4-20位密码"];
            return;
        }
        else
        {
            if ([_type isEqualToString:@"1"])
            {
                 NSString* userPassword = [APP_DELEGATE.persistConfig getString:USER_INFO_PASSWORD];
                
                if ([_newpwdTxtfield.text isEqualToString:userPassword])
                {
                    [HUDUtil showErrorWithStatus:@"当前密码与新密码一致，请重新输入"];
                    return;
                    [self hiddenKeyboard];
                }
                else
                {
                    ADAPI_adv3_ResetPassword([self genDelegatorID:@selector(HandleNotification:)], _phone, _newpwdTxtfield.text, _identifyingCodeTxtField.text);
                }
            }
            else
            {
                if ([_newpwdTxtfield.text isEqualToString:[APP_DELEGATE.persistConfig getString:USER_INFO_PASSWORD]])
                {
                    [HUDUtil showErrorWithStatus:@"当前密码与新密码一致，请重新输入"];
                    return;
                    [self hiddenKeyboard];
                }
                else
                {
                    ADAPI_adv3_CustomerCommon_ResetPassword([self genDelegatorID:@selector(HandleNotification:)],  _newpwdTxtfield.text, _identifyingCodeTxtField.text);
                }
            }
        }
        [self hiddenKeyboard];
    }
}

-(void)HandleNotification:(DelegatorArguments *) arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_ResetPassword])
    {
        [arguments logError];
        
        DictionaryWrapper * wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            [APP_DELEGATE.persistConfig set:USER_INFO_NAME value: _phone];
            [APP_DELEGATE.persistConfig set:USER_INFO_PASSWORD value: _newpwdTxtfield.text];
            //跳转登陆页面
            PUSH_VIEWCONTROLLER(LogonViewController);
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_CustomerCommon_ResetPassword])
    {
        [arguments logError];
        
        DictionaryWrapper * wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            [APP_DELEGATE.persistConfig set:USER_INFO_NAME value: tel];
            [APP_DELEGATE.persistConfig set:USER_INFO_PASSWORD value: _newpwdTxtfield.text];
            //跳转登陆页面
            PUSH_VIEWCONTROLLER(LogonViewController);
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_GetPhoneCode])
    {
        [arguments logError];
        
        DictionaryWrapper* wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            [_rebloggingBtn startTimer];
            
            _phoneNumLable.hidden = NO;
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
        else if ([wrapper getInt:@"Code"] == 1002 || [wrapper getInt:@"Code"] == 1001)
        {
            [self.navigationController popViewControllerAnimated:YES];
            
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
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

- (void)dealloc
{
    [tel release];
    
    [_phoneNumLable release];
    [_identifyingCodeTxtField release];
    [_rebloggingBtn release];

    [_newpwdTxtfield release];
    [_showBtn release];
    [_finishBtn release];
    [_rebloggingLable release];
    [_secCountLable release];
    
    [_strLable release];
    [_lineImageOne release];
    [_lineImageTwo release];
    [super dealloc];
}


@end
