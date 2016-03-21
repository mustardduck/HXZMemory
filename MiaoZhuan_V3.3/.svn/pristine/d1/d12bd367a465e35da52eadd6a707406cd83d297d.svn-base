//
//  CRMTAManager.h
//  miaozhuan
//
//  Created by Abyss on 15-3-6.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define APP_MTA ((CRMTAManager *)APP_DELEGATE.mtaManager)

/* banner点击 **/
#define MTAEVENT_main_banner1           @"main_banner1"                     //首页轮换广告1
#define MTAEVENT_main_banner2           @"main_banner2"                     //首页轮换广告2
#define MTAEVENT_main_banner3           @"main_banner3"                     //首页轮换广告3
#define MTAEVENT_dh_mall_banner         @"dh_mall_banner"                   //兑换商城横幅广告
#define MTAEVENT_main_other_banner      @"main_other_banner"                //首页下方横幅广告
#define MTAEVENT_user_vip_banner1       @"user_vip_banner1"                 //用户特权广告1
#define MTAEVENT_user_vip_banner2       @"user_vip_banner2"                 //用户特权广告2
#define MTAEVENT_yh_mall_banner         @"yh_mall_banner"                   //易贸商城横幅广告

/* 购买与支付 **/
#define MTAEVENT_user_vip_to_pay        @"user_vip_to_pay"                  //用户VIP-立即购买按钮
#define MTAEVENT_user_vip_confirm       @"user_vip_confirm_payment"         //用户VIP-确认支付
#define MTAEVENT_user_vip_fruit_to_pay  @"user_vip_fruit_to_pay"            //感恩果-立即购买按钮
#define MTAEVENT_user_vip_fruit_confirm @"user_vip_fruit_confirm_payment"   //感恩果-确认支付
#define MTAEVENT_business_vip_to_pay    @"business_vip_to_pay"              //商家VIP-立即购买按钮
#define MTAEVENT_business_vip_confirm   @"business_vip_confirm_payment"     //商家VIP-确认支付

/* 常用功能 **/
#define MTAEVENT_mall_exchange          @"mall_exchange"                    //商城兑换
#define MTAEVENT_get_silver             @"get_silver"                       //捡银元
#define MTAEVENT_get_red_packet         @"get_red_packet"                   //拆红包
#define MTAEVENT_red_ad_submit          @"red_ad_submit"                    //红包广告-提交审核按钮
#define MTAEVENT_silver_ad_submit       @"silver_ad_submit"                 //银元广告-提交审核按钮


@interface CRMTAManager : NSObject

- (void)MTA_start;

// MTA on Page
- (void)MTA_page_beginFrom:(NSString *)obj with:(NSString *)sup;
- (void)MTA_page_endFrom:(NSString *)obj with:(NSString *)sup;
- (void)MTA_touch_From:(id)event;
- (void)MTA_touch_From:(id)event by:(NSDictionary *)data;
@end
