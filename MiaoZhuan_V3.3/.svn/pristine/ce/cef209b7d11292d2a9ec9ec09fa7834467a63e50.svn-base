//
//  UserInfo.m
//  miaozhuan
//
//  Created by abyss on 14/11/17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "UserInfo.h"
#import "Define+RCMethod.h"

static UserInfo *infoManager = nil;
@interface UserInfo ()
{
    DictionaryWrapper *_infoDic;
}
@end
@implementation UserInfo

+ (instancetype)shareInstance
{
    if (infoManager) [infoManager refreshInfo];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!infoManager)
        {
            infoManager = [[UserInfo alloc] init];
            [infoManager refreshInfo];
        }
    });
    return infoManager;
}

#pragma mark - setter

- (void)refreshInfo
{
    if (!_infoDic)
    {
        [_infoDic retain];
    }
    _infoDic = [APP_DELEGATE.runtimeConfig getDictionaryWrapper:RUNTIME_USER_LOGIN_INFO];
}

- (BOOL)isYin
{
    return [_infoDic getBool:@"IsSilver"];
}

- (BOOL)isJin
{
    return [_infoDic getBool:@"IsGold"];
}

- (BOOL)isZhi
{
    return [_infoDic getBool:@"IsDirect"];
}

- (BOOL)isVip
{
    return [_infoDic getBool:@"IsEnterpriseVip"];
}

- (int)setPayPwdStatus
{
    return [_infoDic getInt:@"SetPayPwdStatus"];
}

- (int64_t)vipLevel
{
    return [_infoDic getInteger:@"VipLevel"];
}

- (NSString *)EnterprisePic
{
    return [_infoDic getString:@"EnterpriseLogoUrl"];
}

- (BOOL)HasBuyHugeGold
{
    return [_infoDic getBool:@"HasBuyHugeGold"];
}

- (BOOL)HasGoldOrder
{
    return [_infoDic getBool:@"HasGoldOrder"];
}

- (BOOL)HasMerchantGoldOrder
{
    return [_infoDic getBool:@"HasMerchantGoldOrder"];
}

- (NSString *)GoldOrderLastDate
{
    return [_infoDic getString:@"GoldOrderLastDate"];
}

- (NSString *)MerchantGoldOrderLastDate
{
    return [_infoDic getString:@"MerchantGoldOrderLastDate"];
}
- (NSString *)qq
{
    return [_infoDic getString:@"QQ"];
}

- (NSString *)CustomerId
{
    return [_infoDic getString:@"CustomerId"];
}


- (NSString *)userPic
{
    return [_infoDic getString:@"PhotoUrl"];
}

- (NSString *)userName
{
    NSString* ret = [_infoDic getString:@"TrueName"];
    if (!ret || [ret isEqualToString:@""]) ret = @"未编辑姓名";
    return [_infoDic getString:@"TrueName"];
}

- (NSString *)phone
{
    return [_infoDic getString:@"UserName"];
}

- (NSString *)EnterpriseId
{
    NSString* ret = @"";
    int EnterpriseId = [_infoDic getInt:@"EnterpriseId"];
    if (EnterpriseId!= -1)
    {
        ret = [NSString stringWithFormat:@"%d",EnterpriseId];
    }
    return ret;
}

- (BOOL)IsPhoneVerified
{
    return [_infoDic getBool:@"IsPhoneVerified"];
}

- (BOOL)IsNameVerified
{
    return (([_infoDic getInt:@"IdentityStatus"]==1)?YES: NO);
}

- (BOOL)IsEnterpriseId
{
    return [_infoDic getInt:@"EnterpriseId"] > 0;
}

- (BOOL)IsExchangeAdmin
{
    return [_infoDic getBool:@"IsExchangeAdmin"];
}

NSArray * USER_MANAGER_VIPICON_ARRAY ()
{
    static NSArray *daysOfTheWeek = nil;
    if ( ! daysOfTheWeek) {
        daysOfTheWeek = [[NSArray alloc] initWithObjects:@"VIP0@2x.png",@"VIP1@2x.png",@"VIP2@2x.png",@"VIP3@2x.png",@"VIP4@2x.png",@"VIP5@2x.png",@"VIP6@2x.png",@"VIP7@2x.png", nil];
    }
    return daysOfTheWeek;
}

- (UIImage *)getVipPic:(ino64_t)level
{
    if (level > 7) return @"";
    UIImage *image = [UIImage imageNamed:USER_MANAGER_VIPICON_ARRAY()[level]];
    return image;
}

#pragma mark - private


- (void)dealloc
{
    [_infoDic release];
    
    [super dealloc];
}

@end
