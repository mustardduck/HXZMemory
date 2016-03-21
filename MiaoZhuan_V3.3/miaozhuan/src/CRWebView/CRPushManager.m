//
//  CRPushManager.m
//  miaozhuan
//
//  Created by abyss on 15/1/29.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "CRPushManager.h"
#import "BPush.h"
#import "UserInfo.h"

#import "NotiftCenterViewController.h"
#import "ControlViewController.h"
#import "MallScanAdvertMain.h"
#import "ThankFulFansStatisticalViewController.h"
#import "RankListViewController.h"
#import "RecommendMerchantViewController.h"
#import "VipPriviliegeViewController.h"
#import "VIPPrivilegeViewController.h"

@interface CRPushManager()<BPushDelegate>

@end

@implementation CRPushManager

- (instancetype) initWith:(NSDictionary *)launchOptions application:(UIApplication *)application
{
    self = [super init];
    if (self)
    {
        _debugMode = NO;
        
        _application = application;
        [_application retain];
        
        _launchOptions = launchOptions;
        [_launchOptions retain];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound
            | UIUserNotificationTypeAlert;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes
                                                                                     categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }else {
            UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
        }
    }
    
#warning 上线 AppStore 时需要修改 pushMode
    // 在 App 启动时注册百度云推送服务,需要提供 Apikey
    [BPush registerChannel:launchOptions apiKey:@"TS5m2vmPBmBiKDEUXXxhkBM2" pushMode:BPushModeProduction isDebug:NO];
    // 设置 BPush 的回调
    [BPush setDelegate:self];
    // App 是⽤用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        [BPush handleNotification:userInfo];
    }
    
    // push to open applocation
    {
        NSDictionary *dic = nil;
        dic = [launchOptions.wrapper getDictionary:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
        if (dic && dic.count > 0)
        {
            NSString *pushMsgId = [dic.wrapper getString:@"MsgId"];
            [self sendReport:pushMsgId];
            
            _type = [dic.wrapper getInt:@"Type"];
            if (_type > 0) _needJumpAfterLogin = YES;
        
            if ([APP_DELEGATE.appVersion isEqualToString:@"DEBUG"] && _debugMode)
            {
                [AlertUtil showAlert:[NSString stringWithFormat:@"%d获得",_type]
                             message:[NSString stringWithFormat:@"%@",dic.wrapper.dictionary]
                             buttons:@[@"确定",]];
            }
        }
    }
    [_application setApplicationIconBadgeNumber:0];
    
    return self;
}

- (void)registerToken:(NSData *)deviceToken
{
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannel];
    
    NSString *deviceTokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    deviceTokenStr = [[deviceTokenStr substringWithRange:NSMakeRange(0, 72)] substringWithRange:NSMakeRange(1, 71)];
    NSLog(@"deviceTokenStr = %@",deviceTokenStr);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)responsePushNotification:(NSDictionary *)userInfo islocal:(BOOL)isLocal newApplocation:(UIApplication *)updade
{
    _application = updade;
    _type = [userInfo.wrapper getInt:@"Type"];
    if (_application.applicationState == UIApplicationStateActive)
    {
        if ([APP_DELEGATE.appVersion isEqualToString:@"DEBUG"] && _debugMode)
        {
            [AlertUtil showAlert:[NSString stringWithFormat:@"%d获得",_type]
                         message:[NSString stringWithFormat:@"%@",userInfo]
                         buttons:@[@"确定",]];
        }

        // convert to local notification without jump and alert
        if (!isLocal)
        {
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            localNotification.userInfo = userInfo;
            localNotification.soundName = UILocalNotificationDefaultSoundName;
            localNotification.alertBody = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
            localNotification.fireDate = [NSDate date];
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        }
    }
    else
    {
        NSString *pushMsgId = [userInfo.wrapper getString:@"MsgId"];
        [self sendReport:pushMsgId];
        [self notifyToJump];
//        if (isLocal) [[UIApplication sharedApplication] cancelLocalNotification:_notity];
        [BPush handleNotification:userInfo];
    }
}

- (void)debugPushIsSucess:(NSError *)error
{
    if ([APP_DELEGATE.appVersion isEqualToString:@"DEBUG"] && _type)
    {
        [AlertUtil showAlert:@"推送失败"
                     message:error.localizedDescription
                     buttons:@[@"确定",]];
    }
}

- (void)pushios8_RegisterUser:(UIUserNotificationSettings *)notificationSettings newApplocation:(UIApplication *)updade
{
    _application = updade;
    [_application registerForRemoteNotifications];
}

