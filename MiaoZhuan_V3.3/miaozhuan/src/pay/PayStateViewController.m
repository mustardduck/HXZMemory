//
//  PayStateViewController.m
//  guanggaoban
//
//  Created by 孙向前 on 14-4-2.
//  Copyright (c) 2014年 edwin good. All rights reserved.
//

#import "PayStateViewController.h"
#import "UIView+expanded.h"
#import "NSDictionary+expanded.h"
#import "TimeCounter.h"
#import "Share_Method.h"
#import "NSDictionary+expanded.h"
#import "UserInfo.h"
#import "CRPopWebView.h"
#import "RRAttributedString.h"
#import "Preview_Commodity.h"

@interface PayStateViewController (){
    TimeCounter *   _timer;
    int             _autoCount;
    BOOL            _orderDone;
    UIButton *_currentShareButton;
    CRPopWebView *webview;
}

@property (retain, nonatomic) IBOutlet UILabel *payFromLbl;//来源
@property (retain, nonatomic) IBOutlet UILabel *orderNoLbl;//订单号
@property (retain, nonatomic) IBOutlet UILabel *totalLbl;//转账金额

@property (retain, nonatomic) IBOutlet UIView *bankView;//银行转账成功页面
@property (retain, nonatomic) IBOutlet UIView *payedView;//付款成功页面
@property (retain, nonatomic) IBOutlet UIView *payErrorView;//交易异常页面
@property (retain, nonatomic) IBOutlet UIView *dealing1View;//正在处理页面
@property (retain, nonatomic) IBOutlet UIView *directedErrorView;

@property (retain, nonatomic) IBOutlet UIView *payed1View;
@property (retain, nonatomic) IBOutlet UILabel *lblPayedGoodName;
@property (retain, nonatomic) IBOutlet UILabel *lblPayedGoodNum;
@property (retain, nonatomic) IBOutlet UILabel *lblPayedOrderNum;
@property (retain, nonatomic) IBOutlet UILabel *lblPayedType;
@property (retain, nonatomic) IBOutlet UILabel *lblPayedStatus;
@property (retain, nonatomic) IBOutlet UILabel *lblPayedTotal;

@property (retain, nonatomic) IBOutlet UIView *dealIngview;//正在处理页面
@property (retain, nonatomic) IBOutlet UILabel *lblGoodsName;
@property (retain, nonatomic) IBOutlet UILabel *lblGoodsNum;
@property (retain, nonatomic) IBOutlet UILabel *lblOrderNum;
@property (retain, nonatomic) IBOutlet UILabel *lblPayType;
@property (retain, nonatomic) IBOutlet UILabel *lblStatus;
@property (retain, nonatomic) IBOutlet UILabel *lblTotal;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) IBOutlet UIView *refreshView;

@property (retain, nonatomic) IBOutlet UILabel *lbldes;
@property (retain, nonatomic) IBOutlet UILabel *lblmallstatus;

@end

@implementation PayStateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _timer = STRONG_OBJECT(TimeCounter, init);
        _orderDone = FALSE;
    }
    return self;
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = _isBankChange ? @"转账结果" : @"支付结果";
    [self setupMoveFowardButtonWithTitle:@"完成"];
    
    if (_isBankChange) {
        _orderDone = true;
        [self createLeftItem];
        [self addSubviewToScrollview:_bankView];
        
        _payFromLbl.text = _payFrom;
        _orderNoLbl.text = _orderNum;
        _totalLbl.text = [NSString stringWithFormat:@"转账金额 ￥%.2f",[_totalPay floatValue]];
        
        NSAttributedString *attrStr = [RRAttributedString setText:_totalLbl.text font:[UIFont systemFontOfSize:14] color:AppColor(34) range:NSMakeRange(0, 4)];
        
        _totalLbl.attributedText = attrStr;

    } else {
        [self setupMoveBackButton];
        [self startAutoReqeustOrderInfo];
    }
    
}

- (void)startAutoReqeustOrderInfo
{
    if(_orderDone)
    {
        return ;
    }
    
    [_timer deSetup];
    
    [_timer setDelegator:self selector:@selector(autoRequestOrderInfo:)];
    [_timer setTimer:3 repeatCount:4];
    [_timer setup];
    _autoCount = 0;
    
    [self requestOrderInfo];
}

- (void)autoRequestOrderInfo:(DelegatorArguments*)arguments
{
    [self requestOrderInfo];
}

