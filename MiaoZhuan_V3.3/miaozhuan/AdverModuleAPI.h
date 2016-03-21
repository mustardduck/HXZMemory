//
//  AdverModuleAPI.h
//  miaozhuan
//
//  Created by apple on 14/10/24.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AdverModuleAPI : NSObject
@end

extern NSString* ADVERT_MODULE;

#define DECLARE_ADAPI(name, args) \
extern NSString* ADOP_##name;\
void ADAPI_##name args

#define IMPLEMENT_ADAPI(name, args) \
NSString* ADOP_##name = @#name;\
void ADAPI_##name args \

#pragma mark 登出

//退出登录
#define ADOP_adv3_Logout @"ADOP_adv3_Logout"
void ADAPI_adv3_Logout(DelegatorID delegatorID);

#pragma mark - 登录注册

//注册自动感恩
#define ADOP_adv3_autothanks @"ADOP_adv3_autothanks"
void ADAPI_adv3_autothanks (DelegatorID delegatorID,NSString * phoneNumber);

//注册验证及分享朋友圈
#define ADOP_adv3share_registerShare @"ADOP_adv3share_registerShare"
void ADAPI_adv3share_registerShare(DelegatorID delegatorID,NSString * phoneNumber);

//注册用户
#define ADOP_adv3_MemberRegister @"ADOP_adv3_MemberRegister"
void ADAPI_adv3_MemberRegister(DelegatorID delegatorID,NSString * phoneNumber,NSString * password);

//获取单个偏好设置
#define ADOP_adv3_CustomerSurvey_GetQuestion @"ADOP_adv3_CustomerSurvey_GetQuestion"
void ADAPI_adv3_CustomerSurvey_GetQuestion(DelegatorID delegatorID,NSString * QuestionId,NSString * AdvertId);

//完善基础资料
#define ADOP_adv3_PerfectInformation @"ADOP_adv3_PerfectInformation"
void ADAPI_adv3_PerfectInformation(DelegatorID delegatorID,NSString * TrueName,NSString * Gender,NSString * Birthday,NSString * AnnualIncome);

//完善详细资料
#define ADOP_adv3_Customer_FillDetailsInfo @"ADOP_adv3_Customer_FillDetailsInfo"
void ADAPI_adv3_Customer_FillDetailsInfo(DelegatorID delegatorID,NSString * PhotoId,NSString * TrueName,NSString * Gender,NSString *Birthday,NSString *ProvinceId,NSString *CityId,NSString *DistrictId,NSString *OtherPhone,NSString *QQ,NSString *Email,NSString *Weibo,NSString *Weixin);

//获取我感恩的用户信息
#define ADOP_adv3_GetRecommendedComInfo @"ADOP_adv3_GetRecommendedComInfo"
void ADAPI_adv3_GetRecommendedComInfo(DelegatorID delegatorID);

//提交感恩信息
#define ADOP_adv3_MemberCampaignSave @"ADOP_adv3_MemberCampaignSave"
void ADAPI_adv3_MemberCampaignSave(DelegatorID delegatorID,NSString* CampaignType, NSString* thanksInfo);

//感恩粉丝统计
#define ADOP_adv3_MemberCampaign_Summary @"ADOP_adv3_MemberCampaign_Summary"
void ADAPI_adv3_MemberCampaign_Summary(DelegatorID delegatorID,NSString * Type , NSString * StartTime,NSString * EndTime);

//提醒粉丝手机验证
#define ADOP_adv3_1_MemberCampaign_RemindFansPhoneVerify @"ADOP_adv3_1_MemberCampaign_RemindFansPhoneVerify"
void ADAPI_adv3_1_MemberCampaign_RemindFansPhoneVerify(DelegatorID delegatorID,NSString * FansCustomerId);

//获取商家各种图片资源
#define ADOP_adv3_3_Enterprise_PicRes @"ADOP_adv3_3_Enterprise_PicRes"
void ADAPI_adv3_3_Enterprise_PicRes (DelegatorID delegatorID,NSArray * array);

//添加商家经营场所
#define ADOP_adv3_3_Enterprise_AddPlacePic @"ADOP_adv3_3_Enterprise_AddPlacePic"
void ADAPI_adv3_3_Enterprise_AddPlacePic (DelegatorID delegatorID, NSString *PicId);


//删除经营场所图片
#define ADOP_adv3_3_Enterprise_DeletePlacePic @"ADOP_adv3_3_Enterprise_DeletePlacePic"
void ADAPI_adv3_3_Enterprise_DeletePlacePic (DelegatorID delegatorID, NSString *PicId);


////粉丝明细
//#define ADOP_adv3_MemberCampaign_Level1Report @"ADOP_adv3_MemberCampaign_Level1Report"
//void ADAPI_adv3_MemberCampaign_Level1Report(DelegatorID delegatorID);

//登录
#define ADOP_adv3_startlogin @"ADOP_adv3_startlogin"
void ADAPI_adv3_startlogin(DelegatorID delegatorID,NSString * userName ,NSString *password);

//获取图片验证码
#define ADOP_adv3_GetCaptcha @"ADOP_adv3_GetCaptcha"
void ADAPI_adv3_GetCaptcha(DelegatorID delegatorID,NSString * Phone);

