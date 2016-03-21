//
//  DeleteBusinessViewController.m
//  miaozhuan
//
//  Created by abyss on 14/11/12.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DeleteBusinessViewController.h"
#import "ControlViewController.h"
#import "UIView+expanded.h"
@interface DeleteBusinessViewController ()

@end

@implementation DeleteBusinessViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    InitNav(@"注销商家");
    [self layout];
}

- (void)layout
{
    self.view.backgroundColor = AppColorBackground;
    _textF.layer.borderWidth = 0;
    _bt.h_color = AppColor(229);
    _bt.n_color = AppColorWhite;
//    [_bt addBorder];
    [_bt roundCornerBorder];
    [_bt addTimer:60];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc
{
    [_bt release];
    [_textF release];
    CRDEBUG_DEALLOC();
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBt:nil];
    [self setTextF:nil];
    [super viewDidUnload];
}
- (IBAction)getYanzhengma:(id)sender
{
    ADAPI_adv3_GetPhoneCode([self genDelegatorID:@selector(myHandle:)], [[APP_DELEGATE.runtimeConfig getDictionaryWrapper:RUNTIME_USER_LOGIN_INFO] getString:@"UserName"], @"",@"2",@"",@"");
  
}

- (IBAction)delete:(id)sender
{
    NSString *temp = _textF.text;
    
    [_textF resignFirstResponder];
    
    if (temp && temp.length > 1)
    {
        ADAPI_adv3_DeleteEnterprise([self genDelegatorID:@selector(myHandle:)], temp);
    }
    else
    {
        [HUDUtil showErrorWithStatus:@"验证码不能为空"];
    }
}

- (void)myHandle:(DelegatorArguments *)arg
{
    DictionaryWrapper *wrapper = arg.ret;
    
    NSString *msg = @"";
    
    msg = [wrapper getString:@"Desc"];
    
    [arg logError];
    if ([arg isEqualToOperation:ADOP_adv3_GetPhoneCode])
    {
        if (wrapper.operationSucceed)
        {
            [_bt startTimer];
        }
        else
        {
            NSLog(@"%@",wrapper.operationMessage);
            
            if(msg != nil && ![msg isEqualToString:@""] && ![msg isEqual:[NSNull class]])
                [HUDUtil showErrorWithStatus:msg];
            else
                    
                [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
    else if ([arg isEqualToOperation:ADOP_adv3_DeleteEnterprise])
    {
        if (wrapper.operationSucceed)
        {
            //立即激活
            NSArray*                controllerArray = nil;
            ControlViewController*  fatherContoller = nil;
            {
                controllerArray = [DotCUIManager instance].mainNavigationController.viewControllers;
                for (UIViewController *target in controllerArray)
                {
                    if ( [target isKindOfClass:[ControlViewController class]])
                    {
                        fatherContoller = (ControlViewController *)target;
                    }
                }
                [[DotCUIManager instance].mainNavigationController popToViewController:fatherContoller animated:YES];
                
                [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".EnterpriseStatus" value:@(0)];
                [fatherContoller viewDidLayoutSubviews];
            }
            
            [HUDUtil showSuccessWithStatus:@"注销成功"];
        }
        else
        {
            NSLog(@"%@",wrapper.operationMessage);
//            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
            
            
            if(msg != nil && ![msg isEqualToString:@""] && ![msg isEqual:[NSNull class]])
                [HUDUtil showErrorWithStatus:msg];
            else
                
                [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}

@end
