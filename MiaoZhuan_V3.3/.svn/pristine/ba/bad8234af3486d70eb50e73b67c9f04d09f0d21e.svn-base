//
//  RCAdvertModuleAPI.m
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RCAdvertModuleAPI.h"
#import "NSData+Base64.h"

@implementation RCAdvertModuleAPI
@end

#define DOREQUEST_RC_URL(_key,_url) NSString *op = [NSString stringWithFormat:@"%@%@",_key,_url]
#define DOREQUEST_RC_OPTION() ServerRequestOption* option = [ServerRequestOption optionFromService:op]
#define DOREQUEST_RC_DELEGATOR(_key) \
option.delegatorID = delegatorID; \
[option turnOn:OPTION_NEED_LOADING_INDICATOR]; \
[NET_SERVICE doRequest:_key forModule:ADVERT_MODULE withOption:option]

#define DOREQUEST_RC_DONE(_key) \
DOREQUEST_RC_OPTION(); \
DOREQUEST_RC_DELEGATOR(_key)

#define DOREQUEST_RC_DONE_WITH(_key,_para) \
ServerRequestOption* option = [ServerRequestOption optionFromService:op \
parameters:_para]; \
DOREQUEST_RC_DELEGATOR(_key)

//Hidden
// NSString *op
// ServerRequestOption *option

NSString* KEY_RC_RANKLIST = @"api/Top/";
#pragma mark - 排行榜
#define DOREQUEST_RC_URL_RANKLIST(url) DOREQUEST_RC_URL(KEY_RC_RANKLIST,url)

#define ADOP_adv3_top @"ADOP_adv3_top"
void ADAPI_adv3_top(DelegatorID delegatorID)
{
//    DOREQUEST_RC_URL_RANKLIST(@"Snap");
//    DOREQUEST_RC_DONE(ADOP_adv3_top);
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/Operator/GetContentByContentCode"               parameters:@{@"ContentCode":@"436b5f777fb00cea3c6788b63e9a42cc"}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    
    [NET_SERVICE doRequest:ADOP_adv3_top forModule:REGISTRATION_MODULE withOption:option];
    
}

#define ADOP_adv3_CustomerPosition @"ADOP_adv3_CustomerPosition"
void ADAPI_adv3_CustomerPosition(DelegatorID delegatorID, NSInteger type)
{
    DOREQUEST_RC_URL_RANKLIST(@"CustomerPosition");
    DOREQUEST_RC_DONE_WITH(ADOP_adv3_CustomerPosition,@{@"type":@(type)});
    NSLog(@"%d",[option isGet]);
}

void ADAPI_adv23_top_months(DelegatorID delegatorID, NSInteger type)
{
    DOREQUEST_RC_URL_RANKLIST(@"Months");
//    DOREQUEST_RC_DONE_WITH(ADOP_adv3_CustomerPosition,@{@"type":@(type)});
    DOREQUEST_RC_DONE(ADOP_top_months);
    [option description];
}

void ADAPI_adv23_top_weeks(DelegatorID delegatorID, NSInteger type)
{
    DOREQUEST_RC_URL_RANKLIST(@"Weeks");
//    DOREQUEST_RC_DONE_WITH(ADOP_adv3_CustomerPosition,@{@"type":@(type)});
    DOREQUEST_RC_DONE(ADOP_top_weeks);
}

//@"api/Enterprise/";
NSString* KEY_RC_ADVERTCOLLECTION = @"api/Favorite/";
#pragma mark - 广告收藏
#define DOREQUEST_RC_URL_ADVERTCOLLECTION(url) DOREQUEST_RC_URL(KEY_RC_ADVERTCOLLECTION,url)

//收藏银元广告
#define ADOP_adv3_CollectAdvert @"ADOP_adv3_CollectAdvert"
void ADAPI_adv3_CollectAdvert(DelegatorID delegatorID,NSInteger AdvertId,NSInteger AdvertType)
{
    NSDictionary *paraDic = @{@"AdvertId":[NSString stringWithFormat:@"%ld",(long)AdvertId],
                              @"AdvertType":[NSString stringWithFormat:@"%ld",(long)AdvertType]};
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Favorite/CollectAdvert"
                                                              parameters:nil
                                                                    body:paraDic];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_CollectAdvert forModule:ADVERT_MODULE withOption:option];
}