//设置新密码
#define ADOP_adv3_ResetPassword @"ADOP_adv3_ResetPassword"
void ADAPI_adv3_ResetPassword(DelegatorID delegatorID,NSString * UserName,NSString * Password,NSString *ValidateCode);

//找回支付密码第一步
#define ADOP_adv3_PaymentFindPayPwdStep1 @"ADOP_adv3_PaymentFindPayPwdStep1"
void ADAPI_adv3_PaymentFindPayPwdStep1(DelegatorID delegatorID,NSString *validateCode);

//找回支付密码第二步
#define ADOP_adv3_PaymentFindPayPwdStep2 @"ADOP_adv3_PaymentFindPayPwdStep2"
void ADAPI_adv3_PaymentFindPayPwdStep2(DelegatorID delegatorID,NSString *secAnswer,NSString * securityCode);

//找回支付密码第三步
#define ADOP_adv3_PaymentFindPayPwdStep3 @"ADOP_adv3_PaymentFindPayPwdStep3"
void ADAPI_adv3_PaymentFindPayPwdStep3(DelegatorID delegatorID,NSString *newPayPwd,NSString * securityCode);

//用户修改支付密码
#define ADOP_adv3_PaymentResetPayPwd @"ADOP_adv3_PaymentResetPayPwd"
void ADAPI_adv3_PaymentResetPayPwd (DelegatorID delegatorID,NSString * originPayPwd,NSString *newPayPwd);


//设置安全问题
//#define ADOP_adv3_PaymentSetSecAnswer @"ADOP_adv3_PaymentSetSecAnswer"
//void ADAPI_adv3_PaymentSetSecAnswer (DelegatorID delegatorID,NSString * secQuestion, NSString * secAnswer);

//获取用户安全问题
#define ADOP_adv3_PaymentGetSecQuestion @"ADOP_adv3_PaymentGetSecQuestion"
void ADAPI_adv3_PaymentGetSecQuestion (DelegatorID delegatorID);

//用户获取商家图片资源
#define ADOP_adv3_EnterpriseCustomerGetPicRes @"ADOP_adv3_EnterpriseCustomerGetPicRes"
void ADAPI_adv3_EnterpriseCustomerGetPicRes (DelegatorID delegatorID,NSString * enterpriseId, NSArray * array);

//联系客服找回支付密码
#define ADOP_adv3_PaymentAskForPayPwd @"ADOP_adv3_PaymentAskForPayPwd"
void ADAPI_adv3_PaymentAskForPayPwd (DelegatorID delegatorID);

//设置支付密码
#define ADOP_adv3_PaymentSetPayPwd @"ADOP_adv3_PaymentSetPayPwd"
void ADAPI_adv3_PaymentSetPayPwd (DelegatorID delegatorID,NSString * payPwd, NSString * secQuestion, NSString * secAnswer,NSString * ValidateCode);

//修改密码
#define ADOP_adv3_CustomerCommon_ResetPassword @"ADOP_adv3_CustomerCommon_ResetPassword"
void ADAPI_adv3_CustomerCommon_ResetPassword (DelegatorID delegatorID,NSString * Password,NSString *ValidateCode);

//获取实名认证信息
#define ADOP_adv3_GetIdentityVerifyInfo @"ADOP_adv3_GetIdentityVerifyInfo"
void ADAPI_adv3_GetIdentityVerifyInfo(DelegatorID delegatorID);

//提交手机认证
#define ADOP_adv3_VerifyPhone @"ADOP_adv3_VerifyPhone"
void ADAPI_adv3_VerifyPhone(DelegatorID delegatorID,NSString * ValidateCode);

//提交实名认证
#define ADOP_adv3_Customer_VerifyIdentity @"ADOP_adv3_Customer_VerifyIdentity"
void ADAPI_adv3_Customer_VerifyIdentity(DelegatorID delegatorID,NSString * TrueName,NSString *IdentityNo,NSString *FrontPicId,NSString *BackPicId);

//帮助/反馈
#define ADOP_adv3_CommonAbout_Suggest @"ADOP_adv3_CommonAbout_Suggest"
void ADAPI_adv3_CommonAbout_Suggest(DelegatorID delegatorID,NSString * Message);


#pragma mark 易货额度

//我的易货码首页
#define ADOP_adv3_3_BarterCodeIndex @"ADOP_adv3_3_BarterCodeIndex"
void ADAPI_adv3_3_BarterCodeIndex(DelegatorID delegatorID);


//易货额度首页
#define ADOP_adv3_3_BarterQuota_Index @"ADOP_adv3_3_BarterQuota_Index"
void ADAPI_adv3_3_BarterQuota_Index(DelegatorID delegatorID);


//获取易货额度价格
#define ADOP_adv3_3_BarterQuota_PriceList @"ADOP_adv3_3_BarterQuota_PriceList"
void ADAPI_adv3_3_BarterQuota_PriceList(DelegatorID delegatorID);



#pragma mark 兑换管理员相关

