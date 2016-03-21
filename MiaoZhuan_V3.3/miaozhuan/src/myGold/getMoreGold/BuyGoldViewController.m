//
//  BuyGoldViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/16.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BuyGoldViewController.h"
#import "Redbutton.h"
#import "UIView+expanded.h"
#import "CROrderManagerViewController.h"
#import "ConfirmOrderViewController.h"

@interface BuyGoldViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
{
    BOOL buyGold;
    
    int beginMonth;
    
    int big;
    
//    CRENUM_OrderType type;
}
@property (retain, nonatomic) IBOutlet UIImageView *animation_line;

//小额购买
@property (retain, nonatomic) IBOutlet UILabel *balanceMoneyLabel;
@property (retain, nonatomic) IBOutlet UITextField *needGoldTxt;
@property (retain, nonatomic) IBOutlet UILabel *payMoneyLable;
@property (retain, nonatomic) IBOutlet Redbutton *payMoneyBtn;

//大额购买
@property (retain, nonatomic) IBOutlet UIScrollView *scrollerview;
@property (retain, nonatomic) IBOutlet UILabel *bigbalanceMoneyLable;
@property (retain, nonatomic) IBOutlet UITextField *bigNeedMoneyLable;
@property (retain, nonatomic) IBOutlet UIView *bigTwoView;
@property (retain, nonatomic) IBOutlet UILabel *zengsongLable;
@property (retain, nonatomic) IBOutlet UILabel *bigPayMoney;
@property (retain, nonatomic) IBOutlet Redbutton *bigpaymoneyBtn;
@property (retain, nonatomic) IBOutlet UILabel *cuxiaotwoLable;
@property (retain, nonatomic) IBOutlet UILabel *cuxiaooneLable;


//整体
@property (retain, nonatomic) IBOutlet UIButton *bigmoneyBtn;
@property (retain, nonatomic) IBOutlet UIButton *smallMoneyBtn;
@property (retain, nonatomic) IBOutlet UIView *bigmoneyView;
@property (retain, nonatomic) IBOutlet UIView *smallMoneyView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *redlines;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *scrollerWidth;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *scrollerHeight;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineVew;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineOne;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineTwo;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineThree;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *bigTwoTop;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *cuxiaotwoTop;
@property (retain, nonatomic) IBOutlet UIImageView *imageTop;
- (IBAction)touchUpInside:(id)sender;
- (IBAction)itemBtnclick:(id)sender;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineTop;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineTwoTop;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineThreeTop;

@end

@implementation BuyGoldViewController

-(void)viewWillAppear:(BOOL)animated
{
    ADAPI_CustomerGoldGetCustomerGoldSummary([self genDelegatorID:@selector(handleGetGoldSummary:)]);
}

- (void)handleGetGoldSummary:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        DictionaryWrapper * result = wrapper.data;
        
        _balanceGold = [NSString stringWithFormat:@"%.2f",[result getFloat:@"RemainingGold"]];
        
        _balanceMoneyLabel.text = _balanceGold;
        
        _bigbalanceMoneyLable.text = _balanceGold;
    }
//    else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
//    {
//        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
//    }
}

- (void)viewDidLayoutSubviews
{
    [_scrollerview setContentSize:CGSizeMake(SCREENWIDTH, 450)];
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"购买广告金币");
    
    [self setupMoveFowardButtonWithImage:@"goumai@2x.png" In:@"goumai@2x.png"];
    
    [self setLoad];
    
    [self GetNowTime];
    
    NSInteger num = [_bigNeedMoneyLable.text integerValue];
    
    double zengsong = num *0.1;
    
    double gongji = zengsong * (12 - beginMonth + 1);
    
    _zengsongLable.text = [NSString stringWithFormat:@"每月赠送%.2f广告金币，从%d月到12月共计%.2f广告金币",zengsong,beginMonth,gongji];
    
//    type = CRENUM_OrderTypeBuy_DEJB;
}

