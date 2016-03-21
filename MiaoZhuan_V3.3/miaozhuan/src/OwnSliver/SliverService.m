//
//  SliverService.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-2.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SliverService.h"

static SliverService *share = nil;

@implementation SliverService

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (share == nil) {
            share = [[SliverService alloc] init];
        }
    });
    return share;
}

- (void)createRequestWithType:(int)type dataDic:(NSDictionary *)dic{
    
}

@end
