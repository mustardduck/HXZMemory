//
//  AppUtils.h
//  miaozhuan
//
//  Created by xm01 on 15-1-10.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFReachabilityManager.h"

@interface AppUtils : NSObject

//获取实例
+ (instancetype)getInstance;

//获取网络状态
-(AFReachabilityStatus) getNetStatus;

-(void)setNetStatus:(AFReachabilityStatus)status;

-(NSMutableArray *)getResendList;

-(BOOL)getErrorIsShow;

-(void)setErrorIsShow:(BOOL)isShow;

+(CGSize)textWidthSize:(NSString *)contentText height:(CGFloat)height fontSize:(UIFont *)font;

//计算text的高度By Char
+(CGFloat)textHeightByChar:(NSString*)contentText width:(CGFloat)width fontSize:(UIFont *)font;

//计算text的宽度By Char
+(CGFloat)textWidthByChar:(NSString*)contentText height:(CGFloat)height fontSize:(UIFont *)font;

//线条 横线
+(UIView *)LineView:(CGFloat)y;

//线条 横线
+(UIView *)LineView:(CGFloat)y w:(CGFloat)w;

+(UIView *)LineView:(CGFloat)x y:(CGFloat)y;

//线条 竖线
+(UIView *)LineView_Vertical:(CGFloat)x y:(CGFloat)y h:(CGFloat)h;

//比较时间返回最大
+(NSString *)theMaxTimeStamp:(NSString *)timeStr;

//@property(nonatomic, retain) MJRefreshController *requestMjCon;

//@property(nonatomic, retain) NSMutableArray *requestsArray;

//计算千分位
+(NSString *)calculateThousands:(NSString *)number;

//获取网络状态
+(NSString *)getNetWorkStates;

@end