//获取商家现场兑换订单信息
#define ADOP_adv3_ExchangeManagement_GetExchangeRecordDetail @"ADOP_adv3_ExchangeManagement_GetExchangeRecordDetail"
void ADAPI_adv3_ExchangeManagement_GetExchangeRecordDetail (DelegatorID delegatorID,NSString * OrderNumber,NSString * ExchangeAddressId);

//获取商家邮寄兑换订单信息
#define ADOP_adv3_ExchangeManagement_GetSilverOrderDetail @"ADOP_adv3_ExchangeManagement_GetSilverOrderDetail"
void ADAPI_adv3_ExchangeManagement_GetSilverOrderDetail (DelegatorID delegatorID,NSString * OrderNumber);

//商家确认兑换
#define ADOP_adv3_ExchangeManagement_ConfirmExchange @"ADOP_adv3_ExchangeManagement_ConfirmExchange"
void ADAPI_adv3_ExchangeManagement_ConfirmExchange(DelegatorID delegatorID,NSString * EnterpriseId,NSString * OrderNumber,NSString * ExchangeAddressId,NSString * LogisticsCompany,NSString * WaybillNumber);

//获取兑换订单收货地址
#define ADOP_adv3_ExchangeManagement_GetDeliveryAddress @"ADOP_adv3_ExchangeManagement_GetDeliveryAddress"
void ADAPI_adv3_ExchangeManagement_GetDeliveryAddress(DelegatorID delegatorID,NSString * OrderNumber);

//更改兑换订单收货地址
#define ADOP_adv3_ExchangeManagement_ChangeDeliveryAddress @"ADOP_adv3_ExchangeManagement_ChangeDeliveryAddress"
void ADAPI_adv3_ExchangeManagement_ChangeDeliveryAddress(DelegatorID delegatorID,NSString * OrderNumber,NSString * ContactName,NSString * ContactPhone,NSString * Province,NSString * City,NSString * District,NSString * Address);

//商家备忘已撤销的银元兑换订单
#define ADOP_adv3_ExchangeManagement_AddNotes @"ADOP_adv3_ExchangeManagement_AddNotes"
void ADAPI_adv3_ExchangeManagement_AddNotes(DelegatorID delegatorID,NSString * OrderNumber,NSString * Notes);

//查询订单收货信息接口
#define ADOP_adv3_GoldOrder_GetOrderDeliveryAddress @"ADOP_adv3_GoldOrder_GetOrderDeliveryAddress"
void ADAPI_adv3_GoldOrder_GetOrderDeliveryAddress (DelegatorID delegatorID,NSString * OrderId);

//商家修改收货地址接口
#define ADOP_adv3_GoldOrder_EnterpriseUpdateOrderAddress @"ADOP_adv3_GoldOrder_EnterpriseUpdateOrderAddress"
void ADAPI_adv3_GoldOrder_EnterpriseUpdateOrderAddress (DelegatorID delegatorID,NSString * OrderId,NSString * ContactName,NSString * ContactPhone,NSString * province,NSString * City,NSString * District,NSString * Address);

//商家发货接口
#define ADOP_adv3_GoldOrder_EnterpriseDeliver @"ADOP_adv3_GoldOrder_EnterpriseDeliver"
void ADAPI_adv3_GoldOrder_EnterpriseDeliver (DelegatorID delegatorID,NSString * OrderId,NSString * CompanyName,NSString * BillNo);

//商家订单处理接口
#define ADOP_adv3_GoldOrder_EnterpriseOrderOperate @"ADOP_adv3_GoldOrder_EnterpriseOrderOperate"
void ADAPI_adv3_GoldOrder_EnterpriseOrderOperate (DelegatorID delegatorID,NSString * OrderId,NSString * OperateType);

//商家关闭发货备忘接口
#define ADOP_adv3_GoldOrder_EnterpriseCloseComent @"ADOP_adv3_GoldOrder_EnterpriseCloseComent"
void ADAPI_adv3_GoldOrder_EnterpriseCloseComent (DelegatorID delegatorID, NSString * OrderId,NSString * CloseComent);


#pragma mark 兑换商城
//获取是否有新订单状态
#define ADOP_adv3_MallManagement_GetUnreadSummary @"ADOP_adv3_MallManagement_GetUnreadSummary"
void ADAPI_adv3_MallManagement_GetUnreadSummary(DelegatorID delegatorID,NSString * EnterpriseId);

//获取邮寄兑换订单状态计数
#define ADOP_adv3_MallManagement_CountSilverMailExchange @"ADOP_adv3_MallManagement_CountSilverMailExchange"
void ADAPI_adv3_MallManagement_CountSilverMailExchange(DelegatorID delegatorID,NSString * EnterpriseId);

//金币交易商家查询订单详情接口
#define ADOP_adv3_GoldOrder_GetOrderDetails @"ADOP_adv3_GoldOrder_GetOrderDetails"
void ADAPI_adv3_GoldOrder_GetOrderDetails(DelegatorID delegatorID,NSString * OrderId);

//物流公司列表
#define ADOP_adv3_MyGoldMall_GetCompanys @"ADOP_adv3_MyGoldMall_GetCompanys"
void ADAPI_adv3_MyGoldMall_GetCompanys(DelegatorID delegatorID);