//取消银元广告收藏
#define ADOP_adv3_RemoveAdvert @"ADOP_adv3_RemoveAdvert"
void ADAPI_adv3_RemoveAdvert(DelegatorID delegatorID,NSInteger AdvertId,NSInteger AdvertType)
{
    NSDictionary *paraDic = @{@"AdvertId":[NSString stringWithFormat:@"%ld",(long)AdvertId],
                              @"AdvertType":[NSString stringWithFormat:@"%ld",(long)AdvertType]};
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Favorite/RemoveAdvert"
                                                              parameters:nil
                                                                    body:paraDic];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_RemoveAdvert forModule:ADVERT_MODULE withOption:option];
}

//过滤收藏
#define ADOP_adv3_Filter @"ADOP_adv3_Filter"
void ADAPI_adv3_Filter(DelegatorID delegatorID)
{
    DOREQUEST_RC_URL_ADVERTCOLLECTION(@"Filter");
    ServerRequestOption* option = [ServerRequestOption optionFromService:op body:@{}];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];;
    DOREQUEST_RC_DELEGATOR(ADOP_adv3_Filter);
}

//移除收藏的广告
#define ADOP_adv3_Remove @"ADOP_adv3_Remove"
void ADAPI_adv3_Remove(DelegatorID delegatorID,NSInteger AdvertId,NSInteger AdvertType)
{
    DOREQUEST_RC_URL_ADVERTCOLLECTION(@"RemoveAdvert");
    ServerRequestOption* option = [ServerRequestOption optionFromService:op body:@{@"AdvertId":@(AdvertId),
                                                                                   @"AdvertType":@(AdvertType)}];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    DOREQUEST_RC_DELEGATOR(ADOP_adv3_Remove);
}

NSString* KEY_RC_VIP = @"api/CustomerPrivilege/";
#pragma mark - VIP特权
#define DOREQUEST_RC_URL_VIP(url) DOREQUEST_RC_URL(KEY_RC_VIP,url)

//获取用户特权介绍
void ADAPI_adv3_GetIntro(DelegatorID delegatorID)
{
    DOREQUEST_RC_URL_VIP(@"GetIntro");
    ServerRequestOption* option = [ServerRequestOption optionFromService:op];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    DOREQUEST_RC_DELEGATOR(ADOP_adv3_GetIntro);
}

//获取用户VIP等级
void ADAPI_adv3_GetVipLevel(DelegatorID delegatorID)
{
    DOREQUEST_RC_URL_VIP(@"GetVipLevel");
    DOREQUEST_RC_DONE(ADOP_adv3_GetVipLevel);
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
}

//购买钻石
void ADAPI_adv3_BuyVip(DelegatorID delegatorID, NSInteger Count)
{
    DOREQUEST_RC_URL_VIP(@"BuyVip");
    ServerRequestOption* option = [ServerRequestOption optionFromService:op body:@{@"ItemCount":@(Count)}];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    DOREQUEST_RC_DELEGATOR(ADOP_adv3_BuyVip);

}

NSString* KEY_RC_DATAANALYSIS = @"api/VipEnterpriseAnalysis/";
#pragma mark - 数据分析
#define DOREQUEST_RC_URL_DATAANALYSIS(url) DOREQUEST_RC_URL(KEY_RC_DATAANALYSIS,url)
#define ADOP_adv3_Snap @"ADOP_adv3_Snap"
void ADAPI_adv3_Snap(DelegatorID delegatorID)
{
    NSString *op = [NSString stringWithFormat:@"%@%@",KEY_RC_DATAANALYSIS,@"Snap"];
    ServerRequestOption* option = [ServerRequestOption optionFromService:op];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    DOREQUEST_RC_DELEGATOR(ADOP_adv3_Snap);
}

//我的商家快照
void ADAPI_adv3_MyBusinessSnap(DelegatorID delegatorID)
{
    NSString *op = [NSString stringWithFormat:@"%@%@",KEY_RC_DATAANALYSIS,@"MyBusinessSnap"];
    ServerRequestOption* option = [ServerRequestOption optionFromService:op];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    DOREQUEST_RC_DELEGATOR(ADOP_adv3_MyBusinessSnap);
}

