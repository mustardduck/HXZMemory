//
//  CRPushManager.h
//  miaozhuan
//
//  Created by abyss on 15/1/29.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(int, CRNotifyHandleType)
{
    CRNotifyHandleTypeOld      = -1,
    CRNotifyHandleUnKonw       = 0,
    
    CRNotifyHandleNotifyCenter = 1,
    CRNotifyHandleMain         = 2,
    CRNotifyHandleYinMall      = 3,
    CRNotifyHandleJinMall      = 4,
    CRNotifyHandleThanks       = 5,
    CRNotifyHandleRanking      = 6,
    CRNotifyHandleMerch        = 7,
    CRNotifyHandleVIP          = 8,
    CRNotifyHandleEnterVIP     = 9,
};
// operation : RegisteCRPushConfigForApplication()

@interface CRPushManager : NSObject
@property (assign, nonatomic) BOOL debugMode;

@property (retain, nonatomic) NSDictionary* launchOptions;
@property (retain, nonatomic) UIApplication* application;
@property (assign, nonatomic) CRNotifyHandleType type;
@property (assign, nonatomic) BOOL needJumpAfterLogin;
@property (retain, nonatomic) UILocalNotification* notity;

- (instancetype) initWith:(NSDictionary *)launchOptions application:(UIApplication *)application;

- (void)registerToken:(NSData *)deviceToken;
- (void)responsePushNotification:(NSDictionary *)userInfo  islocal:(BOOL)isLocal newApplocation:(UIApplication *)updade;
- (void)debugPushIsSucess:(NSError *)error;
- (void)pushios8_RegisterUser:(UIUserNotificationSettings *)notificationSettings newApplocation:(UIApplication *)updade;

//Bpush
//- (void)Bpush_onMethod:(NSString*)method response:(NSDictionary*)data;

//MZConfig
- (void)notifyToJump;
- (void)sendToken;
- (void)sendReport:(NSString *)MsgId;

#define RegisteCRPushConfigForApplication() \
CRPUSH_ResponsePushNotification() \
CRPUSH_RegisterToken() \
CRPUSH_pushios8_RegisterUser() \
CRPUSH_debugPushIsSucess() \
CRPUSH_ResponseLocalNotification() \


#define CRPUSH_ResponsePushNotification() \
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo \
{[_pushManager responsePushNotification:userInfo islocal:NO  newApplocation:application];}

#define CRPUSH_RegisterToken() \
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken \
{[_pushManager registerToken:deviceToken];}

#define CRPUSH_debugPushIsSucess() \
- (void)application:(UIApplication *) application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error\
{[_pushManager debugPushIsSucess:error];}

#define CRPUSH_pushios8_RegisterUser() \
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings\
{[_pushManager pushios8_RegisterUser:notificationSettings  newApplocation:application];}

#define CRPUSH_ResponseLocalNotification() \
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification \
{\
    _pushManager.notity = notification;\
[_pushManager responsePushNotification:notification.userInfo islocal:YES  newApplocation:application];}

@end
