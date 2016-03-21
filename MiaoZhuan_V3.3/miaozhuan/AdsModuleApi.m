//
//  AdsModuleApi.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-7.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AdsModuleApi.h"
#import "ServerRequest.h"

@implementation AdsModuleApi

@end

/*******************************************上传图片************************************************/
//图片上传
void ADAPI_Picture_Upload(DelegatorID delegatorID, NSData *body){
    
    //压缩比0.7
    body = UIImageJPEGRepresentation([UIImage imageWithData:body], 0.7f);
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Picture/Upload"
                                                                    body:body];
//    [option addHeadParam:@"Content-Type" value:@"image/png"];
    
    [option addHeadParam:@"Content-Type" value:@"image/jpg"];
    
    option.delegatorID = delegatorID;
    option.timeoutInterval = 300.f;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Picture_Upload forModule:ADVERT_MODULE withOption:option];
}
//删除图片
void ADAPI_Picture_Delete(DelegatorID delegatorID, NSDictionary *params){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Picture/Delete"
                                                              parameters:nil
                                                                    body:params];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Picture_Delete forModule:ADVERT_MODULE withOption:option];
}

/*********************************************看广告************************************************/
//获取闪屏广告
void ADAPI_SplashAdvert_Index(DelegatorID delegatorID){
    
    NSString *url = @"api/SplashAdvert/Index";
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_SplashAdvert_Index forModule:ADVERT_MODULE withOption:option];
}

//检查银元赠送双方是否进行手机验证
void ADAPI_CustomerIntegral_CheckPhoneVerified(DelegatorID delegatorID, NSString *mobile){
    
    NSString *url = [NSString stringWithFormat:@"api/CustomerIntegral/CheckPhoneVerified?Phone=%@",mobile];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CustomerIntegral_CheckPhoneVerified forModule:ADVERT_MODULE withOption:option];
}

//推荐商家
void ADAPI_Enterprise_Recommend(DelegatorID delegatorID, int type, int pageIndex, int pageSize){
    
    NSString *url = [NSString stringWithFormat:@"api/Enterprise/Recommend?Type=%d&PageIndex=%d&PageSize=%d", type, pageIndex, pageSize];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Enterprise_Recommend forModule:ADVERT_MODULE withOption:option];
}

//超值商品
void ADAPI_RecommendProduct_List(DelegatorID delegatorID, int pageIndex, int pageSize){
    
    NSString *url = [NSString stringWithFormat:@"api/RecommendProduct/List?PageIndex=%d&PageSize=%d", pageIndex, pageSize];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_RecommendProduct_List forModule:ADVERT_MODULE withOption:option];
}

//看广告首页接口，组合自多个接口
void ADAPI_CustomerHome_Index(DelegatorID delegatorID){
    
    NSString *url = @"api/CustomerHome/Index";
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CustomerHome_Index forModule:ADVERT_MODULE withOption:option];
}

//分享
void ADAPI_adv2_Share(DelegatorID delegatorID, NSDictionary *goodsInfo){
    
    NSString *urlStr = [NSString stringWithFormat:@"api/Share/GetShare"];
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:urlStr
                                                              parameters:goodsInfo];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv2_Share forModule:ADVERT_MODULE withOption:option];
}

//保存分享
void ADAPI_Share_Stub(DelegatorID delegatorID, NSDictionary *params){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Share/Stub"
                                                              parameters:params];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Share_Stub forModule:ADVERT_MODULE withOption:option];
}

//广告分类
void ADAPI_adv24_advert_categories(DelegatorID delegatorID){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/SilverAdvert/Categories"];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv24_advert_categories forModule:ADVERT_MODULE withOption:option];
    
}

//拉取广告
void ADAPI_adv24_advert_pull(DelegatorID delegatorID, NSDictionary *dataDic){
    
    NSString *url = [NSString stringWithFormat:@"api/SilverAdvert/Pull"];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url
                                                                    body:dataDic
                                   ];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv24_advert_pull forModule:ADVERT_MODULE withOption:option];
    
}

//拉取广告详情
void ADAPI_adv23_enterprise_advertDetail(DelegatorID delegatorID, NSString *adId){
    
    NSString *url = [NSString stringWithFormat:@"api/SilverAdvert/Detail?Id=%@",adId];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    [NET_SERVICE doRequest:ADOP_adv23_enterprise_advertDetail forModule:ADVERT_MODULE withOption:option];
}

//公益广告详情
void ADAPI_adv23_publicServiceAdvertDetails(DelegatorID delegatorID, NSString *adId)
{
    NSString *url = [NSString stringWithFormat:@"api/PublicServiceAdvert/Details?Id=%@",adId];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    [NET_SERVICE doRequest:ADOP_adv23_publicServiceAdvertDetails forModule:ADVERT_MODULE withOption:option];
}