//用户咨询主页
#define ADOP_adv3_GoldMall_ConsultSnap @"ADOP_adv3_GoldMall_ConsultSnap"
void ADAPI_adv3_GoldMall_ConsultSnap (DelegatorID delegatorID,NSString * ProductId,NSString * type);

//未读消息总数
#define ADOP_UnReadMessage @"ADOP_UnReadMessage"
void ADAPI_UnReadMessage(DelegatorID delegatorID);




#pragma mark 运维相关

//按内容Code列表获取内容
#define ADOP_adv3_Operator_GetContentListByContentCode @"ADOP_adv3_Operator_GetContentListByContentCode"
void ADAPI_adv3_Operator_GetContentListByContentCode (DelegatorID delegatorID,NSString * ContentCode);

//按内容code获取bannner（3.1通用接口）
#define ADOP_adv3_1_Operator_GetBanner @"ADOP_adv3_1_Operator_GetBanne"
void ADAPI_adv3_1_Operator_GetBanne (DelegatorID delegatorID,NSString * CategoryCode);

//按分类Code获取Banner(单个内容)
#define ADOP_adv3_Operator_GetBannerByContentCode @"ADOP_adv3_Operator_GetBannerByContentCode"
void ADAPI_adv3_Operator_GetBannerByContentCode (DelegatorID delegatorID,NSString * ContentCode);

//按分类Code获取Banner（多个内容）
#define ADOP_adv3_Operator_GetBannerListByCategoryCode @"ADOP_adv3_Operator_GetBannerListByCategoryCode"
void ADAPI_adv3_Operator_GetBannerListByCategoryCode (DelegatorID delegatorID,NSString * ContentCode);
void ADAPI_adv3_Operator_GetBannerListByCategoryCode_top (DelegatorID delegatorID,NSString * ContentCode);

//注册协议
#define ADOP_adv3_registerGetContentByContentCode @"ADOP_adv3_registerGetContentByContentCode"
void ADAPI_adv3_registerGetContentByContentCode(DelegatorID delegatorID,NSString * ContentCode);

#pragma mark 我的金币相比
//获取已有代理商的省级区域列表
#define ADOP_adv3_CustomerGold_GetProvinceAgentRegionList @"ADOP_adv3_CustomerGold_GetProvinceAgentRegionList"
void ADAPI_adv3_CustomerGold_GetProvinceAgentRegionList(DelegatorID delegatorID);

//根据具体区域获取代理商信息
#define ADOP_adv3_CustomerGold_GetProvinceAgentByCode @"ADOP_adv3_CustomerGold_GetProvinceAgentByCode"
void ADAPI_adv3_CustomerGold_GetProvinceAgentByCode (DelegatorID delegatorID,NSString * Name);


#pragma mark -获取商家相关
//检查用户是否可以创建商家
#define ADOP_adv3_Enterprise_CheckIsCanCreate @"ADOP_adv3_Enterprise_CheckIsCanCreate"
void ADAPI_adv3_Enterprise_CheckIsCanCreate (DelegatorID delegatorID);

//获取商家申请状态
#define ADOP_adv3_GetEnterpriseStatus @"ADOP_adv3_GetEnterpriseStatus"
void ADAPI_adv3_GetEnterpriseStatus(DelegatorID delegatorID);

//获取商家广告统计
#define ADOP_adv3_GetAdvertSummary @"ADOP_adv3_GetAdvertSummary"
void ADAPI_adv3_GetAdvertSummary(DelegatorID delegatorID);

//激活商家
#define ADOP_adv3_Activation @"ADOP_adv3_Activation"
void ADAPI_adv3_Activation(DelegatorID delegatorID);

//获取商家VIP信息
#define ADOP_adv3_GetSummaryStatus @"ADOP_adv3_GetSummaryStatus"
void ADAPI_adv3_GetSummaryStatus(DelegatorID delegatorID);

#pragma mark -客户咨询

//删除咨询
#define ADOP_adv3_DeleteCounsel @"ADOP_adv3_DeleteCounsel"
void ADAPI_adv3_DeleteCounsel(DelegatorID delegatorID,NSString * CounselId,NSString * Type);

//获取客户咨询总情况
#define ADOP_adv3_GetSummaryCounsel @"ADOP_adv3_GetSummaryCounsel"
void ADAPI_adv3_GetSummaryCounsel(DelegatorID delegatorID);

//取消收藏的咨询
#define ADOP_adv3_CancelFavorite @"ADOP_adv3_CancelFavorite"
void ADAPI_adv3_CancelFavorite(DelegatorID delegatorID,NSMutableArray *array);

//获取资讯消息
#define ADOP_adv3_ReadCounsel @"ADOP_adv3_ReadCounsel"
void ADAPI_adv3_ReadCounsel(DelegatorID delegatorID,NSString *CounselId);

//回复咨询消息
#define ADOP_adv3_ReplyCounsel @"ADOP_adv3_ReplyCounsel"
void ADAPI_adv3_ReplyCounsel(DelegatorID delegatorID,NSString *CounselId,NSString *Content);

//商家收藏咨询
#define ADOP_adv3_AddFavorite @"ADOP_adv3_AddFavorite"
void ADAPI_adv3_AddFavorite(DelegatorID delegatorID,NSString *CounselId);

