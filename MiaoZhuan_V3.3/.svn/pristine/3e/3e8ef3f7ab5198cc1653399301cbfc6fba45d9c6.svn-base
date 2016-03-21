//
//  RCAdvertModuleAPI.h
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCAdvertModuleAPI : AdverModuleAPI
@end


// wait to change :     AppDelegate - getGPSposition
//                      EditImageViewController
@interface ServerRequestOption (Addtion)
+ (instancetype) optionFromService:(NSString*)service image:(UIImage *)image;
@end

extern NSString* KEY_RC_RANKLIST;
#pragma mark - 排行榜 ---------------------------------------------------------------------------------

//快照页
#define ADOP_adv3_top @"ADOP_adv3_top"
void ADAPI_adv3_top(DelegatorID delegatorID);

//获取本用户在排行榜的位置
#define ADOP_adv3_CustomerPosition @"ADOP_adv3_CustomerPosition"
void ADAPI_adv3_CustomerPosition(DelegatorID delegatorID, NSInteger type);

//获取用户排名，服务端返回拼接好的字符串，客户端直接显示。
#define ADOP_top_customerPosition @"ADOP_top_customerPosition"
void ADAPI_top_customerPosition(DelegatorID delegatorID, NSInteger typeText);

//返回供用户选择的月列表。
#define ADOP_top_months @"ADOP_top_months"
void ADAPI_adv23_top_months(DelegatorID delegatorID, NSInteger type);

//返回供用户选择的周列表。
#define ADOP_top_weeks @"ADOP_top_weeks"
void ADAPI_adv23_top_weeks(DelegatorID delegatorID, NSInteger type);

extern NSString* KEY_RC_ADVERTCOLLECTION;
#pragma mark - 广告收藏 ---------------------------------------------------------------------------------

//收藏银元广告
#define ADOP_adv3_CollectAdvert @"ADOP_adv3_CollectAdvert"
void ADAPI_adv3_CollectAdvert(DelegatorID delegatorID,NSInteger AdvertId,NSInteger AdvertType);

//取消银元广告收藏
#define ADOP_adv3_RemoveAdvert @"ADOP_adv3_RemoveAdvert"
void ADAPI_adv3_RemoveAdvert(DelegatorID delegatorID,NSInteger AdvertId,NSInteger AdvertType);

//收藏列表 - MJ分页请求
//@"List" ,int AdvertType ,string KeyWord

//过滤收藏
#define ADOP_adv3_Filter @"ADOP_adv3_Filter"
void ADAPI_adv3_Filter(DelegatorID delegatorID);

//移除收藏的广告
#define ADOP_adv3_Remove @"ADOP_adv3_Remove"
void ADAPI_adv3_Remove(DelegatorID delegatorID,NSInteger AdvertId,NSInteger AdvertType);


extern NSString* KEY_RC_VIP;
#pragma mark - VIP特权 ---------------------------------------------------------------------------------

//获取用户特权介绍
#define ADOP_adv3_GetIntro @"ADOP_adv3_GetIntro"
void ADAPI_adv3_GetIntro(DelegatorID delegatorID);

//获取用户VIP等级
#define ADOP_adv3_GetVipLevel @"ADOP_adv3_GetVipLevel"
void ADAPI_adv3_GetVipLevel(DelegatorID delegatorID);

//购买钻石
#define ADOP_adv3_BuyVip @"ADOP_adv3_BuyVip"
void ADAPI_adv3_BuyVip(DelegatorID delegatorID, NSInteger Count);

extern NSString* KEY_RC_DATAANALYSIS;
#pragma mark - 数据分析 ---------------------------------------------------------------------------------

//快照
#define ADOP_adv3_Snap @"ADOP_adv3_Snap"
void ADAPI_adv3_Snap(DelegatorID delegatorID);