-(void) setLoad
{
    [_needGoldTxt roundCornerBorder];
    
    [self addDoneToKeyboard:_needGoldTxt];
    
    [_bigNeedMoneyLable roundCornerBorder];
    
    [self addDoneToKeyboard:_bigNeedMoneyLable];
    
    _lineOne.constant = 0.5;
    
    _lineTwo.constant = 0.5;
    
    _lineThree.constant = 0.5;
    
    _lineTwoTop.constant = 39.5;
    
    _lineTop.constant = 59.5;
    
    _lineThreeTop.constant = 59.5;
    
    DictionaryWrapper * result =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    if ([result getInt:@"VipLevel"] == 7)
    {
        if ([result getInt:@"EnterpriseStatus"] != 4)
        {
            _payMoneyBtn.backgroundColor = AppColorLightGray204;
            
            _payMoneyBtn.userInteractionEnabled = NO;
            
            _bigpaymoneyBtn.backgroundColor = AppColorLightGray204;
            
            _bigpaymoneyBtn.userInteractionEnabled = NO;
            
            _bigNeedMoneyLable.enabled = NO;
            
            _needGoldTxt.enabled = NO;
        }
    }
    
    
    if ([result getBool:@"HasBuyHugeGold"])
    {
        _imageTop.image = [UIImage imageNamed:@"yuanone.png"];
        _bigTwoTop.constant = 167;
        _cuxiaotwoTop.constant = 175;
        _cuxiaotwoLable.text = @"1、从即日起到今年12月31号，每月5号之前，都赠送本次购买总额的10%广告金币到您的账户。";
        _cuxiaooneLable.hidden = YES;
    }
    
    [self.view addSubview:_bigmoneyView];
    
    _bigmoneyView.frame = CGRectMake(0, 40, SCREENWIDTH, [UIScreen mainScreen].bounds.size.height - 104);
    
    _bigmoneyBtn.selected = YES;
}

-(void) GetNowTime
{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];

    beginMonth = [dateComponent month];
}

- (void)onMoveFoward:(UIButton *)sender
{
    PUSH_VIEWCONTROLLER(CROrderManagerViewController);
    model.type = CRENUM_OrderTypeGold;
}

-(void)hiddenKeyboard
{
    [_needGoldTxt resignFirstResponder];
    
    [_bigNeedMoneyLable resignFirstResponder];
}

- (IBAction)touchUpInside:(id)sender
{
    if (sender == _payMoneyBtn)
    {
        big = 1;
        
//        type = CRENUM_OrderTypeGold;
        
        //购买数量
        NSString *count = _needGoldTxt.text;
        //跳转去购买
        NSDictionary *dic = @{@"OrderType" : @"4", @"ItemCount" : count};
        ADAPI_Payment_GoCommonOrderShow([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGoCommonOrderShow:)], dic);
    }
    else if (sender == _bigpaymoneyBtn)
    {
        big = 2;
        
//        type = CRENUM_OrderTypeBuy_DEJB;
        
        //购买数量
        NSString *count = _bigNeedMoneyLable.text;
        //跳转去购买
        NSDictionary *dic = @{@"OrderType" : @"9", @"ItemCount" : count};
        ADAPI_Payment_GoCommonOrderShow([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGoCommonOrderShow:)], dic);
    }
}

- (IBAction)itemBtnclick:(id)sender
{
    BOOL flag = [sender isEqual:_smallMoneyBtn];
    _lineVew.constant = !flag ? -2 : -(_smallMoneyBtn.center.x - _bigmoneyBtn.center.x + 2);
    [UIView animateWithDuration:.3 animations:^{
        [self.view layoutIfNeeded];
        
    }];
    _bigmoneyBtn.selected = !flag;
    _bigmoneyBtn.titleLabel.font = (flag ? Font(14) : Font(16));
    _smallMoneyBtn.selected = flag;
    _smallMoneyBtn.titleLabel.font = (!flag ? Font(14) : Font(16));
    if (flag) {
        _smallMoneyView.frame = CGRectMake(0, 40, SCREENWIDTH, SCREENHEIGHT - 104);
        [self.view addSubview:_smallMoneyView];
    }
    else
    {
        _bigmoneyView.frame = CGRectMake(0, 40, SCREENWIDTH, SCREENHEIGHT - 104);
        [self.view addSubview:_bigmoneyView];
    }
}

