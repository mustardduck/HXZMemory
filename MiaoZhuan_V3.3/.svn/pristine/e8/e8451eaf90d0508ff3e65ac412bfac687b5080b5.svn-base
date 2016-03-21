//
//  AdsModuleApi.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-7.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 看广告模块
 */

@interface AdsModuleApi : AdverModuleAPI

@end
#pragma mark - 看广告
//获取闪屏广告
#define ADOP_SplashAdvert_Index @"ADOP_SplashAdvert_Index"
void ADAPI_SplashAdvert_Index(DelegatorID delegatorID);

//检查银元赠送双方是否进行手机验证
#define ADOP_CustomerIntegral_CheckPhoneVerified @"ADOP_CustomerIntegral_CheckPhoneVerified"
void ADAPI_CustomerIntegral_CheckPhoneVerified(DelegatorID delegatorID, NSString *mobile);

/*******************************************上传图片************************************************/
//图片上传
#define ADOP_Picture_Upload @"ADOP_Picture_Upload"
void ADAPI_Picture_Upload(DelegatorID delegatorID, NSData *body);
//删除图片
#define ADOP_Picture_Delete @"ADOP_Picture_Delete"
void ADAPI_Picture_Delete(DelegatorID delegatorID, NSDictionary *params);


/*********************************************看广告************************************************/
//推荐商家
#define ADOP_Enterprise_Recommend @"ADOP_Enterprise_Recommend"
void ADAPI_Enterprise_Recommend(DelegatorID delegatorID, int type, int pageIndex, int pageSize);

//超值商品
#define ADOP_RecommendProduct_List @"ADOP_RecommendProduct_List"
void ADAPI_RecommendProduct_List(DelegatorID delegatorID, int pageIndex, int pageSize);

//看广告首页接口，组合自多个接口
#define ADOP_CustomerHome_Index @"ADOP_CustomerHome_Index"
void ADAPI_CustomerHome_Index(DelegatorID delegatorID);

//分享CustomerHome/Index
#define ADOP_adv2_Share @"ADOP_adv2_Share"
void ADAPI_adv2_Share(DelegatorID delegatorID, NSDictionary *goodsInfo);

//分享后保存结果
#define ADOP_Share_Stub @"ADOP_Share_Stub"
void ADAPI_Share_Stub(DelegatorID delegatorID, NSDictionary *params);

//广告分类
#define ADOP_adv24_advert_categories @"ADOP_adv24_advert_categories"
void ADAPI_adv24_advert_categories(DelegatorID delegatorID);

//拉取广告
#define ADOP_adv24_advert_pull @"ADOP_adv24_advert_pull"
void ADAPI_adv24_advert_pull(DelegatorID delegatorID, NSDictionary *dataDic);

//拉取广告详情
#define ADOP_adv23_enterprise_advertDetail @"ADOP_adv23_enterprise_advertDetail"
void ADAPI_adv23_enterprise_advertDetail(DelegatorID delegatorID, NSString *adId);

//公益广告详情
#define ADOP_adv23_publicServiceAdvertDetails @"ADOP_adv23_publicServiceAdvertDetails"
void ADAPI_adv23_publicServiceAdvertDetails(DelegatorID delegatorID, NSString *adId);

//捡银子
#define ADOP_adv2_GeneratedIntegral @"ADOP_adv2_GeneratedIntegral"
void ADAPI_adv2_GeneratedIntegral(DelegatorID delegatorID,NSDictionary *dataDic);

//支持公益广告
#define ADOP_publicServiceAdvertRead @"ADOP_publicServiceAdvertRead"
void ADAPI_publicServiceAdvertRead(DelegatorID delegatorID,NSString *adId);

//广告咨询
#define ADOP_adv2_AddAdvertCounsel @"ADOP_adv2_AddAdvertCounsel"
void ADAPI_adv2_AddAdvertCounsel(DelegatorID delegatorID, NSDictionary *counseInfo);

//商家详情
#define ADOP_adv23_enterprise_index @"ADOP_adv23_enterprise_index"
void ADAPI_adv23_enterprise_index(DelegatorID delegatorID, NSString *enId, NSString *comefrom);

//竞价广告详情
#define ADOP_BannerAdvert_Detail @"ADOP_BannerAdvert_Detail"
void ADAPI_BannerAdvert_Detail(DelegatorID delegatorID, NSString *adId);

#pragma mark - 发广告
/*********************************************发广告************************************************/
//获取所有百度区域列表
#define ADOP_Region_GetAllBaiduRegionList @"ADOP_Region_GetAllBaiduRegionList"
void ADAPI_Region_GetAllBaiduRegionList(DelegatorID delegatorID);

//获取百度区域列表
#define ADOP_Region_GetBaiduRegionList @"ADOP_Region_GetBaiduRegionList"
void ADAPI_Region_GetBaiduRegionList(DelegatorID delegatorID, NSString *parentId);