//我的商家快照
#define ADOP_adv3_MyBusinessSnap @"ADOP_adv3_MyBusinessSnap"
void ADAPI_adv3_MyBusinessSnap(DelegatorID delegatorID);

//银元广告数据统计快照 - MJ分页请求
//@"SilverAdvert" 

//银元广告详情
#define ADOP_adv3_SilverAdvert @"ADOP_adv3_SilverAdvert"
void ADAPI_adv3_SilverAdvert(DelegatorID delegatorID,NSInteger SilverAdvertId);

//直投广告详情
#define ADOP_adv3_DirectAdvert @"ADOP_adv3_DirectAdvert"
void ADAPI_adv3_DirectAdvert(DelegatorID delegatorID,NSInteger DirectAdvertId);

//银元广告收到收看用户 - MJ分页请求
//@"SilverAdvertPV",int SilverAdvertId

//DirectAdvertSnap - MJ分页请求
//@"DirectAdvertSnap"

//获取商家VIP信息
#define ADOP_adv3_DirectAdvert @"ADOP_adv3_DirectAdvert"
void ADAPI_adv3_DirectAdvert(DelegatorID delegatorID,NSInteger DirectAdvertId);

//DirectAdvertCV - MJ分页请求
//@"DirectAdvertCV",int DirectAdvertId

extern NSString* KEY_RC_BUSINESSINFO;
#pragma mark - 商家信息 ---------------------------------------------------------------------------------

//上传商家Logo图片
#define ADOP_adv3_UploadLogoImage @"ADOP_adv3_UploadLogoImage"
void ADAPI_adv3_UploadLogoImage(DelegatorID delegatorID, UIImage *img);

////创建商家
//#define ADOP_adv3_SaveEnterprise @"ADOP_adv3_SaveEnterprise"
//void ADAPI_adv3_SaveEnterprise(DelegatorID delegatorID,NSMutableDictionary *dic);

//编辑商家
#define ADOP_adv3_EditEnterprise @"ADOP_adv3_EditEnterprise"
void ADAPI_adv3_EditEnterprise(DelegatorID delegatorID,NSMutableDictionary *dic);

//获取商家总的状态
//#define ADOP_adv3_GetSummaryStatus @"ADOP_adv3_GetSummaryStatus"
//void ADAPI_adv3_GetSummaryStatus(DelegatorID delegatorID);
//
////激活商家
//#define ADOP_adv3_Activation @"ADOP_adv3_Activation"
//void ADAPI_adv3_Activation(DelegatorID delegatorID);
//
////获取商家广告统计
//#define ADOP_adv3_GetAdvertSummary @"ADOP_adv3_GetAdvertSummary"
//void ADAPI_adv3_GetAdvertSummary(DelegatorID delegatorID);

//获取商家基本信息
#define ADOP_adv3_GetBasicInfo @"ADOP_adv3_GetBasicInfo"
void ADAPI_adv3_GetBasicInfo(DelegatorID delegatorID, NSString *EnterpriseId);

//注销商家
#define ADOP_adv3_DeleteEnterprise @"ADOP_adv3_DeleteEnterprise"
void ADAPI_adv3_DeleteEnterprise(DelegatorID delegatorID, NSString *Code);

//获取商家兑换承诺书列表
#define ADOP_adv3_GetExchangePromiseList @"ADOP_adv3_GetExchangePromiseList"
void ADAPI_adv3_GetExchangePromiseList(DelegatorID delegatorID);

//获取商家资质列表
#define ADOP_adv3_GetCertificationList @"ADOP_adv3_GetCertificationList"
void ADAPI_adv3_GetCertificationList(DelegatorID delegatorID);

#pragma mark - 其他 ---------------------------------------------------------------------------------

//创建购买商家VIP服务订单
#define ADOP_adv3_CreatePrePayEnterpriseVipOrder @"ADOP_adv3_CreatePrePayEnterpriseVipOrder"
void ADAPI_adv3_CreatePrePayEnterpriseVipOrder(DelegatorID delegatorID,NSInteger ItemCount,NSInteger MonthCount);

