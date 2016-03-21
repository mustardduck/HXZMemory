//
//  ZhiFuPwdEditController.m
//  miaozhuan
//
//  Created by momo on 15/6/1.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "ZhiFuPwdEditController.h"
#import "Redbutton.h"
#import "ZhiFuSecAnswerController.h"
#import "ZhiFuPwdMainController.h"
#import "ZhiFuPwdQueRenViewController.h"
#import "CircurateViewController.h"
#import "MyGoldCircurateViewController.h"
#import "ConfirmOrderViewController.h"
#import "MyMarketMyOrderListController.h"
#import "ZhiFuPwdQueRenViewController.h"
#import "CommonSettingViewController.h"

@interface ZhiFuPwdEditController ()<UIAlertViewDelegate,UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UIView *editPwdView;
@property (retain, nonatomic) IBOutlet UIView *setPwdView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *commitViewTopCons;
@property (retain, nonatomic) IBOutlet UITextField *setPwdText;
@property (retain, nonatomic) IBOutlet UITextField *setPwdAgainText;
@property (retain, nonatomic) IBOutlet UITextField *editOldText;
@property (retain, nonatomic) IBOutlet UITextField *editNewText;
@property (retain, nonatomic) IBOutlet UITextField *editNewAgainText;
@property (retain, nonatomic) IBOutlet Redbutton *commitBtn;

@end

@implementation ZhiFuPwdEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(_isEdit)
    {
        [self setNavigateTitle:@"修改支付密码"]
        ;
        
        _editPwdView.hidden = NO;
        
        self.commitViewTopCons.constant = 0;
        
        [_editOldText becomeFirstResponder];
    }
    else
    {
        [self setNavigateTitle:@"设置支付密码"];
        
        [_setPwdText becomeFirstResponder];

    }
    [self setupMoveBackButton];
    
    [self addDoneToKeyboard:_setPwdText];
    [self addDoneToKeyboard:_setPwdAgainText];
    [self addDoneToKeyboard:_editOldText];
    [self addDoneToKeyboard:_editNewText];
    [self addDoneToKeyboard:_editNewAgainText];
    
    _setPwdText.delegate = self;
    _setPwdAgainText.delegate = self;
    _editOldText.delegate = self;
    _editNewText.delegate = self;
    _editNewAgainText.delegate = self;

}

- (void) hiddenKeyboard
{
    [_setPwdText resignFirstResponder];
    [_setPwdAgainText resignFirstResponder];
    [_editOldText resignFirstResponder];
    [_editNewText resignFirstResponder];
    [_editNewAgainText resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        for (DotCViewController *vc in self.navigationController.viewControllers) {
            if([vc isKindOfClass:[ZhiFuPwdQueRenViewController class]] || [vc isKindOfClass:[ZhiFuPwdMainController class]] || [vc isKindOfClass:[CommonSettingViewController class]]){
                [self.navigationController popToViewController:vc animated:YES];
                return;
            }
        }
        for (DotCViewController *vc in self.navigationController.viewControllers) {
            if([vc isKindOfClass:[CircurateViewController class]] || [vc isKindOfClass:[MyGoldCircurateViewController class]] || [vc isKindOfClass:[ConfirmOrderViewController class]] || [vc isKindOfClass:[MyMarketMyOrderListController class]]){
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
//        [self jumpToMainView];
    }
}

- (IBAction)touchUpInsideOn:(id)sender {
    if(sender == _commitBtn)
    {
        if([self checkText])
        {
            [self hiddenKeyboard];
            if(_isEdit)
            {
                ADAPI_adv3_PaymentResetPayPwd([self genDelegatorID:@selector(HandleNotification:)], _editOldText.text, _editNewText.text);
            }
            else
            {
                if(_isForgot)
                {
                    ADAPI_adv3_PaymentFindPayPwdStep3([self genDelegatorID:@selector(HandleNotification:)], _setPwdText.text, _secCode);
                }
                else
                {
                    [HUDUtil showSuccessWithStatus:@"设置支付密码成功"];
                    
                    ZhiFuSecAnswerController *model = [[[ZhiFuSecAnswerController alloc] init] autorelease];
                    model.payPwd = _setPwdText.text;
                    model.ValidateCode = _ValidateCode;
                    [self.navigationController pushViewController:model animated:YES];
                }
                
                _setPwdText.text = @"";
                _setPwdAgainText.text = @"";
            }
        }
    }
}

- (void) onMoveBack:(UIButton *)sender
{
    if(_isForgot)
    {
        UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"" message:@"确定放弃设置支付密码？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [view show];
        [view autorelease];
    }
    else
    {
        for (DotCViewController *vc in self.navigationController.viewControllers) {
            if([vc isKindOfClass:[ZhiFuPwdQueRenViewController class]] || [vc isKindOfClass:[ZhiFuPwdMainController class]] || [vc isKindOfClass:[CommonSettingViewController class]]){
                [self.navigationController popToViewController:vc animated:YES];
                return;
            }
        }
        for (DotCViewController *vc in self.navigationController.viewControllers) {
            if([vc isKindOfClass:[CircurateViewController class]] || [vc isKindOfClass:[MyGoldCircurateViewController class]] || [vc isKindOfClass:[ConfirmOrderViewController class]] || [vc isKindOfClass:[MyMarketMyOrderListController class]]){
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
        
//        [self jumpToMainView];
    }
}

- (void) jumpToMainView
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[ZhiFuPwdMainController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
            return;
        }
    }
    
    switch (_zhifuPwdFromType) {
        case ZhifuPWD_Gold:
        {
            ZhiFuPwdQueRenViewController *next = WEAK_OBJECT(ZhiFuPwdQueRenViewController, init);
            next.name = _name;
            next.dataDic = _dataDic;
            next.isGold = _isGold;
            next.type = _type;
            [UI_MANAGER.mainNavigationController pushViewController:next animated:YES];
        }
            break;
        case ZhifuPWD_Silver:
        {
            ZhiFuPwdQueRenViewController *next = WEAK_OBJECT(ZhiFuPwdQueRenViewController, init);
            next.name = _name;
            next.dataDic = _dataDic;
            next.type = _type;
            [UI_MANAGER.mainNavigationController pushViewController:next animated:YES];
        }
            break;
        case ZhifuPWD_YiHuoMallBuy:
        {
            ZhiFuPwdQueRenViewController *next = WEAK_OBJECT(ZhiFuPwdQueRenViewController, init);
            next.dataDic = _dataDic;
            next.type = _type;
//            next.isJinBiNum = _isJinBiNum;
            [UI_MANAGER.mainNavigationController pushViewController:next animated:YES];
        }
            break;
        case ZhifuPWD_MyOrderShouHuo:
        {
            ZhiFuPwdQueRenViewController *next = WEAK_OBJECT(ZhiFuPwdQueRenViewController, init);
            next.OrderId = _orderId;
            next.type = _type;
            [UI_MANAGER.mainNavigationController pushViewController:next animated:YES];
        }
        case ZhifuPWD_ReturnShouHuo:
        {
            ZhiFuPwdQueRenViewController *next = WEAK_OBJECT(ZhiFuPwdQueRenViewController, init);
            next.OrderId = _orderId;
            next.isTuiHuo = _isTuiHuo;
            next.type = _type;
            next.orderNum = _orderNum;
            next.orderType = _orderType;
            [UI_MANAGER.mainNavigationController pushViewController:next animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)HandleNotification: (DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_PaymentResetPayPwd])
    {
        [arguments logError];
        
        DictionaryWrapper* wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:@"设置支付密码成功"];
            
            _setPwdText.text = @"";
            _setPwdAgainText.text = @"";
            
            for (DotCViewController *vc in self.navigationController.viewControllers) {
                if([vc isKindOfClass:[ZhiFuPwdMainController class]]){
                    [self.navigationController popToViewController:vc animated:YES];
                    return;
                }
            }
        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_PaymentFindPayPwdStep3])
    {
        [arguments logError];
        
        DictionaryWrapper* wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:@"设置支付密码成功"];
            
            for (DotCViewController *vc in self.navigationController.viewControllers) {
                if([vc isKindOfClass:[ZhiFuPwdQueRenViewController class]] || [vc isKindOfClass:[ZhiFuPwdMainController class]]){
                    [self.navigationController popToViewController:vc animated:YES];
                    return;
                }
            }
//            [self jumpToMainView];
        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (_setPwdText == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 6)
        {
            return NO;
        }
    }
    else if (_setPwdAgainText == textField)
    {
        if ([toBeString length] > 6)
        {
            return NO;
        }
    }
    else if (_editOldText == textField)
    {
        if ([toBeString length] > 6)
        {
            return NO;
        }
    }
    else if (_editNewText == textField)
    {
        if ([toBeString length] > 6)
        {
            return NO;
        }
    }
    else if (_editNewAgainText == textField)
    {
        if ([toBeString length] > 6)
        {
            return NO;
        }
    }
    return YES;
}

