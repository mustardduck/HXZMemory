//
//  ZhiFuPwdMainController.m
//  miaozhuan
//
//  Created by momo on 15/6/1.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "ZhiFuPwdMainController.h"
#import "ZhiFuPwdForgetController.h"
#import "ZhiFuPwdEditController.h"
#import "UserInfo.h"
#import "PhoneAuthenticationViewController.h"

@interface ZhiFuPwdMainController ()
@property (retain, nonatomic) IBOutlet UIButton *editPwdBtn;
@property (retain, nonatomic) IBOutlet UIButton *forgotPwdBtn;

@end

@implementation ZhiFuPwdMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigateTitle:@"支付密码管理"];
    [self setupMoveBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchUpInsideOn:(id)sender
{
    //判断是否进行了手机认证
    if (!USER_MANAGER.IsPhoneVerified) {
        [AlertUtil showAlert:@"" message:@"您未通过手机认证，请先认证" buttons:@[
                                                                       @{
                                                                           @"title":@"去认证",
                                                                           @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                                                           ({
            PUSH_VIEWCONTROLLER(PhoneAuthenticationViewController);
        })
                                                                           },@"取消"
                                                                       
                                                                       ]];
        return;
    }
    else
    {
        if(sender == _editPwdBtn)
        {
            PUSH_VIEWCONTROLLER(ZhiFuPwdEditController);
            model.isEdit = YES;
        }
        else if (sender == _forgotPwdBtn)
        {
            PUSH_VIEWCONTROLLER(ZhiFuPwdForgetController);
        }
    }

}

- (void)dealloc {
    [_editPwdBtn release];
    [_forgotPwdBtn release];
    [super dealloc];
}
@end
