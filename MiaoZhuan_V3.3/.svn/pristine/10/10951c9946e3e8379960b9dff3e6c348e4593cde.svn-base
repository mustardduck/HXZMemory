//
//  BankChangStepTwoController.m
//  miaozhuan
//
//  Created by momo on 15/6/9.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "BankChangStepTwoController.h"
#import "DatePickerViewController.h"
#import "UIView+expanded.h"
#import "PayStateViewController.h"

@interface BankChangStepTwoController ()<DatePickerDelegate>

@property (retain, nonatomic) IBOutlet UITextField *txtName;
@property (retain, nonatomic) IBOutlet UITextField *txtNo;
@property (retain, nonatomic) IBOutlet UITextField *txtTime;
@property (retain, nonatomic) IBOutlet UIView *infoView;
@property (nonatomic, retain) DatePickerViewController *datePickerVC;
@property (retain, nonatomic) IBOutlet UIButton *btnCommit;
@property (retain, nonatomic) IBOutlet UIView *payToView;
@property (retain, nonatomic) IBOutlet UIView *LSHView;
@property (retain, nonatomic) IBOutlet UIView *payToCenterView;
@property (retain, nonatomic) IBOutlet UIView *LSHCenterView;
@property (retain, nonatomic) IBOutlet UILabel *payFromLbl;
@property (retain, nonatomic) IBOutlet UILabel *orderNoLbl;
@property (retain, nonatomic) IBOutlet UILabel *totalLbl;
@property (retain, nonatomic) IBOutlet UILabel *secondLbl;
@property (retain, nonatomic) IBOutlet UIView *POSView;
@property (retain, nonatomic) IBOutlet UIView *POSCenterView;


@end

@implementation BankChangStepTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_infoView roundCorner];
    _infoView.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    [_payToCenterView roundCorner];
    _payToCenterView.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    [_LSHCenterView roundCorner];
    _LSHCenterView.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    [_POSCenterView roundCorner];
    _POSCenterView.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    [self addDoneToKeyboard:_txtName];
    [self addDoneToKeyboard:_txtNo];
    
    InitNav(@"填写转账信息");
    [self setupMoveBackButton];
    
    [self setPayViewData];
    
    [self fixUI];

    _POSView.hidden = YES;
}

- (void) fixUI
{
    CGFloat height = [[UIScreen mainScreen] bounds].size.height - 64;
    
    _LSHCenterView.top = (height - H(_LSHCenterView))/2;
    
    _payToCenterView.top = (height - H(_payToCenterView))/2;
    
    _POSCenterView.top = (height - H(_POSCenterView))/2;

    if(_isPOS)
    {
        _secondLbl.text = @"参考号";
        
        _txtNo.placeholder = @"付款参考号";
    }
}

- (void) hiddenKeyboard
{
    [_txtName resignFirstResponder];
    [_txtNo resignFirstResponder];
}

- (void) setPayViewData
{
    _payFromLbl.text = _payFrom;
    _orderNoLbl.text = _orderId;
    _totalLbl.text = [NSString stringWithFormat:@"￥%.2f",[_totalPay floatValue]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)payToAccountClick:(id)sender {
    [self hiddenKeyboard];
    _payToView.hidden = NO;
    
}

- (IBAction)LSHClick:(id)sender {
    [self hiddenKeyboard];
    if(_isPOS)
    {
        _POSView.hidden = NO;
    }
    else
    {
        _LSHView.hidden = NO;
    }
}
- (IBAction)hiddenPOSView:(id)sender {
    
    _POSView.hidden = YES;

}

- (IBAction)hiddenPayView:(id)sender {
    
    _payToView.hidden = YES;
}

- (IBAction)hiddenLSHView:(id)sender {
    
    _LSHView.hidden = YES;
}

- (IBAction)commitButtonClicked:(id)sender {
    
    NSString *name = _txtName.text;
    if (!name.length) {
        [HUDUtil showErrorWithStatus:@"亲，付款人姓名不能为空!"];return;
    }
    if (!_txtNo.text.length) {
        if(_isPOS)
        {
            [HUDUtil showErrorWithStatus:@"亲，付款参考号不能为空!"];return;
        }
        else
        {
            [HUDUtil showErrorWithStatus:@"亲，付款流水号不能为空!"];return;
        }
    }
    if (!_txtTime.text.length) {
        [HUDUtil showErrorWithStatus:@"亲，付款时间不能为空!"];return;
    }
    
    for(int i=0; i< [name length];i++){
        
        int str = [name characterAtIndex:i];
        
        if(!((str >= 0x4e00 && str <= 0x9fff) || (str >= 0x3400 && str <= 0x4dff) || (str >= 0xf900 && str <= 0xfaff) || (str >= 0x20000 && str <= 0x2A6DF) || (str >= 0x2F800 && str <= 0x2FA1F))) {
            [HUDUtil showErrorWithStatus:@"亲，姓名只能是汉字!"];
            return;
        }
    }
    
    NSDictionary *dic = @{@"OrderSerialNo":_orderId, @"PaymentName":_txtName.text, @"TradeNo":_txtNo.text,@"PaymentTime":_txtTime.text};
    
    if(_isPOS)
    {
        ADAPI_Payment_GoPOSPayment([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleBankTransfre:)], dic);
    }
    else
    {
        ADAPI_Payment_GoBankTransferPayment([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleBankTransfre:)], dic);

    }
}

