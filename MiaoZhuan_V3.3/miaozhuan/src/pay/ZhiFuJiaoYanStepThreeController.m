//
//  ZhiFuJiaoYanStepThreeController.m
//  miaozhuan
//
//  Created by momo on 15/6/4.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "ZhiFuJiaoYanStepThreeController.h"
#import "ZhiFuPwdEditController.h"

@interface ZhiFuJiaoYanStepThreeController ()
@property (retain, nonatomic) IBOutlet UILabel *quesLbl;
@property (retain, nonatomic) IBOutlet UITextField *codeText;

@end

@implementation ZhiFuJiaoYanStepThreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    InitNav(@"安全校验");
    [self setupMoveBackButton];
    
    [self addDoneToKeyboard:_codeText];
    [_codeText becomeFirstResponder];
    
    ADAPI_adv3_PaymentGetSecQuestion([self genDelegatorID:@selector(HandleNotification:)]);
    
}

- (void) hiddenKeyboard
{
    [_codeText resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nextClick:(id)sender {
    if(!_codeText.text.length)
    {
        [HUDUtil showErrorWithStatus:@"请输入安全保护问题答案"];
        [_codeText becomeFirstResponder];
        return;
    }
    [self hiddenKeyboard];
    ADAPI_adv3_PaymentFindPayPwdStep2([self genDelegatorID:@selector(HandleNotification:)], _codeText.text, _securityCode);
}

-(void)HandleNotification:(DelegatorArguments *) arguments
{
    DictionaryWrapper * wrapper = arguments.ret;

    if ([arguments isEqualToOperation:ADOP_adv3_PaymentFindPayPwdStep2])
    {//支付密码确认页面
        if(wrapper.operationSucceed)
        {
            PUSH_VIEWCONTROLLER(ZhiFuPwdEditController);
            model.secCode = [wrapper.data getString:@"SecurityCode"];
            model.isForgot = YES;
            
            _codeText.text = @"";

        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_PaymentGetSecQuestion])
    {
        if(wrapper.operationSucceed)
        {
            _quesLbl.text = [wrapper.data getString:@"SecQuestion"];
        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}

- (void)dealloc {
    [_quesLbl release];
    [_codeText release];
    [super dealloc];
}
@end
