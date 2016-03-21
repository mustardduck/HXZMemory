//
//  ZhiFuJiaoYanStepTwoController.m
//  miaozhuan
//
//  Created by momo on 15/6/4.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "ZhiFuJiaoYanStepTwoController.h"
#import "Redbutton.h"
#import "UserInfo.h"
#import "RRAttributedString.h"
#import "ZhiFuJiaoYanStepThreeController.h"

@interface ZhiFuJiaoYanStepTwoController ()
@property (retain, nonatomic) IBOutlet UITextField *codeText;
@property (retain, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (retain, nonatomic) IBOutlet UIImageView *codeImage;
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
@property (retain, nonatomic) IBOutlet Redbutton *nextBtn;

@end

@implementation ZhiFuJiaoYanStepTwoController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    InitNav(@"安全校验");
    [self setupMoveBackButton];
    
    NSMutableString *phone = WEAK_OBJECT(NSMutableString, initWithString:USER_MANAGER.phone);
    
    [phone replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    _titleLbl.text = [NSString stringWithFormat:@"已发送验证码到您的手机 %@", phone];
    
    NSAttributedString *attrStr = [RRAttributedString setText:_titleLbl.text color:RGBCOLOR(34, 34, 34) range:NSMakeRange(12, _titleLbl.text.length - 12)];
    _titleLbl.attributedText = attrStr;
    
    [self addDoneToKeyboard:_codeText];
    [_codeText becomeFirstResponder];
    
    [_getCodeBtn addTimer:60];
    [_getCodeBtn startTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchUpInsdieOn:(id)sender {
    if(sender == _getCodeBtn)
    {
        ADAPI_adv3_GetPhoneCode([self genDelegatorID:@selector(HandleNotification:)], USER_MANAGER.phone, _imageCode, @"8", @"1",@"");
    }
    else if (sender == _nextBtn)
    {
        [self hiddenKeyboard];
        
        ADAPI_adv3_PaymentFindPayPwdStep1([self genDelegatorID:@selector(HandleNotification:)], _codeText.text);
    }
}

-(void)HandleNotification:(DelegatorArguments *) arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_GetPhoneCode])
    {
        [arguments logError];
        
        DictionaryWrapper* wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            [_getCodeBtn addTimer:60];
            [_getCodeBtn startTimer];
        
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
    else if ([arguments isEqualToOperation:ADOP_adv3_PaymentFindPayPwdStep1])
    {

        DictionaryWrapper * wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        { 
            PUSH_VIEWCONTROLLER(ZhiFuJiaoYanStepThreeController);

            model.securityCode = [wrapper.data getString:@"SecurityCode"];
                        
            _codeText.text = @"";
        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }

    }
}

- (void) hiddenKeyboard
{
    [_codeText resignFirstResponder];
}

- (void)dealloc {
    [_codeText release];
    [_getCodeBtn release];
    [_codeImage release];
    [_titleLbl release];
    [_nextBtn release];
    [super dealloc];
}
@end
