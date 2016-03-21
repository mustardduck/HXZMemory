//
//  AppDelegate+MJSetup.h
//  miaozhuan
//
//  Created by xm01 on 14-10-28.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AppDelegate.h"
#import "RequestFailedView.h"
#import "RequestFailed.h"

extern NSString* APP_EVENT_GPS_LOCATION_CHANGE;
extern NSString* APP_EVENT_ARGUMENT_GPS_LOCATION;

@interface AppDelegate (Setup)
{

}

- (void) setup;

@end


typedef enum
{
    USER_STATE_UNKNOWN = 0,
    USER_STATE_LOGOUT = 1,
    USER_STATE_LOGINING,
    USER_STATE_LOGIN,
}EUserState;

extern NSString* APP_EVENT_USER_STATE_CHANGE;
extern NSString* APP_EVENT_ARGUMENT_USER_OLD_STATE;
extern NSString* APP_EVENT_ARGUMENT_USER_STATE;

@interface AppDelegate (UserState)

- (void) setUserState:(EUserState)state;
- (EUserState) userState;

@end

@interface AppDelegate (Goto)<RRRequestFailedDelegate, RequestFailedDelegate>

- (void) gotoAutoLogin;

- (void) gotoLogin;

- (void) gotoHome;

- (void) gotoLogout;

- (void) gotoWelcome;

- (void) onLoginRequestSucceed:(DelegatorArguments*)arguments;

@end

@interface EnterpriseInfo : NSObject 
//EnterpriseId	int	否	没创建商家返回-1
//EnterpriseName	string	是	商家名称
//EnterpriseLogoUrl	string	是	商家LOGO URL
//EnterpriseStatus	int	否	0-未创建，1-审核中，2-审核失败，3-审核成功，4-已激活

+ (int) ID;
+ (NSString*) name;
//+ (NSString*) logoURL;
//+ (NSString*) status;

@end