//捡银子
void ADAPI_adv2_GeneratedIntegral(DelegatorID delegatorID,NSDictionary *dataDic){
    
    NSString *url = @"api/SilverAdvert/GeneratedIntegral";
    ServerRequestOption* option = [ServerRequestOption optionFromService:url
                                                              parameters:nil
                                                                    body:dataDic];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv2_GeneratedIntegral forModule:ADVERT_MODULE withOption:option];

}

//支持公益广告
void ADAPI_publicServiceAdvertRead(DelegatorID delegatorID,NSString *adId){
    
    NSString *url = @"api/PublicServiceAdvert/Read";
    ServerRequestOption* option = [ServerRequestOption optionFromService:url
                                                              parameters:nil
                                                                    body:@{@"Id":adId}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_publicServiceAdvertRead forModule:ADVERT_MODULE withOption:option];
    
}



//广告咨询
void ADAPI_adv2_AddAdvertCounsel(DelegatorID delegatorID, NSDictionary *counseInfo){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/CustomerCounsel/Counsel" body:counseInfo];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv2_AddAdvertCounsel forModule:ADVERT_MODULE withOption:option];
}

//商家详情
void ADAPI_adv23_enterprise_index(DelegatorID delegatorID, NSString *enId, NSString *comefrom){
    
    NSString *url = [NSString stringWithFormat:@"api/Enterprise/Detail?EnterpriseId=%@&Comefrom=%@",enId,comefrom];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    [NET_SERVICE doRequest:ADOP_adv23_enterprise_advertDetail forModule:ADVERT_MODULE withOption:option];
    
}

//竞价广告详情
void ADAPI_BannerAdvert_Detail(DelegatorID delegatorID, NSString *adId){
    
    NSString *url = [NSString stringWithFormat:@"api/BannerAdvert/Detail?BiddingId=%@",adId];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    [NET_SERVICE doRequest:ADOP_BannerAdvert_Detail forModule:ADVERT_MODULE withOption:option];
}

#pragma mark - 发广告
/*********************************************发广告************************************************/
//获取所有百度区域列表
void ADAPI_Region_GetAllBaiduRegionList(DelegatorID delegatorID){
    
    NSString *url = @"api/Region/GetAllBaiduRegionList";
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Region_GetAllBaiduRegionList forModule:ADVERT_MODULE withOption:option];
}

//获取百度区域列表
void ADAPI_Region_GetBaiduRegionList(DelegatorID delegatorID, NSString *parentId){
    
    NSString *url = [NSString stringWithFormat:@"api/Region/GetBaiduRegionList?ParentId=%@",parentId];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Region_GetBaiduRegionList forModule:ADVERT_MODULE withOption:option];
}

//获取行业类别列表
void ADAPI_Industry_GetIndustryCategoryList(DelegatorID delegatorID, NSString *parentId){
    
    NSString *url = [NSString stringWithFormat:@"api/Industry/GetIndustryCategoryList?ParentId=%@",parentId];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Industry_GetIndustryCategoryList forModule:ADVERT_MODULE withOption:option];
}

//精准直投快照
void ADAPI_DirectAdvert_Snap(DelegatorID delegatorID){
    
    NSString *url = @"api/DirectAdvert/Snap";
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
//    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_DirectAdvert_Snap forModule:ADVERT_MODULE withOption:option];
}

//访问某个Unread域，清理未读状态
void ADAPI_DirectAdvert_DoRead(DelegatorID delegatorID, int unreadType){
    
    NSString *url = [NSString stringWithFormat:@"api/DirectAdvert/DoRead?UnreadType=%d",unreadType];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_DirectAdvert_DoRead forModule:ADVERT_MODULE withOption:option];
}

//红包广告条数
void ADAPI_adv3_3_DirectAdvert_GetPrice(DelegatorID delegatorID)
{
    NSString *url = @"api/DirectAdvert/GetPrice";
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_3_DirectAdvert_GetPrice forModule:ADVERT_MODULE withOption:option];

}

//购买广告次数的货架
void ADAPI_DirectAdvert_AdvertShelf(DelegatorID delegatorID){
    
    NSString *url = @"api/DirectAdvert/AdvertShelf";
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_DirectAdvert_AdvertShelf forModule:ADVERT_MODULE withOption:option];
}

//购买广告
void ADAPI_DirectAdvert_BuyAdvert(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/DirectAdvert/BuyAdvert"
                                                              parameters:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_DirectAdvert_BuyAdvert forModule:ADVERT_MODULE withOption:option];
}

//获取商家通信信息
void ADAPI_Enterprise_ContactInfo(DelegatorID delegatorID, NSString *enId){
    
    NSString *url = [NSString stringWithFormat:@"api/Enterprise/ContactInfo?EnterpriseId=%@",enId];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Enterprise_ContactInfo forModule:ADVERT_MODULE withOption:option];
}