//获取商家历史标签列表
#define ADOP_adv3_GetLabelList @"ADOP_adv3_GetLabelList"
void ADAPI_adv3_GetLabelList(DelegatorID delegatorID);

//商家设置收藏列表
#define ADOP_adv3_SetLabel @"ADOP_adv3_SetLabel"
void ADAPI_adv3_SetLabel(DelegatorID delegatorID,NSMutableArray * array,NSString * LabelName);

#pragma mark 看广告－我的商城
//首页未读信息
#define ADOP_adv3_Order_CountOrders @"ADOP_adv3_Order_CountOrders"
void ADAPI_adv3_Order_CountOrders (DelegatorID delegatorID);

//收货地址列表
#define ADOP_adv3_ShippingAddress_ShippingAddressList @"ADOP_adv3_ShippingAddress_ShippingAddressList"
void ADAPI_adv3_ShippingAddress_ShippingAddressList (DelegatorID delegatorID);

//新增/修改收货地址
#define ADOP_adv3_ShippingAddress_SaveShippingAddress @"ADOP_adv3_ShippingAddress_SaveShippingAddress"
void ADAPI_adv3_ShippingAddress_SaveShippingAddress (DelegatorID delegatorID,NSString * Id,NSString * Name,NSString * Address,NSString * Phone,NSString * ProvinceName,NSString * CityName,NSString * DistrictName);

//获取单个收件地址
#define ADOP_adv3_ShippingAddress_GetShippingAddress @"ADOP_adv3_ShippingAddress_GetShippingAddress"
void ADAPI_adv3_ShippingAddress_GetShippingAddress (DelegatorID delegatorID,NSString * Id);

//设为默认收件地址
#define ADOP_adv3_ShippingAddress_SetPrimary @"ADOP_adv3_ShippingAddress_SetPrimary"
void ADAPI_adv3_ShippingAddress_SetPrimary (DelegatorID delegatorID,NSString * ShippingAddressId);

//删除收货地址
#define ADOP_adv3_ShippingAddress_DeleteShippingAddress @"ADOP_adv3_ShippingAddress_DeleteShippingAddress"
void ADAPI_adv3_ShippingAddress_DeleteShippingAddress (DelegatorID delegatorID,NSString * ShippingAddressId);


//用户获取现场订单详情
#define ADOP_adv3_ExchangeManagement_CustomerGetExchangeOrderDetail @"ADOP_adv3_ExchangeManagement_CustomerGetExchangeOrderDetail"
void ADAPI_adv3_ExchangeManagement_CustomerGetExchangeOrderDetail (DelegatorID delegatorID,NSString * OrderNo);

//用户撤销兑换
#define ADOP_adv3_ExchangeManagement_CustomerCancelExchangeOrder @"ADOP_adv3_ExchangeManagement_CustomerCancelExchangeOrder"
void ADAPI_adv3_ExchangeManagement_CustomerCancelExchangeOrder (DelegatorID delegatorID,NSString * OrderNo);

#pragma mark - 获取短信验证码

//获取短信验证码
#define ADOP_adv3_GetPhoneCode @"ADOP_adv3_GetPhoneCode"
void ADAPI_adv3_GetPhoneCode(DelegatorID delegatorID,NSString * Phone,NSString *CaptchaCode,NSString * Type,NSString * SmsType,NSString * sender);

//验证手机验证码是否正确
#define ADOP_adv3_3_ValidateCode_ValidatePhoneCode @"ADOP_adv3_3_ValidateCode_ValidatePhoneCode"
void ADAPI_adv3_3_ValidateCode_ValidatePhoneCode(DelegatorID delegatorID,NSString * ValidateCode,NSString * PhoneCodeType);

#pragma mark 商家交易

//商家查询订单交易状态对应的数量接口
#define ADOP_adv3_GoldOrder_GetOrderStatusNumbers @"ADOP_adv3_GoldOrder_GetOrderStatusNumbers"
void ADAPI_adv3_GoldOrder_GetOrderStatusNumbers(DelegatorID delegatorID,NSString * EnterpriseId);


#pragma mark - 用户特权

//获取用户激活的感恩层级
#define ADOP_adv3_GetThankfulLevel @"ADOP_adv3_GetThankfulLevel"
void ADAPI_adv3_GetThankfulLevel(DelegatorID delegatorID);

//推荐商家和热门搜索（ 20 个 ）
#define ADOP_EnterpriseRecommend @"ADOP_EnterpriseRecommend"
void ADAPI_EnterpriseRecommend(DelegatorID delegatorID, int type, int pageIndex, int pageSize);

//获取个人偏好设置列表
#define ADOP_adv23_PersonalPreferenceGet @"ADOP_adv23_PersonalPreferenceGet"
void ADAPI_adv23_PersonalPreferenceGet(DelegatorID delegatorID);

//提交个人偏好设置
#define ADOP_PersonalPreferenceSet @"ADOP_PersonalPreferenceSet"
void ADAPI_PersonalPreferenceSet(DelegatorID delegatorID, NSString* questionId, NSArray *array);

//获取商家行业类别列表
#define ADOP_GetIndustryCategoryList @"ADOP_GetIndustryCategoryList"
void ADAPI_GetIndustryCategoryList(DelegatorID delegatorID, int parentId);