- (void)onMethod:(NSString*)method response:(NSDictionary*)data
{
    if ([BPushRequestMethodBind isEqualToString:method]) {
        NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
//        NSString *appid = [res.wrapper getString:BPushRequestAppIdKey];
        NSString *userid = [res.wrapper getString:BPushRequestUserIdKey];
        NSString *channelid = [res.wrapper getString:BPushRequestChannelIdKey];
        NSString *appId = [res.wrapper getString:BPushRequestAppIdKey];
        int returnCode = [[res.wrapper getString:BPushRequestErrorCodeKey] intValue];
        NSString *requestid = [res.wrapper getString:BPushRequestRequestIdKey];
        NSNumber *pushVersion = @(3);
        
        if (returnCode == 0)
        {
            
            if ([APP_DELEGATE.appVersion isEqualToString:@"DEBUG"] && _debugMode)
            {
                [AlertUtil showAlert:@""
                             message:@"成功"
                             buttons:@[@"确定",]];
            }
            [BPush setDelegate:nil];
            
            [[NSUserDefaults standardUserDefaults] setValue:appId forKey:@"appid"];
            [[NSUserDefaults standardUserDefaults] setValue:userid forKey:@"userid"];
            [[NSUserDefaults standardUserDefaults] setValue:channelid forKey:@"channelid"];
            [[NSUserDefaults standardUserDefaults] setValue:pushVersion forKey:@"PushVersion"];
            [[NSUserDefaults standardUserDefaults] synchronize];

        } else
        {

            [BPush bindChannel];
        }
        [res release];
    }
}

#pragma mark -

- (void)notifyToJump
{
    if ([APP_DELEGATE.appVersion isEqualToString:@"DEBUG"] && _debugMode)
    {
        [AlertUtil showAlert:@"type————》即将跳转"
                     message:[NSString stringWithFormat:@"%d",_type]
                     buttons:@[@"确定",]];
    }
    if (_type < 0 || (int)_type > 9) return;
    
    __block CRPushManager* weakself = self;
    if (![UICommon getOldViewController:[ControlViewController class]])
    {
        NSLog(@"%@",UI_MANAGER.mainNavigationController.viewControllers);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself notifyToJump];
        });
        return;
    }
    
    UIViewController* currentViewCon = UI_MANAGER.mainNavigationController.topViewController;
#define checkCurrentConWith(_model) \
if ([currentViewCon isKindOfClass:[_model class]]) \
{return;}
    
    switch (_type)
    {
        case CRNotifyHandleUnKonw:
        {
            if ([APP_DELEGATE.appVersion isEqualToString:@"DEBUG"] && _debugMode)
            {
                [AlertUtil showAlert:@"跳转失败或非推送点击打开程序"
                             message:@"检查跳转跳转目标"
                             buttons:@[@"确定",]];
            }
        }
            break;
        case CRNotifyHandleNotifyCenter:
        {
            checkCurrentConWith(NotiftCenterViewController);
            PUSH_VIEWCONTROLLER(NotiftCenterViewController);
            break;
        }
        case CRNotifyHandleMain:
        {
//            [UI_MANAGER startWithClass:[ControlViewController class] animated:YES];
            break;
        }
        case CRNotifyHandleYinMall:
        {
            checkCurrentConWith(MallScanAdvertMain);
            PUSH_VIEWCONTROLLER(MallScanAdvertMain);
            break;
        }
        case CRNotifyHandleJinMall:
        {
            checkCurrentConWith(MallScanAdvertMain);
            PUSH_VIEWCONTROLLER(MallScanAdvertMain);
            model.startPage = 1;
            break;
        }
        case CRNotifyHandleThanks:
        {
            checkCurrentConWith(ThankFulFansStatisticalViewController);
            PUSH_VIEWCONTROLLER(ThankFulFansStatisticalViewController);
            break;
        }
        case CRNotifyHandleRanking:
        {
            checkCurrentConWith(RankListViewController);
            PUSH_VIEWCONTROLLER(RankListViewController);
            break;
        }
        case CRNotifyHandleMerch:
        {
            checkCurrentConWith(RecommendMerchantViewController);
            PUSH_VIEWCONTROLLER(RecommendMerchantViewController);
            break;
        }
        case CRNotifyHandleVIP:
        {
            checkCurrentConWith(VipPriviliegeViewController);
            PUSH_VIEWCONTROLLER(VipPriviliegeViewController);
            break;
        }
        case CRNotifyHandleEnterVIP:
        {
            checkCurrentConWith(VIPPrivilegeViewController);
            PUSH_VIEWCONTROLLER(VIPPrivilegeViewController);
            break;
        }
            
        default:
            break;
    }
    
    // reset
    {
        _type = CRNotifyHandleTypeOld;
        _needJumpAfterLogin = NO;
    }
}

- (void)sendReport:(NSString *)MsgId
{
    __block CRPushManager *weakself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //用户统计
        ADAPI_adv3_Push_Report([GLOBAL_DELEGATOR_MANAGER addDelegator:weakself selector:@selector(responseReport:)], USER_MANAGER.CustomerId?USER_MANAGER.CustomerId:@"", MsgId?MsgId:@"");
    });
}

- (void)sendToken
{
    NSString *a = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    NSString *b = [[NSUserDefaults standardUserDefaults] valueForKey:@"appid"];
    NSString *c = [[NSUserDefaults standardUserDefaults] valueForKey:@"userid"];
    NSString *d = [[NSUserDefaults standardUserDefaults] valueForKey:@"channelid"];
    NSString *e = [[NSUserDefaults standardUserDefaults] valueForKey:@"PushVersion"];
    
    if (!a||!b||!c||!d||!e) return;
    __block CRPushManager *weakself = self;
    ADAPI_adv3_push_Update([GLOBAL_DELEGATOR_MANAGER addDelegator:weakself selector:@selector(responseReport:)],
                           a,
                           b,
                           c,
                           d,
                           e);
    //更新设备信息
}

- (void)responseReport:(DelegatorArguments *)arg
{
    NSLog(@"%@",arg.ret);
}

@end