- (void)requestOrderInfo
{
    if ([_orderType intValue] == 7 || [_orderType intValue] == 8) {
        //支付成功
        
        if (![_payedView superview]) {
            [self addSubviewToScrollview:_payedView];
        }
        
        if (_isPost)
        {
            _lblmallstatus.text = @"付款成功，请等待商家发货！";
            _lbldes.text = @"                    商家发货       确认收货    交易完成";
        }
        else
        {
            _lblmallstatus.text = @"付款成功，请前往现场兑换哟！";
            _lbldes.text = @"                    现场兑换       确认兑换    交易完成";
        }
        
        if (_payBonusLink.length) {
            
            if (webview) {
                return;
            }
            
            if (self.payBonusLink.length && ![self.payBonusLink isKindOfClass:[NSNull class]]) {
                if ([_orderType intValue] == 7) {
                     webview = STRONG_OBJECT(CRPopWebView, init);
                    [webview showUrl:self.payBonusLink];
                }
            }
        }
        
    } else if (_isBankChange)
    {
        //现金支付、银行转帐
        //支付成功
        [self addSubviewToScrollview:_bankView];
        
    }
    else
    {
        NSDictionary *dic = @{@"OrderSerialNo":_orderNum,@"OrderType":_orderType,@"PaymentType":[NSString stringWithFormat:@"%d" ,_payType]};
        ADAPI_Payment_ClientNotify([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(onUpdateOrderInfo:)], dic);
    }
}

- (void)createLeftItem{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = left;
    [left release];
    [view release];
}

- (void)onUpdateOrderInfo:(DelegatorArguments *)arguments
{
    if(_orderDone)
    {
        return ;
    }
    
    BOOL lastAutoUpdate = FALSE;
    
    ++_autoCount;
    
    lastAutoUpdate = _autoCount == 5;
    
    if ([arguments getArgument:NET_ARGUMENT_ERROR])
    {

        self.refreshView.hidden = NO;
        [self createLeftItem];
        
        return;
    }
    
    if(lastAutoUpdate)
    {
        [self createLeftItem];
    }
    
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        
        int value = 0;
        if ([_orderType intValue] == 7 || [_orderType intValue] == 8) {
            value = [dic.data getInt:@"OrderStatus"];
            
            if (value >=200 && value < 300 && lastAutoUpdate) {
                [self addSubviewToScrollview:_dealing1View];
            } else if (value == 901) {
                //支付成功
                [self addSubviewToScrollview:_payedView];
            }
            
        } else {
            value = [dic.data getInt:@"Status"];
            
            _orderDone = value == 901;
            
            if (_isBankChange) {
                //转账
                if (value == 102) {
                    //处理中
                } else if (value == 901) {
                    //支付成功
                    [self addSubviewToScrollview:_bankView];
                } else if (value == 105) {
                    //交易异常
                }
                
            } else {
                if(value == 105)  // Order Fail
                {
                    if (lastAutoUpdate)
                    {
                        if ([_orderType intValue] == 7 || [_orderType intValue] == 8)
                            [self addSubviewToScrollview:_directedErrorView];
                        else
                            [self addSubviewToScrollview:_payErrorView];
                    }
                }
                else
                {
                    if ([_orderType intValue] == 7 || [_orderType intValue] == 8)
                    {
                        if(value == 102 && lastAutoUpdate)    // 处理中
                        {
                            [self addSubviewToScrollview:_dealing1View];
                        }
                        else if (value == 901)
                        {
                            //支付成功
                            [self addSubviewToScrollview:_payedView];
                        }
                    }
                    else
                    {
                        //other
                        NSString *paytype = (self.payType == 1 ? @"银联支付" : (self.payType == 2 ? @"支付宝支付" : @"微信支付"));
                        NSString *goodName = [self.goodsInfo[0] valueForJSONStrKey:@"name"];
                        NSString *goodNum = [self.goodsInfo[0] valueForJSONStrKey:@"num"];
                        if (value == 102 && lastAutoUpdate)
                        {
                            //处理中
                            [self addSubviewToScrollview:_dealIngview];
                            _lblGoodsName.text = goodName;
                            _lblGoodsNum.text = goodNum;
                            _lblOrderNum.text = _orderNum;
                            _lblPayType.text = paytype;
                            _lblTotal.text = [NSString stringWithFormat:@"￥%.2f",[_totalPay floatValue]];
                        } else if (value == 901)
                        {
                            //支付成功
                            [self addSubviewToScrollview:_payed1View];
                            _lblPayedGoodName.text = goodName;
                            _lblPayedGoodNum.text = goodNum;
                            _lblPayedOrderNum.text = _orderNum;
                            _lblPayedTotal.text = [NSString stringWithFormat:@"￥%.2f",[_totalPay floatValue]];
                            _lblPayedType.text = paytype;
                        }
                    }
                }
            }
        }
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
    }
    
//    if (_delegate && [_delegate respondsToSelector:@selector(payFinishWithStatus:)]) {
//        [_delegate payFinishWithStatus:_orderDone];
//    }
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"PayStatus" object:@(_orderDone)];
    
    if(_orderDone)
    {
        [self createLeftItem];
        [_timer deSetup];
    }
}

- (void)addSubviewToScrollview:(UIView *)view{
    view.frame = CGRectMake(0, 0, SCREENWIDTH, view.frameHeight);
    [_scrollview addSubview:view];
    [_scrollview setContentSize:CGSizeMake(SCREENWIDTH, view.frameHeight)];
}