//推荐商家Banner
DECLARE_ADAPI(RecommandMerchantBanner, (DelegatorID delegatorID));

//收红包首页
DECLARE_ADAPI(GetRedPacketHome, (DelegatorID delegatorID));

//获取商家基本信息
#define ADOP_GetMerchantInformation @"ADOP_GetMerchantInformation"
void ADAPI_GetMerchantInformation(DelegatorID delegatorID,int merchantID);

//商家拒绝退货
#define ADOP_MerchantDisgreeReturn @"ADOP_MerchantDisgreeReturn"
void ADAPI_MerchantDisgreeReturn(DelegatorID delegatorID, int orderId, NSString* reason, NSArray* pictureIds);

//看广告协商退货详情页面
#define ADOP_NegotiateReturnDetail @"ADOP_NegotiateReturnDetail"
void ADAPI_NegotiateReturnDetail(DelegatorID delegatorID, int orderId);

//发广告协商退货详情页面
#define ADOP_MerchantNegotiateReturnDetail @"ADOP_MerchantNegotiateReturnDetail"
void ADAPI_MerchantNegotiateReturnDetail(DelegatorID delegatorID, int orderId);

//退货售后显示数目
#define ADOP_SalesAndAfterSaleStatusCount @"ADOP_SalesAndAfterSaleStatusCount"
void ADAPI_SalesAndAfterSaleStatusCount(DelegatorID delegatorID);

//根据一级行业类别是否有特殊资质的信息
#define ADOP_GetInformationOfSpecialQualification @"ADOP_GetInformationOfSpecialQualification"
void ADAPI_GetInformationOfSpecialQualification(DelegatorID delegatorID, int industuryId);

//=====================用户===================================//
//物流公司列表
#define ADOP_LogisticsCompanyData @"ADOP_LogisticsCompanyData"
void ADAPI_LogisticsCompanyData(DelegatorID delegatorID);

//售后详情页
#define ADOP_SalesReturnAndAfterSaleDetail @"ADOP_SalesReturnAndAfterSaleDetail"
void ADAPI_SalesReturnAndAfterSaleDetail(DelegatorID delegatorID, int orderId);

//申请退货
#define ADOP_ApplyToReturn @"ADOP_ApplyToReturn"
void ADAPI_ApplyToReturn(DelegatorID delegatorID, NSDictionary *dic);

//确认退货
#define ADOP_ConfirmReturn @"ADOP_ConfirmReturn"
void ADAPI_ConfirmReturn(DelegatorID delegatorID, NSDictionary *dic);

//发起申诉
#define ADOP_UserStartApealing @"ADOP_UserStartApealing"
void ADAPI_UserStartApealing(DelegatorID delegatorID, NSDictionary *dic);

//申请退款
#define ADOP_MallRefund @"ADOP_MallRefund"
void ADAPI_MallRefund(DelegatorID delegatorID, NSDictionary *dic);



#pragma mark - 寻找商家

//获取行业类别列表
#define ADOP_GetIndustryCategoryList @"ADOP_GetIndustryCategoryList"
void ADAPI_GetIndustryCategoryList(DelegatorID delegatorID, int parentId);

//获取所有百度区域列表
#define ADOP_RegionGetAllBaiduRegionList @"ADOP_RegionGetAllBaiduRegionList"
void ADAPI_RegionGetAllBaiduRegionList(DelegatorID delegatorID);

//创建商家
#define ADOP_CreatMerchant @"ADOP_CreatMerchant"
void ADAPI_CreatMerchant(DelegatorID delegatorID, NSDictionary* dataDic);

//获取商家基本信息（创建商家审核不通过）
#define ADOP_GetMerchantBasicInfoToRepost @"ADOP_GetMerchantBasicInfoToRepost"
void ADAPI_GetMerchantBasicInfoToRepost(DelegatorID delegatorID);

//收红包说明
#define ADOP_GetRedPacketStatement @"ADOP_GetRedPacketStatement"
void ADAPI_GetRedPacketStatement(DelegatorID delegatorID);

//根据Code获取内容
#define ADOP_GetContentByCode @"ADOP_GenContentByCode"
void ADAPI_GetContentByCode(DelegatorID delegatorID, NSString* code);

//拆红包
#define ADOP_OpenRedPacket @"ADOP_OpenRedPacket"
void ADAPI_OpenRedPacket(DelegatorID delegatorID, NSString* adsId);

#define ADOP_RedPacketDetail @"ADOP_RedPacketDetail"
void ADAPI_RedPacketDetail(DelegatorID delegatorID, int adsId);

//新增、编辑兑换点
#define ADOP_AddAndEditConvertCenter @"ADOP_AddAndEditConvertCenter"
void ADAPI_AddAndEditConvertCenter(DelegatorID delegatorID,NSDictionary* dataDic);

//删除兑换点
#define ADOP_DeleteConvertCenter @"ADOP_DeleteConvertCenter"
void ADAPI_DeleteConvertCenter(DelegatorID delegatorID, int convertCenterId);