#define ADOP_adv3_Me_getCount @"ADOP_adv3_Me_getCount"
void ADAPI_adv3_Me_getCount(DelegatorID delegatorID);
#define HANDLE_SHOW_ERROR() [HUDUtil showErrorWithStatus:wrapper.operationMessage]

#define ADOP_adv3_CancelOrder @"ADOP_adv3_CancelOrder"
void ADAPI_adv3_CancelOrder(DelegatorID delegatorID,NSString *OrderSerialNo);

#define ADOP_adv3_DeleteOrder @"ADOP_adv3_DeleteOrder"
void ADAPI_adv3_DeleteOrder(DelegatorID delegatorID,NSString *OrderSerialNo);

#define ADOP_adv3_RefreshOrder @"ADOP_adv3_RefreshOrder"
void ADAPI_adv3_RefreshOrder(DelegatorID delegatorID,NSString *OrderSerialNo);

#define ADOP_adv3_MessageDelete @"ADOP_adv3_MessageDelete"
void ADAPI_adv3_MessageDelete(DelegatorID delegatorID,NSString *MsgIds, NSInteger type);

#define ADOP_adv3_MessageDeleteType @"ADOP_adv3_MessageDeleteType"
void ADAPI_adv3_MessageDeleteType(DelegatorID delegatorID,NSArray *TypeList);

#pragma mark - 消息中心 ---------------------------------------------------------------------------------
#define ADOP_adv3_Message_Index @"ADOP_adv3_Message_Index"
void ADAPI_adv3_Message_Index(DelegatorID delegatorID);




#pragma mark - added 
//SilverMall
//检查客户端最新版本
#define ADOP_adv3_Checkver @"ADOP_adv3_Checkver"
void ADAPI_adv3_Checkver(DelegatorID delegatorID);


#pragma mark - 商城

//兑换商品详情页
#define ADOP_adv3_CustomerGetProductDetail @"ADOP_adv3_CustomerGetProductDetail"
void ADAPI_adv3_CustomerGetProductDetail(DelegatorID delegatorID,NSInteger ProductId,NSInteger AdvertId);

//上架提醒
#define ADOP_adv3_RecordProductReminder @"ADOP_adv3_RecordProductReminder"
void ADAPI_adv3_RecordProductReminder(DelegatorID delegatorID,NSInteger ProductId,NSInteger AdvertId);

//收藏，取消收藏
//GoldMall
//今日主打商品信息
#define ADOP_adv3_PrimaryProduct @"ADOP_adv3_PrimaryProduct"
void ADAPI_adv3_PrimaryProduct(DelegatorID delegatorID);

//易货商品详细信息
#define ADOP_adv3_GetProduct @"ADOP_adv3_GetProduct"
void ADAPI_adv3_GetProduct(DelegatorID delegatorID,NSInteger ProductId);

//GoldProductManagement/GetProductCatagorys
#define ADOP_adv3_GetProductCatagorys @"ADOP_adv3_GetProductCatagorys"
void ADAPI_adv3_GetProductCatagorys(DelegatorID delegatorID);

//Uuid 	string 	否 	设备唯一码
//AppId 	string 	否 	百度标识
//UserId 	string 	否 	百度用户标识
//ChannelId 	string 	否 	通道标识
//PushVersion 	int 	是 	推送版本
//默认为1
#define ADOP_adv3_push_Update @"ADOP_adv3_push_Update"
void ADAPI_adv3_push_Update(DelegatorID delegatorID,NSString* uuid,NSString* appld,NSString* userid,NSString* cannel,NSString* pushversion);

#define ADOP_adv3_Push_Report @"ADOP_adv3_Push_Report"
void ADAPI_adv3_Push_Report(DelegatorID delegatorID,NSString* customerId,NSString* pushMsgId);




