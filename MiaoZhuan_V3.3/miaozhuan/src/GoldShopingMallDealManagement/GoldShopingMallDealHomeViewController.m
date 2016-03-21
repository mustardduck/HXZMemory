//
//  GoldShopingMallDealHomeViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-12-8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "GoldShopingMallDealHomeViewController.h"
#import "SalesReturnAndAfterSaleViewController.h"
#import "NetImageView.h"
#import "RCScrollView.h"
#import "WatingShippingViewController.h"
#import "WebhtmlViewController.h"
#import "CRScrollController.h"
#import "VIPPrivilegeViewController.h"
@interface GoldShopingMallDealHomeViewController ()<UIScrollViewDelegate,CRSCDelegate>
{
    DictionaryWrapper * result;
    
    NSString * code;
    
    NSArray * arrImage;
    
    CRScrollController *_scrollCon;
}

@property (retain, nonatomic) IBOutlet UIScrollView *mainScroller;
@property (retain, nonatomic) IBOutlet UIButton *watingUserPayMoneyBtn;
@property (retain, nonatomic) IBOutlet UIButton *watingShippingBtn;
@property (retain, nonatomic) IBOutlet UIButton *alreadyShippingBtn;
@property (retain, nonatomic) IBOutlet UIButton *aftersalesBtn;
@property (retain, nonatomic) IBOutlet UIButton *succeedBtn;
@property (retain, nonatomic) IBOutlet UIButton *closeBtn;

@property (retain, nonatomic) IBOutlet UILabel *watingPayMoneyLable;
@property (retain, nonatomic) IBOutlet UILabel *watingShippingLable;
@property (retain, nonatomic) IBOutlet UILabel *alreadShippingLable;
@property (retain, nonatomic) IBOutlet UILabel *afterSalesLable;
@property (retain, nonatomic) IBOutlet UILabel *succeedLable;
@property (retain, nonatomic) IBOutlet UILabel *closeLable;
@property (retain, nonatomic) IBOutlet UIWebView *webShowView;
@property (retain, nonatomic) IBOutlet UIView *showView;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollerView;

- (IBAction)touchUpInsideBtn:(id)sender;

@end

@implementation GoldShopingMallDealHomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    ADAPI_adv3_GoldOrder_GetOrderStatusNumbers([self genDelegatorID:@selector(HandleNotification:)], _EnterpriseId);
}


- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_GoldOrder_GetOrderStatusNumbers])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            result = wrapper.data;
            [result retain];
            
            [self setNum:result];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_1_Operator_GetBanner])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            _showView.hidden = YES;
            
            arrImage = wrapper.data;
            [arrImage retain];
            _scrollCon.picArray = arrImage;

            //或者 使用代理
            _scrollCon.delegate = self;

        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

- (void) scrollView:(CRScrollController *)view didSelectPage:(NSInteger)index
{
    PUSH_VIEWCONTROLLER(VIPPrivilegeViewController);
//    PUSH_VIEWCONTROLLER(WebhtmlViewController);
//    model.navTitle = @"";
//    model.ContentCode = [[[arrImage objectAtIndex:index] wrapper] getString:@"Code"];
}

#pragma mark 数据展示