//获取行业类别列表
#define ADOP_Industry_GetIndustryCategoryList @"ADOP_Industry_GetIndustryCategoryList"
void ADAPI_Industry_GetIndustryCategoryList(DelegatorID delegatorID, NSString *parentId);

//精准直投快照
#define ADOP_DirectAdvert_Snap @"ADOP_DirectAdvert_Snap"
void ADAPI_DirectAdvert_Snap(DelegatorID delegatorID);

//访问某个Unread域，清理未读状态
#define ADOP_DirectAdvert_DoRead @"ADOP_DirectAdvert_DoRead"
void ADAPI_DirectAdvert_DoRead(DelegatorID delegatorID, int unreadType);

//红包广告条数
#define ADOP_adv3_3_DirectAdvert_GetPrice @"ADOP_adv3_3_DirectAdvert_GetPrice"
void ADAPI_adv3_3_DirectAdvert_GetPrice(DelegatorID delegatorID);

//购买广告次数的货架
#define ADOP_DirectAdvert_AdvertShelf @"ADOP_DirectAdvert_AdvertShelf"
void ADAPI_DirectAdvert_AdvertShelf(DelegatorID delegatorID);

//购买广告
#define ADOP_DirectAdvert_BuyAdvert @"ADOP_DirectAdvert_BuyAdvert"
void ADAPI_DirectAdvert_BuyAdvert(DelegatorID delegatorID, NSDictionary *dataDic);

//获取商家通信信息
#define ADOP_Enterprise_ContactInfo @"ADOP_Enterprise_ContactInfo"
void ADAPI_Enterprise_ContactInfo(DelegatorID delegatorID, NSString *enId);

//保存草稿箱
#define ADOP_DirectAdvert_Save @"ADOP_DirectAdvert_Save"
void ADAPI_DirectAdvert_Save(DelegatorID delegatorID, NSDictionary *dataDic);

//获取问卷调查
#define ADOP_DirectAdvert_CustomerQuestion @"ADOP_DirectAdvert_CustomerQuestion"
void ADAPI_DirectAdvert_CustomerQuestion(DelegatorID delegatorID, int type);

//读取广告
#define ADOP_DirectAdvert_LoadAdvert @"ADOP_DirectAdvert_LoadAdvert"
void ADAPI_DirectAdvert_LoadAdvert(DelegatorID delegatorID, NSString *adId);

//删除广告
#define ADOP_DirectAdvert_DeleteAdvert @"ADOP_DirectAdvert_DeleteAdvert"
void ADAPI_DirectAdvert_DeleteAdvert(DelegatorID delegatorID, NSDictionary *dataDic);

//关于精准直投
#define ADOP_DirectAdvert_Intro @"ADOP_DirectAdvert_Intro"
void ADAPI_DirectAdvert_Intro(DelegatorID delegatorID);

//取消订单
#define ADOP_Order_Cancel @"ADOP_Order_Cancel"
void ADAPI_Order_Cancel(DelegatorID delegatorID, NSDictionary *dataDic);

//刷新订单
#define ADOP_Order_Refresh @"ADOP_Order_Refresh"
void ADAPI_Order_Refresh(DelegatorID delegatorID, NSDictionary *dataDic);

//删除订单
#define ADOP_Order_Delete @"ADOP_Order_Delete"
void ADAPI_Order_Delete(DelegatorID delegatorID, NSDictionary *dataDic);

///获取问题类型列表
#define ADOP_DirectAdvert_GetQuestionFields @"ADOP_DirectAdvert_GetQuestionFields"
void ADAPI_DirectAdvert_GetQuestionFields(DelegatorID delegatorID);

#pragma mark - 我 - 我的金币
/*********************************************我的金币************************************************/

//赠送金币给好友
#define ADOP_CustomerGoldSendGiftGold @"ADOP_CustomerGoldSendGiftGold"
void ADAPI_CustomerGoldSendGiftGold(DelegatorID delegatorID, NSDictionary *dataDic);

//获取金币流通好友列表
#define ADOP_CustomerGoldGetGiftedUserList @"ADOP_CustomerGoldGetGiftedUserList"
void ADAPI_CustomerGoldGetGiftedUserList(DelegatorID delegatorID, NSString *keyWord);

//向好友求赠金币
#define ADOP_CustomerGoldAskGiftGold @"ADOP_CustomerGoldAskGiftGold"
void ADAPI_CustomerGoldAskGiftGold(DelegatorID delegatorID, NSDictionary *dataDic);


#pragma mark - 我 - 我的银元
/*********************************************我的银元************************************************/
//获取我的银元信息
#define ADOP_CustomerIntegral_GetCustomerIntegral @"ADOP_CustomerIntegral_GetCustomerIntegral"
void ADAPI_CustomerIntegral_GetCustomerIntegral(DelegatorID delegatorID);

//赠送银元给好友
#define ADOP_CustomerIntegral_SendGiftIntegral @"ADOP_CustomerIntegral_SendGiftIntegral"
void ADAPI_CustomerIntegral_SendGiftIntegral(DelegatorID delegatorID, NSDictionary *dataDic);

