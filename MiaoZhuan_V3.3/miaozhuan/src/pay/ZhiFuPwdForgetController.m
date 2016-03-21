//
//  ZhiFuPwdForgetController.m
//  miaozhuan
//
//  Created by momo on 15/6/1.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "ZhiFuPwdForgetController.h"
#import "ZhiFuJiaoYanController.h"

@interface ZhiFuPwdForgetController ()
@property (retain, nonatomic) IBOutlet UIButton *answerBtn;
@property (retain, nonatomic) IBOutlet UIButton *phoneBtn;

@end

@implementation ZhiFuPwdForgetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigateTitle:@"忘记支付密码"];
    [self setupMoveBackButton];
}

- (IBAction)touchUpInsideOn:(id)sender {
    if(sender == _answerBtn)
    {
        PUSH_VIEWCONTROLLER(ZhiFuJiaoYanController);
    }
    else if (sender == _phoneBtn)
    {
        ADAPI_adv3_PaymentAskForPayPwd([self genDelegatorID:@selector(askForPayPwd:)]);
        
        [[UICommon shareInstance]makeCall:kServiceMobile];
        
    }
}

-(void)askForPayPwd:(DelegatorArguments *) arguments
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc {
    [_answerBtn release];
    [_phoneBtn release];
    [super dealloc];
}
@end
