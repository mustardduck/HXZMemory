//
//  UserInfo.h
//  miaozhuan
//
//  Created by abyss on 14/11/17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

#define USER_MANAGER [UserInfo shareInstance]
+ (instancetype)shareInstance;

@property (assign, nonatomic, readonly) BOOL isVip;
@property (assign, nonatomic, readonly) BOOL isJin;
@property (assign, nonatomic, readonly) BOOL isYin;
@property (assign, nonatomic, readonly) BOOL isZhi;
@property (assign, nonatomic, readonly) int64_t vipLevel;
@property (retain, nonatomic, readonly) NSString* qq;
@property (retain, nonatomic, readonly) NSString* CustomerId;
@property (retain, nonatomic, readonly) NSString* EnterprisePic;
@property (retain, nonatomic, readonly) NSString* EnterpriseId;
@property (retain, nonatomic, readonly) NSString* userPic;
@property (retain, nonatomic, readonly) NSString* userName;
@property (retain, nonatomic, readonly) NSString* phone;
@property (assign, nonatomic, readonly) BOOL IsPhoneVerified;
@property (assign, nonatomic, readonly) BOOL IsNameVerified;
@property (assign, nonatomic, readonly) BOOL IsEnterpriseId;
@property (assign, nonatomic, readonly) BOOL IsExchangeAdmin;

@property (assign, nonatomic, readonly) int setPayPwdStatus;//支付密码状态：0-未设置，1-已设置(3.3新增)
@property (assign, nonatomic, readonly) BOOL HasBuyHugeGold;//商家是否买过大额金币(3.3新增)
@property (assign, nonatomic, readonly) BOOL HasGoldOrder;//是否有金币订单(3.3新增)
@property (retain, nonatomic, readonly) NSString* GoldOrderLastDate;//金币订单最后完成时间(3.3新增)
@property (assign, nonatomic, readonly) BOOL HasMerchantGoldOrder;//商家是否有金币订单(3.3新增)
@property (retain, nonatomic, readonly) NSString* MerchantGoldOrderLastDate;//商家金币订单最后完成时间(3.3新增)



- (void)refreshInfo;
- (UIImage *)getVipPic:(ino64_t)level;
@end
