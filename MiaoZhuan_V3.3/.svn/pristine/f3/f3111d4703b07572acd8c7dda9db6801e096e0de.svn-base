//
//  LoginModuleAPI.h
//  miaozhuan
//
//  Created by xm01 on 14-11-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModuleAPI : NSObject

@end

extern NSString* LOGIN_MODULE;

extern NSString* REGISTRATION_MODULE;

#define LGOP_login   @"LGOP_login"

#define LGOP_register @"LGOP_register"

typedef enum
{
    LOGIN_FROM_AUTO = 1,
    LOGIN_FROM_MANUAL,
    LOGIN_FROM_BACKGROUND,
}ELoginFrom;

void LGAPI_register(DelegatorID delegatorID,NSString * userName,NSString *password);

void LGAPI_login(DelegatorID delegatorID, NSString* userName, NSString* userPassword, ELoginFrom loginFrom);
