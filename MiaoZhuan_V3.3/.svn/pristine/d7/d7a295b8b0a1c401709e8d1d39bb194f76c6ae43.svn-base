//
//  ThankfulFruitViewController.m
//  miaozhuan
//
//  Created by apple on 14/10/22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ThankfulFruitViewController.h"
#import "UIView+expanded.h"
#import "UICommon.h"
#import "Redbutton.h"
#import "otherButton.h"
#import "RRAttributedString.h"
#import "ThankFulFansStatisticalViewController.h"
#import "Share_Method.h"
#import "PhoneAuthenticationViewController.h"
#import "CROrderManagerViewController.h"
#import "ConfirmOrderViewController.h"

@interface ThankfulFruitViewController ()
{
    int nowNum;
    int suggestionsBuyNum;
    int buyNum;
    
    DictionaryWrapper *resultDic;
}

@property (retain, nonatomic) IBOutlet UIButton *reduceBtn;
@property (retain, nonatomic) IBOutlet UIButton *increaseBtn;
@property (retain, nonatomic) IBOutlet UILabel *payMoneyLable;
@property (retain, nonatomic) IBOutlet Redbutton *payNowBtn;
@property (retain, nonatomic) IBOutlet UILabel *nowActivationLayerLable;
@property (retain, nonatomic) IBOutlet UILabel *recommendLable;
@property (retain, nonatomic) IBOutlet UILabel *numLable;
@property (retain, nonatomic) IBOutlet UIView *viewNoPay;
@property (retain, nonatomic) IBOutlet UIView *coverView;


@property (retain, nonatomic) IBOutlet UILabel *noPayNowNumlable;
@property (retain, nonatomic) IBOutlet UIButton *fansStatisticsBtn;
@property (retain, nonatomic) IBOutlet UIButton *shareBtn;
@property (retain, nonatomic) IBOutlet UIView *realNameAuthenticationView;
@property (retain, nonatomic) IBOutlet Redbutton *gotoAuthenticationBtn;

- (IBAction)touchUpInsideBtn:(id)sender;

@end

@implementation ThankfulFruitViewController

-(void)viewWillAppear:(BOOL)animated
{
    DictionaryWrapper* dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    if ([dic getBool:@"IsPhoneVerified"])
    {
        ADAPI_adv3_GetThankfulLevel([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(HandleNotification:)]);
        
        [_realNameAuthenticationView removeFromSuperview];
    }
    else
    {
        [self.view addSubview:_realNameAuthenticationView];
    }
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"感恩果");
    
    [self setRound];
}

-(void) setRound
{
    
    [_gotoAuthenticationBtn roundCorner];
    
    [_numLable roundCorner];
    
    _numLable.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    [_payNowBtn roundCorner];
    
    _fansStatisticsBtn.layer.masksToBounds = YES;
    _fansStatisticsBtn.layer.cornerRadius = 5.0;
    _fansStatisticsBtn.layer.borderWidth = 1.0;
    _fansStatisticsBtn.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];
    
    _shareBtn.layer.masksToBounds = YES;
    _shareBtn.layer.cornerRadius = 5.0;
    _shareBtn.layer.borderWidth = 1.0;
    _shareBtn.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];
}


- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_GetThankfulLevel])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        NSLog(@"--%d",[wrapper getInt:@"Code"]);
        
        if (wrapper.operationSucceed)
        {
            resultDic =  wrapper.data;
            
            [resultDic retain];
            
            int ThankfulLevel = [resultDic getInt:@"ThankfulLevel"];
            
            [self setNumload:ThankfulLevel];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}

- (void)onMoveFoward:(UIButton *)sender
{
    PUSH_VIEWCONTROLLER(CROrderManagerViewController);
    model.type = CRENUM_OrderTypeThankGiving;
}


