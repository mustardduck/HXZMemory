//
//  Update_Type.h
//  MZFramework
//
//  Created by Nick on 15-3-26.
//  Copyright (c) 2015年 Nick. All rights reserved.
//

//通知消息定义
extern NSString * const UpdateSuccessAction;
extern NSString * const UpdateFailureAction;

#ifndef MZFramework_Update_Type_h
#define MZFramework_Update_Type_h


#define pageCount                   10                              //table加载条数


#define URL_Address                 @"http://192.168.0.201/api"

typedef enum _update_type
{
    //model_outside
    ut_login,
    ut_test1,
    ut_logout,
    
}update_type;


#endif
