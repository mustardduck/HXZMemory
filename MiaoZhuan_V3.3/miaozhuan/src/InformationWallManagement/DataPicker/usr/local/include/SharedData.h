//
//  SharedData.h
//  MZFramework
//
//  Created by Nick on 15-3-26.
//  Copyright (c) 2015年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Update_Type.h"

#import "API_Outside.h"
#import "Model_Outside.h"


//@class PersonalInfo;

@interface SharedData : NSObject

@property(nonatomic, strong) PersonalInfo   *personalInfo;                      //用户信息




//获取实例
#define G_DATA [SharedData getInstance]
+ (instancetype)getInstance;

-(void)engine_request:(NSString *)url requestType:(update_type)utype meth:(NSString *)meth paramters:(NSDictionary *)dict;

@end