-(void) setNum:(DictionaryWrapper *) dic
{
    int WaitingPaymentCount = [dic getInt:@"WaitingPaymentCount"];
    
    if (WaitingPaymentCount > 99)
    {
        _watingPayMoneyLable.hidden = NO;
        _watingPayMoneyLable.text = @"...";
    }
    else if (WaitingPaymentCount ==0)
    {
        _watingPayMoneyLable.hidden = YES;
    }
    else
    {
        _watingPayMoneyLable.hidden = NO;
        _watingPayMoneyLable.text = [NSString stringWithFormat:@"%d",WaitingPaymentCount];
    }
    
    int WaitingDeliverCount = [dic getInt:@"WaitingDeliverCount"];
    
    if (WaitingDeliverCount > 99)
    {
        _watingShippingLable.hidden = NO;
        _watingShippingLable.text = @"...";
    }
    else if (WaitingDeliverCount ==0)
    {
        _watingShippingLable.hidden = YES;
    }
    else
    {
        _watingShippingLable.hidden = NO;
        _watingShippingLable.text = [NSString stringWithFormat:@"%d",WaitingDeliverCount];
    }
    
    int DelivedCount = [dic getInt:@"DelivedCount"];
    if (DelivedCount > 99)
    {
        _alreadShippingLable.hidden = NO;
        _alreadShippingLable.text = @"...";
    }
    else if (DelivedCount ==0)
    {
        _alreadShippingLable.hidden = YES;
    }
    else
    {
        _alreadShippingLable.hidden = NO;
        _alreadShippingLable.text = [NSString stringWithFormat:@"%d",DelivedCount];
    }
    
    int AfterSalesCount = [dic getInt:@"AfterSalesCount"];
    if (AfterSalesCount > 99)
    {
        _afterSalesLable.hidden = NO;
        _afterSalesLable.text = @"...";
    }
    else if (AfterSalesCount ==0)
    {
        _afterSalesLable.hidden = YES;
    }
    else
    {
        _afterSalesLable.hidden = NO;
        _afterSalesLable.text = [NSString stringWithFormat:@"%d",AfterSalesCount];
    }
    
    int TodaySucceedCount = [dic getInt:@"TodaySucceedCount"];
    int YestodaySucceedCount = [dic getInt:@"YestodaySucceedCount"];
    int LastMonthSucceedCount = [dic getInt:@"LastMonthSucceedCount"];
    
    _succeedLable.text = [NSString stringWithFormat:@"今日：%d    昨日：%d    最近1月：%d",TodaySucceedCount,YestodaySucceedCount,LastMonthSucceedCount];
    
    int TodayClosedCount = [dic getInt:@"TodayClosedCount"];
    int YestodayClosedCount = [dic getInt:@"YestodayClosedCount"];
    int LastMonthClosedCount = [dic getInt:@"LastMonthClosedCount"];
    
    _closeLable.text = [NSString stringWithFormat:@"今日：%d    昨日：%d    最近1月：%d",TodayClosedCount,YestodayClosedCount,LastMonthClosedCount];
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    InitNav(@"易货商城交易管理");

    [self setRound];
    
     _scrollCon = [CRScrollController controllerFromView:_scrollerView];
    _scrollCon.isBackWhite = YES;
    
    ADAPI_adv3_1_Operator_GetBanne([self genDelegatorID:@selector(HandleNotification:)], @"253380f338d1bf60b22d61a25ca4bce8");
    
    [_mainScroller setContentSize:CGSizeMake(320, 475)];
}

-(void) setRound
{
    [_watingPayMoneyLable setRoundCornerAll];
    
    [_watingShippingLable setRoundCornerAll];
    
    [_alreadShippingLable setRoundCornerAll];
    
    [_afterSalesLable setRoundCornerAll];
}

- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _watingUserPayMoneyBtn)
    {
        //等待用户付款
        PUSH_VIEWCONTROLLER(WatingShippingViewController);
        model.EnterpriseId = _EnterpriseId;
        model.orderType = @"2";
        model.dealState = @"1";
    }
    else if (sender == _watingShippingBtn)
    {
        //等待发货
        PUSH_VIEWCONTROLLER(WatingShippingViewController);
        model.EnterpriseId = _EnterpriseId;
        model.orderType = @"2";
        model.dealState = @"2";
    }
    else if (sender == _alreadyShippingBtn)
    {
        //已发货
        PUSH_VIEWCONTROLLER(WatingShippingViewController);
        model.EnterpriseId = _EnterpriseId;
        model.orderType = @"2";
        model.dealState = @"3";
    }
    else if (sender == _aftersalesBtn)
    {
        //退换/售后
        PUSH_VIEWCONTROLLER(SalesReturnAndAfterSaleViewController);
    }
    else if (sender == _succeedBtn)
    {
        //交易成功
        PUSH_VIEWCONTROLLER(WatingShippingViewController);
        model.EnterpriseId = _EnterpriseId;
        model.orderType = @"2";
        model.dealState = @"5";
    }
    else if (sender == _closeBtn)
    {
        //交易关闭
        PUSH_VIEWCONTROLLER(WatingShippingViewController);
        model.EnterpriseId = _EnterpriseId;
        model.orderType = @"2";
        model.dealState = @"6";
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [result release];
    result = nil;
    [code release];
    
    [arrImage release];
    
    [_scrollCon remove];
    
    [_watingUserPayMoneyBtn release];
    [_watingShippingBtn release];
    [_alreadyShippingBtn release];
    [_aftersalesBtn release];
    [_succeedBtn release];
    [_closeBtn release];
    [_watingPayMoneyLable release];
    [_watingShippingLable release];
    [_alreadShippingLable release];
    [_afterSalesLable release];
    [_succeedLable release];
    [_closeLable release];
    [_mainScroller release];
    [_webShowView release];
    [_scrollerView release];
    [_showView release];
    [super dealloc];
}

@end
