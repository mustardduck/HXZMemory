//
//  ControlViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-10-22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ControlViewController.h"
#import "MainViewController.h"
#import "PersonalCenterViewController.h"
#import "HandleOutAdsViewController.h"
#import "UICommon.h"
#import "Share_Method.h"
#import "NotiftCenterViewController.h"
#import "ConfirmOrderViewController.h"
#import "RRLineView.h"
#import "PlaySound.h"
#import "AppDelegate.h"

@interface ControlViewController ()
{
//    int _pageIndex;
}
@property (nonatomic, retain)MainViewController *mainVC;
@property (nonatomic, retain)PersonalCenterViewController *personalCenterVC;
@property (nonatomic, retain)HandleOutAdsViewController *handleAdsVC;
@property (retain, nonatomic) IBOutlet UIButton *btnwatch;

@end

@implementation ControlViewController

//MTA_viewDidAppear()
//MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setNavigateTitle:@"秒赚"];
    
    [self _initViewController];
    
    //消息中心跳转到发广告
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMessage:) name:@"Message" object:nil];
    
//    //VIP
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshVIP:) name:@"PayStatus" object:nil];
}

//- (void)refreshVIP:(id)object
//{
//    ADAPI_adv3_GetVipLevel([self genDelegatorID:@selector(refreshVIP_local:)]);
//    
//}

//- (void)refreshVIP_local:(DelegatorArguments *)arg
//{
//    if (arg.ret.operationSucceed)
//    {
//        int i = [arg.ret.data getInt:@"VipLevel"];
//        if (i > 0)
//        {
//            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".VipLevel" value:@(i)];
//        }
//    }
//}

- (void)handleMessage:(NSNotification *)noti{
    [self tabbarItemClicked:_sendOutBtn];
}

- (void)notityRefresh
{
    ADAPI_UnReadMessage([self genDelegatorID:@selector(requestMessageCount:)]);
}

- (void)requestMessageCount:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    DictionaryWrapper *item = [wrapper getDictionaryWrapper:@"Data"];
    
    if (wrapper.operationSucceed) {

        [self setupMoveForwardButtonWithImage:@"home_message.png" In:@"home_message_hover.png" andUnreadCount:[item getInt:@"TotalCount"]];
    }else {
    
        [self setupMoveForwardButtonWithImage:@"home_message.png" In:@"home_message_hover.png" andUnreadCount:0];
    }
    
    DictionaryWrapper* dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    if ([APP_DELEGATE.runtimeConfig getInt:@"WholeMessageCount"] && [APP_DELEGATE.runtimeConfig getInt:@"WholeMessageCount"] < [item getInt:@"TotalCount"]) {
        
        [PlaySound playSound:@"newMessageVoice" type:@"mp3"];
    }
    [APP_DELEGATE.runtimeConfig set:@"WholeMessageCount" int:[item getInt:@"TotalCount"]];
    
    NSString * EnterpriseStatus = [NSString stringWithFormat:@"%d",[dic getInt:@"EnterpriseStatus"]];
    
    if (_pageIndex == 2 && ![EnterpriseStatus isEqualToString:@"4"])
    {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    [self performSelector:@selector(notityRefresh) withObject:nil afterDelay:20000];
}

- (void)viewDidLayoutSubviews
{
    DictionaryWrapper* dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    NSString * EnterpriseStatus = [NSString stringWithFormat:@"%d",[dic getInt:@"EnterpriseStatus"]];
    
    if (_pageIndex == 2 && ![EnterpriseStatus isEqualToString:@"4"])
    {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
        
        //from superView
        [_handleAdsVC viewRefresh];
    }
    else
    {
        //分享按钮
        UIButton* btnShare = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake(0, 5, 24, 24));
        [btnShare setImage:[UIImage imageNamed:@"home_share.png"] forState:UIControlStateNormal];
        [btnShare setImage:[UIImage imageNamed:@"home_share_hover.png"] forState:UIControlStateHighlighted];
        [btnShare addTarget:self action:@selector(shareClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = WEAK_OBJECT(UIBarButtonItem, initWithCustomView:btnShare);
        [self setupMoveForwardButtonWithImage:@"home_message.png" In:@"home_message_hover.png" andUnreadCount:0];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_pageIndex == 2)
    {
        [_handleAdsVC viewRefresh];
    }
    {
        if (_pageIndex == 3)[_personalCenterVC viewRefresh];
    }
    [self performSelector:@selector(notityRefresh) withObject:self afterDelay:3.f];
}

//初始化视图控制器
- (void)_initViewController{
    _mainVC = STRONG_OBJECT(MainViewController, init);
    _handleAdsVC = STRONG_OBJECT(HandleOutAdsViewController, init);
    _personalCenterVC = STRONG_OBJECT(PersonalCenterViewController, init);
    [self performSelector:@selector(haha) withObject:nil afterDelay:.01];
   
}

- (void)haha{
    [self addSubviewWithView:_mainVC.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//切换tabbar按钮
- (void)normalStatusButton
{
    UIButton *btnLook = (UIButton *)[self.view viewWithTag:1];
    UIButton *btnEdit = (UIButton *)[self.view viewWithTag:2];
    UIButton *btnOwn = (UIButton *)[self.view viewWithTag:3];
    btnLook.selected = NO;
    btnEdit.selected = NO;
    btnOwn.selected = NO;
    
    NSLog(@"%d",_pageIndex);
    if (_pageIndex == 2)
    {
        [_handleAdsVC viewRefresh];
    }
    if (_pageIndex == 3)
    {
        [_personalCenterVC viewRefresh];
    }
    
    [self notityRefresh];
}

- (IBAction)tabbarItemClicked:(UIButton *)sender
{
    _pageIndex = (int)sender.tag;
    [self normalStatusButton];
    sender.selected = YES;
    self.navigationItem.title = (sender.tag == 1) ? @"秒赚" : ((sender.tag == 2) ? @"发广告" : @"我的");
    UIView *view = (sender.tag == 1) ? _mainVC.view : ((sender.tag == 2) ? _handleAdsVC.view : _personalCenterVC.view);
    
    [self addSubviewWithView:view];
    
    _tabBtn = (UIButton *)sender;
    
//    [self viewDidLayoutSubviews];
//    [_handleAdsVC viewRefresh];
}
- (void)addSubviewWithView:(UIView *)view
{
    [self removeSubviews];
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 - 64);
    [self.view addSubview:view];
    
    RRLineView *line = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, _btnwatch.top, SCREENWIDTH, 0.5));
    [self.view addSubview:line];
}
- (void)removeSubviews
{
    for (UIView *view in self.view.subviews) {
        if (![view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    
}

#pragma mark - 事件
//分享
- (void)shareClicked:(id)sender
{
    [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"24b85ba13b2d0e6245c257ffe27670a2"}];
}
//消息中心
- (IBAction)onMoveFoward:(UIButton *)sender
{
    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(NotiftCenterViewController, init) animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_mainVC release];
    [_handleAdsVC release];
    [_personalCenterVC release];
    [_sendOutBtn release];
    [_btnwatch release];
    [super dealloc];
}

@end
