//
//  ZhiFuJiaoYanController.m
//  miaozhuan
//
//  Created by momo on 15/6/4.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "ZhiFuJiaoYanController.h"
#import "Redbutton.h"
#import "ZhiFuJiaoYanStepTwoController.h"
#import "UserInfo.h"

@interface ZhiFuJiaoYanController ()

@property (retain, nonatomic) IBOutlet UIImageView *imageCodeView;
@property (retain, nonatomic) IBOutlet UIButton *getImageCodeBtn;
@property (retain, nonatomic) IBOutlet UITextField *codeText;
@property (retain, nonatomic) IBOutlet Redbutton *getCodeBtn;
@end

@implementation ZhiFuJiaoYanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    InitNav(@"安全校验");
    [self setupMoveBackButton];
    
    [self addDoneToKeyboard:_codeText];
    [_codeText becomeFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self getCaptcha];
}

- (IBAction)touchUpInsideOn:(id)sender {
    if(sender == _getCodeBtn)
    {
        if([self checkText])
        {
            [self hiddenKeyboard];
            
            ADAPI_adv3_GetPhoneCode([self genDelegatorID:@selector(HandleNotification:)], USER_MANAGER.phone, _codeText.text, @"8", @"1",@"");

        }
    }
    else if (sender == _getImageCodeBtn)
    {
        [self getCaptcha];
    }
}

- (BOOL) checkText
{
    if(!_codeText.text.length)
    {
        [HUDUtil showErrorWithStatus:@"请输入图片验证码"];
        [_codeText becomeFirstResponder];
        return NO;
    }
    return YES;
}

-(void)hiddenKeyboard
{
    [_codeText resignFirstResponder];
}

-(void)HandleNotification: (DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_GetCaptcha])
    {
        UIImage * image = WEAK_OBJECT(UIImage, initWithData:(NSData *)arguments.ret);
        
        _imageCodeView.image = image;
        
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_GetPhoneCode])
    {
        [arguments logError];
        
        DictionaryWrapper* wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            //跳转安全校验stepTwo
            PUSH_VIEWCONTROLLER(ZhiFuJiaoYanStepTwoController);
            
            model.imageCode = _codeText.text;
            
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            _codeText.text = @"";
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            
            [self getCaptcha];

            return;
        }
        else if ([wrapper getInt:@"Code"] == 1002 || [wrapper getInt:@"Code"] == 1001)
        {
            _codeText.text = @"";
            
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            
            [self getCaptcha];
            
            return;
        }
    }
}

//获取图片验证码
-(void)getCaptcha
{
    ADAPI_adv3_GetCaptcha([self genDelegatorID:@selector(HandleNotification:)],@"");
}

- (void)dealloc {
    [_getCodeBtn release];
    [_codeText release];
    [_getImageCodeBtn release];
    [_imageCodeView release];
    [super dealloc];
}
@end
