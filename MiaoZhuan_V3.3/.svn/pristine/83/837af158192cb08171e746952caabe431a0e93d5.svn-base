//
//  RegisterOneViewController.m
//  miaozhuan
//
//  Created by apple on 14/10/21.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RegisterOneViewController.h"
#import "SetPasswordViewController.h"
#import "UIView+expanded.h"
#import "DelegatorManager.h"
#import "Redbutton.h"
#import "HightedButton.h"
#import "RRAttributedString.h"
#import "LogonViewController.h"
#import "WebhtmlViewController.h"
#import "Share_Method.h"
#import <ShareSDK/ShareSDK.h>
#import "JSONKit.h"
#import "RRLineView.h"

@interface RegisterOneViewController ()<UIAlertViewDelegate>

@property (retain, nonatomic) IBOutlet UITextField *phoneNumTxtField;
@property (retain, nonatomic) IBOutlet UITextField *identifyingCodeTxtField;
@property (retain, nonatomic) IBOutlet HightedButton *identifyingCodeBtn;
@property (retain, nonatomic) IBOutlet Redbutton *nextBtn;
@property (retain, nonatomic) IBOutlet UILabel *agreementLable;
@property (retain, nonatomic) IBOutlet RRLineView *lineImage;
@property (nonatomic, retain) NSTimer  *getCodeTimer;                        //获取验证码计时器
@property (nonatomic, assign) BOOL     isTimeGetCode;                        //是否定时器生成，而非接口调用生成

- (IBAction)touchUpInsideBtn:(id)sender;
- (IBAction)xieyiBtn:(id)sender;

@end

@implementation RegisterOneViewController

@synthesize phoneNumTxtField = _phoneNumTxtField;
@synthesize identifyingCodeBtn = _identifyingCodeBtn;
@synthesize identifyingCodeTxtField = _identifyingCodeTxtField;
@synthesize nextBtn = _nextBtn;
@synthesize agreementLable = _agreementLable;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    InitNav(@"注册1/2");
    
    _lineImage.top = 99.5;
    
    [_identifyingCodeBtn roundCorner];
    _identifyingCodeBtn.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    [_nextBtn roundCorner];
    
    _phoneNumTxtField.delegate = self;
    _identifyingCodeTxtField.delegate = self;
    
    [self addDoneToKeyboard:_phoneNumTxtField];
    [self addDoneToKeyboard:_identifyingCodeTxtField];
    
    
    NSAttributedString *attributedString = [RRAttributedString setText:_agreementLable.text color:RGBCOLOR(34, 34, 34) range:NSMakeRange(16, _agreementLable.text.length - 16)];
    _agreementLable.attributedText = attributedString;
}

-(void)hiddenKeyboard
{
    [_identifyingCodeTxtField resignFirstResponder];
    [_phoneNumTxtField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (_phoneNumTxtField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11)
        {
            return NO;
        }
        _identifyingCodeTxtField.text = @"";
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    //返回一个BOOL值指明是否允许根据用户请求清除内容
    //可以设置在特定条件下才允许清除内容
    _identifyingCodeTxtField.text = @"";
    
    return YES;
}

- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _nextBtn)
    {
        if ([_phoneNumTxtField.text isEqualToString:@""])
        {
            [AlertUtil showAlert:@"" message:@"请先输入手机号" buttons:@[@"好的"]];
        }
        else if (_phoneNumTxtField.text.length < 11)
        {
            //号码位数不对
            [AlertUtil showAlert:@"" message:@"请填写正确手机号码" buttons:@[@"好的"]];
//            _phoneNumTxtField.text = @"";

        }
        else if ([_identifyingCodeTxtField.text isEqualToString:@""])
        {
            //未获取验证码
            [AlertUtil showAlert:@"" message:@"请获取验证码" buttons:@[@"好的"]];
            
            [self hiddenKeyboard];
        }
        else
        {
            PUSH_VIEWCONTROLLER(SetPasswordViewController);
            model.userName = _phoneNumTxtField.text;
            model.validateCode = _identifyingCodeTxtField.text;
        }
    }
    else if (sender == _identifyingCodeBtn)
    {
        if ([_phoneNumTxtField.text isEqualToString:@""])
        {
            //为空
            [AlertUtil showAlert:@"" message:@"请先输入手机号" buttons:@[@"好的"]];
        }
        else if (_phoneNumTxtField.text.length < 11)
        {
            //号码位数不对
            [AlertUtil showAlert:@"" message:@"请填写正确手机号码" buttons:@[@"好的"]];
//            _phoneNumTxtField.text = @""; 
        }
        else
        {
            [self hiddenKeyboard];
            
            ADAPI_adv3share_registerShare([self genDelegatorID:@selector(HandleNotification:)], _phoneNumTxtField.text);
            
            
            _isTimeGetCode = NO;
            _getCodeTimer = [NSTimer scheduledTimerWithTimeInterval:6.0f
                                                               target:self
                                                             selector:@selector(onTime)
                                                             userInfo:nil
                                                              repeats:NO];
            
            _identifyingCodeBtn.enabled = NO;
        }
    }
}

