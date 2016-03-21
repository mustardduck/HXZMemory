//
//  ZhiFuPwdYanZhengViewController.m
//  miaozhuan
//
//  Created by apple on 15/6/29.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "ZhiFuPwdYanZhengViewController.h"
#import "UIView+expanded.h"
#import "Redbutton.h"
#import "otherButton.h"
#import "ZhiFuPwdEditController.h"
#import "UserInfo.h"

@interface ZhiFuPwdYanZhengViewController ()<UITextFieldDelegate>
{
    NSString * SecurityCode;
}

@property (retain, nonatomic) IBOutlet UITextField *yanzhengmaTxt;
@property (retain, nonatomic) IBOutlet otherButton *getYanzhengmaBtn;
- (IBAction)btnTouch:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *phoneOneLable;
@property (retain, nonatomic) IBOutlet UILabel *phoneTwoLable;
- (IBAction)telPhone:(id)sender;
@property (retain, nonatomic) IBOutlet Redbutton *nextBtn;

@property (nonatomic, retain) NSTimer  *getCodeTimer;                        //获取验证码计时器
@property (nonatomic, assign) BOOL     isTimeGetCode;                        //是否定时器生成，而非接口调用生成
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineOne;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineTwo;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineThree;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineFour;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineFive;
@end

@implementation ZhiFuPwdYanZhengViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"设置支付密码");
    
    [_getYanzhengmaBtn roundCorner];
    _getYanzhengmaBtn.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    [_nextBtn roundCorner];
    
    _yanzhengmaTxt.delegate = self;
    
    [self addDoneToKeyboard:_yanzhengmaTxt];
    
    _getYanzhengmaBtn.h_color = AppColor(229);
    
    _getYanzhengmaBtn.n_color = AppColorWhite;
    
    [_getYanzhengmaBtn addTimer:60];
    
    _lineOne.constant = 0.5;
    
    _lineThree.constant = 0.5;
    
    _lineTwo.constant = 0.5;
    
    _lineFour.constant = 0.5;
    
    _lineFive.constant = 0.5;
}

-(void)hiddenKeyboard
{
    [_yanzhengmaTxt resignFirstResponder];
}

- (IBAction)btnTouch:(id)sender
{
    if (sender == _getYanzhengmaBtn)
    {
        
        ADAPI_adv3_GetPhoneCode([self genDelegatorID:@selector(HandleNotification:)], USER_MANAGER.phone, @"", @"10", @"2",@"");
        
    }
    else if (sender == _nextBtn)
    {
        if ([_yanzhengmaTxt.text isEqualToString:@""])
        {
            [HUDUtil showErrorWithStatus:@"请输入验证码"];
            return;
        }
        else
        {
            ADAPI_adv3_3_ValidateCode_ValidatePhoneCode([self genDelegatorID:@selector(HandleNotification:)], _yanzhengmaTxt.text, @"10");
        }
    }
}

-(void)HandleNotification: (DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_GetPhoneCode])
    {
        [arguments logError];
        
        DictionaryWrapper* wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            [_getYanzhengmaBtn startTimer];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_3_ValidateCode_ValidatePhoneCode])
    {
        [arguments logError];
        
        DictionaryWrapper* wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            SecurityCode = [wrapper.data getString:@"SecurityCode"];
            
            [self pushView];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}

-(void) pushView
{
    if (_zhifuPwdFromType == ZhifuPWD_Silver)
    {
        ZhiFuPwdEditController *model = [[[ZhiFuPwdEditController alloc ] init] autorelease];
        model.zhifuPwdFromType = ZhifuPWD_Silver;
        model.name = _name;
        model.dataDic = _dataDic;
        model.type = @"1";
        model.ValidateCode = SecurityCode;
        [self.navigationController pushViewController:model animated:YES];
    }
    else if (_zhifuPwdFromType == ZhifuPWD_YiHuoMallBuy)
    {
        PUSH_VIEWCONTROLLER(ZhiFuPwdEditController);
        model.zhifuPwdFromType = ZhifuPWD_YiHuoMallBuy;
        model.dataDic = _dataDic;
        model.type = @"2";
        model.ValidateCode = SecurityCode;
    }
    else if (_zhifuPwdFromType == ZhifuPWD_Gold)
    {
        ZhiFuPwdEditController *model = [[[ZhiFuPwdEditController alloc] init] autorelease];
        model.dataDic = _dataDic;
        model.zhifuPwdFromType = ZhifuPWD_Gold;
        model.name = _name;
        model.isGold = YES;
        model.type = @"1";
        model.ValidateCode = SecurityCode;
        [self.navigationController pushViewController:model animated:YES];
    }
    else if (_zhifuPwdFromType == ZhifuPWD_MyOrderShouHuo)
    {
        PUSH_VIEWCONTROLLER(ZhiFuPwdEditController);
        model.zhifuPwdFromType = ZhifuPWD_MyOrderShouHuo;
        model.orderId = _orderId;
        model.type = @"3";
        model.ValidateCode = SecurityCode;
    }
    else if (_zhifuPwdFromType == ZhifuPWD_ReturnShouHuo)
    {
        PUSH_VIEWCONTROLLER(ZhiFuPwdEditController);
        model.orderId = _orderId;
        model.isTuiHuo = YES;
        model.type = @"3";
        model.orderNum = _orderNum;
        model.orderType = _orderType;
        model.zhifuPwdFromType = ZhifuPWD_ReturnShouHuo;
        model.ValidateCode = SecurityCode;
    }
    else
    {
        PUSH_VIEWCONTROLLER(ZhiFuPwdEditController);
        model.ValidateCode = SecurityCode;
    }
}

- (IBAction)telPhone:(id)sender
{
    if (sender == _phoneOneLable)
    {
        [[UICommon shareInstance]makeCall:@"400-019-3588"];
    }
    else
    {
        [[UICommon shareInstance]makeCall:@"400-629-8899"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    [_yanzhengmaTxt release];
    [_getYanzhengmaBtn release];
    [_phoneOneLable release];
    [_phoneTwoLable release];
    [_nextBtn release];
    [_lineOne release];
    [_lineTwo release];
    [_lineThree release];
    [_lineFour release];
    [_lineFive release];
    [super dealloc];
}

@end
