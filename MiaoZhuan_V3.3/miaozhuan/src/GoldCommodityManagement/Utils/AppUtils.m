//
//  AppUtils.m
//  miaozhuan
//
//  Created by xm01 on 15-1-10.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "AppUtils.h"

@implementation AppUtils

AFReachabilityStatus netStatus;
bool                 errorIsShow;
NSMutableArray       *resendList;

//实例
+(instancetype)getInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        
        //RequestFiled 是否显示
        errorIsShow = NO;
        
        resendList = [[NSMutableArray alloc] init];
        
        [[AFReachabilityManager sharedManager] startMonitoring];
        [[AFReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFReachabilityStatus status) {
            netStatus = status;
        }];

    });
    return sharedInstance;
}

-(AFReachabilityStatus) getNetStatus
{
    return netStatus;
}

-(void)setNetStatus:(AFReachabilityStatus)status
{
    netStatus = status;
}

-(BOOL)getErrorIsShow
{
    return errorIsShow;
}

-(void)setErrorIsShow:(BOOL)isShow
{
    errorIsShow = isShow;
}

-(NSMutableArray *)getResendList
{
    return resendList;
}

+(CGSize)textWidthSize:(NSString *)contentText height:(CGFloat)height fontSize:(UIFont *)font
{
    CGSize size= [contentText sizeWithFont:font constrainedToSize:CGSizeMake(30000.0f, height) lineBreakMode:UILineBreakModeWordWrap];//UILineBreakModeCharacterWrap
    return size;
}

//计算text的高度By Char
+(CGFloat)textHeightByChar:(NSString*)contentText width:(CGFloat)width fontSize:(UIFont *)font
{
    CGSize size=[contentText sizeWithFont:font constrainedToSize:CGSizeMake(width, 30000.0f) lineBreakMode:UILineBreakModeWordWrap];//UILineBreakModeCharacterWrap
    CGFloat height = size.height;
    return height;
}

//计算text的宽度By Char
+(CGFloat)textWidthByChar:(NSString*)contentText height:(CGFloat)height fontSize:(UIFont *)font
{
    CGSize size=[contentText sizeWithFont:font constrainedToSize:CGSizeMake(30000.0f, height) lineBreakMode:UILineBreakModeWordWrap];//UILineBreakModeCharacterWrap
    CGFloat width = size.width;
    return width;
}

+(UIView *)LineView:(CGFloat)y
{
    UIView *line_view = [[UIView alloc] initWithFrame:CGRectMake(0, y - 0.5f, 320, 0.5f)];
    line_view.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0f];
    return line_view;
}

+(UIView *)LineView:(CGFloat)y w:(CGFloat)w
{
    UIView *line_view = [[UIView alloc] initWithFrame:CGRectMake(0, y - 0.5f, w, 0.5f)];
    line_view.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0f];
    return line_view;
}

+(UIView *)LineView:(CGFloat)x y:(CGFloat)y
{
    UIView *line_view = [[UIView alloc] initWithFrame:CGRectMake(x, y - 0.5f, 320.0f, 0.5f)];
    line_view.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0f];
    return line_view;
}

+(UIView *)LineView_Vertical:(CGFloat)x y:(CGFloat)y h:(CGFloat)h
{
    UIView *line_view = [[UIView alloc] initWithFrame:CGRectMake(x, y, 0.5f, h)];
    line_view.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0f];
    return line_view;
}

//比较时间返回最大
+(NSString *)theMaxTimeStamp:(NSString *)timeStr
{
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *datepre = [formatter dateFromString:timeStr];
    
    NSDate *datenow = [NSDate date];
    
    NSTimeInterval timePre = [datepre timeIntervalSince1970];
    NSTimeInterval timeNow = [datenow timeIntervalSince1970];
    
    long long int pre = (long long int)timePre;
    
    long long int now = (long long int)timeNow;
    
    if(pre > now)
        return timeStr;
    else
        return  [formatter stringFromDate:[datenow dateByAddingTimeInterval:+60*60*24]];
}

//获取网络状态
+(NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state = @"2g";
                    break;
                case 2:
                    state = @"3g";
                    break;
                case 3:
                    state = @"4g";
                    break;
                case 5:
                {
                    state = @"wifi";
                }
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}


//计算千分位
+(NSString *)calculateThousands:(NSString *)number
{
    
    NSString *numStr = [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:number withAppendStr:nil];
    
    //小数点之后
    NSString *after = @"";
    
    //小数点之前
    NSString *before = numStr;
    
    //拼接后的结果
    NSString *result = @"";
    
    NSString *symbol = @"+";
    
    //负
    if([numStr rangeOfString:@"-"].length > 0)
    {
        symbol = @"-";
        //去掉负数符号
        numStr = [numStr substringFromIndex:1];
    }
    
    NSRange range = [numStr rangeOfString:@"."];
    
    //是否小数
    if(range.length > 0)
    {
        //小数点(包含)之后的字符
        after = [numStr substringFromIndex:range.location];
        
        //小数点(不包含)之前的字符
        before = [numStr substringToIndex:range.location];
    }
    
    //计数count, 有几次","
    int count = 0;
    
    int beforNum = [before intValue];
    
    while (beforNum >= 1000) {
        
        count++;
        
        beforNum = beforNum/1000;
    }
    
    for(int i = 0; i < count; i++)
    {
        //从字符串后往前,每3位数增加一个符号
        before = [NSString stringWithFormat:@"%@,%@",[before substringToIndex:(before.length - (i+1)*3 - i)] ,[before substringFromIndex:(before.length - (i+1)*3 - i)]];
    }
    
    result = [symbol stringByAppendingString:[before stringByAppendingString:after]];
    
    
    return result;
}

@end