- (IBAction)xieyiBtn:(id)sender
{
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.navTitle = @"注册协议";
    model.ContentCode = @"c531582ab4612b1d58ff980c5782bfc7";
}

-(void)onTime
{
    //生成随机数字，代替验证码
    NSMutableArray * arr=[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    int num3=10;
    NSString * str;
    for (int i=0; i<5; i++)
    {
        int m=arc4random()%num3;
        str = [arr objectAtIndex:m];
        [arr removeObjectAtIndex:m];
        num3--;
    }
    NSString *string = [arr componentsJoinedByString:@""];
    
    _identifyingCodeTxtField.text = string;
    
    [HUDUtil showSuccessWithStatus:@"验证码获取成功"];
    
    _isTimeGetCode = YES;
    
    _identifyingCodeBtn.enabled = YES;
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3share_registerShare])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        [_getCodeTimer invalidate];
        
        _identifyingCodeBtn.enabled = YES;
        
        if (wrapper.operationSucceed)
        {

           [self share:wrapper.data];
            
            //非定时器生成
            if(!_isTimeGetCode)
            {
                //生成随机数字，代替验证码
                NSMutableArray * arr=[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
                int num3=10;
                NSString * str;
                for (int i=0; i<5; i++)
                {
                    int m=arc4random()%num3;
                    str = [arr objectAtIndex:m];
                    [arr removeObjectAtIndex:m];
                    num3--;
                }
                NSString *string = [arr componentsJoinedByString:@""];
                
                _identifyingCodeTxtField.text = string;
                
//                [_getCodeTimer invalidate];//关掉生成验证码定时器
                
//                _identifyingCodeBtn.enabled = YES;
            }
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
        else if (wrapper.operationDealWithCode)
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:wrapper.operationMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"直接登录", nil];
            [alert show];
            [alert release];
            
            return;
        }
    }
}


-(void) share : (DictionaryWrapper *) dic
{
    if (!dic || [dic isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString * url = [dic getString:@"ClickUrl"];
    NSString *postStatusText = [dic getString:@"Content"];
    NSString *imagePath = [dic getString:@"PictureUrl"];
    NSString *title = [dic getString:@"Title"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:postStatusText
                                       defaultContent:@"请输入您要分享的内容"
                                                image:[ShareSDK imageWithUrl:imagePath]
                                                title:title
                                                  url:url
                                          description:@""
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent type:ShareTypeWeixiTimeline authOptions:nil shareOptions:nil statusBarTips:NO result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        if (state == SSResponseStateSuccess)
        {
//            DLog(@"分享成功");
        }
        else if (state == SSResponseStateFail)
        {
            [HUDUtil showSuccessWithStatus:@"验证码获取成功"];
        }
    }];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        PUSH_VIEWCONTROLLER(LogonViewController);
        
        [APP_DELEGATE.persistConfig set:USER_INFO_NAME value: _phoneNumTxtField.text];
        
        _phoneNumTxtField.text = @"";
        _identifyingCodeTxtField.text = @"";
    }
}


-(void)onOkBtn : (UIButton *) btn
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [_phoneNumTxtField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    
    [_phoneNumTxtField release];
    [_identifyingCodeTxtField release];
    [_identifyingCodeBtn release];
    [_nextBtn release];
    [_agreementLable release];
    [_lineImage release];
//    [_getCodeTimer release];
    [super dealloc];
}

- (void)viewDidUnload
{
    
    [self setPhoneNumTxtField:nil];
    [self setIdentifyingCodeTxtField:nil];
    [self setIdentifyingCodeBtn:nil];
    [self setNextBtn:nil];
    [self setAgreementLable:nil];
    [self setGetCodeTimer:nil];
    [super viewDidUnload];
}


@end