//银元广告详情
void ADAPI_adv3_SilverAdvert(DelegatorID delegatorID,NSInteger SilverAdvertId)
{
    NSString *op = [NSString stringWithFormat:@"%@%@",KEY_RC_DATAANALYSIS,@"SilverAdvert"];
    ServerRequestOption* option = [ServerRequestOption optionFromService:op
                                                              parameters:@{@"SilverAdvertId":@(SilverAdvertId)}];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    DOREQUEST_RC_DELEGATOR(ADOP_adv3_SilverAdvert);
}

//直投广告详情
void ADAPI_adv3_DirectAdvert(DelegatorID delegatorID,NSInteger DirectAdvertId)
{
    NSString *op = [NSString stringWithFormat:@"%@%@",KEY_RC_DATAANALYSIS,@"DirectAdvert"];
    ServerRequestOption* option = [ServerRequestOption optionFromService:op
                                                              parameters:@{@"DirectAdvertId":@(DirectAdvertId)}];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    DOREQUEST_RC_DELEGATOR(ADOP_adv3_DirectAdvert);
}

NSString* KEY_RC_BUSINESSINFO = @"api/Enterprise/";
#pragma mark - 商家信息
#define DOREQUEST_RC_URL_BUSINESSINFO(url) DOREQUEST_RC_URL(KEY_RC_BUSINESSINFO,url)

//编辑商家
void ADAPI_adv3_EditEnterprise(DelegatorID delegatorID,NSMutableDictionary *dic)
{
    DOREQUEST_RC_URL_BUSINESSINFO(@"EditEnterprise");
    ServerRequestOption* option = [ServerRequestOption optionFromService:op
                                                                    body:dic];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    DOREQUEST_RC_DELEGATOR(ADOP_adv3_EditEnterprise);
}

//获取商家基本信息
void ADAPI_adv3_GetBasicInfo(DelegatorID delegatorID, NSString *EnterpriseId)
{
    NSString *op = [NSString stringWithFormat:@"%@%@",KEY_RC_BUSINESSINFO,@"GetBasicInfo"];    
    ServerRequestOption* option = [ServerRequestOption optionFromService:op];

    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option description];
    [NET_SERVICE doRequest:ADOP_adv3_GetBasicInfo forModule:ADVERT_MODULE withOption:option];
}

//注销商家
void ADAPI_adv3_DeleteEnterprise(DelegatorID delegatorID, NSString *Code)
{
    DOREQUEST_RC_URL_BUSINESSINFO(@"DeleteEnterprise");
    ServerRequestOption* option = [ServerRequestOption optionFromService:op
                                                                    body:@{@"Code":Code}];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    DOREQUEST_RC_DELEGATOR(ADOP_adv3_DeleteEnterprise);
}

//获取商家兑换承诺书列表
void ADAPI_adv3_GetExchangePromiseList(DelegatorID delegatorID)
{
    DOREQUEST_RC_URL_BUSINESSINFO(@"GetExchangePromiseList");
    DOREQUEST_RC_DONE(ADOP_adv3_GetExchangePromiseList);
}

//获取商家资质列表
void ADAPI_adv3_GetCertificationList(DelegatorID delegatorID)
{
    DOREQUEST_RC_URL_BUSINESSINFO(@"GetCertificationList");
    DOREQUEST_RC_DONE(ADOP_adv3_GetCertificationList);
}

#pragma mark - 其他

//创建购买商家VIP服务订单
#define ADOP_adv3_CreatePrePayEnterpriseVipOrder @"ADOP_adv3_CreatePrePayEnterpriseVipOrder"
void ADAPI_adv3_CreatePrePayEnterpriseVipOrder(DelegatorID delegatorID,NSInteger ItemCount,NSInteger MonthCount)
{
    DOREQUEST_RC_URL(@"Payment/", @"CreatePrePayEnterpriseVipOrder");
    DOREQUEST_RC_DONE_WITH(ADOP_adv3_CreatePrePayEnterpriseVipOrder, (@{@"ItemCount":[NSString stringWithFormat:@"%d",ItemCount],
                                                                        @"MonthCount":[NSString stringWithFormat:@"%d",MonthCount]}));
}

