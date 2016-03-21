//
//  MainExchangeMangerViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MainExchangeMangerViewController.h"
#import "NetImageView.h"
#import "RCScrollView.h"
#import "WatingShippingViewController.h"
#import "WebhtmlViewController.h"
#import "VIPPrivilegeViewController.h"
#import "CRScrollController.h"

@interface MainExchangeMangerViewController ()<CRSCDelegate>
{
    CRScrollController *_scrollCon;
    DictionaryWrapper * result;
    
    NSString * code;
    
    NSArray * arrImage;
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *watingPayMoneyLable;
@property (retain, nonatomic) IBOutlet UILabel *watingFaHuoLable;
@property (retain, nonatomic) IBOutlet UIButton *watingPayMoneyBtn;
@property (retain, nonatomic) IBOutlet UILabel *jiaoyichenggongLable;
@property (retain, nonatomic) IBOutlet UILabel *watingUserPayMoneylable;
@property (retain, nonatomic) IBOutlet UIButton *watingFaHuoBtn;
@property (retain, nonatomic) IBOutlet UIButton *succeedBtn;
@property (retain, nonatomic) IBOutlet UIButton *watingUserPayMoneyBtn;
@property (retain, nonatomic) IBOutlet UIView *showView;


- (IBAction)touchUpInside:(id)sender;
@end

@implementation MainExchangeMangerViewController

-(void)viewWillAppear:(BOOL)animated
{
    _watingFaHuoLable.hidden = YES;
    
    _watingPayMoneyLable.hidden = YES;
    
    ADAPI_adv3_MallManagement_CountSilverMailExchange([self genDelegatorID:@selector(HandleNotification:)],_EnterpriseId);
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_MallManagement_CountSilverMailExchange])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            result = wrapper.data;
            
            [result retain];
            
            [self setResult:result];
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
            
            NSLog(@"---arrimage%@",arrImage);
            
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

-(void) setResult : (DictionaryWrapper *) dic
{
    if ([dic getInt:@"PendingPayCount"] > 0)
    {
        _watingPayMoneyLable.hidden = NO;
        
        if([dic getInt:@"PendingPayCount"] <= 99)
        {
            _watingPayMoneyLable.text = [NSString stringWithFormat:@"%d",[dic getInt:@"PendingPayCount"]];
        }
        else
        {
            _watingPayMoneyLable.text = [NSString stringWithFormat:@"..."];
        }
    }
    
    if ([dic getInt:@"PendingDeliverCount"] > 0)
    {
        _watingFaHuoLable.hidden = NO;
        
        if ([dic getInt:@"PendingDeliverCount"] <= 99)
        {
            _watingFaHuoLable.text = [NSString stringWithFormat:@"%d",[dic getInt:@"PendingDeliverCount"]];
        }
        else
        {
            _watingFaHuoLable.text = [NSString stringWithFormat:@"..."];
        }
    }
    
    NSString * todaysucceed = [NSString stringWithFormat:@"%d",[dic getInt:@"SuccessTodayCount"]];
    
    NSString * yesterdaysucceed = [NSString stringWithFormat:@"%d",[dic getInt:@"SuccessYesterdayCount"]];
    
    NSString * monthsucceed = [NSString stringWithFormat:@"%d",[dic getInt:@"SuccessMonthCount"]];
    
    _jiaoyichenggongLable.text = [NSString stringWithFormat:@"今日：%@    昨日：%@    最近1月：%@",todaysucceed,yesterdaysucceed,monthsucceed];
    
    NSString * ClosedTodayCount = [NSString stringWithFormat:@"%d",[dic getInt:@"ClosedTodayCount"]];
    
    NSString * ClosedYesterdayCount = [NSString stringWithFormat:@"%d",[dic getInt:@"ClosedYesterdayCount"]];
    
    NSString * ClosedMonthCount = [NSString stringWithFormat:@"%d",[dic getInt:@"ClosedMonthCount"]];
    
    _watingUserPayMoneylable.text = [NSString stringWithFormat:@"今日：%@    昨日：%@    最近1月：%@",ClosedTodayCount,ClosedYesterdayCount,ClosedMonthCount];

}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    InitNav(@"邮寄兑换管理");
    
    [_watingFaHuoLable setRoundCornerAll];
    
    _watingPayMoneyBtn.frame = CGRectMake(0, 0.5, 320, 48.5);
    
    _watingFaHuoBtn.frame = CGRectMake(0, 49.5, 320, 50.5);
    
    _succeedBtn.frame = CGRectMake(0, 0.5, 320, 58.5);
    
    _watingUserPayMoneyBtn.frame = CGRectMake(0, 59.5, 320, 60.5);
    
    [_watingPayMoneyLable setRoundCornerAll];
    
    _scrollCon = [CRScrollController controllerFromView:_scrollView];
    _scrollCon.isBackWhite = YES;
    
//    ADAPI_adv3_Operator_GetBannerListByCategoryCode([self genDelegatorID:@selector(HandleNotification:)], @"1ff3a70cd83971bf947079f0e08d3844");
    
    ADAPI_adv3_1_Operator_GetBanne([self genDelegatorID:@selector(HandleNotification:)], @"1ff3a70cd83971bf947079f0e08d3844");
}

- (IBAction)touchUpInside:(id)sender
{
    PUSH_VIEWCONTROLLER(WatingShippingViewController);
    
    //判断是邮寄兑换或者易货商城交易管理
    model.orderType = @"1";
    
    if (sender == _watingFaHuoBtn)
    {
        model.dealState = @"2";
    }
    else if (sender == _watingPayMoneyBtn)
    {
        model.dealState = @"1";
    }
    else if (sender == _succeedBtn)
    {
        model.dealState = @"3";
    }
    else if (sender == _watingUserPayMoneyBtn)
    {
        model.dealState = @"4";
    }
    
    model.EnterpriseId = _EnterpriseId;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    
    [_scrollCon remove];
    [result release];
    
    [arrImage release];
    
    result = nil ;
    
    [code release];
    
    [_watingPayMoneyLable release];
    [_watingFaHuoLable release];
    [_watingPayMoneyBtn release];
    [_jiaoyichenggongLable release];
    [_watingUserPayMoneylable release];
    [_watingFaHuoBtn release];
    [_succeedBtn release];
    [_watingUserPayMoneyBtn release];
    [_scrollView release];
    [_showView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setWatingPayMoneyLable:nil];
    [self setWatingFaHuoLable:nil];
    [self setWatingPayMoneyBtn:nil];
    [self setJiaoyichenggongLable:nil];
    [self setWatingUserPayMoneylable:nil];
    [self setWatingFaHuoBtn:nil];
    [self setSucceedBtn:nil];
    [self setWatingUserPayMoneyBtn:nil];
    [super viewDidUnload];
}

@end
