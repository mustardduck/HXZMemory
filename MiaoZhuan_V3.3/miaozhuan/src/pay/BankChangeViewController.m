//
//  BankChangeViewController.m
//  guanggaoban
//
//  Created by 孙向前 on 14-4-2.
//  Copyright (c) 2014年 edwin good. All rights reserved.
//

#import "BankChangeViewController.h"
#import "UIView+expanded.h"
#import "NSDictionary+expanded.h"
#import "RRLineView.h"
#import "BankChangStepTwoController.h"
#import "RRAttributedString.h"

@interface BankChangeViewController ()<UIAlertViewDelegate>
{
    NSString * _paymentType;
}


@property (retain, nonatomic) IBOutlet UIButton *btnCommit;
@property (retain, nonatomic) IBOutlet UILabel *lblPrice;
@property (retain, nonatomic) IBOutlet UILabel *fromTypeLbl;
@property (retain, nonatomic) IBOutlet UILabel *commitTitleLbl;


@end

@implementation BankChangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(_isPos)
    {
        _paymentType = @"7";//POS
        
        _commitTitleLbl.text = @"请用快钱POS机转账到以上账户";
    }
    else
    {
        _paymentType = @"3";//银行转账
        _commitTitleLbl.text = @"请前往银行转账到以上账户";

    }
    
    self.navigationItem.title = @"确认转账信息";
    [self setupMoveBackButton];
    
    [_btnCommit roundCorner];
    
    _lblPrice.text = [NSString stringWithFormat:@"转账金额 ￥%.2f",[_totalPay floatValue]];
    
    NSAttributedString *attrStr = [RRAttributedString setText:_lblPrice.text font:[UIFont systemFontOfSize:14] color:AppColor(34) range:NSMakeRange(0, 4)];
    
    _lblPrice.attributedText = attrStr;
    

    //*  OrderType : 1：直购商城 2：用户感恩果 3：商家VIP（年）4：金币 5：用户VIP 6：直投广告 7：易货商城(易货商品) 8：兑换商城(银元商品) 9:大额金币购买 10:易货额度购买
    if(_orderType == 4 || _orderType == 9)
    {
        self.orderType = 9;
        _fromTypeLbl.text = @"购买大额广告金币";
    }
    else if (_orderType == 6)
    {
        _fromTypeLbl.text = @"购买红包广告条数";
    }
    else if (_orderType == 3)
    {
        _fromTypeLbl.text = @"购买商家VIP";
    }else if (_orderType == 10)
    {
        _fromTypeLbl.text = @"购买易货额度";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

//好的，去转账
- (IBAction)commitButtonClicked:(id)sender {
    
    NSDictionary *dic = @{@"ItemCount":_itemCount,@"OrderSerialNo":_orderId, @"OrderType":@(_orderType), @"PaymentType": _paymentType};//3.银行转账 7.pos机
    
    ADAPI_Payment_GoCashPayment([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGoCashPayment:)], dic);

}

- (void)handleGoCashPayment:(DelegatorArguments *)arguments
{
    DictionaryWrapper * wrapper = arguments.ret;
    
    if(wrapper.operationSucceed)
    {
        PUSH_VIEWCONTROLLER(BankChangStepTwoController);
        model.orderId = [wrapper.data getString:@"OrderSerialNo"];
        model.orderType = _orderType;
        model.itemCount = _itemCount;
        model.totalPay = _totalPay;
        model.payFrom = _fromTypeLbl.text;
        model.paymType = _paymentType;
        model.isPOS = _isPos;
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void)dealloc {
    [_itemCount release];

    [_orderId release];
    [_totalPay release];
    [_goodsinfo release];
    [_lblPrice release];

    [_btnCommit release];
    [_fromTypeLbl release];
    [_commitTitleLbl release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLblPrice:nil];
    [self setBtnCommit:nil];
    [super viewDidUnload];
}



@end