void ADAPI_adv3_Me_getCount(DelegatorID delegatorID)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Customer/AccountSummary"];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_Me_getCount forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_CancelOrder(DelegatorID delegatorID,NSString *OrderSerialNo)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Order/Cancel"
                                                                    body:@{@"OrderSerialNo":OrderSerialNo}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_CancelOrder forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_DeleteOrder(DelegatorID delegatorID,NSString *OrderSerialNo)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Order/Delete"
                                                                    body:@{@"OrderSerialNo":OrderSerialNo}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_DeleteOrder forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_RefreshOrder(DelegatorID delegatorID,NSString *OrderSerialNo)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Order/Refresh"
                                                                    body:@{@"OrderSerialNo":OrderSerialNo}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_DEBUG_INFO];
    [NET_SERVICE doRequest:ADOP_adv3_RefreshOrder forModule:ADVERT_MODULE withOption:option];
}

#pragma 消息中心

void ADAPI_adv3_MessageDelete(DelegatorID delegatorID,NSString *MsgIds, NSInteger type)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Message/Delete"
                                                                    body:@{@"MsgIds":@[MsgIds],
                                                                           @"Type":@(type)}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_MessageDelete forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_MessageDeleteType(DelegatorID delegatorID,NSArray *TypeList)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Message/DeleteByType"
                                                                    body:@{@"TypeList":TypeList}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_MessageDeleteType forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_Message_Index(DelegatorID delegatorID)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Message/Index"];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_Message_Index forModule:ADVERT_MODULE withOption:option];
}


void ADAPI_adv3_Checkver(DelegatorID delegatorID)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Version/Checkver"];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_Checkver forModule:ADVERT_MODULE withOption:option];
}



/////////

//SilverMall
#pragma mark - 商城

void ADAPI_adv3_CustomerGetProductDetail(DelegatorID delegatorID,NSInteger ProductId,NSInteger AdvertId)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/SilverMall/CustomerGetProductDetail"
                                                              parameters:@{@"ProductId":@(ProductId),
                                                                            @"AdvertId":@(AdvertId)}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    [NET_SERVICE doRequest:ADOP_adv3_CustomerGetProductDetail forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_RecordProductReminder(DelegatorID delegatorID,NSInteger ProductId,NSInteger AdvertId)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/SilverMall/RecordProductReminder"
                                                                    body:@{@"ProductId":@(ProductId),
                                                                           @"AdvertId":@(AdvertId)}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_RecordProductReminder forModule:ADVERT_MODULE withOption:option];
}

//收藏，取消收藏

void ADAPI_adv3_PrimaryProduct(DelegatorID delegatorID)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldMall/PrimaryProduct"];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_PrimaryProduct forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GetProduct(DelegatorID delegatorID,NSInteger ProductId)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldMall/GetProduct"
                                                              parameters:@{@"ProductId":@(ProductId)}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_GetProduct forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GetProductCatagorys(DelegatorID delegatorID)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldProductManagement/GetProductCatagorys"];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_GetProductCatagorys forModule:ADVERT_MODULE withOption:option];
}

#define ADOP_adv3_push_Update @"ADOP_adv3_push_Update"
void ADAPI_adv3_push_Update(DelegatorID delegatorID,NSString* uuid,NSString* appld,NSString* userid,NSString* cannel,NSString* pushversion)
{
//    [AlertUtil showAlert:@"" message:[NSString stringWithFormat:@"channelid %@ userid %@", uuid, cannel]];
    
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/CustomerDevice/Update" body:@{
                                                                                                             @"Uuid":uuid,
                                                                                                             @"AppId":appld,
                                                                                                             @"UserId":userid,
                                                                                                             @"ChannelId":cannel,
                                                                                                             @"PushVersion":pushversion,
                                                                                                             }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_GetProductCatagorys forModule:@"PUSH" withOption:option];
}

#define ADOP_adv3_Push_Report @"ADOP_adv3_Push_Report"
void ADAPI_adv3_Push_Report(DelegatorID delegatorID,NSString* customerId,NSString* pushMsgId)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Push/Read" body:@{ @"customerId":customerId,
                                                                                                  @"pushMsgId":pushMsgId,}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_GetProductCatagorys forModule:@"PUSH" withOption:option];
}