//取消管理
#define ADOP_CanclePermissionOfManager @"ADOP_CanclePermissionOfManager"
void ADAPI_CanclePermissionOfManager(DelegatorID delegatorID, int managerId, int convertCenterId);

//获取兑换点详情
#define ADOP_GetConvertCenterInfo @"ADOP_GetConvertCenterInfo"
void ADAPI_GetConvertCenterInfo(DelegatorID delegatorID, int convertCenterId);

//现金说明
#define ADOP_CashStatement @"ADOP_CashStatement"
void ADAPI_CashStatement(DelegatorID delegatorID);

//爱心账户
#define ADOP_PublicBenifitAccount @"ADOP_PublicBenifitAccount"
void ADAPI_PublicBenifitAccount(DelegatorID delegatorID);

//获取银行卡列表
#define ADOP_GetBankCardList @"ADOP_GetBankCardList"
void ADAPI_GetBankCardList(DelegatorID delegatorID);

//创建银行卡
#define ADOP_AddNewBankCard @"ADOP_AddNewBankCard"
void ADAPI_AddNewBankCard(DelegatorID delegatorID,NSDictionary* dataDic);

//移除银行卡
#define ADOP_RemoveBankCard @"ADOP_RemoveBankCard"
void ADAPI_RemoveBankCard(DelegatorID delegatorID,int bankCardId);

//申请提现
#define ADOP_ApplyToGetCash @"ADOP_ApplyToGetCash"
void ADAPI_ApplyToGetCash(DelegatorID delegatorID,NSDictionary* dataDic);

//竞价热榜
#define ADOP_AdsBidding @"ADOP_AdsBidding"
void ADAPI_AdsBidding(DelegatorID delegatorID, NSString* AdsType, NSString* RegionType, NSString* RegionIds);

//更新广告竞价
#define ADOP_UpdateBiddingPrice @"ADOP_UpdateBiddingPrice"
void ADAPI_UpdateBiddingPrice(DelegatorID delegatorID, NSString* biddingId, NSString* biddingCount, double biddingPrice);

//提现记录
#define ADOP_GetCashRecord @"ADOP_GetCashRecord"
void ADAPI_GetCashRecord(DelegatorID delegatorID, NSString *month);

//验证管理员
#define ADOP_VerifyConvertManagers @"ADOP_VerifyConvertManagers"
void ADAPI_VerifyConvertManagers(DelegatorID delegatorID, NSArray* array);

//仲裁结果
#define ADOP_ApealingResult @"ADOP_ApealingResult"
void ADAPI_ApealingResult(DelegatorID delegatorID, int orderId);


//商家发起仲裁
#define ADOP_MerchantStartApealing @"ADOP_MerchantStartApealing"
void ADAPI_MercahntStartApealing(DelegatorID delegatorID,NSDictionary *dic);



#pragma mark - 银元广告发布与管理

//银元广告发布与管理-首页-获取未读数
#define ADOP_SilverAdvertCountUnread @"ADOP_SilverAdvertCountUnread"
void ADAPI_SilverAdvertCountUnread(DelegatorID delegatorID);

//银元兑换商品管理-首页-获取未读数
#define ADOP_SilverAdvertCountUnreadProducts @"ADOP_SilverAdvertCountUnreadProducts"
void ADAPI_SilverAdvertCountUnreadProducts(DelegatorID delegatorID);

//保存银元兑换商品
#define ADOP_SilverAdvertSaveSilverProduct @"ADOP_SilverAdvertSaveSilverProduct"
void ADAPI_SilverAdvertSaveSilverProduct(DelegatorID delegatorID, NSMutableDictionary * body);

//商家获取兑换商品详情
#define ADOP_SilverAdvertEnterpriseGetProductDetail @"ADOP_SilverAdvertEnterpriseGetProductDetail"
void ADAPI_SilverAdvertEnterpriseGetProductDetail(DelegatorID delegatorID, NSString * prodId);

//删除兑换商品
#define ADOP_SilverAdvertDeleteProduct @"ADOP_SilverAdvertDeleteProduct"
void ADAPI_SilverAdvertDeleteProduct(DelegatorID delegatorID, NSString * prodId);

//删除银元广告
#define ADOP_SilverAdvertDeleteAdvert @"ADOP_SilverAdvertDeleteAdvert"
void ADAPI_SilverAdvertDeleteAdvert(DelegatorID delegatorID, NSString * advertId);

//获取兑换点列表
#define ADOP_SilverAdvertGetExchangeAddress @"ADOP_SilverAdvertGetExchangeAddress"
void ADAPI_SilverAdvertGetExchangeAddress(DelegatorID delegatorID, NSString * pageIndex, NSString * pageSize);

//删除管理员
#define ADOP_DeleteConvertManager @"ADOP_DeleteConvertManager"
void ADAPI_DeleteConvertManager (DelegatorID delegatorID, int managerId);

//银元广告管理-首页-获取未读数
#define ADOP_SilverAdvertCountUnreadAds @"ADOP_SilverAdvertCountUnreadAds"
void ADAPI_SilverAdvertCountUnreadAds(DelegatorID delegatorID);

