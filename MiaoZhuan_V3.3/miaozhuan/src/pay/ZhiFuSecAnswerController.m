//
//  ZhiFuSecAnswerController.m
//  miaozhuan
//
//  Created by momo on 15/6/1.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "ZhiFuSecAnswerController.h"
#import "IndustryPicker.h"
#import "Redbutton.h"
#import "CommonSettingViewController.h"
#import "ZhiFuPwdQueRenViewController.h"

@interface ZhiFuSecAnswerController ()<IndustryPickerDelegate>
{
    IndustryPicker * _Qpicker;
}
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *bottomViewTopCons;
@property (retain, nonatomic) IBOutlet UIButton *selectBtn;
@property (retain, nonatomic) IBOutlet UITextField *quesText;
@property (retain, nonatomic) IBOutlet UITextField *answerText;
@property (retain, nonatomic) IBOutlet Redbutton *commitBtn;

@end

@implementation ZhiFuSecAnswerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigateTitle:@"设置安全保护问题"];
    [self setupMoveBackButton];
    
    [self addDoneToKeyboard:_quesText];
    [self addDoneToKeyboard:_answerText];
    
    NSArray * qArr = @[@"自定义",@"你配偶的姓名是？",@"你父亲的姓名是？",@"你母亲的姓名是？",@"你配偶的生日是？",@"你最喜欢的电影是？",];
    
    _Qpicker = STRONG_OBJECT(IndustryPicker, initWithStyle:self pickerData:qArr);
    
    
    CGFloat offsetY = [UICommon getIos4OffsetY];
    _Qpicker.frame = CGRectMake(0, 0, 320, 460 + offsetY);
    
    _Qpicker.delegate = self;
    
    _Qpicker.hidden = YES;
    
    [self.view addSubview:_Qpicker];
}

- (void) hiddenKeyboard
{
    [_quesText resignFirstResponder];
    [_answerText resignFirstResponder];
}

- (IBAction)touchUpInsideOn:(id)sender {
    
    if(sender == _selectBtn)
    {
        [self hiddenKeyboard];
        _Qpicker.hidden = NO;
    }
    else if(sender == _commitBtn)
    {
        [self hiddenKeyboard];

        if([self checkText])
        {
            NSString * ques = _selectBtn.titleLabel.text;
            
            if([_selectBtn.titleLabel.text isEqualToString:@"自定义"])
            {
                ques = _quesText.text;
            }
            
            ADAPI_adv3_PaymentSetPayPwd([self genDelegatorID:@selector(HandleNotification:)], _payPwd, ques, _answerText.text,_ValidateCode);
        }
    }
}

-(void)HandleNotification: (DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_PaymentSetPayPwd])
    {
        [arguments logError];
        
        DictionaryWrapper* wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:@"设置安全保护问题成功"];
            
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".SetPayPwdStatus" string:@"1"];            
            
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[CommonSettingViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                    return;
                }
            }
            
            DictionaryWrapper *dict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ConfirmPayPasswordInfo"] wrapper];
            ZhiFuPwdQueRenViewController *next = WEAK_OBJECT(ZhiFuPwdQueRenViewController, init);
            next.name = [dict getString:@"name"];
            next.dataDic = [[NSMutableDictionary alloc] initWithDictionary:[dict getDictionary:@"dataDic"]];
            next.type = [dict getString:@"type"];
            next.isGold = [dict getBool:@"isGold"];
            next.OrderId = [dict getString:@"OrderId"];
            [self.navigationController pushViewController:next animated:YES];
        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}

- (void) jumpToMainView
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[CommonSettingViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}

- (BOOL)checkText
{
    if([_selectBtn.titleLabel.text isEqualToString:@"自定义"])
    {
        if(!_quesText.text.length)
        {
            [HUDUtil showErrorWithStatus:@"请输入安全保护问题"];
            [_quesText becomeFirstResponder];
            return NO;
        }
        else if (!_answerText.text.length)
        {
            [HUDUtil showErrorWithStatus:@"请输入安全保护问题答案"];
            [_answerText becomeFirstResponder];
            return NO;
        }
    }
    else if ([_selectBtn.titleLabel.text isEqualToString:@"请选择安全保护问题"])
    {
        [HUDUtil showErrorWithStatus:@"请选择安全保护问题进行回答"];
        return NO;
    }
    else
    {
        if(!_answerText.text.length)
        {
            [HUDUtil showErrorWithStatus:@"请输入安全保护问题答案"];
            [_answerText becomeFirstResponder];
            return NO;
        }
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pickerIndustryOk:(IndustryPicker *)picker
{
    [_selectBtn setTitle:picker.curText forState:UIControlStateNormal];

    if([picker.curText isEqualToString:@"自定义"])
    {
        self.bottomViewTopCons.constant = 50;
    }
    else
    {
        self.bottomViewTopCons.constant = 0;
    }
    
    picker.hidden = YES;
}

- (void)pickerIndustryCancel:(IndustryPicker *)picker
{
    picker.hidden = YES;
}

- (void)dealloc {
    [_bottomViewTopCons release];
    [_selectBtn release];
    [_Qpicker release];
    [_quesText release];
    [_answerText release];
    [_commitBtn release];
    [super dealloc];
}
@end