#pragma mark - 购买
- (void)handleGoCommonOrderShow:(DelegatorArguments *)arguments
{
    DictionaryWrapper *dic = arguments.ret;
    
    if (dic.operationSucceed)
    {
        
        PUSH_VIEWCONTROLLER(ConfirmOrderViewController);
        model.type = 3;
        if (big == 1)
        {
            model.payDic = @{@"OrderSerialNo" : @"", @"OrderType" : @"4", @"ItemCount" : _needGoldTxt.text};
            model.orderInfoDic = dic.data;
            model.goodsInfo = @[@{@"name" : @"金币",@"num" : @"1"}];
        }
        else
        {
            model.payDic = @{@"OrderSerialNo" : @"", @"OrderType" : @"9", @"ItemCount" : _bigNeedMoneyLable.text};
            model.orderInfoDic = dic.data;
            model.goodsInfo = @[@{@"name" : @"金币",@"num" : @"1"}];
        }
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (_needGoldTxt == textField)
    {
        NSInteger num = [toBeString integerValue];
        
        if (num >= 100 && num <= 9999)
        {
            [self okbtnYes];
        }
        else if([toBeString length] == 0)
        {
            [self okbtnNo];
        }
        else if([toBeString length] > 4)
        {
            return NO;
            [self okbtnNo];
        }
        else
        {
            [self okbtnNo];
        }
        
        _payMoneyLable.text = [NSString stringWithFormat:@"¥%d.00", (int)num];
    }
    else if (_bigNeedMoneyLable == textField)
    {
        NSInteger num = [toBeString integerValue];
        
        if (num >= 10000 && num < 1000000000)
        {
            [self bigPaybtnYes];
        }
        else if([toBeString length] == 0)
        {
            [self bigPaybtnNo];
        }
        else
        {
            [self bigPaybtnNo];
        }
        
        _bigPayMoney.text = [NSString stringWithFormat:@"¥%d.00", (int)num];
        
        double zengsong = num *0.1;
        
        double gongji = zengsong * (12 - beginMonth + 1);
        
        _zengsongLable.text = [NSString stringWithFormat:@"每月赠送%.2f广告金币，从%d月到12月共计%.2f广告金币",zengsong,beginMonth,gongji];
    }
    return YES;
}

-(void) okbtnNo
{
    _payMoneyBtn.backgroundColor = AppColorLightGray204;
    
    _payMoneyBtn.userInteractionEnabled = NO;
}

-(void) okbtnYes
{
    _payMoneyBtn.backgroundColor = AppColorRed;
    
    _payMoneyBtn.userInteractionEnabled = YES;
}

-(void) bigPaybtnNo
{
    _bigpaymoneyBtn.backgroundColor = AppColorLightGray204;
    
    _bigpaymoneyBtn.userInteractionEnabled = NO;
}

-(void) bigPaybtnYes
{
    _bigpaymoneyBtn.backgroundColor = AppColorRed;
    
    _bigpaymoneyBtn.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_balanceMoneyLabel release];
    [_needGoldTxt release];
    [_payMoneyLable release];
    [_payMoneyBtn release];
    [_bigmoneyBtn release];
    [_smallMoneyBtn release];
    [_bigmoneyView release];
    [_smallMoneyView release];
    [_scrollerview release];
    [_bigbalanceMoneyLable release];
    [_bigNeedMoneyLable release];
    [_bigTwoView release];
    [_zengsongLable release];
    [_bigPayMoney release];
    [_bigpaymoneyBtn release];
    [_cuxiaotwoLable release];
    [_cuxiaooneLable release];
    [_redlines release];
    [_scrollerWidth release];
    [_scrollerHeight release];
    [_lineVew release];
    [_animation_line release];
    [_lineOne release];
    [_lineTwo release];
    [_lineThree release];
    [_bigTwoTop release];
    [_cuxiaotwoTop release];
    [_imageTop release];
    [_lineTop release];
    [_lineTwoTop release];
    [_lineThreeTop release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setBalanceMoneyLabel:nil];
    [self setNeedGoldTxt:nil];
    [self setPayMoneyLable:nil];
    [self setPayMoneyBtn:nil];
    [super viewDidUnload];
}

@end