- (IBAction) onMoveFoward:(UIButton*) sender{
    if(_isPost)
    {
        if ([_orderType intValue] == 5 || [_orderType intValue] == 4 || [_orderType intValue] == 9 || [_orderType intValue] == 3 || [_orderType intValue] == 2)
        {
            [self onMoveBack:nil];
            return;
        }
        
        if([_orderType intValue] == 8)
        {
            [self onMoveBack:nil];
            return;
        }
        
        [self jumpToMainView];
    }
    else
    {
        [self onMoveBack:nil];
    }
}

- (void) jumpToMainView
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[Preview_Commodity class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}

//返回
- (IBAction)onMoveBack:(UIButton *)btn
{
    if ([_orderType intValue] == 7)
    {
        NSArray *vcs = self.navigationController.viewControllers;
        UIViewController *vc = vcs[2];
        [self.navigationController popToViewController:vc animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PayStatus" object:@(YES)];
        return;
    }
    
    NSArray *vcs = self.navigationController.viewControllers;
    UIViewController *vc = vcs[vcs.count - (_isBankChange ? 4 : 3)];
    [self.navigationController popToViewController:vc animated:YES];
    
    if ([_orderType intValue] == 8 || _isBankChange) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PayStatus" object:@(YES)];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PayStatus" object:@(_orderDone)];
    }
}

//点击页面刷新
- (IBAction)tapRefreshButtonClicked:(UITapGestureRecognizer *)sender
{
    [_refreshView setHidden:YES];
    
    [self startAutoReqeustOrderInfo];
}
//分享
- (IBAction)shareButtonClicked:(UIButton *)sender {
    _currentShareButton = sender;
    sender.enabled = NO;
    if ([_orderType intValue] == 7 || [_orderType intValue] == 8) {
        
        NSString *key = @"";
        if ([_orderType intValue] == 7) {
            key = @"709b55f6261448417f8d5055b7aff27a";
        } else {
            key = @"72e7c16a7b36074620cbea3fceb8d2be";
        }
        
        if ([_orderType intValue] == 8) {
            [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":key, @"product_id":_productId.length ? _productId : @"", @"advert_id":_advertId.length ? _advertId : @""}];
        } else {
            [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":key, @"product_id":_productId.length ? _productId : @""}];
        }
        
    } else {
        
        NSString *key = @"";
        switch ([_orderType intValue]) {
            case 2:
                key = @"24107f67025a9cec2c237394d4e3a9e8";
                break;
            case 3:
                key = @"da12652baa7b8f645f84554fc6b95422";
                break;
            case 5:
                key = @"8a792919bc4cc02b3e02223b1bcff9ae";
                break;
                
            default:
                key = @"24b85ba13b2d0e6245c257ffe27670a2";
                break;
        }
        
        [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key" : key}];
        
    }
    sender.enabled = YES;
}

//打电话
- (IBAction)makeCallClicked:(id)sender {
    [[UICommon shareInstance]makeCall:kServiceMobile];
}

- (void)viewWillDisappear:(BOOL)animated{
    [_timer deSetup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [webview release];
    [_payBonusLink release];
    [_orderNum release];
    [_productId release];
    [_advertId release];
    [_totalPay release];
    [_timer deSetup];
    [_timer release];
    [_bankView release];
    [_payedView release];
    [_payErrorView release];
    [_dealIngview release];
    [_lblGoodsName release];
    [_lblGoodsNum release];
    [_lblOrderNum release];
    [_lblPayType release];
    [_lblStatus release];
    [_lblTotal release];
    [_dealing1View release];
    [_payed1View release];
    [_lblPayedGoodName release];
    [_lblPayedGoodNum release];
    [_lblPayedOrderNum release];
    [_lblPayedType release];
    [_lblPayedStatus release];
    [_lblPayedTotal release];
    [_scrollview release];
    [_refreshView release];
    [_directedErrorView release];
    [_lbldes release];
    [_lblmallstatus release];
    [_payFromLbl release];
    [_orderNoLbl release];
    [_totalLbl release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBankView:nil];
    [self setPayedView:nil];
    [self setPayErrorView:nil];
    [self setDealIngview:nil];
    [self setLblGoodsName:nil];
    [self setLblGoodsNum:nil];
    [self setLblOrderNum:nil];
    [self setLblPayType:nil];
    [self setLblStatus:nil];
    [self setLblTotal:nil];
    [self setDealing1View:nil];
    [self setPayed1View:nil];
    [self setLblPayedGoodName:nil];
    [self setLblPayedGoodNum:nil];
    [self setLblPayedOrderNum:nil];
    [self setLblPayedType:nil];
    [self setLblPayedStatus:nil];
    [self setLblPayedTotal:nil];
    [self setScrollview:nil];
    [self setRefreshView:nil];
    [self setDirectedErrorView:nil];
    [self setLbldes:nil];
    [self setLblmallstatus:nil];
    [super viewDidUnload];
}
@end
