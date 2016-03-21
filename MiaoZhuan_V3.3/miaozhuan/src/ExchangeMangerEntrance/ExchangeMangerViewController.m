//
//  ExchangeMangerViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ExchangeMangerViewController.h"
#import "SceneExangeMangerViewController.h"
#import "MainExchangeMangerViewController.h"
#import "GoldShopingMallDealHomeViewController.h"
#import "Management_Index.h"
#import "YiHuoEDuMangerViewController.h"

@interface ExchangeMangerViewController ()<UIScrollViewDelegate>

@property (retain, nonatomic) IBOutlet UIView *jinbiView;
@property (retain, nonatomic) IBOutlet UIView *yinyuanView;
@property (retain, nonatomic) IBOutlet UIButton *xianchangBtn;
@property (retain, nonatomic) IBOutlet UIButton *youjiBtn;
@property (retain, nonatomic) IBOutlet UIImageView *bgImage;
@property (retain, nonatomic) IBOutlet UIView *yuanbgView;
@property (retain, nonatomic) IBOutlet UIView *jiaoyiYuanBgView;
@property (retain, nonatomic) IBOutlet UIButton *mallMangerBtn;
@property (retain, nonatomic) IBOutlet UIButton *jiaoyiMangerBtn;
@property (retain, nonatomic) IBOutlet UIButton *YiHuoEDuBtn;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineOne;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineTwo;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineThree;

- (IBAction)touchUpInside:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollerview;
@end

@implementation ExchangeMangerViewController

-(void)viewWillAppear:(BOOL)animated
{
    if ([_type isEqualToString:@"1"])
    {
        ADAPI_adv3_MallManagement_GetUnreadSummary([self genDelegatorID:@selector(HandleNotification:)],_EnterpriseId);
    }
    else
    {
        DictionaryWrapper * result =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
        
        NSString * endid = [NSString stringWithFormat:@"%d",[result getInt:@"EnterpriseId"]];
        
        ADAPI_adv3_MallManagement_GetUnreadSummary([self genDelegatorID:@selector(HandleNotification:)],endid);
    }
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_MallManagement_GetUnreadSummary])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            DictionaryWrapper * dic = wrapper.data;
            
            if ([dic getBool:@"IsSilverMailNew"])
            {
                _yuanbgView.hidden = NO;
            }
            if ([dic getBool:@"IsGoldOrderNew"])
            {
                _jiaoyiYuanBgView.hidden = NO;
            }
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
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
    
    InitNav(@"商城管理");
    
    _yuanbgView.hidden = YES;
    
    _jiaoyiYuanBgView.hidden = YES;
    
    _xianchangBtn.frame = CGRectMake(0.5, 74, 289, 51.5);
    
    _youjiBtn.frame = CGRectMake(0, 125.5, 290, 53);
    
    _jiaoyiMangerBtn.frame = CGRectMake(0, 125.5, 290, 53);
    
    _mallMangerBtn.frame = CGRectMake(0.5, 74, 289, 51.5);
    
    [_yuanbgView setRoundCornerAll];
    
    [_jiaoyiYuanBgView setRoundCornerAll];
    
    _lineOne.constant = 0.5;
    
    _lineTwo.constant = 0.5;
    
    _lineThree.constant = 0.5;
    
    //兑换管理员进入
    if ([_type isEqualToString:@"1"])
    {
        _jinbiView.hidden = YES;
    }
}

- (IBAction)touchUpInside:(id)sender
{
    if (sender == _xianchangBtn)
    {
        //现场兑换
        PUSH_VIEWCONTROLLER(SceneExangeMangerViewController);
        
        //兑换管理员专用入口
        if ([_type isEqualToString:@"1"])
        {
            model.ExchangeAddressId = _ExchangeAddressId;
            model.EnterpriseId = _EnterpriseId;
        }
        else//易货商城
        {
            model.ExchangeAddressId = @"0";
            
            DictionaryWrapper * result =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;

            model.EnterpriseId = [NSString stringWithFormat:@"%d",[result getInt:@"EnterpriseId"]];
        }
    }
    else if (sender == _youjiBtn)
    {
        //邮寄兑换
        PUSH_VIEWCONTROLLER(MainExchangeMangerViewController);
        
        if ([_type isEqualToString:@"1"])
        {
            model.EnterpriseId = _EnterpriseId;
            
            model.type = @"1";
        }
        else
        {
            DictionaryWrapper * result =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
            
            model.EnterpriseId = [NSString stringWithFormat:@"%d",[result getInt:@"EnterpriseId"]];
            
            model.type =  @"2";
        }
    }
    else if (sender == _mallMangerBtn)
    {
        //商城管理
        PUSH_VIEWCONTROLLER(Management_Index);
        model.statusTag = 4;
    }
    else if (sender == _jiaoyiMangerBtn)
    {
        DictionaryWrapper * result =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;

        //交易管理
        PUSH_VIEWCONTROLLER(GoldShopingMallDealHomeViewController);
        model.EnterpriseId = [NSString stringWithFormat:@"%d",[result getInt:@"EnterpriseId"]];
    }
    else if (sender ==  _YiHuoEDuBtn)
    {
        PUSH_VIEWCONTROLLER(YiHuoEDuMangerViewController);
    }
}

- (void)push1:(UIViewController *)v
{
    [self.navigationController pushViewController:v animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    [_jinbiView release];
    [_xianchangBtn release];
    [_youjiBtn release];
    [_bgImage release];
    [_yinyuanView release];
    [_yuanbgView release];
    [_jiaoyiYuanBgView release];
    [_mallMangerBtn release];
    [_jiaoyiMangerBtn release];
    [_YiHuoEDuBtn release];
    [_lineOne release];
    [_lineTwo release];
    [_lineThree release];
    [_scrollerview release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setJinbiView:nil];
    [self setXianchangBtn:nil];
    [self setYoujiBtn:nil];
    [self setBgImage:nil];
    [self setYinyuanView:nil];
    [self setYuanbgView:nil];
    [self setJiaoyiYuanBgView:nil];
    [super viewDidUnload];
}

@end
