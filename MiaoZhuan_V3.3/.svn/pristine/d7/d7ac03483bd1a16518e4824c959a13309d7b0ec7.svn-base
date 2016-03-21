//
//  ZhiFuPwdQueRenViewController.m
//  miaozhuan
//
//  Created by apple on 15/6/1.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "ZhiFuPwdQueRenViewController.h"
#import "Redbutton.h"
#import "OwnSliverManagerViewController.h"
#import "MyGoldMainController.h"
#import "CurrencyCirculationMsgViewController.h"
#import "ZhiFuPwdForgetController.h"
#import "MyMarketMyOrderDetailController.h"
#import "PayStateViewController.h"
#import "GetMoreGoldViewController.h"
#import "ZhiFuPwdEditController.h"
#import "CircurateViewController.h"
#import "MyGoldCircurateViewController.h"
#import "ConfirmOrderViewController.h"
#import "MyMarketMyOrderListController.h"
#import "MySaleReturnAndAfterSaleViewController.h"

@interface ZhiFuPwdQueRenViewController ()<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *payNumTxt;
@property (retain, nonatomic) IBOutlet Redbutton *payBtn;

@property (retain, nonatomic) IBOutlet UIButton *forgetPwbBtn;
- (IBAction)touchUpBtn:(id)sender;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineOne;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineTwo;
@end

@implementation ZhiFuPwdQueRenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    InitNav(@"支付密码确认");
    _lineOne.constant = 0.5;
    _lineTwo.constant = 0.5;
    
    [_payNumTxt setSecureTextEntry:YES];
    
    [self addDoneToKeyboard:_payNumTxt];
}

- (void) hiddenKeyboard
{
    [_payNumTxt resignFirstResponder];
}

- (void) onMoveBack:(UIButton *)sender
{
    [self turn];
}

- (IBAction)touchUpBtn:(id)sender
{
    if (sender ==  _forgetPwbBtn)
    {
        //忘记密码
        PUSH_VIEWCONTROLLER(ZhiFuPwdForgetController);
    }
    else if (sender == _payBtn)
    {
        NSString *PayPwd = _payNumTxt.text;
        if (!PayPwd.length)
        {
            [HUDUtil showErrorWithStatus:@"请输入支付密码!"];return;
        }
        
//        if (_isJinBiNum == NO)
//        {
//            __block typeof(self) weakself = self;
//           [AlertUtil showAlert:@"" message:@"抱歉，金币账户余额不足" buttons:@[@"确定",@{
//                                                                      @"title":@"去赚金币",
//                                                                      @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
//                                                                      ({
//            [weakself.navigationController pushViewController:WEAK_OBJECT(GetMoreGoldViewController, init) animated:YES];
//        })
//                                                                      }]];return;
//        }
        //银元、金币流通
        if ([_type isEqualToString:@"1"])
        {
            [_dataDic setValue:PayPwd forKey:@"PayPwd"];
            
            [_payNumTxt resignFirstResponder];
            if(!_isGold)
            {
                ADAPI_CustomerIntegral_SendGiftIntegral([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSendGiftIntegral:)], _dataDic);
            }
            else
            {
                ADAPI_CustomerGoldSendGiftGold([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSendGiftGold:)],_dataDic);
            }
        }
        else if ([_type isEqualToString:@"2"])
        {
            [_dataDic setValue:PayPwd forKey:@"PayPwd"];
            
            [_payNumTxt resignFirstResponder];
            
            //易货购物
            ADAPI_Payment_GoGoldPayment([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGoldPayment:)], _dataDic);
        }
        else if ([_type isEqualToString:@"3"])
        {
            [_payNumTxt resignFirstResponder];
            
            //确认收货
            ADAPI_GoldMallEnsure([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(ensureHandler:)], _OrderId, _payNumTxt.text);
        }
    }
}

//易货购买
- (void)handleGoldPayment:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed)
    {
        PayStateViewController *pay = WEAK_OBJECT(PayStateViewController, init);
        pay.orderNum = [dic.data getString:@"OrderSerialNo"];
        pay.payType = _ptype;
        pay.orderType = [[_dataDic wrapper] getString:@"OrderType"];
        pay.isPost = ![[_dataDic wrapper] getBool:@"ExchangeType"];
        pay.goodsInfo = _goodsInfo;
        pay.productId = [[_dataDic wrapper] getString:@"ProductId"];
        pay.payBonusLink = [dic.data getString:@"PayBonusLink"];
        
        [self.navigationController pushViewController:pay animated:YES];
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];return;
    }
}


//确认收货
- (void)ensureHandler:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed)
    {
        [HUDUtil showSuccessWithStatus:@"确认收货成功"];
        
        if (_isTuiHuo)
        {
            PUSH_VIEWCONTROLLER(MyMarketMyOrderDetailController);
            
            model.orderNum = self.orderNum;
            
            model.productType = _orderType;
            
            model.Type = 1;
        }
        else
        {
            [self turn];
        }
    }
    else
    {
        [HUDUtil showErrorWithStatus: wrapper.operationMessage];
    }
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
    }
}


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
    DotCViewController *dvc = nil;
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    for (DotCViewController *vc in self.navigationController.viewControllers) {
        if([vc isKindOfClass:[CircurateViewController class]] || [vc isKindOfClass:[MyGoldCircurateViewController class]] || [vc isKindOfClass:[ConfirmOrderViewController class]] || [vc isKindOfClass:[MyMarketMyOrderListController class]] || [vc isKindOfClass:[MySaleReturnAndAfterSaleViewController class]]){
            dvc = vc;
            break;
        }
    }
    [self.navigationController popToViewController:dvc animated:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (_payNumTxt == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 6)
        {
            return NO;
        }
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_payNumTxt release];
    [_forgetPwbBtn release];
    [_payBtn release];
    [_lineOne release];
    [_lineTwo release];
    
    [_name release];
    [_dataDic release];
    
    [super dealloc];
}

@end
