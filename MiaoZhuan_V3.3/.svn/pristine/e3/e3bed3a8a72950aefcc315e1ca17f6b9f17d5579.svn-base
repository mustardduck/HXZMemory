//
//  LoginModuleAPI.m
//  miaozhuan
//
//  Created by xm01 on 14-11-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "LoginModuleAPI.h"
#import "OpenUDID.h"
#import "SharedData.h"

@implementation LoginModuleAPI

@end

NSString* LOGIN_MODULE = @"LOGIN_MODULE";

NSString* REGISTRATION_MODULE = @"REGISTRATION_MODULE";

void LGAPI_register(DelegatorID delegatorID,NSString * userName,NSString *password)
{
    if(APP_DELEGATE.userState == USER_STATE_LOGINING)
    {
        return ;
    }
    
    if(userName.length<=0 || password.length<=0)
    {
        userName = [APP_DELEGATE.persistConfig getString:USER_INFO_NAME];
        password = [APP_DELEGATE.persistConfig getString:USER_INFO_PASSWORD];
    }
    
    userName = userName ? userName : @"";
    password = password ? password : @"";
    
    NSString * imei = [OpenUDID value];
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Auth/CustomerRegister"
                                                                    body:@{
                                                                           @"UserName":userName,
                                                                           @"Password":password,@"Imei":imei}];
    
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    [option turnOn:OPTION_NEED_DEBUG_INFO];
    
    [NET_SERVICE doRequest:LGOP_register forModule:REGISTRATION_MODULE withOption:option];
    
    APP_DELEGATE.userState = USER_STATE_LOGINING;
}

void LGAPI_login(DelegatorID delegatorID, NSString* userName, NSString* userPassword, ELoginFrom loginFrom)
{
//    if(APP_DELEGATE.userState == USER_STATE_LOGINING)
//    {
//        return ;
//    }
    
    if(APP_DELEGATE.userState == USER_STATE_LOGOUT && loginFrom == LOGIN_FROM_BACKGROUND)
    {
        return ;
    }
    
    if(userName.length<=0 || userPassword.length<=0)
    {
        userName = [APP_DELEGATE.persistConfig getString:USER_INFO_NAME];
        userPassword = [APP_DELEGATE.persistConfig getString:USER_INFO_PASSWORD];
    }
    
    userName = userName ? userName : @"";
    userPassword = userPassword ? userPassword : @"";
    
    NSString * imei = [OpenUDID value];
    
    [SharedData getInstance].isUserLogoutManual = NO;
    [SharedData getInstance].personalInfo.userUserName = userName;
    [SharedData getInstance].personalInfo.userPassword = userPassword;
    [SharedData getInstance].personalInfo.userImei = imei;
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Auth/Login"
                                                                    body:@{
                                                                           @"UserName":userName,
                                                                           @"Password":userPassword,@"Imei":imei}];

    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    [option turnOn:OPTION_NEED_DEBUG_INFO];
    
    if(loginFrom != LOGIN_FROM_BACKGROUND)
    {
        [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    }
    [option addOption:@"LOGIN_FROM" value:@(loginFrom)];
    [option addOption:@"LOGIN_USER_NAME" value:userName];
    [option addOption:@"LOGIN_USER_PASSWORD" value:userPassword];
    
    [NET_SERVICE doRequest:LGOP_login forModule:LOGIN_MODULE withOption:option];
    
    APP_DELEGATE.userState = USER_STATE_LOGINING;
}
