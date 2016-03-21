//
//  ApplyToGetCash2ViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ApplyToGetCash2ViewController.h"
#import "ApplytoGetCash3ViewController.h"
#import "UserInfo.h"
#import "PlaySound.h"
@interface ApplyToGetCash2ViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)WDictionaryWrapper* postData;
@property (retain, nonatomic) IBOutlet UITextField *securityCodeTextField;
@property (retain, nonatomic) IBOutlet UIButton *getSecurityBtn;
@property (retain, nonatomic) IBOutlet UILabel *securityCodeReminderLabel;
@property (retain, nonatomic) IBOutlet UIView *UILineView1;
@property (retain, nonatomic) IBOutlet UIView *UILineView2;
@end

@implementation ApplyToGetCash2ViewController
@synthesize bankCardData = _bankCardData;
@synthesize postData = _postData;
@synthesize securityCodeTextField = _securityCodeTextField;
@synthesize cashCount = _cashCount;
@synthesize getSecurityBtn = _getSecurityBtn;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"申请提现"];
    [self addDoneToKeyboard:_securityCodeTextField];
    self.postData = WEAK_OBJECT(WDictionaryWrapper, init);
    self.getSecurityBtn.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    self.getSecurityBtn.layer.borderWidth = 0.5;
    
    [self.UILineView1 setFrame:CGRectMake(0, 0, 320, 0.5)];
    [self.UILineView2 setFrame:CGRectMake(0, 49.5, 320, 0.5)];
    _getSecurityBtn.layer.masksToBounds = YES;
}

- (IBAction)commitApplication:(id)sender {
    
    if ([[_postData getString:@"Code"]isEqualToString:@""]||![_postData getString:@"Code"]) {
        
        [HUDUtil showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    [AlertUtil showAlert:@"确认提现信息"
                 message:[NSString stringWithFormat:@"向您尾号%@储蓄卡账户提现￥%.2f元",[_bankCardData getString:@"AccountNumberEnd"],_cashCount]
                 buttons:@[
                           @{
                               @"title":@"取消",
                               @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
        return;
    })},
                           @{
                               @"title":@"确定",
                               @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
        ADAPI_ApplyToGetCash([self genDelegatorID:@selector(applyToGetCash:)],_postData.dictionary);
    })}]];
}

//申请提现回调
- (void)applyToGetCash:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
        DictionaryWrapper *theWrapper = wrapper.data;
        //传订单编号
        ApplytoGetCash3ViewController *temp = WEAK_OBJECT(ApplytoGetCash3ViewController, init);
        temp.orderNumber = [theWrapper getString:@"OrderNumber"];
        
        WDictionaryWrapper *item = WEAK_OBJECT(WDictionaryWrapper, init);
        NSString *dateStr;
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"MM-dd-yyyy"];
        dateStr = [dateFormat stringFromDate:date];
        [dateFormat release];
        [item set:dateStr int:1];
        [APP_DELEGATE.userConfig set:@"GetCashRecord" value:item.dictionary];
        
        [PlaySound playSound:@"applyGetCashVoice" type:@"mp3"];
        [self.navigationController pushViewController:temp animated:YES];
        
    }else {
        [HUDUtil showErrorWithStatus:[wrapper getString:@"Desc"]];
    }
}

//获取验证码
- (IBAction)applyToGetSecurityCode:(id)sender {
    
    ADAPI_adv3_GetPhoneCode([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handlePhoneCode:)], USER_MANAGER.phone, @"", @"6", @"", @"");
}

//验证码回调
- (void)handlePhoneCode:(DelegatorArguments *)arguments{
    
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        [_getSecurityBtn addTimer:60];
        [_getSecurityBtn startTimer];
        
        NSMutableString *mutableStr = WEAK_OBJECT(NSMutableString, initWithString:USER_MANAGER.phone);
        [mutableStr replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
        self.securityCodeReminderLabel.text = [NSString stringWithFormat:@"已将验证码发送到%@",mutableStr];
        [HUDUtil showSuccessWithStatus:[dic getString:@"Desc"]];
    }else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (void)hiddenKeyboard {
    
    [_securityCodeTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [_securityCodeTextField resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self.postData set:@"Code" string:aString];
    [self.postData set:@"CashOut" string:[NSString stringWithFormat:@"%.2f",_cashCount]];
    [self.postData set:@"BankId" string:[NSString stringWithFormat:@"%d",[_bankCardData getInt:@"BankId"]]];
    return YES;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    [_postData release];
    [_bankCardData release];
    [_securityCodeTextField release];
    [_getSecurityBtn release];
    [_securityCodeReminderLabel release];
    [_UILineView1 release];
    [_UILineView2 release];
    [super dealloc];
}
@end
