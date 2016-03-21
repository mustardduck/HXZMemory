
//
//  AppDelegate.m
//  DotC
//
//  Created by Yang G on 14-7-2.
//  Copyright (c) 2014年 BIN. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ControlViewController.h"
#import "NetImageView.h"
#import "AdverModuleAPI.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "AppDelegate+Setup.h"
#import "ApplyToBeMerchantStep2.h"
#import <AlipaySDK/AlipaySDK.h>
#import "BannerDetailViewController.h"

#import "CRFileUtil.h"
#import "MallHistory.h"

#import "PlaySound.h"

//推送
#import "BPush.h"
#import "UserInfo.h"
#import "CRMTAManager.h"

#import "VoiceControl.h"
#import "CRPushManager.h"
#import "CRDateCounter.h"
#import "API_PostBoard.h"

/**
 *  微信开放平台申请得到的 appid, 需要同时添加在 URL schema
 */
NSString * const WXAppId = @"wxc35131ff6cd1ea70";

@interface AppDelegate ()<WXApiDelegate>
{
//    NotifyHandleType _notifyType;
}
@end

@implementation AppDelegate

@synthesize userConfig = _userConfig;

RegisteCRPushConfigForApplication()

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    self.appVersion = @"RELEASE";//@"INDOOR_RELEASE";//@"DEBUG";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([self.appVersion isEqualToString:@"DEBUG"]) {
        [userDefault setObject:@"http://192.168.0.201:8321/api/" forKey:@"MZAPI_URL"];
    }else if ([self.appVersion isEqualToString:@"INDOOR_RELEASE"]){
        [userDefault setObject:@"http://service.four.inkey.com/api/" forKey:@"MZAPI_URL"];
    }else if ([self.appVersion isEqualToString:@"RELEASE"]){
        [userDefault setObject:@"http://service.inkey.com/api/" forKey:@"MZAPI_URL"];
    }else{
    }
    [userDefault synchronize];
    
    
    _mtaManager = [CRMTAManager new];
    [_mtaManager MTA_start];

    if(![super application:application didFinishLaunchingWithOptions:launchOptions])
    {
        return NO;
    }
    
    [self setup];
    
    if(self.isInstall)
    {
        [self saveFlashPicture:nil data:nil linkUrl:nil];
        [self gotoWelcome];
        [VoiceControl openTheSound:YES];
    }
    else
    {
        [self gotoAutoLogin];
    }
    
    //白色NavTitle
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,BoldFont(19),UITextAttributeFont,nil]];
    //白色StatuBar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [self initStatuBar];
//#warning 第一次登陆
    [[NSUserDefaults standardUserDefaults] setBool:YES  forKey:cr_CACHE_AUTOCLEAR];
    [[NSUserDefaults standardUserDefaults] setBool:YES  forKey:cr_SOUND_TURN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [CRFileUtil cleanSevenDaysAgoCache];
#warning end
    _pushManager = [[CRPushManager alloc] initWith:launchOptions application:application];
    
    //配置sharesdk
    [self shareSetting];
    //配置wxpay
    [self wxPaySetting];
    
#warning 动画结束后调用

    if (!self.isInstall)
    {
        [self addAnimationToHomeView];
    }
    
    [self getSplashScreen];
    
    return YES;
}

- (void)updateMZ:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        NSString * OrVersion = [NSString stringWithFormat:@"%d",[arg.ret.data getInt:@"Status"]];
        [[NSUserDefaults standardUserDefaults] setObject:OrVersion forKey:@"OrVersion"];
        [[NSUserDefaults standardUserDefaults] setObject:[arg.ret.data getString:@"Downurl"] forKey:@"Downurl"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if ([arg.ret.data getInt:@"Status"] == 2)
        {
            [AlertUtil showAlert:@"发现新版本"
                         message:[arg.ret.data getString:@"Content"]
                         buttons:@[@"稍后再去",@{ @"title":@"立即更新",
                                            @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[arg.ret.data getString:@"Downurl"]]];
            })}]];
        }
        else if ([arg.ret.data getInt:@"Status"] == 3)
        {
            [AlertUtil showAlert:@"发现新版本"
                         message:[arg.ret.data getString:@"Content"]
                         buttons:@[@{ @"title":@"确定",
                                            @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[arg.ret.data getString:@"Downurl"]]];
            })}]];
        }
    }
}

#pragma mark - 闪屏动画

