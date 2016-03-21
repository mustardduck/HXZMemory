//
//  DictionaryWrapper+Net.m
//  miaozhuan
//
//  Created by Santiago on 14-10-24.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DictionaryWrapper+Net.h"
#import "CRHttpAddedManager.h"

@implementation DictionaryWrapper(Net)

- (BOOL) operationSucceed
{
    int64_t status = [self getInteger:@"Code"];
    
    return  status == 100;
}

-(BOOL) operationDealWithCode
{
    int64_t status = [self getInteger:@"Code"];
    
    return  status >= 1000 && status <= 9999;
}

-(BOOL) operationPromptCode
{
    int64_t status = [self getInteger:@"Code"];
    
    return  status >= 10000 && status <= 99999;
}

-(BOOL) operationErrorCode
{
    int64_t status = [self getInteger:@"Code"];
    
    return  status >= -1000 && status <= -100;
}

- (id) data
{
    id ret = [self get:@"Data"];
    
    if([ret isKindOfClass:[NSDictionary class]])
    {
        ret = ((NSDictionary*)ret).wrapper; 
    }
    
    return ret;
}

- (int) code
{
    return  [self getInt:@"Code"];
}

- (NSString*) operationMessage
{
    NSString* ret = [self getString:@"Desc"]; // 2.0
    
    if(!ret)
    {
        ret = @"";
    }
    
    if (ret.length > 40) ret = @"数据加载失败";
    
    return ret;
}


@end