//保存草稿箱
void ADAPI_DirectAdvert_Save(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/DirectAdvert/Save"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_DirectAdvert_Save forModule:ADVERT_MODULE withOption:option];
}

//获取问卷调查
void ADAPI_DirectAdvert_CustomerQuestion(DelegatorID delegatorID, int type){
    
    NSString *url = [NSString stringWithFormat:@"api/DirectAdvert/CustomerQuestion?Type=%d",type];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_DirectAdvert_CustomerQuestion forModule:ADVERT_MODULE withOption:option];
}

//读取广告
void ADAPI_DirectAdvert_LoadAdvert(DelegatorID delegatorID, NSString *adId) {
    
    NSString *url = [NSString stringWithFormat:@"api/DirectAdvert/LoadAdvert?DirectAdvertId=%@",adId];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_DirectAdvert_LoadAdvert forModule:ADVERT_MODULE withOption:option];
}

//删除广告
void ADAPI_DirectAdvert_DeleteAdvert(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/DirectAdvert/DeleteAdvert"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_DirectAdvert_DeleteAdvert forModule:ADVERT_MODULE withOption:option];
}

//关于精准直投
void ADAPI_DirectAdvert_Intro(DelegatorID delegatorID){
    
    NSString *url = @"api/DirectAdvert/Intro";
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_DirectAdvert_Intro forModule:ADVERT_MODULE withOption:option];
}

//取消订单
#define ADOP_Order_Cancel @"ADOP_Order_Cancel"
void ADAPI_Order_Cancel(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Order/Cancel"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Order_Cancel forModule:ADVERT_MODULE withOption:option];
}

//刷新订单
#define ADOP_Order_Refresh @"ADOP_Order_Refresh"
void ADAPI_Order_Refresh(DelegatorID delegatorID, NSDictionary *dataDic){

    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Order/Refresh"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Order_Refresh forModule:ADVERT_MODULE withOption:option];
}

//删除订单
void ADAPI_Order_Delete(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Order/Delete"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Order_Delete forModule:ADVERT_MODULE withOption:option];
}

///获取问题类型列表
void ADAPI_DirectAdvert_GetQuestionFields(DelegatorID delegatorID){
    
    NSString *url = @"api/DirectAdvert/GetQuestionFields";
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_DirectAdvert_GetQuestionFields forModule:ADVERT_MODULE withOption:option];
}


//赠送金币给好友
void ADAPI_CustomerGoldSendGiftGold(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/CustomerGold/SendGiftGold"
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CustomerGoldSendGiftGold forModule:ADVERT_MODULE withOption:option];
}

//获取金币流通好友列表
void ADAPI_CustomerGoldGetGiftedUserList(DelegatorID delegatorID, NSString *keyWord)
{
    NSString *url = [NSString stringWithFormat:@"api/CustomerGold/GetGiftedUserList?KeyWord=%@",keyWord];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CustomerGoldGetGiftedUserList forModule:ADVERT_MODULE withOption:option];
}

//向好友求赠金币
void ADAPI_CustomerGoldAskGiftGold(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/CustomerGold/AskGiftGold"
                                                              body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CustomerGoldAskGiftGold forModule:ADVERT_MODULE withOption:option];
}


#pragma mark - 我 - 我的银元
/*********************************************我的银元************************************************/
//获取我的银元信息
void ADAPI_CustomerIntegral_GetCustomerIntegral(DelegatorID delegatorID){
    
    NSString *url = @"api/CustomerIntegral/GetCustomerIntegral";
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CustomerIntegral_GetCustomerIntegral forModule:ADVERT_MODULE withOption:option];
}

//赠送银元给好友
void ADAPI_CustomerIntegral_SendGiftIntegral(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/CustomerIntegral/SendGiftIntegral"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CustomerIntegral_SendGiftIntegral forModule:ADVERT_MODULE withOption:option];
}

//获取赠送人员列表
void ADAPI_CustomerIntegral_GetGiftedUserList(DelegatorID delegatorID, NSString *keyWord){
    
    NSString *url = [NSString stringWithFormat:@"api/CustomerIntegral/GetGiftedUserList?KeyWord=%@",keyWord];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CustomerIntegral_GetGiftedUserList forModule:ADVERT_MODULE withOption:option];
}

//向好友求赠银元
void ADAPI_CustomerIntegral_AskGiftIntegral(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/CustomerIntegral/AskGiftIntegral"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CustomerIntegral_AskGiftIntegral forModule:ADVERT_MODULE withOption:option];
}

//获取好友姓名（0-默认 1-检查是否有金币账户(只有赠送金币给好友：传1 其它默认传0）
void ADAPI_CustomerIntegral_GetNameByPhone(DelegatorID delegatorID, NSString *phone, int checkState){
    
    NSString *url = [NSString stringWithFormat:@"api/CustomerIntegral/GetNameByPhone?Phone=%@&CheckState=%d",phone, checkState];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
//    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CustomerIntegral_GetNameByPhone forModule:ADVERT_MODULE withOption:option];
}

