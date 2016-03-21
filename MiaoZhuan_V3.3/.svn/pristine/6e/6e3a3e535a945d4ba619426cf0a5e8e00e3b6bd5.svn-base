//
//  PhoneAuthenticationViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PhoneAuthenticationViewController.h"
#import "UIView+expanded.h"
#import "RRAttributedString.h"
#import "otherButton.h"
#import "Redbutton.h"
#import "RRLineView.h"
@interface PhoneAuthenticationViewController ()<UITextFieldDelegate>
{
    NSString * phone;
    
    int tag;
}
@property (retain, nonatomic) IBOutlet UIButton *msessageBtn;
@property (retain, nonatomic) IBOutlet UIButton *phoneticBtn;
@property (retain, nonatomic) IBOutlet UIView *messageView;
@property (retain, nonatomic) IBOutlet UIView *yuyinView;
@property (retain, nonatomic) IBOutlet UITextField *messageImageCode;
@property (retain, nonatomic) IBOutlet UITextField *messageCode;
@property (retain, nonatomic) IBOutlet UIImageView *messageImage;
@property (retain, nonatomic) IBOutlet otherButton *messageGetCode;

@property (retain, nonatomic) IBOutlet UITextField *yuyinCodeTxt;
@property (retain, nonatomic) IBOutlet otherButton *yuyinGetCodeBtn;
@property (retain, nonatomic) IBOutlet UILabel *messagePhoneLable;
@property (retain, nonatomic) IBOutlet UILabel *yuyinPhoneLable;
@property (retain, nonatomic) IBOutlet UIView *succeedView;
@property (retain, nonatomic) IBOutlet UIView *showView;

@property (retain, nonatomic) IBOutlet UIView *messagebgView;
- (IBAction)touchUpInsideBtn:(id)sender;
- (IBAction)getImageCodeBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *getImageCodeBtns;
@property (retain, nonatomic) IBOutlet Redbutton *okBtn;
@property (retain, nonatomic) IBOutlet RRLineView *lineImage;

@property (retain, nonatomic) IBOutlet UIView *othervw;
@end

@implementation PhoneAuthenticationViewController


-(void)viewWillAppear:(BOOL)animated
{
    [self SetMessageView];
}

//获取图片验证码
-(void) setImageCode
{
    ADAPI_adv3_GetCaptcha([self genDelegatorID:@selector(HandleNotification:)],@"");
}

-(void)HandleNotification: (DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_GetCaptcha])
    {
        UIImage * image = [[UIImage alloc] initWithData:(NSData *)arguments.ret];
        
        _messageImage.image = image;
        
        [image release];
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_GetPhoneCode])
    {
        [arguments logError];
        
        DictionaryWrapper* wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            if (tag == 1)
            {
                //获取短信验证码
                [_messageGetCode startTimer];
                
                _messagebgView.backgroundColor = AppColorBackground;
                
                _messagebgView.tag = 2;
                
                //输入框禁用
                
                _messageImageCode.userInteractionEnabled = NO;
                
                _getImageCodeBtns.userInteractionEnabled = NO;
            }
            else if (tag == 2)
            {
                [_yuyinGetCodeBtn startTimer];
            }
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
        else if ([wrapper getInt:@"Code"] == 1002 || [wrapper getInt:@"Code"] == 1001)
        {
            if (tag == 1)
            {
                _messageImageCode.userInteractionEnabled = YES;
    
                _getImageCodeBtns.userInteractionEnabled = YES;
    
                _messagebgView.backgroundColor = [UIColor whiteColor];
    
                _messageImageCode.text = @"";
    
                [self setImageCode];
                
                _messagebgView.tag = 1;
            }
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_VerifyPhone])
    {
        [arguments logError];
        
        DictionaryWrapper* wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            [self.view addSubview:_succeedView];
            
            NSString *str = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            
            _yuyinPhoneLable.text = str;
            
            //保存信息
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".IsPhoneVerified" _Bool:YES];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"手机认证");
    
    [self addDoneToKeyboard:_messageImageCode];
    
    [self addDoneToKeyboard:_messageCode];
    
    [self addDoneToKeyboard:_yuyinCodeTxt];
    
    [_othervw roundCornerBorder];
    
    _lineImage.top = 49.5;
    
    [self setRound];
}

-(void) setRound
{
    _messageView.hidden = NO;
    
    [_messageGetCode roundCornerBorder];
    
    [_yuyinGetCodeBtn roundCornerBorder];
    
    _messageGetCode.h_color = AppColor(229);
    
    [self okbtnNo];
    
    _messageGetCode.n_color = AppColorWhite;
    
    [_messageGetCode addTimer:60];
    
    _yuyinGetCodeBtn.h_color = AppColor(229);
    
    _yuyinGetCodeBtn.n_color = AppColorWhite;
    
    [_yuyinGetCodeBtn addTimer:60];
}

-(void)hiddenKeyboard
{
    [_messageImageCode resignFirstResponder];
    [_messageCode resignFirstResponder];
    [_yuyinCodeTxt resignFirstResponder];
}