-(void) setNumload : (int) Num
{
    nowNum = Num;
    
    if (nowNum == 6)
    {
        _coverView.hidden = YES;
        
        [self.view addSubview:_viewNoPay];
        
        [self setupMoveFowardButtonWithImage:@"goumai@2x.png" In:@"goumai@2x.png"];
    }
    else
    {
        [self setupMoveFowardButtonWithImage:@"goumai@2x.png" In:@"goumai@2x.png"];
        
        _coverView.hidden = YES;
    }
    
    suggestionsBuyNum = 6 - nowNum;
    
    buyNum = suggestionsBuyNum;
    
    _nowActivationLayerLable.text = [NSString stringWithFormat:@"当前您激活的感恩银元层数:%d层",nowNum];
    
    _recommendLable.text = [NSString stringWithFormat:@"建议购买%d颗感恩果，即可激活其他%d层的奖励",suggestionsBuyNum,suggestionsBuyNum];
    
    NSAttributedString * nowattributedString = [RRAttributedString setText:_nowActivationLayerLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(13, _nowActivationLayerLable.text.length - 13)];
    
    _nowActivationLayerLable.attributedText = nowattributedString;
    
    NSAttributedString * recommendattributedString = [RRAttributedString setText:_recommendLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(4, 2)];
    
    _recommendLable.attributedText = recommendattributedString;
    
    NSAttributedString * noPayommendattributedString = [RRAttributedString setText:_noPayNowNumlable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(16, 2)];
    
    _noPayNowNumlable.attributedText = noPayommendattributedString;
    
    _numLable.text = [NSString stringWithFormat:@"%d颗",buyNum];
    
    _payMoneyLable.text = [NSString stringWithFormat:@"¥%d.00",buyNum * 30];
    
    if (buyNum == 1 == suggestionsBuyNum )
    {
        _reduceBtn.enabled = NO;
        _increaseBtn.enabled = NO;
    }
    else if(buyNum == suggestionsBuyNum)
    {
        _increaseBtn.enabled = NO;
        _reduceBtn.enabled = YES;
    }
    else if(buyNum == 1)
    {
        _reduceBtn.enabled = NO;
    }
}


- (IBAction)touchUpInsideBtn:(id)sender
{
    //减
    if (sender == _reduceBtn)
    {
        if (--buyNum != 1)
        {
            _reduceBtn.enabled = YES;
            _increaseBtn.enabled = YES;
        }
        else
        {
            _reduceBtn.enabled = NO;
            _increaseBtn.enabled = YES;
        }
    }
    else if(sender == _increaseBtn)
    {
        if (++buyNum != suggestionsBuyNum)
        {
            _reduceBtn.enabled = YES;
            _increaseBtn.enabled = YES;
        }
        else
        {
            _increaseBtn.enabled = NO;
            _reduceBtn.enabled = YES;
        }
    }
    else if (sender == _fansStatisticsBtn)
    {
        PUSH_VIEWCONTROLLER(ThankFulFansStatisticalViewController);
    }
    else if (sender == _shareBtn)
    {
        [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"1336828a622ace94b24f482cf75a3776"}];
    }
    else if (sender == _gotoAuthenticationBtn)
    {
        PUSH_VIEWCONTROLLER(PhoneAuthenticationViewController);
    }
    else if (sender == _payNowBtn)
    {
        //购买数量
        NSString *count = [NSString stringWithFormat:@"%d",buyNum];
        //跳转去购买
        NSDictionary *dic = @{@"OrderType" : @"2", @"ItemCount" : count};
        ADAPI_Payment_GoCommonOrderShow([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGoCommonOrderShow:)], dic);
    }
    
    _numLable.text = [NSString stringWithFormat:@"%d颗",buyNum];
    
    _payMoneyLable.text = [NSString stringWithFormat:@"¥%d.00",buyNum * 30];
}

#pragma mark - 购买
- (void)handleGoCommonOrderShow:(DelegatorArguments *)arguments
{
    DictionaryWrapper *dic = arguments.ret;
    
    if (dic.operationSucceed)
    {
        
        [APP_MTA MTA_touch_From:MTAEVENT_user_vip_fruit_to_pay];
        
        PUSH_VIEWCONTROLLER(ConfirmOrderViewController);
        model.type = 3;
        model.payDic = @{@"OrderSerialNo" : @"", @"OrderType" : @"2", @"ItemCount" : [NSString stringWithFormat:@"%d",buyNum]};
        model.orderInfoDic = dic.data;
        model.goodsInfo = @[@{@"name" : @"感恩果",@"num" : [NSString stringWithFormat:@"%d",buyNum]}];
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [resultDic release];
    [_reduceBtn release];
    [_increaseBtn release];
    [_payMoneyLable release];
    [_payNowBtn release];
    [_viewNoPay release];
    [_nowActivationLayerLable release];
    [_recommendLable release];
    [_numLable release];
    [_coverView release];
    [_noPayNowNumlable release];
    [_fansStatisticsBtn release];
    [_shareBtn release];
    [_realNameAuthenticationView release];
    [_gotoAuthenticationBtn release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setReduceBtn:nil];
    [self setIncreaseBtn:nil];
    [self setPayMoneyLable:nil];
    [self setPayNowBtn:nil];
    [self setViewNoPay:nil];
    [self setNowActivationLayerLable:nil];
    [self setRecommendLable:nil];
    [self setNumLable:nil];
    [self setCoverView:nil];
    [self setNoPayNowNumlable:nil];
    [self setFansStatisticsBtn:nil];
    [self setShareBtn:nil];
    [self setRealNameAuthenticationView:nil];
    [self setGotoAuthenticationBtn:nil];
    [super viewDidUnload];
}

@end