//获取赠送人员列表
#define ADOP_CustomerIntegral_GetGiftedUserList @"ADOP_CustomerIntegral_GetGiftedUserList"
void ADAPI_CustomerIntegral_GetGiftedUserList(DelegatorID delegatorID, NSString *keyWord);

//向好友求赠银元
#define ADOP_CustomerIntegral_AskGiftIntegral @"ADOP_CustomerIntegral_AskGiftIntegral"
void ADAPI_CustomerIntegral_AskGiftIntegral(DelegatorID delegatorID, NSDictionary *dataDic);

//获取好友姓名
#define ADOP_CustomerIntegral_GetNameByPhone @"ADOP_CustomerIntegral_GetNameByPhone"
void ADAPI_CustomerIntegral_GetNameByPhone(DelegatorID delegatorID, NSString *phone, int checkState);

#pragma mark - 看广告 - 商城
/*********************************************商城************************************************/

//用户购物点击去支付时跳转通用订单页面准备支付，调用此接口
#define ADOP_Payment_GoCommonOrderShow @"ADOP_Payment_GoCommonOrderShow"
void ADAPI_Payment_GoCommonOrderShow(DelegatorID delegatorID, NSDictionary *dataDic);

//获取未支付的订单去通用订单页面准备支付
#define ADOP_Payment_ShowOrderToPay @"ADOP_Payment_ShowOrderToPay"
void ADAPI_Payment_ShowOrderToPay(DelegatorID delegatorID, NSDictionary *dataDic);

//现金支付接入 创建订单，获取第三方支付接口报文，准备跳转第三方支付
#define ADOP_Payment_GoCashPayment @"ADOP_Payment_GoCashPayment"
void ADAPI_Payment_GoCashPayment(DelegatorID delegatorID, NSDictionary *dataDic);

//银行转账支付
#define ADOP_Payment_GoBankTransferPayment @"ADOP_Payment_GoBankTransferPayment"
void ADAPI_Payment_GoBankTransferPayment(DelegatorID delegatorID, NSDictionary *dataDic);

//POS转账支付
#define ADOP_Payment_GoPOSPayment @"ADOP_Payment_GoPOSPayment"
void ADAPI_Payment_GoPOSPayment(DelegatorID delegatorID, NSDictionary *dataDic);

//金币支付
#define ADOP_Payment_GoGoldPayment @"ADOP_Payment_GoGoldPayment"
void ADAPI_Payment_GoGoldPayment(DelegatorID delegatorID, NSDictionary *dataDic);

//银行转账支付
#define ADOP_Payment_GoSilverPayment @"ADOP_Payment_GoSilverPayment"
void ADAPI_Payment_GoSilverPayment(DelegatorID delegatorID, NSDictionary *dataDic);

//客户端通知支付成功
#define ADOP_Payment_ClientNotify @"ADOP_Payment_ClientNotify"
void ADAPI_Payment_ClientNotify(DelegatorID delegatorID, NSDictionary *dataDic);

//商城订单刷新状态
#define ADOP_Mall_RefreshOrder @"ADOP_Mall_RefreshOrder"
void ADAPI_Mall_RefreshOrder(DelegatorID delegatorID, NSDictionary *dataDic);

//未拆红包数
#define ADOP_DirectAdvert_DirectAdvertUnreadCount @"ADOP_DirectAdvert_DirectAdvertUnreadCount"
void ADAPI_DirectAdvert_DirectAdvertUnreadCount(DelegatorID delegatorID);

//行业类别
#define ADOP_Industry_GetAllIndustryCategoryList @"ADOP_Industry_GetAllIndustryCategoryList"
void ADAPI_Industry_GetAllIndustryCategoryList(DelegatorID delegatorID);

#warning 3.1新增接口
//感恩粉丝统计
#define ADOP_MemberCampaign_Summary @"ADOP_MemberCampaign_Summary"
void ADAPI_MemberCampaign_Summary(DelegatorID delegatorID, NSString *type, NSString *startTime, NSString *endTime);

//提醒粉丝手机验证
#define ADOP_MemberCampaign_RemindFansPhoneVerify @"ADOP_MemberCampaign_RemindFansPhoneVerify"
void ADAPI_MemberCampaign_RemindFansPhoneVerify(DelegatorID delegatorID, NSString *fansCustomerId);

//公益广告详情
#define ADOP_PublicServiceOrg_Detail @"ADOP_PublicServiceOrg_Detail"
void ADAPI_PublicServiceOrg_Detail(DelegatorID delegatorID, NSString *orgId, NSString *Comefrom);

//添加兑换管理员
#define ADOP_SilverAdvert_AddExchangeManager @"ADOP_SilverAdvert_AddExchangeManager"
void ADAPI_SilverAdvert_AddExchangeManager(DelegatorID delegatorID, NSDictionary *dataDic);




