-(void) SetMessageView
{
    DictionaryWrapper * dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    phone = [APP_DELEGATE.persistConfig getString:USER_INFO_NAME];
    
    NSString *str = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    _showView.hidden = YES;
    
    if ([dic getBool:@"IsPhoneVerified"])
    {
        _yuyinPhoneLable.text = str;

        [self.view addSubview:_succeedView];
    }
    else
    {
        _messagePhoneLable.text = [NSString stringWithFormat:@"我们将对%@进行手机认证",str];
        
        NSAttributedString * nowattributedString = [RRAttributedString setText:_messagePhoneLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(4, 11)];
        
        _messagePhoneLable.attributedText = nowattributedString;
        
        _messagebgView.backgroundColor = [UIColor whiteColor];
        
        _messagebgView.tag = 1;
        
//        [self setImageCode];
    }
}

- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _msessageBtn)
    {
        _messageView.hidden = NO;
        _yuyinView.hidden = YES;
        [self hiddenKeyboard];
    }
    else if (sender == _phoneticBtn)
    {
        _messageView.hidden = YES;
        _yuyinView.hidden = NO;
        [self hiddenKeyboard];
    }
    else if (sender == _messageGetCode)
    {
        [self hiddenKeyboard];

        if ([_messageImageCode.text isEqualToString:@""])
        {
            [HUDUtil showErrorWithStatus:@"请输入图片验证码"];
            return;
        }
        else
        {
            ADAPI_adv3_GetPhoneCode([self genDelegatorID:@selector(HandleNotification:)], phone, _messageImageCode.text, @"3", @"1",@"");
            tag = 1;
        }
    }
    else if (sender == _yuyinGetCodeBtn)
    {
        //获取语音验证码
        [self hiddenKeyboard];
        
        ADAPI_adv3_GetPhoneCode([self genDelegatorID:@selector(HandleNotification:)], phone, @"", @"3", @"2",@"");
        tag = 2;
    }
    else if (sender == _okBtn)
    {
//        if (_messageView.hidden == NO)
//        {
//            ADAPI_adv3_VerifyPhone([self genDelegatorID:@selector(HandleNotification:)], _messageCode.text);
//        }
//        else
//        {
            ADAPI_adv3_VerifyPhone([self genDelegatorID:@selector(HandleNotification:)], _yuyinCodeTxt.text);
//        }
        
        [self hiddenKeyboard];
    }
}

- (IBAction)getImageCodeBtn:(id)sender
{
    [self setImageCode];
}

-(void) okbtnNo
{
    _okBtn.backgroundColor = AppColorLightGray204;
    
    _okBtn.userInteractionEnabled = NO;
}

-(void) okbtnYes
{
    _okBtn.backgroundColor = AppColorRed;
    
    _okBtn.userInteractionEnabled = YES;
}

#pragma mark TextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (_messageCode == textField)
    {
        if ([toBeString length] >= 1)
        {
            [self okbtnYes];
        }
        else
        {
            [self okbtnNo];
        }
    }
    else if (textField == _messageImageCode)
    {
        if ([toBeString length] >= 1)
        {
            [self okbtnYes];
        }
        else
        {
            [self okbtnNo];
        }
    }
    else if(textField == _yuyinCodeTxt)
    {
        if ([toBeString length] > 0)
        {
            [self okbtnYes];
        }
        else if([toBeString length] == 0)
        {
            [self okbtnNo];
        }
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _messageImageCode || textField == _messageCode || textField == _yuyinCodeTxt)
    {
        [self animateTextField: textField up: YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _messageImageCode || textField == _messageCode || textField == _yuyinCodeTxt)
    {
        [self animateTextField: textField up: NO];
    }
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int movementDistance = 0;
    
    float movementDuration = 0.3f;
    
    if (textField == _messageImageCode || textField == _yuyinCodeTxt)
    {
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            movementDistance = 100;
        }
        else
        {
            movementDistance = 130;
        }
    }
    else if (textField == _messageCode)
    {
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            movementDistance = 110;
        }
        else
        {
            movementDistance = 150;
        }
    }
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    
    [UIView setAnimationBeginsFromCurrentState: YES];
    
    [UIView setAnimationDuration: movementDuration];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_msessageBtn release];
    [_phoneticBtn release];
    [_messageView release];
    [_yuyinView release];
    [_messageImageCode release];
    [_messageCode release];
    [_messageImage release];
    [_messageGetCode release];
    [_yuyinCodeTxt release];
    [_yuyinGetCodeBtn release];
    [_messagePhoneLable release];
    [_yuyinPhoneLable release];
    [_succeedView release];
    [_showView release];
    [_messagebgView release];
    [_getImageCodeBtns release];
    [_okBtn release];
    [_lineImage release];
    [_othervw release];
    [super dealloc];
}

- (void)viewDidUnload {

    [self setMsessageBtn:nil];
    [self setPhoneticBtn:nil];
    [self setMessageView:nil];
    [self setYuyinView:nil];
    [self setMessageImageCode:nil];
    [self setMessageCode:nil];
    [self setMessageImage:nil];
    [self setMessageGetCode:nil];
    [self setYuyinCodeTxt:nil];
    [self setYuyinGetCodeBtn:nil];
    [self setMessagePhoneLable:nil];
    [self setYuyinPhoneLable:nil];
    [self setSucceedView:nil];
    [self setShowView:nil];
    [super viewDidUnload];
}

@end
