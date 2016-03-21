//
//  API_Outside.h
//  MZFramework
//
//  Created by Nick on 15-3-26.
//  Copyright (c) 2015年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API_Outside : NSObject

//获取实例
#define API_OUTSIDE [API_Outside getInstance]
+ (instancetype)getInstance;


//登录
-(void) engine_outside_login:(NSString *)UserName passWod:(NSString *)Password imei :(NSString *)Imei;

@end