//添加动画引导
- (void)addAnimationToHomeView{
    
    //创建uiimageview
    
    //获取图片
    
    NSData *data = [[[NSUserDefaults standardUserDefaults] valueForKey:@"hoverImage"] firstObject];
    UIImage *image = [UIImage imageWithData:data];
    
    UIImageView *imagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[UICommon getIos4OffsetY] ? @"Default-568h.png" : @"Default.png"]];
    
    imagev.frame = CGRectMake( - SCREENWIDTH, 0, 320, [SystemUtil aboveIOS7_0] ? SCREENHEIGHT : SCREENHEIGHT-20);
    [self.window addSubview:imagev];
    
    UIImageView *hoverImageview = [[UIImageView alloc] initWithImage:image];
    hoverImageview.frame = CGRectMake(0, 0, 320, [UICommon getIos4OffsetY] ? 422 : 372);
    hoverImageview.contentMode = UIViewContentModeScaleToFill;
    hoverImageview.alpha = 0.f;
    [imagev addSubview:hoverImageview];
    
    UITapGestureRecognizer *tap = WEAK_OBJECT(UITapGestureRecognizer, initWithTarget:self action:@selector(tapFlashPic:));
    hoverImageview.userInteractionEnabled = YES;
    [hoverImageview addGestureRecognizer:tap];
    
//    self.window.top = [SystemUtil aboveIOS7_0] ? -SCREENHEIGHT : -(SCREENHEIGHT-20);
    self.window.left    = SCREENWIDTH;
    
    [UIView animateWithDuration:0.5 animations:^{
        hoverImageview.alpha = 1.f;
    }];
    
    [PlaySound playSound:@"FlashScreenV" type:@"mp3"];
    
    [UIView animateWithDuration:0.5 delay:4 options:UIViewAnimationOptionTransitionNone animations:^{
//        self.window.top = 0;
        self.window.left    = 0;
    } completion:^(BOOL finished) {
        [hoverImageview removeFromSuperview];
        [hoverImageview release];
        [imagev removeFromSuperview];
        [imagev release];
        _isFinish = YES;
//        [self notify];
    }];
    
}

- (void)tapFlashPic:(UITapGestureRecognizer *)tap{
    NSString *link = [[NSUserDefaults standardUserDefaults] valueForKey:@"flashLinkUrl"];
    if (link.length) {
        BannerDetailViewController *banner = WEAK_OBJECT(BannerDetailViewController, init);
        banner.urlStr = link;
        [UI_MANAGER.mainNavigationController pushViewController:banner animated:YES];
        
    }
}

- (void)getSplashScreen
{
    if (!USER_MANAGER.CustomerId.length) {
        [self performSelector:@selector(getSplashScreen) withObject:nil afterDelay:2];
    }

    ADAPI_SplashAdvert_Index([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSplash:)]);

    ADAPI_adv3_Checkver([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(updateMZ:)]);
}

#pragma mark - 屏幕广告数据处理
- (void)handleSplash:(DelegatorArguments *)arguments{
    DictionaryWrapper *dic = arguments.ret;
    if(dic.operationSucceed)
    {
        if ([dic.data isKindOfClass:[NSNull class]]) {
            return;
        }
        NSString *urlStr = [[dic.data getString:@"PictureUrl"] lowercaseString];
        NSString *link = [[dic.data getString:@"LinkUrl"] lowercaseString];
        NSDate *date = [UICommon dateFromString:[UICommon format19Time:[dic.data getString:@"StartTime"]]];
        if(!urlStr.length)
        {
            [self saveFlashPicture:nil data:nil linkUrl:link.length ? link : @""];
        }
        else if([urlStr isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"flashImageUrl"]])
        {
            return ;
        }
        else
        {
            if (date && ([date compare:[NSDate date]] != NSOrderedDescending)) {
            
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
                [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
                 {
                     if(data && data.length)
                     {
                         [self saveFlashPicture:urlStr data:data linkUrl:link];
                     }
                     
                 }];
            }
        }
    }
    
}

- (void) saveFlashPicture:(NSString*)url data:(NSData*)data linkUrl:(NSString *)link
{
    if(!url || url.length == 0)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"flashLinkUrl"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"flashImageUrl"];
        
        UIImage *image = [UIImage imageNamed:[UICommon getIos4OffsetY] ? @"start568.png" : @"start.png"];
        if (image)
            [[NSUserDefaults standardUserDefaults] setValue:@[UIImagePNGRepresentation(image)] forKey:@"hoverImage"];
    }
    else
    {
        APP_ASSERT(data);
        
        [[NSUserDefaults standardUserDefaults] setValue:link forKey:@"flashLinkUrl"];
        [[NSUserDefaults standardUserDefaults] setValue:url forKey:@"flashImageUrl"];
        [[NSUserDefaults standardUserDefaults] setValue:@[data] forKey:@"hoverImage"];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 状态栏
//状态栏
- (void)initStatuBar
{
    //白色NavTitle
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,BoldFont(19),UITextAttributeFont,nil]];
    //白色StatuBar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