- (BOOL)checkText
{
    if(_isEdit)
    {
        if(!_editOldText.text.length)
        {
            [HUDUtil showErrorWithStatus:@"请输入原支付密码"];
            [_editOldText becomeFirstResponder];
            return NO;
        }
        else if(!_editNewText.text.length)
        {
            [HUDUtil showErrorWithStatus:@"请输入新的支付密码"];
            [_editNewText becomeFirstResponder];
            return NO;
        }
        else if (!_editNewAgainText.text.length)
        {
            [HUDUtil showErrorWithStatus:@"请再次输入新的支付密码"];
            [_editNewAgainText becomeFirstResponder];
            return NO;
        }
        else if (![_editNewAgainText.text isEqualToString:_editNewText.text])
        {
            [HUDUtil showErrorWithStatus:@"两次输入密码不一致\n请重新确认后输入支付密码"];
            [_editNewText becomeFirstResponder];
            return NO;
        }
        else if (_editNewText.text.length != 6)
        {
            [HUDUtil showErrorWithStatus:@"密码格式有误\n\n支付密码是由6个0-9的数字组成"];
            [_editNewText becomeFirstResponder];
            return NO;
        }
    }
    else
    {
        if(!_setPwdText.text.length)
        {
            [HUDUtil showErrorWithStatus:@"请输入支付密码"];
            [_setPwdText becomeFirstResponder];
            return NO;
        }
        else if(!_setPwdAgainText.text.length)
        {
            [HUDUtil showErrorWithStatus:@"请再次输入支付密码"];
            [_setPwdAgainText becomeFirstResponder];
            return NO;
        }
        else if (![_setPwdAgainText.text isEqualToString:_setPwdText.text])
        {
            [HUDUtil showErrorWithStatus:@"两次输入密码不一致\n请重新确认后输入支付密码"];
            [_setPwdText becomeFirstResponder];
            return NO;
        }
        else if (_setPwdText.text.length != 6)
        {
            [HUDUtil showErrorWithStatus:@"密码格式有误\n支付密码是由6个0-9的数字组成"];
            [_setPwdText becomeFirstResponder];
            return NO;
        }
    }
    return YES;
}

- (void)dealloc {
    [_editPwdView release];
    [_setPwdView release];
    [_commitViewTopCons release];
    [_setPwdText release];
    [_setPwdAgainText release];
    [_editOldText release];
    [_editNewText release];
    [_editNewAgainText release];
    [_commitBtn release];
    [super dealloc];
}
@end
