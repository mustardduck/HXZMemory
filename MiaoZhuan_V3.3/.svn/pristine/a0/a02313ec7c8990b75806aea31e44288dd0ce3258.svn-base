//
//  AdsBiddingAndManagement.m
//  miaozhuan
//
//  Created by Santiago on 14-11-5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AdsBiddingAndManagement.h"
#import "BiddingListViewController.h"
#import "MyBiddingViewController.h"
#import "VIPPrivilegeViewController.h"
#import "WebhtmlViewController.h"
#import "LineView.h"
@interface AdsBiddingAndManagement (){

BOOL _isVip;
}

@property (retain, nonatomic) IBOutlet UIView *viewForVipMercahant;
@property (retain, nonatomic) IBOutlet UIView *viewForNormalMerchant;
@property (retain, nonatomic) IBOutlet UIView *UILineView;
@property (retain, nonatomic) IBOutlet LineView *UILineView2;
@property (retain, nonatomic) IBOutlet LineView *UILineView3;

@end

@implementation AdsBiddingAndManagement


MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"竞价广告发布与管理"];
    [self setupMoveFowardButtonWithTitle:@"说明"];
    [self.UILineView setFrame:CGRectMake(0, 84.5, 320, 0.5)];
    [self.UILineView2 setSize:CGSizeMake(320, 0.5)];
    [self.UILineView3 setSize:CGSizeMake(320, 0.5)];
}

- (void)viewWillAppear:(BOOL)animated {

    //调用商家是否是vip请求
    ADAPI_GetMerchantInformation([self genDelegatorID:@selector(handleNotification:)],[[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper getInt:@"EnterpriseId"]);
}

- (void)handleNotification:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    _isVip = [wrapper.data getBool:@"IsVip"];
    [self chooseViewToShow];
}

- (IBAction)toBeVip:(id)sender {
    
    //购买VIP页面
    PUSH_VIEWCONTROLLER(VIPPrivilegeViewController);
}

- (void)chooseViewToShow {
    
    if (_isVip) {
        
        _viewForNormalMerchant.hidden = YES;
        _viewForVipMercahant.hidden = NO;
    }else{
        
        _viewForNormalMerchant.hidden = NO;
        _viewForVipMercahant.hidden = YES;
    }
}

- (IBAction) onMoveFoward:(UIButton*) sender
{
    PUSH_VIEWCONTROLLER(WebhtmlViewController)
    model.navTitle = @"竞价广告说明";
    model.ContentCode = @"dbc4e7ff6dbf265b3a4d3c9cf12d8bf2";
}
- (IBAction)toBiddingList:(id)sender {
    
    PUSH_VIEWCONTROLLER(BiddingListViewController);
}
- (IBAction)toMyBidding:(id)sender {
    
    PUSH_VIEWCONTROLLER(MyBiddingViewController);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_viewForVipMercahant release];
    [_viewForNormalMerchant release];
    [_UILineView release];
    [_UILineView2 release];
    [_UILineView3 release];
    [super dealloc];
}
@end