#pragma mark - 分享
- (void)shareSetting
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //参数为ShareSDK官网中添加应用后得到的AppKey
        [ShareSDK registerApp:@"4ee3cb14c67c"];
        
        //添加微信应用
        [ShareSDK connectWeChatWithAppId:@"wxc35131ff6cd1ea70"        //此参数为申请的微信AppID
                               wechatCls:[WXApi class]];
        
        //添加新浪微博应用
        [ShareSDK connectSinaWeiboWithAppKey:@"2763605768"
                                   appSecret:@"41167403085d3c908e3d9cecbd4ebb46"
                                 redirectUri:@"http://www.mykjgf.com/"];
        
        //添加腾讯微博应用
//        [ShareSDK connectTencentWeiboWithAppKey:@"801503064"
//                                      appSecret:@"fc2907415513c697e23ac12704b0319a"
//                                    redirectUri:@"http://www.mykjgf.com/"];
        
        //添加QQ空间应用
        [ShareSDK connectQZoneWithAppKey:@"101082558"
                               appSecret:@"0665dc99288124829fef67ef230a3d9d"
                       qqApiInterfaceCls:[QQApiInterface class]
                         tencentOAuthCls:[TencentOAuth class]];
        
        //添加微信朋友圈应用
        [ShareSDK connectWeChatTimelineWithAppId:@"wxc35131ff6cd1ea70" wechatCls:[WXApi class]];
        
        //添加QQ应用
        //    101082558
        //    [ShareSDK connectQQWithAppId:@"100371282" qqApiCls:[QQApi class]];
        
        [ShareSDK connectQQWithQZoneAppKey:@"101082558"
                         qqApiInterfaceCls:[QQApiInterface class]
                           tencentOAuthCls:[TencentOAuth class]];
        
        //添加人人网应用
//        [ShareSDK connectRenRenWithAppKey:@"3e5e1fd2f2034348a58cb4dc37d2499a"
//                                appSecret:@"e3cd77e04a384cc4a5e2d9f5c8925398"];
        [ShareSDK connectMail];
        [ShareSDK connectSMS];
    });
}

#pragma mark - 微信支付
- (void)wxPaySetting{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WXApi registerApp:WXAppId];
    });
}

//微信支付
- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        
#if APP_VERSION == VERSION_DEBUG
        
//        NSString *strTitle = [NSString stringWithFormat:@"支付结果"];
//        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
//        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:strTitle
//                                                         message:strMsg
//                                                        delegate:self
//                                               cancelButtonTitle:@"OK"
//                                               otherButtonTitles:nil, nil] autorelease];
//        [alert show];
        
#endif
        
        if (!resp.errCode) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wxpay" object:@(resp.errCode)];
        }
        
    }
}

