//
//  CRShareUnit.m
//  miaozhuan
//
//  Created by abyss on 14/12/12.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CRShareUnit.h"
#import "OpenUDID.h"

NSString *APP_TOKEN_KEY = @"token";

static int parse(char c)
{
    if (c >= 'a')
        return (c - 'a' + 10) & 0x0f;
    if (c >= 'A')
        return (c - 'A' + 10) & 0x0f;
    return (c - '0') & 0x0f;
}


@implementation CRShareUnit

+ (NSString *)token
{
    return [OpenUDID value];
}


@end
