//
//  CRMTAManager.m
//  miaozhuan
//
//  Created by Abyss on 15-3-6.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "CRMTAManager.h"
#import "UserInfo.h"

@implementation CRMTAManager

- (void)MTA_start
{
    [MTA startWithAppkey:@"I8S419IKSRTD"];
    
    // 进入后台60s再次打开视为新会话
    [[MTAConfig getInstance] setSessionTimeoutSecs:60];
    
    // 统计策略
    [[MTAConfig getInstance] setReportStrategy:MTA_STRATEGY_APP_LAUNCH|MTA_STRATEGY_ONLY_WIFI];
    
    // 推送统计
    [[MTAConfig getInstance] setPushDeviceToken:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    // 安装渠道
    [[MTAConfig getInstance] setChannel:@"AppStore"];
    
    // 用户画像
    [self performSelector:@selector(reportQQ_local:) withObject:nil afterDelay:10];
    
    // 错误报告
#warning 注释掉错误日志上报成功回调打印的错误日志信息（因为生成的live_report.plcrash文件夹为空字符串，转换为json时崩溃）
//    [self MTA_errorReportor];
}

- (void)reportQQ_local:(NSString *)qq
{
    if (USER_MANAGER.phone)
    {
        [[MTAConfig getInstance] setCustomerUserID:USER_MANAGER.phone];
        [[MTAConfig getInstance] setCustomerAppVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        if (USER_MANAGER.qq && USER_MANAGER.qq.length > 4)
        {
            NSLog(@"USER_MANAGER.qq:%@",USER_MANAGER.qq);
            [MTA reportQQ:USER_MANAGER.qq];
//            [MTA reportQQ:@"3122577920"];
        }
    }
    else
    {
        [self performSelector:@selector(reportQQ_local:) withObject:nil afterDelay:5];
    }
}

- (void)MTA_errorReportor
{
    void (^errorCallback)(NSString *) = ^(NSString * errorString)
    {
        NSLog(@"error_callback %@",errorString);
    };
    [[MTAConfig getInstance] setCrashCallback: errorCallback];
}

- (void)MTA_page_beginFrom:(NSString *)obj with:(NSString *)sup
{
    if ([sup isEqual:NSStringFromClass([DotCViewController class])])
    {
        [MTA trackPageViewBegin:obj];
    }
}


- (void)MTA_page_endFrom:(NSString *)obj with:(NSString *)sup
{
    if ([sup isEqual:NSStringFromClass([DotCViewController class])])
    {
        [MTA trackPageViewEnd:obj];
    }
}

- (void)MTA_touch_From:(id)event
{
    [self MTA_touch_From:event by:nil];
}

- (void)MTA_touch_From:(id)event by:(NSDictionary *)data
{
    [MTA trackCustomKeyValueEvent:event props:data];
}
@end