#pragma mark - 看广告 - 商城
/*********************************************商城************************************************/

//用户购物点击去支付时跳转通用订单页面准备支付，调用此接口
void ADAPI_Payment_GoCommonOrderShow(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/GoCommonOrderShow"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Payment_GoCommonOrderShow forModule:ADVERT_MODULE withOption:option];
}

//获取未支付的订单去通用订单页面准备支付
void ADAPI_Payment_ShowOrderToPay(DelegatorID delegatorID, NSDictionary *dataDic){

    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/ShowOrderToPay"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Payment_ShowOrderToPay forModule:ADVERT_MODULE withOption:option];
}

//现金支付接入 创建订单，获取第三方支付接口报文，准备跳转第三方支付
void ADAPI_Payment_GoCashPayment(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/GoCashPayment"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Payment_GoCashPayment forModule:ADVERT_MODULE withOption:option];
}

//POS转账支付
void ADAPI_Payment_GoPOSPayment(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/GoBill99POSPayment"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Payment_GoPOSPayment forModule:ADVERT_MODULE withOption:option];
}

//银行转账支付
void ADAPI_Payment_GoBankTransferPayment(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/GoBankTransferPayment"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Payment_GoBankTransferPayment forModule:ADVERT_MODULE withOption:option];
}

//金币支付
void ADAPI_Payment_GoGoldPayment(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/GoBarterCodePayment"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Payment_GoGoldPayment forModule:ADVERT_MODULE withOption:option];
}

//银行转账支付
void ADAPI_Payment_GoSilverPayment(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/GoSilverPayment"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Payment_GoSilverPayment forModule:ADVERT_MODULE withOption:option];
}

//客户端通知支付成功
void ADAPI_Payment_ClientNotify(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/ClientNotify"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Payment_ClientNotify forModule:ADVERT_MODULE withOption:option];
}

//商城订单刷新状态
void ADAPI_Mall_RefreshOrder(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Mall/RefreshOrder"
                                                              parameters:nil
                                                                    body:dataDic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_Mall_RefreshOrder forModule:ADVERT_MODULE withOption:option];
}

//未拆红包数
void ADAPI_DirectAdvert_DirectAdvertUnreadCount(DelegatorID delegatorID){
    
    NSString *url = @"api/DirectAdvert/DirectAdvertUnreadCount";
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [NET_SERVICE doRequest:ADOP_DirectAdvert_DirectAdvertUnreadCount forModule:ADVERT_MODULE withOption:option];
}

//行业类别
void ADAPI_Industry_GetAllIndustryCategoryList(DelegatorID delegatorID){
    
    NSString *url = @"api/Industry/GetAllIndustryCategoryList";
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [NET_SERVICE doRequest:ADOP_Industry_GetAllIndustryCategoryList forModule:ADVERT_MODULE withOption:option];
}

#warning 3.1新增接口
//感恩粉丝统计
void ADAPI_MemberCampaign_Summary(DelegatorID delegatorID, NSString *type, NSString *startTime, NSString *endTime){
    
    NSString *url = [NSString stringWithFormat:@"api/MemberCampaign/Summary?Type=%@&StartTime=%@&EndTime=%@", type, startTime, endTime];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [NET_SERVICE doRequest:ADOP_MemberCampaign_Summary forModule:ADVERT_MODULE withOption:option];
}

//提醒粉丝手机验证
void ADAPI_MemberCampaign_RemindFansPhoneVerify(DelegatorID delegatorID, NSString *fansCustomerId) {
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/MemberCampaign/RemindFansPhoneVerify"
                                                              parameters:nil
                                                                    body:@{@"FansCustomerId":fansCustomerId}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_MemberCampaign_RemindFansPhoneVerify forModule:ADVERT_MODULE withOption:option];
}

//公益组织详情
void ADAPI_PublicServiceOrg_Detail(DelegatorID delegatorID, NSString *orgId, NSString *Comefrom){
    
    NSString *url = [NSString stringWithFormat:@"api/PublicServiceOrg/Detail?PublicServiceOrgId=%@&Comefrom=%@", orgId, Comefrom];
    ServerRequestOption* option = [ServerRequestOption optionFromService:url];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_PublicServiceOrg_Detail forModule:ADVERT_MODULE withOption:option];
}

//添加兑换管理员
void ADAPI_SilverAdvert_AddExchangeManager(DelegatorID delegatorID, NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/SilverAdvert/AddExchangeManager"
                                                              parameters:nil
                                                                    body:dataDic];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_SilverAdvert_AddExchangeManager forModule:ADVERT_MODULE withOption:option];
    
}






