- (BOOL)application:(UIApplication *)application  handleOpenURL:(NSURL *)url
{
    if ([url.host hasPrefix:@"platformId"]) {
        return [ShareSDK handleOpenURL:url
                            wxDelegate:self];
    } else {
        return [WXApi handleOpenURL:url delegate:self];
    }
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    NSString * autoPhoneUrl = [NSString stringWithFormat:@"%@",url];

//    NSString *autoPhoneUrl = @"miaozuan://13231313131";
    
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([[resultDic wrapper] getInt:@"resultStatus"] == 9000) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"alipay" object:@{}];
            }
        }];
        return YES;
    } else if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        return YES;
    } else if([url.host hasPrefix:@"platformId"]) {
        return [ShareSDK handleOpenURL:url
                     sourceApplication:sourceApplication
                            annotation:annotation
                            wxDelegate:self];
    }
    else if ([autoPhoneUrl hasPrefix:@"miaozuan:"])
    {
        if (autoPhoneUrl.length > 11)
        {
            NSString * autoPhone = [autoPhoneUrl substringWithRange:NSMakeRange(autoPhoneUrl.length - 11, 11)];
            
            [[NSUserDefaults standardUserDefaults] setObject:autoPhone forKey:@"autoPhone"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GetPhoneNum" object:autoPhone];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        
        return YES;
    } else {
        return [WXApi handleOpenURL:url delegate:self];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//#pragma mark - 推送
//
////收到推送
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    _notifyType = [userInfo.wrapper getInteger:@"Type"];
//
//    if (application.applicationState == UIApplicationStateActive)
//    {
//    }
//    else
//    {
//        NSString *pushMsgId = [userInfo valueForKey:@"MsgId"];
//        [self performSelector:@selector(pushCount:) withObject:pushMsgId afterDelay:5];
//        [self notify];
//    }
//    [application setApplicationIconBadgeNumber:0];
//
//    [BPush handleNotification:userInfo];
//}
//
//
//
////注册token
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
//
//    [BPush registerDeviceToken:deviceToken];
//    // 必须。可以在其它时机调用,只有在该方法返回(通过 onMethod:response:回调)绑定成功时,app 才能接收到 Push 消息。一个 app 绑定成功至少一次即可(如 果 access token 变更请重新绑定)。
//    [BPush bindChannel];
//
//    //将device token转换为字符串
//    NSString *deviceTokenStr = [NSString stringWithFormat:@"%@",deviceToken];
//
//    //modify the token, remove the  "<, >"
//    deviceTokenStr = [[deviceTokenStr substringWithRange:NSMakeRange(0, 72)] substringWithRange:NSMakeRange(1, 71)];
//
//    NSLog(@"deviceTokenStr = %@",deviceTokenStr);
//    //将deviceToken保存在NSUserDefaults
//
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    //保存 device token 令牌,并且去掉空格
//    [userDefaults setObject:[deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"token"];
//
//    // 必须
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
////
//// 必须,如果正确调用了 setDelegate,在 bindChannel 之后,结果在这个回调中返回。 若绑定失败,请进行重新绑定,确保至少绑定成功一次
//- (void)onMethod:(NSString*)method response:(NSDictionary*)data
//{
//    if ([BPushRequestMethod_Bind isEqualToString:method]) {
//        NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
//        NSString *appid = [res.wrapper getString:BPushRequestAppIdKey];
//        NSString *userid = [res.wrapper getString:BPushRequestUserIdKey];
//        NSString *channelid = [res.wrapper getString:BPushRequestChannelIdKey];
//        NSString *appId = [res.wrapper getString:BPushRequestAppIdKey];
//        int returnCode = [[res.wrapper getString:BPushRequestErrorCodeKey] intValue];
//        NSString *requestid = [res.wrapper getString:BPushRequestRequestIdKey];
//        NSNumber *pushVersion = @(1);
//        if (returnCode == BPushErrorCode_Success) {
//            [BPush setDelegate:nil];
////            DLog(@"res%@appid%@userid%@channelid%@_requestid%@returnCode_%d ",res,appid,userid,channelid,requestid,returnCode);
//            [[NSUserDefaults standardUserDefaults] setValue:appId forKey:@"appid"];
//            [[NSUserDefaults standardUserDefaults] setValue:userid forKey:@"userid"];
//            [[NSUserDefaults standardUserDefaults] setValue:channelid forKey:@"channelid"];
//            [[NSUserDefaults standardUserDefaults] setValue:pushVersion forKey:@"PushVersion"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            //            DLog(@"%@%@",kUserid,kChannelid);
//        } else {
//            int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
////            DLog(@"%d",returnCode);
//            [BPush bindChannel];
//        }
//        [res release];
//    }
//}
////处理拒绝推送
//- (void)application:(UIApplication *) application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//{
//    [_pushManager debugPushIsSucess:error];
//    NSLog(@"\n\n=============================================================\n推送失败原因 :%@\n=============================================================\n\n\n",error);
//}
////IOS8 注册用户信息
//- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
//{
//    //register to receive notifications
//    [application registerForRemoteNotifications];
//}
//
////推送跳转
//- (void)notify
//{
//    [BPConfig getNotifyHandleJumping:_notifyType];
//}
//
////初始化推送
//- (void)initBPush:(NSDictionary *)launchOptions application:(UIApplication *)application
//{
//    _notifyType = NotifyHandleMain;
//    [BPush setupChannel:launchOptions];
//    NSDictionary *dic = nil;
//    dic = [launchOptions.wrapper getDictionary:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
//    if (dic != nil)
//    {
//        if (dic.count > 1)
//        {
//            NSString *pushMsgId = [dic.wrapper getString:@"MsgId"];
//            [self performSelector:@selector(pushCount:) withObject:pushMsgId afterDelay:5];
//        }
//        _notifyType = [dic.wrapper getInteger:@"Type"];
//    }
//
//    // 必须。参数对象必须实现(void)onMethod:(NSString*)method response:(NSDictionary*)data 方法,本示例中为 self
//    [BPush setDelegate:self];
//
//    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//    {
//        UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//    }
//    else
//    {
//        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
//    }
//}
//
////推送反馈
//- (void)pushCount:(NSString *)pushMsgId
//{
//    if (pushMsgId == nil)
//    {
//        return;
//    }
////    ADAPI_adv24_pushCount([DELEGATOR_MANAGER addDelegator:self selector:@selector(HandleBackPush:)], [LoginManager sharedInstance].curUserId.intValue, pushMsgId);
//}

@end