//保存银元广告
#define ADOP_SilverAdvertSaveSilverAdvert @"ADOP_SilverAdvertSaveSilverAdvert"
void ADAPI_SilverAdvertSaveSilverAdvert(DelegatorID delegatorID, NSMutableDictionary * body);

//商家获取广告详情
#define ADOP_SilverAdvertEnterpriseGetAdvertDetail @"ADOP_SilverAdvertEnterpriseGetAdvertDetail"
void ADAPI_SilverAdvertEnterpriseGetAdvertDetail(DelegatorID delegatorID, NSString * advertId);

//收藏红包广告
#define ADOP_CollectRedPacketAds @"ADOP_CollectRedPacketAds"
void ADAPI_CollectRedPacketAds(DelegatorID delegatorID, int advertId);

//取消收藏红包广告
#define ADOP_CancelCollectRedPacketAds @"ADOP_CancelCollectRedPacketAds"
void ADAPI_CancelCollectRedPacketAds(DelegatorID delegatorID, int advertId);

//获取我的金币信息
#define ADOP_CustomerGoldGetCustomerGoldSummary @"ADOP_CustomerGoldGetCustomerGoldSummary"
void ADAPI_CustomerGoldGetCustomerGoldSummary(DelegatorID delegatorID);

//检查金币赠送双方是否进行手机验证
#define ADOP_CustomerGoldCheckPhoneVerified @"ADOP_CustomerGoldCheckPhoneVerified"
void ADAPI_CustomerGoldCheckPhoneVerified(DelegatorID delegatorID, NSString * phone);


//取消订单
#define ADOP_GoldMallCancel @"ADOP_GoldMallCancel"
void ADAPI_GoldMallCancel(DelegatorID delegatorID, NSString * orderId);

//提醒发货
#define ADOP_GoldMallRemind @"ADOP_GoldMallRemind"
void ADAPI_GoldMallRemind(DelegatorID delegatorID, NSString * orderNo, int orderType);

//延长收货
#define ADOP_GoldMallDelay @"ADOP_GoldMallDelay"
void ADAPI_GoldMallDelay(DelegatorID delegatorID, NSString * orderId);

//确认收货
#define ADOP_GoldMallEnsure @"ADOP_GoldMallEnsure"
void ADAPI_GoldMallEnsure(DelegatorID delegatorID, NSString * orderId,NSString * PayPwd);

//退货原因
#define ADOP_MyGoldMallGetReturnReasons @"ADOP_MyGoldMallGetReturnReasons"
void ADAPI_MyGoldMallGetReturnReasons(DelegatorID delegatorID, int returnType);

//删除记录
#define ADOP_GoldMallDelete @"ADOP_GoldMallDelete"
void ADAPI_GoldMallDelete(DelegatorID delegatorID,  NSString * orderNo, int orderType);

//刷新订单状态
#define ADOP_GoldMallRefresh @"ADOP_GoldMallRefresh"
void ADAPI_GoldMallRefresh(DelegatorID delegatorID, NSString * orderNo, int orderType);

//获取订单详情
#define ADOP_GoldMallOrderDetail @"ADOP_GoldMallOrderDetail"
void ADAPI_GoldMallOrderDetail(DelegatorID delegatorID, NSString * orderNo, NSInteger productType);


//------------------ 易货商城商品管理 ------------------

//查询商品管理各状态下的数量
#define ADOP_GoldSearchProductCount         @"ADOP_GoldSearchProductCount"
void ADAPI_GoldSearchProductCount(DelegatorID delegatorID);

//详情
#define ADOP_GoldCommodityDetail            @"ADOP_GoldCommodityDetail"
void ADAPI_GoldCommodityDetail(DelegatorID delegatorID, int productId);

//修改商品名称及规格名称
#define ADOP_UpdateCommodityProductName
void ADAPI_UpdateCommodityProductName(DelegatorID delegatorID, int productId, NSString *productName, NSArray *specList);

//修改商品
#define ADOP_UpdateCommodity                @"ADOP_UpdateCommodity"
void ADAPI_UpdateCommodity(DelegatorID delegatorID, int productId, CGFloat deliveryPrice, int offlineType, NSString *dateTime, NSArray *standardList);

//预览宝贝
#define ADOP_PreviewCommodity               @"ADOP_PreviewCommodity"
void ADAPI_PreviewCommodity (DelegatorID delegatorID, int productId);

//收藏宝贝
#define ADOP_FavoriteCommodity              @"ADOP_FavoriteCommodity"
void ADAPI_FavoriteCommodity (DelegatorID delegatorID, int productId, int AdvertType);

//取消收藏宝贝
#define ADOP_UnFavoriteCommodity            @"ADOP_UnFavoriteCommodity"
void ADAPI_UnFavoriteCommodity (DelegatorID delegatorID, int productId, int AdvertType);

//重新发起上架申请
#define ADOP_ResendPutaway                  @"ADOP_ResendPutaway"
void ADAPI_ResendPutaway(DelegatorID delegatorID, int productId);

//
//收藏宝贝-new
void ADAPI_FavoriteCommodity_new (DelegatorID delegatorID, int productId, int advertId,int AdvertType);
//取消收藏宝贝
void ADAPI_UnFavoriteCommodity_new (DelegatorID delegatorID, int productId, int advertId,int AdvertType);