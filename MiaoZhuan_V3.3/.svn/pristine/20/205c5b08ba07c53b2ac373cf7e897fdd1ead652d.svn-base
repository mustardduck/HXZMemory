//
//  ForgetPasswordViewController.m
//  miaozhuan
//
//  Created by apple on 14/10/22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "SetUpNewPwdViewController.h"
#import "UIView+expanded.h"
#import "UICommon.h"
#import "Redbutton.h"
#import "RRLineView.h"
@interface ForgetPasswordViewController ()<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *phoneNumTxtfield;
@property (retain, nonatomic) IBOutlet Redbutton *nextBtn;
@property (retain, nonatomic) IBOutlet UITextField *identifyingCodeTxtField;
@property (retain, nonatomic) IBOutlet UIButton *identifyingCodeBtn;
@property (retain, nonatomic) IBOutlet UIImageView *identifyingCodeImage;
@property (retain, nonatomic) IBOutlet RRLineView *lineImageOne;
@property (retain, nonatomic) IBOutlet RRLineView *lineImageTwo;

- (IBAction)touchUpInsideBtn:(id)sender;

@end

@implementation ForgetPasswordViewController

@synthesize phoneNumTxtfield = _phoneNumTxtfield;
@synthesize nextBtn = _nextBtn;
@synthesize identifyingCodeImage = _identifyingCodeImage;
@synthesize identifyingCodeTxtField = _identifyingCodeTxtField;
@synthesize identifyingCodeBtn = _identifyingCodeBtn;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    InitNav(@"忘记密码");
    
    [_nextBtn roundCorner];
    
    _lineImageOne.top = 49.5;
    _lineImageTwo.top = 49.5;
    
    [self addDoneToKeyboard:_phoneNumTxtfield];
    [self addDoneToKeyboard:_identifyingCodeTxtField];
    
    _phoneNumTxtfield.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getCaptcha];
}

//获取图片验证码
-(void)getCaptcha
{
    ADAPI_adv3_GetCaptcha([self genDelegatorID:@selector(HandleNotification:)],@"");
}

-(void)hiddenKeyboard
{
    [_phoneNumTxtfield resignFirstResponder];
    [_identifyingCodeTxtField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (_phoneNumTxtfield == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11)
        {
            return NO;
        }
        _identifyingCodeTxtField.text = @"";
    }
    return YES;
}

- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender ==  _nextBtn)
    {
        if ([_phoneNumTxtfield.text isEqualToString:@""])
        {
            [HUDUtil showErrorWithStatus:@"请先输入手机号"];
            return;
        }
        else if (_phoneNumTxtfield.text.length < 11)
        {
            //号码位数不对
            [HUDUtil showErrorWithStatus:@"请填写正确手机号码"];
            _phoneNumTxtfield.text = @"";
            return;
        }
        else if ([_identifyingCodeTxtField.text isEqualToString:@""])
        {
            [HUDUtil showErrorWithStatus:@"请输入验证码"];
            return;
        }
        else
        {
            
            [self hiddenKeyboard];
            
            ADAPI_adv3_GetPhoneCode([self genDelegatorID:@selector(HandleNotification:)], _phoneNumTxtfield.text, _identifyingCodeTxtField.text, @"1", @"1",@"");
        }
    }
    else if (sender == _identifyingCodeBtn)
    {
        [self getCaptcha];
    }
}

-(void)HandleNotification: (DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_GetCaptcha])
    {
        UIImage * image = [[UIImage alloc] initWithData:(NSData *)arguments.ret];
        
        _identifyingCodeImage.image = image;
        
        [image release];
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_GetPhoneCode])
    {
        [arguments logError];
        
        DictionaryWrapper* wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {            
            //跳转设置新密码页面
            PUSH_VIEWCONTROLLER(SetUpNewPwdViewController);
            
            model.phone = _phoneNumTxtfield.text;
            model.imageCode = _identifyingCodeTxtField.text;
            model.type = @"1";
            
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            _phoneNumTxtfield.text = @"";
            _identifyingCodeTxtField.text = @"";
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            
            return;
        }
        else if ([wrapper getInt:@"Code"] == 1002 || [wrapper getInt:@"Code"] == 1001)
        {
            _identifyingCodeTxtField.text = @"";
            
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [self hiddenKeyboard];
}


- (void)dealloc
{
    [_phoneNumTxtfield release];
    [_nextBtn release];
    [_identifyingCodeTxtField release];
    [_identifyingCodeImage release];
    [_identifyingCodeBtn release];
    [_lineImageOne release];
    [_lineImageTwo release];
    [super dealloc];
}


@end
