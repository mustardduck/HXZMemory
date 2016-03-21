//
//  CircurateNexViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-2.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CircurateNexViewController.h"
#import "UserInfo.h"
#import "OwnSliverManagerViewController.h"
#import "MyGoldMainController.h"
#import "UIView+expanded.h"
#import "HightedButton.h"
#import "CurrencyCirculationMsgViewController.h"

@interface CircurateNexViewController ()

@property (retain, nonatomic) IBOutlet UITextField *txtConfirm;
@property (retain, nonatomic) IBOutlet HightedButton *btnConfirm;
@property (retain, nonatomic) IBOutlet UIView *mainView;
@property (retain, nonatomic) IBOutlet UILabel *lblWarn;

@end

@implementation CircurateNexViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigateTitle:@"输入验证码"];
    [self setupMoveBackButton];
    
    [self addTimerToButton];
    
    [self addDoneToKeyboard:_txtConfirm];
    
    [_btnConfirm roundCornerBorder];
    [_btnConfirm setContentEdgeInsets:UIEdgeInsetsMake(1, 0, 0, 0)];
}

- (void)addTimerToButton{
    [_btnConfirm addTimer:60];
}

//确认赠送
- (IBAction)sureSendClicked:(id)sender {
    NSString *conCode = _txtConfirm.text;
    if (!conCode.length) {
        [HUDUtil showErrorWithStatus:@"请输入验证码!"];return;
    }
    [_dataDic setValue:conCode forKey:@"ValidateCode"];
    
    [_txtConfirm resignFirstResponder];
    
    if(!_isGold)
    {
        ADAPI_CustomerIntegral_SendGiftIntegral([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSendGiftIntegral:)], _dataDic);
    }
    else
    {
        ADAPI_CustomerGoldSendGiftGold([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSendGiftGold:)],_dataDic);
    }
}

- (void) hiddenKeyboard
{
    [_txtConfirm resignFirstResponder];
}

//确认金币赠送好友回调
- (void)handleSendGiftGold:(DelegatorArguments *)arguments{
    
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        
        NSString * text = [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[[_dataDic wrapper] getFloat:@"GoldNumber"] withAppendStr:nil];;
        
        NSString *str = [NSString stringWithFormat:@"您已成功向 %@ 赠送 %@ 金币",_name, text];
        __block typeof(self) weakself = self;
        [AlertUtil showAlert:@"赠送成功" message:str buttons:@[@{
                                                               @"title":@"确定",
                                                               @"delegator" : ALERT_VIEW_DELEGATOR_BLOCK({
            [weakself turn];
        })
                                                               }]];
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
//        [self showErrorWithCode:dic];
    }
}

//- (void)showErrorWithCode:(DictionaryWrapper *)dic {
//    switch (dic.code) {
//        case 4004:
//        {
//            [AlertUtil showAlert:@"" message:@"赠送失败，你的手机尚未认证" buttons:@[@"稍后再说", @{@"title":@"立即认证",@"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
//                PUSH_VIEWCONTROLLER(PhoneAuthenticationViewController);
//            })}]];
//        }
//            break;
//        case 4005:
//        {
//            [AlertUtil showAlert:@"" message:@"赠送失败，对方手机尚未认证" buttons:@[@"确定"]];
//        }
//            break;
//        default:
//            [HUDUtil showErrorWithStatus:dic.operationMessage];
//            break;
//    }
//}

//确认赠送回调
- (void)handleSendGiftIntegral:(DelegatorArguments *)arguments{
    
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        
        NSString *str = [NSString stringWithFormat:@"您已成功向 %@ 赠送 %@ 银元",_name, [[_dataDic wrapper] getString:@"Integral"]];
        __block typeof(self) weakself = self;
        [AlertUtil showAlert:@"赠送成功" message:str buttons:@[@{
                                                               @"title":@"确定",
                                                               @"delegator" : ALERT_VIEW_DELEGATOR_BLOCK({
            [weakself turn];
                                                                                                         })
                                                               }]];
        

    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (void)turn{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if(!_isGold)
        {
            if ([vc isKindOfClass:[OwnSliverManagerViewController class]] || [vc isKindOfClass:[CurrencyCirculationMsgViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                break;
            }
            
        }
        else
        {
            if ([vc isKindOfClass:[MyGoldMainController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                break;
            }
        }
    }
}

//获取验证码
- (IBAction)getConfirmClicked:(id)sender {
    if (USER_MANAGER.phone.length < 11) {
        return;
    }
    
    [_btnConfirm startTimer];
    
    NSString * type = @"4";
    
    if(_isGold)
    {
        type = @"7";
    }
    
    ADAPI_adv3_GetPhoneCode([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handlePhoneCode:)], USER_MANAGER.phone, @"", type, @"1", @"");
}
//验证码回调
- (void)handlePhoneCode:(DelegatorArguments *)arguments{
    
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        
        NSString *str = [USER_MANAGER.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        _lblWarn.text = [NSString stringWithFormat:@"已将验证码发送到您的手机 %@", str];
        [UIView animateWithDuration:.1 animations:^{
            _mainView.top = _lblWarn.bottom;
        }];

        [HUDUtil showSuccessWithStatus:dic.operationMessage];
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

#pragma mark -内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_name release];
    [_dataDic release];
    [_txtConfirm release];
    [_btnConfirm release];
    [_mainView release];
    [_lblWarn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTxtConfirm:nil];
    [self setBtnConfirm:nil];
    [self setMainView:nil];
    [self setLblWarn:nil];
    [super viewDidUnload];
}
@end