#pragma mark - actions
//接口处理
- (void)handleBankTransfre:(DelegatorArguments *)arguments {
    DictionaryWrapper* dic = arguments.ret;
    if([arguments isEqualToOperation:ADOP_Payment_GoBankTransferPayment] || [arguments isEqualToOperation:ADOP_Payment_GoPOSPayment])
    {
        if (dic.operationSucceed) {
            PayStateViewController *pay = WEAK_OBJECT(PayStateViewController, init);
            pay.orderNum = _orderId;
            pay.isBankChange = YES;
            pay.payType = [_paymType intValue];//银行转账
            pay.payFrom = _payFrom;
            pay.totalPay = _totalPay;
            
            //        pay.goodsInfo = _goodsinfo;
            [self.navigationController pushViewController:pay animated:YES];
        } else {
            
            [HUDUtil showErrorWithStatus:dic.operationMessage];
            return;
        }
    }
}

- (IBAction)dateClicked:(id)sender {
    
    [self hiddenKeyboard];
    
    _datePickerVC = [[DatePickerViewController alloc]initWithNibName:@"DatePickerViewController" bundle:nil];
    CGFloat offset = [UICommon getIos4OffsetY];
    [_datePickerVC setMaxDate:[NSDate date]];
    _datePickerVC.view.frame = CGRectMake(0, 0, 320, 460 + offset);
    _datePickerVC.delegate = self;
    [_datePickerVC setMaxDate:[NSDate date]];
    [self.view addSubview:_datePickerVC.view];
}

#pragma mark -date delegate

- (void) selectDateCallBack:(NSDate*)date{
    [UIView animateWithDuration:.3 animations:^{
        [_datePickerVC.view removeFromSuperview];
    }];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    
    NSString* text = [dateFormatter stringFromDate:date];
    
    _txtTime.text = text;
    
    [dateFormatter release];
    dateFormatter = nil;
}

- (void) cancelDateCallBack:(NSDate*)date{
    
    [UIView animateWithDuration:.3 animations:^{
        [_datePickerVC.view removeFromSuperview];
    }];
}

- (IBAction)makeCallClicked:(UIButton *)sender {
    [[UICommon shareInstance]makeCall:kServiceMobile];
}

- (void)dealloc {
    if (_datePickerVC) {
        [_datePickerVC release];
    }
    [_txtName release];
    [_txtTime release];
    [_txtNo release];
    [_infoView release];

    [_payToView release];
    [_LSHView release];
    [_payToCenterView release];
    [_LSHCenterView release];
    [_payFromLbl release];
    [_orderNoLbl release];
    [_totalLbl release];
    [_secondLbl release];
    [_POSView release];
    [_POSCenterView release];
    [super dealloc];

}

- (void)viewDidUnload {
    
    [self setTxtName:nil];
    [self setTxtTime:nil];
    [self setTxtNo:nil];
    [self setInfoView:nil];

}

@end
