//
//  AdverModuleAPI.m
//  miaozhuan
//
//  Created by apple on 14/10/24.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AdverModuleAPI.h"
#import "ServerRequest.h"
#import "OpenUDID.h"
#import "JSONKit.h"

#import "CRThankgivingEncryptUnit.h"

@implementation AdverModuleAPI
@end

NSString* ADVERT_MODULE = @"ADVERT_MODULE";

void ADAPI_adv3_Logout(DelegatorID delegatorID)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Auth/Logout" body:@""];
    option.delegatorID = delegatorID;
    
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_Logout forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_autothanks (DelegatorID delegatorID,NSString * phoneNumber)
{
    NSString* url = [NSString stringWithFormat:@"http://a.zdit.cn/api/autothanks/%@", phoneNumber];
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:nil];
    option.server = url;
    
    option.delegatorID = delegatorID;
    
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_autothanks forModule:ADVERT_MODULE withOption:option];
}


void ADAPI_adv3share_registerShare(DelegatorID delegatorID, NSString* phoneNumber)
{
    NSString * imei = [OpenUDID value];
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Auth/RegisterShare"
                                                              parameters:@{@"Phone":phoneNumber, @"Imei":imei}];
    option.delegatorID = delegatorID;
    
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3share_registerShare forModule:REGISTRATION_MODULE withOption:option];
}

void ADAPI_adv3_MemberRegister(DelegatorID delegatorID,NSString * phoneNumber,NSString * password)
{
    NSString * imei = [OpenUDID value];
    
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/Auth/CustomerRegister" body:@{@"UserName":phoneNumber, @"Password":password,@"Imei":imei}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    
    [NET_SERVICE doRequest:ADOP_adv3_MemberRegister forModule:REGISTRATION_MODULE withOption:option];
}

void ADAPI_adv3_CustomerSurvey_GetQuestion(DelegatorID delegatorID,NSString * QuestionId,NSString * AdvertId)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/CustomerSurvey/GetQuestion" parameters:@{@"QuestionId":QuestionId, @"AdvertId":AdvertId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_CustomerSurvey_GetQuestion forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_PerfectInformation(DelegatorID delegatorID,NSString * TrueName,NSString * Gender,NSString * Birthday,NSString * AnnualIncome)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Customer/FillBasicInfo"
                                                              body:@{@"TrueName":TrueName, @"Gender":Gender,@"Birthday":Birthday,@"AnnualIncome":AnnualIncome}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    
    [NET_SERVICE doRequest:ADOP_adv3_PerfectInformation forModule:ADVERT_MODULE withOption:option];
    
}

void ADAPI_adv3_Customer_FillDetailsInfo(DelegatorID delegatorID,NSString * PhotoId,NSString * TrueName,NSString * Gender,NSString *Birthday,NSString *ProvinceId,NSString *CityId,NSString *DistrictId,NSString *OtherPhone,NSString *QQ,NSString *Email,NSString *Weibo,NSString *Weixin)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Customer/FillDetailsInfo"
                                                                    body:@{@"PhotoId":PhotoId, @"TrueName":TrueName,@"Gender":Gender,@"Birthday":Birthday,@"ProvinceId":ProvinceId,@"CityId":CityId,@"DistrictId":DistrictId,@"OtherPhone":OtherPhone,@"QQ":QQ,@"Email":Email,@"Weibo":Weibo, @"Weixin":Weixin}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];

    [NET_SERVICE doRequest:ADOP_adv3_Customer_FillDetailsInfo forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GetRecommendedComInfo(DelegatorID delegatorID)
{
    NSString * imei = [OpenUDID value];
    
    NSString * phone = [APP_DELEGATE.persistConfig getString:USER_INFO_NAME];
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"/api/MemberCampaign/GetRecommendedComInfo"
                                                              parameters:@{@"phone":phone, @"imei":imei}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];

    
    [NET_SERVICE doRequest:ADOP_adv3_GetRecommendedComInfo forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_MemberCampaignSave(DelegatorID delegatorID,NSString* CampaignType, NSString* thanksInfo)
{
    //=====================Update by CR.Abyss=====================
    
    NSString*   imei      = nil;
    NSString*   sign      = nil;
    {
        NSData* encryptCode = nil;
        NSString* cookie    = nil;
        
        ServerRequestOption* option = [ServerRequestOption optionFromService:@"/api/MemberCampaign/Save"];

        option.delegatorID  = delegatorID;
        option.requestType  = REQUEST_POST;
        
        cookie = [[NET_SERVICE httpCookiesForURL:option.url] objectForKey:@"token"];

        if (cookie)
        {
            encryptCode     = [CRThankgivingEncryptUnit getThanksgivingCode:cookie forPhone:thanksInfo];
            sign            = [CRThankgivingEncryptUnit stringFromHexData:encryptCode];
            imei            = [OpenUDID value];
            
            
            option.body = @{@"CurrentImei":imei,
                            @"CampaignType":CampaignType,
                            @"Sign":sign,
                            @"PresenterPhone":thanksInfo};

            [option turnOn:OPTION_NEED_DEBUG_INFO];
            [option turnOn:OPTION_NEED_LOADING_INDICATOR];
            
            [NET_SERVICE doRequest:ADOP_adv3_MemberCampaignSave forModule:ADVERT_MODULE withOption:option];
        }
        else
        {
            [HUDUtil showErrorWithStatus:@"感恩失败，请确认已登陆"];
        }
    }
    
    
#pragma mark - info
//    ********HTTP*************
//    URL : http://192.168.0.171/api/MemberCampaign/Save
//    HTTP status : 200 HTTP desc : no error
//    From : Server
//    Module : ADVERT_MODULE Operation : ADOP_adv3_MemberCampaignSave
//    =========Cookies===========
//    actionattr-test = abc
//    token = 0FF226E299170DE2229E120938C4F75F
//    handler-test = abc
//    ********HTTP*************
    
#pragma mark - old
//    //=====================Update by CR.Abyss=====================
//    
//    NSString*   imei      = nil;
//    NSString*   sign      = nil;
//    {
//        NSData* encryptCode = nil;
//        NSString* cookie    = nil;
//        
//        cookie = [CRThankgivingEncryptUnit getTokenFromLocal];
//        
//        if (cookie)
//        {
//            encryptCode = [CRThankgivingEncryptUnit getThanksgivingCode:cookie forPhone:thanksInfo];
//            sign = [CRThankgivingEncryptUnit stringFromHexData:encryptCode];
//            
//            imei = [OpenUDID value];
//            
//            ServerRequestOption* option = [ServerRequestOption optionFromService:@"/api/MemberCampaign/Save"
//                                                                            body:@{@"CurrentImei":imei,@"CampaignType":CampaignType,@"Sign":sign,@"PresenterPhone":thanksInfo}];
//            
//            option.delegatorID = delegatorID;
//            [option turnOn:OPTION_NEED_LOADING_INDICATOR];
//            [option turnOn:OPTION_NEED_HANDLE_ERROR];
//            
//            NSLog(@"%@",option.body);
//            [NET_SERVICE doRequest:ADOP_adv3_MemberCampaignSave forModule:ADVERT_MODULE withOption:option];
//        }
//        else
//        {
//            [HUDUtil showErrorWithStatus:@"感恩失败，请确认已登陆"];
//        }
//    }
}

void ADAPI_adv3_MemberCampaign_Summary(DelegatorID delegatorID,NSString * Type , NSString * StartTime,NSString * EndTime)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"/api/MemberCampaign/Summary" parameters:@{@"Type":Type,@"StartTime":StartTime,@"EndTime":EndTime}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    
    [NET_SERVICE doRequest:ADOP_adv3_MemberCampaign_Summary forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_1_MemberCampaign_RemindFansPhoneVerify(DelegatorID delegatorID,NSString * FansCustomerId)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/MemberCampaign/RemindFansPhoneVerify" body:@{@"FansCustomerId":FansCustomerId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_1_MemberCampaign_RemindFansPhoneVerify forModule:REGISTRATION_MODULE withOption:option];

}

void ADAPI_adv3_3_Enterprise_PicRes (DelegatorID delegatorID,NSArray * array)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/Enterprise/PicRes" parameters:@{@"BusinessResTypes":array}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_3_Enterprise_PicRes forModule:ADVERT_MODULE withOption:option];

}

void ADAPI_adv3_3_Enterprise_AddPlacePic (DelegatorID delegatorID, NSString *PicId)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Enterprise/AddPlacePic"
                                                                    body:@{@"PicId":PicId}];

    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_3_Enterprise_AddPlacePic forModule:ADVERT_MODULE withOption:option];
}


void ADAPI_adv3_3_Enterprise_DeletePlacePic (DelegatorID delegatorID, NSString *PicId)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Enterprise/DeletePlacePic"
                                                                    body:@{@"PicId":PicId}];
    
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_adv3_3_Enterprise_DeletePlacePic forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_startlogin(DelegatorID delegatorID,NSString * userName ,NSString *password)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Auth/Login"
                                                              parameters:@{@"UserName":userName, @"Password":password}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    
    [NET_SERVICE doRequest:ADOP_adv3_startlogin forModule:ADVERT_MODULE withOption:option];
}


void ADAPI_adv3_GetCaptcha(DelegatorID delegatorID,NSString * Phone)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/ValidateCode/GetCaptcha" parameters:@{@"Phone":Phone}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    
    [NET_SERVICE doRequest:ADOP_adv3_GetCaptcha forModule:REGISTRATION_MODULE withOption:option];
}

void ADAPI_adv3_PaymentFindPayPwdStep3(DelegatorID delegatorID,NSString *newPayPwd,NSString * securityCode)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/FindPayPwdStep3" body:@{@"NewPayPwd":newPayPwd, @"SecurityCode":securityCode}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_PaymentFindPayPwdStep3 forModule:REGISTRATION_MODULE withOption:option];
}

void ADAPI_adv3_PaymentFindPayPwdStep2(DelegatorID delegatorID,NSString *secAnswer,NSString * securityCode)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/FindPayPwdStep2" body:@{@"SecAnswer":secAnswer, @"SecurityCode":securityCode}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_PaymentFindPayPwdStep2 forModule:REGISTRATION_MODULE withOption:option];
}

void ADAPI_adv3_PaymentFindPayPwdStep1(DelegatorID delegatorID,NSString *validateCode)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/FindPayPwdStep1" body:@{@"ValidateCode":validateCode}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_PaymentFindPayPwdStep1 forModule:REGISTRATION_MODULE withOption:option];
}

void ADAPI_adv3_ResetPassword(DelegatorID delegatorID,NSString * UserName,NSString * Password,NSString *ValidateCode)
{
    NSString *imei = [OpenUDID value];
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Auth/ResetPassword"
                                                              body:@{@"UserName":UserName,@"Password":Password,@"ValidateCode":ValidateCode,@"Imei":imei}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ResetPassword forModule:REGISTRATION_MODULE withOption:option];
}

//void ADAPI_adv3_PaymentSetSecAnswer (DelegatorID delegatorID,NSString * secQuestion, NSString * secAnswer)
//{
//    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/SetSecAnswer"
//                                                                    body:@{@"SecQuestion":secQuestion, @"SecAnswer":secAnswer }];
//    
//    option.delegatorID = delegatorID;
//    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
//    [option turnOn:OPTION_NEED_HANDLE_ERROR];
//    
//    [NET_SERVICE doRequest:ADOP_adv3_PaymentSetSecAnswer forModule:REGISTRATION_MODULE withOption:option];
//}

void ADAPI_adv3_PaymentAskForPayPwd (DelegatorID delegatorID)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/AskForPayPwd"
                                                                    body:@{@"":@""}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_PaymentAskForPayPwd forModule:REGISTRATION_MODULE withOption:option];
}

void ADAPI_adv3_PaymentSetPayPwd (DelegatorID delegatorID,NSString * payPwd, NSString * secQuestion, NSString * secAnswer,NSString * ValidateCode)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/SetPayPwd"
                                                                    body:@{@"PayPwd": payPwd, @"SecQuestion": secQuestion, @"SecAnswer": secAnswer,@"SecurityCode":ValidateCode}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_PaymentSetPayPwd forModule:REGISTRATION_MODULE withOption:option];

}

void ADAPI_adv3_PaymentResetPayPwd (DelegatorID delegatorID,NSString * originPayPwd,NSString *newPayPwd)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/ResetPayPwd"
                                                                    body:@{@"OriginPayPwd":originPayPwd,@"NewPayPwd":newPayPwd}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_PaymentResetPayPwd forModule:REGISTRATION_MODULE withOption:option];
}

void ADAPI_adv3_CustomerCommon_ResetPassword (DelegatorID delegatorID,NSString * Password,NSString *ValidateCode)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/CustomerCommon/ResetPassword"
                                                                    body:@{@"Password":Password,@"ValidateCode":ValidateCode}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_CustomerCommon_ResetPassword forModule:REGISTRATION_MODULE withOption:option];
}

void ADAPI_adv3_EnterpriseCustomerGetPicRes (DelegatorID delegatorID,NSString * enterpriseId, NSArray * array)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/Enterprise/CustomerGetPicRes" parameters:@{@"EnterpriseId": enterpriseId,@"BusinessResTypes":array}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_EnterpriseCustomerGetPicRes forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_PaymentGetSecQuestion (DelegatorID delegatorID)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Payment/GetSecQuestion"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_PaymentGetSecQuestion forModule:ADVERT_MODULE withOption:option];

}

void ADAPI_adv3_GetIdentityVerifyInfo(DelegatorID delegatorID)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Customer/GetIdentityVerifyInfo"];
                                   
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
   
    [NET_SERVICE doRequest:ADOP_adv3_GetIdentityVerifyInfo forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_Customer_VerifyIdentity(DelegatorID delegatorID,NSString * TrueName,NSString *IdentityNo,NSString *FrontPicId,NSString *BackPicId)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Customer/VerifyIdentity" body:@{@"TrueName":TrueName,@"IdentityNo":IdentityNo,@"FrontPicId":FrontPicId,@"BackPicId":BackPicId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_Customer_VerifyIdentity forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_CommonAbout_Suggest(DelegatorID delegatorID,NSString * Message)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/CommonAbout/Suggest" body:@{@"Message":Message}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_CommonAbout_Suggest forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_3_BarterCodeIndex(DelegatorID delegatorID)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/BarterCode/Index"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_3_BarterCodeIndex forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_3_BarterQuota_Index(DelegatorID delegatorID)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/BarterQuota/Index"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_3_BarterQuota_Index forModule:ADVERT_MODULE withOption:option];
}


void ADAPI_adv3_3_BarterQuota_PriceList(DelegatorID delegatorID)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/BarterQuota/PriceList"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_3_BarterQuota_PriceList forModule:ADVERT_MODULE withOption:option];
}


void ADAPI_adv3_VerifyPhone(DelegatorID delegatorID,NSString * ValidateCode)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Customer/VerifyPhone" body:@{@"ValidateCode":ValidateCode}];
    
    option.delegatorID = delegatorID;
    
    [option turnOn:OPTION_NEED_DEBUG_INFO];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_VerifyPhone forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_ExchangeManagement_GetExchangeRecordDetail (DelegatorID delegatorID,NSString * OrderNumber,NSString * ExchangeAddressId)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/ExchangeManagement/GetExchangeRecordDetail" parameters:@{@"OrderNumber":OrderNumber,@"ExchangeAddressId":ExchangeAddressId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ExchangeManagement_GetExchangeRecordDetail forModule:ADVERT_MODULE withOption:option];
}


void ADAPI_adv3_ExchangeManagement_GetSilverOrderDetail (DelegatorID delegatorID,NSString * OrderNumber)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/ExchangeManagement/GetSilverOrderDetail" parameters:@{@"OrderNumber":OrderNumber}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ExchangeManagement_GetSilverOrderDetail forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_ExchangeManagement_ConfirmExchange(DelegatorID delegatorID,NSString * EnterpriseId,NSString * OrderNumber,NSString * ExchangeAddressId,NSString * LogisticsCompany,NSString * WaybillNumber)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/ExchangeManagement/ConfirmExchange" body:@{@"EnterpriseId":EnterpriseId,@"OrderNumber":OrderNumber,@"ExchangeAddressId":ExchangeAddressId,@"LogisticsCompany":LogisticsCompany,@"WaybillNumber":WaybillNumber}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ExchangeManagement_ConfirmExchange forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_ExchangeManagement_GetDeliveryAddress(DelegatorID delegatorID,NSString * OrderNumber)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/ExchangeManagement/GetDeliveryAddress" parameters:@{@"OrderNumber":OrderNumber}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ExchangeManagement_GetDeliveryAddress forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_ExchangeManagement_ChangeDeliveryAddress(DelegatorID delegatorID,NSString * OrderNumber,NSString * ContactName,NSString * ContactPhone,NSString * Province,NSString * City,NSString * District,NSString * Address)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/ExchangeManagement/ChangeDeliveryAddress" body:@{@"OrderNumber":OrderNumber,@"ContactName":ContactName,@"ContactPhone":ContactPhone,@"Province":Province,@"City":City,@"District":District,@"Address":Address}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ExchangeManagement_ChangeDeliveryAddress forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_ExchangeManagement_AddNotes(DelegatorID delegatorID,NSString * OrderNumber,NSString * Notes)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/ExchangeManagement/AddNotes" body:@{@"OrderNumber":OrderNumber,@"Notes":Notes}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ExchangeManagement_AddNotes forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GoldOrder_GetOrderDeliveryAddress (DelegatorID delegatorID,NSString * OrderId)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/GoldOrder/GetOrderDeliveryAddress" parameters:@{@"OrderId":OrderId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_GoldOrder_GetOrderDeliveryAddress forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GoldOrder_EnterpriseUpdateOrderAddress (DelegatorID delegatorID,NSString * OrderId,NSString * ContactName,NSString * ContactPhone,NSString * Province,NSString * City,NSString * District,NSString * Address)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/GoldOrder/EnterpriseUpdateOrderAddress" body:@{@"OrderId":OrderId,@"ContactName":ContactName,@"ContactPhone":ContactPhone,@"Province":Province,@"City":City,@"District":District,@"Address":Address}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_GoldOrder_EnterpriseUpdateOrderAddress forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GoldOrder_EnterpriseDeliver (DelegatorID delegatorID,NSString * OrderId,NSString * CompanyName,NSString * BillNo)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/GoldOrder/EnterpriseDeliver" body:@{@"OrderId":OrderId,@"CompanyName":CompanyName,@"BillNo":BillNo}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_GoldOrder_EnterpriseDeliver forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GoldOrder_EnterpriseOrderOperate (DelegatorID delegatorID,NSString * OrderId,NSString * OperateType)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/GoldOrder/EnterpriseOrderOperate" body:@{@"OrderId":OrderId,@"OperateType":OperateType}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_GoldOrder_EnterpriseOrderOperate forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GoldOrder_EnterpriseCloseComent (DelegatorID delegatorID, NSString * OrderId,NSString * CloseComent)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/GoldOrder/EnterpriseCloseComent" body:@{@"OrderId":OrderId,@"CloseComent":CloseComent}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_GoldOrder_EnterpriseCloseComent forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_MallManagement_GetUnreadSummary(DelegatorID delegatorID,NSString * EnterpriseId)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/MallManagement/GetUnreadSummary" parameters:@{@"EnterpriseId":EnterpriseId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_MallManagement_GetUnreadSummary forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_MallManagement_CountSilverMailExchange(DelegatorID delegatorID,NSString * EnterpriseId)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/MallManagement/CountSilverMailExchange" parameters:@{@"EnterpriseId":EnterpriseId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
//    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    
    [NET_SERVICE doRequest:ADOP_adv3_MallManagement_CountSilverMailExchange forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GoldOrder_GetOrderDetails(DelegatorID delegatorID,NSString * OrderId)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/GoldOrder/GetOrderDetails" parameters:@{@"OrderId":OrderId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_GoldOrder_GetOrderDetails forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_MyGoldMall_GetCompanys(DelegatorID delegatorID)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/MyGoldMall/GetCompanys"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_MyGoldMall_GetCompanys forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_UnReadMessage(DelegatorID delegatorID) {
    
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Message/Count"];
    option.delegatorID = delegatorID;
    [NET_SERVICE doRequest:ADOP_UnReadMessage forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GoldMall_ConsultSnap (DelegatorID delegatorID,NSString * ProductId,NSString * type)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/GoldMall/ConsultSnap" parameters:@{@"ProductId":ProductId,@"type":type}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    
    [NET_SERVICE doRequest:ADOP_adv3_GoldMall_ConsultSnap forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_Operator_GetContentListByContentCode (DelegatorID delegatorID,NSString * ContentCode)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/Operator/GetContentListByContentCode" body:@{@"ContentCode":ContentCode}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_Operator_GetContentListByContentCode forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_1_Operator_GetBanne (DelegatorID delegatorID,NSString * CategoryCode)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/Operator/GetBanner" parameters:@{@"CategoryCode":CategoryCode}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_1_Operator_GetBanner forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_Operator_GetBannerByContentCode (DelegatorID delegatorID,NSString * ContentCode)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/Operator/GetBannerByContentCode" parameters:@{@"ContentCode":ContentCode}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_Operator_GetBannerByContentCode forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_Operator_GetBannerListByCategoryCode (DelegatorID delegatorID,NSString * ContentCode)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/Operator/GetBannerListByCategoryCode" parameters:@{@"CategoryCode":ContentCode}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    
    [option turnOn:OPTION_NEED_DEBUG_INFO];
    
    [NET_SERVICE doRequest:ADOP_adv3_Operator_GetBannerListByCategoryCode forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_Operator_GetBannerListByCategoryCode_top (DelegatorID delegatorID,NSString * ContentCode)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/Operator/GetTopProductListByCategoryCode" parameters:@{@"CategoryCode":ContentCode}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    
    [NET_SERVICE doRequest:ADOP_adv3_Operator_GetBannerListByCategoryCode forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_registerGetContentByContentCode(DelegatorID delegatorID,NSString * ContentCode)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/Operator/GetContentByContentCode" parameters:@{@"ContentCode":ContentCode}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    
    [NET_SERVICE doRequest:ADOP_adv3_registerGetContentByContentCode forModule:REGISTRATION_MODULE withOption:option];
}

void ADAPI_adv3_CustomerGold_GetProvinceAgentRegionList(DelegatorID delegatorID)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/CustomerGold/GetProvinceAgentRegionList"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    
    [NET_SERVICE doRequest:ADOP_adv3_CustomerGold_GetProvinceAgentRegionList forModule:ADVERT_MODULE withOption:option];
}


void ADAPI_adv3_CustomerGold_GetProvinceAgentByCode (DelegatorID delegatorID,NSString * Name)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/CustomerGold/GetProvinceAgentByCode" parameters:@{@"Name":Name}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    
    [NET_SERVICE doRequest:ADOP_adv3_CustomerGold_GetProvinceAgentByCode forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_Enterprise_CheckIsCanCreate (DelegatorID delegatorID)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/Enterprise/CheckIsCanCreate"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    
    [NET_SERVICE doRequest:ADOP_adv3_Enterprise_CheckIsCanCreate forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GetEnterpriseStatus(DelegatorID delegatorID)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/Enterprise/GetEnterpriseStatus"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_GetEnterpriseStatus forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GetAdvertSummary(DelegatorID delegatorID)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/Enterprise/GetAdvertSummary"];
    
    option.delegatorID = delegatorID;
//    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
//    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_GetAdvertSummary forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_Activation(DelegatorID delegatorID)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/Enterprise/Activation" body:@{}];
    
    option.delegatorID = delegatorID;
//    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_Activation forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GetSummaryStatus(DelegatorID delegatorID)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/EnterpriseVip/GetSummaryStatus"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
//    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    
    [NET_SERVICE doRequest:ADOP_adv3_GetSummaryStatus forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GetSummaryCounsel(DelegatorID delegatorID)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/EnterpriseCounsel/GetSummaryCounsel"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_GetSummaryCounsel forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_DeleteCounsel(DelegatorID delegatorID,NSString * CounselId,NSString * Type)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/EnterpriseCounsel/DeleteCounsel" body:@{@"CounselId":CounselId,@"Type":Type}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_DeleteCounsel forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_CancelFavorite(DelegatorID delegatorID,NSMutableArray *array)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/EnterpriseCounsel/CancelFavorite" body:@{@"CounselIds":array}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_CancelFavorite forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_ReadCounsel(DelegatorID delegatorID,NSString *CounselId)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/EnterpriseCounsel/ReadCounsel" parameters:@{@"CounselId":CounselId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ReadCounsel forModule:ADVERT_MODULE withOption:option];
}


void ADAPI_adv3_ReplyCounsel(DelegatorID delegatorID,NSString *CounselId,NSString *Content)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/EnterpriseCounsel/ReplyCounsel" body:@{@"CounselId":CounselId,@"Content":Content}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ReplyCounsel forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_AddFavorite(DelegatorID delegatorID,NSString *CounselId)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/EnterpriseCounsel/AddFavorite" body:@{@"CounselId":CounselId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_AddFavorite forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GetLabelList(DelegatorID delegatorID)
{
    ServerRequestOption * option = [ServerRequestOption optionFromService:@"api/EnterpriseCounsel/GetLabelList"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_GetLabelList forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_SetLabel(DelegatorID delegatorID,NSMutableArray * array,NSString * LabelName)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/EnterpriseCounsel/SetLabel" body:@{@"CounselIds":array,@"LabelName":LabelName}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_SetLabel forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_Order_CountOrders (DelegatorID delegatorID)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Order/CustomerCountOrders"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_Order_CountOrders forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_ShippingAddress_ShippingAddressList (DelegatorID delegatorID)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/ShippingAddress/ShippingAddressList"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    
    [NET_SERVICE doRequest:ADOP_adv3_ShippingAddress_ShippingAddressList forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_ShippingAddress_SaveShippingAddress (DelegatorID delegatorID,NSString * Id,NSString * Name,NSString * Address,NSString * Phone,NSString * ProvinceName,NSString * CityName,NSString * DistrictName)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/ShippingAddress/SaveShippingAddress" body:@{@"Id":Id,@"Name":Name,@"Address":Address,@"Phone":Phone,@"ProvinceName":ProvinceName,@"CityName":CityName,@"DistrictName":DistrictName}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ShippingAddress_SaveShippingAddress forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_ShippingAddress_GetShippingAddress (DelegatorID delegatorID,NSString * Id)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/ShippingAddress/GetShippingAddress" parameters:@{@"Id":Id}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ShippingAddress_GetShippingAddress forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_ShippingAddress_SetPrimary (DelegatorID delegatorID,NSString * ShippingAddressId)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/ShippingAddress/SetPrimary" body:@{@"ShippingAddressId":ShippingAddressId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ShippingAddress_SetPrimary forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_ShippingAddress_DeleteShippingAddress (DelegatorID delegatorID,NSString * ShippingAddressId)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/ShippingAddress/DeleteShippingAddress" body:@{@"ShippingAddressId":ShippingAddressId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ShippingAddress_DeleteShippingAddress forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_ExchangeManagement_CustomerGetExchangeOrderDetail (DelegatorID delegatorID,NSString * OrderNo)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/ExchangeManagement/CustomerGetExchangeOrderDetail" parameters:@{@"OrderNo":OrderNo}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ExchangeManagement_CustomerGetExchangeOrderDetail forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_ExchangeManagement_CustomerCancelExchangeOrder (DelegatorID delegatorID,NSString * OrderNo)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/ExchangeManagement/CustomerCancelExchangeOrder" body:@{@"OrderNo":OrderNo}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_ExchangeManagement_CustomerCancelExchangeOrder forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GetPhoneCode(DelegatorID delegatorID,NSString * Phone,NSString *CaptchaCode,NSString * Type,NSString * SmsType,NSString * sender)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/ValidateCode/GetPhoneCode"
                                                              parameters:@{@"Phone":Phone,@"CaptchaCode":CaptchaCode,@"Type":Type,@"SmsType":SmsType,@"sender":sender}];
    
    option.delegatorID = delegatorID;
    
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    [option turnOn:OPTION_NEED_DEBUG_INFO];
    
    
    [NET_SERVICE doRequest:ADOP_adv3_GetPhoneCode forModule:REGISTRATION_MODULE withOption:option];
}

void ADAPI_adv3_3_ValidateCode_ValidatePhoneCode(DelegatorID delegatorID,NSString * ValidateCode,NSString * PhoneCodeType)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/ValidateCode/ValidatePhoneCode"body:@{@"ValidateCode":ValidateCode,@"PhoneCodeType":PhoneCodeType}];
    
    option.delegatorID = delegatorID;
    
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    [option turnOn:OPTION_NEED_DEBUG_INFO];
    
    
    [NET_SERVICE doRequest:ADOP_adv3_3_ValidateCode_ValidatePhoneCode forModule:REGISTRATION_MODULE withOption:option];

}

void ADAPI_adv3_GoldOrder_GetOrderStatusNumbers(DelegatorID delegatorID,NSString * EnterpriseId)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/GoldOrder/GetOrderStatusCounts"
                                                              parameters:@{@"EnterpriseId":EnterpriseId}];
    
    option.delegatorID = delegatorID;
    
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_DEBUG_INFO];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    
    [NET_SERVICE doRequest:ADOP_adv3_GoldOrder_GetOrderStatusNumbers forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv3_GetThankfulLevel(DelegatorID delegatorID)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/CustomerPrivilege/GetThankfulLevel"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_adv3_GetThankfulLevel forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_EnterpriseRecommend(DelegatorID delegatorID, int type, int pageIndex, int pageSize)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Enterprise/Recommend"
                                                              parameters:@{@"Type":[NSNumber numberWithInteger:type], @"PageIndex":[NSNumber numberWithInteger:pageIndex], @"PageSize":[NSNumber numberWithInteger:pageSize],}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_EnterpriseRecommend forModule:ADVERT_MODULE withOption:option];

}

void ADAPI_SilverAdvertCountUnread(DelegatorID delegatorID)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/SilverAdvert/CountUnread"];
    
    [option setDelegatorID:delegatorID];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    
    [NET_SERVICE doRequest:ADOP_SilverAdvertCountUnread forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_SilverAdvertCountUnreadProducts(DelegatorID delegatorID)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/SilverAdvert/CountUnreadProducts"];
    
    [option setDelegatorID:delegatorID];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    
    [NET_SERVICE doRequest:ADOP_SilverAdvertCountUnreadProducts forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_GetIndustryCategoryList(DelegatorID delegatorID, int parentId)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Industry/GetIndustryCategoryList"
                                                              parameters:@{
                                                                           @"ParentId":[NSString stringWithFormat:@"%d", parentId]
                                                                           }];
    
    [option setDelegatorID:delegatorID];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    
    [NET_SERVICE doRequest:ADOP_GetIndustryCategoryList forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_AddAndEditConvertCenter(DelegatorID delegatorID,NSDictionary *dataDic){
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/SilverAdvert/SaveExchangeAddress"
                                                              body:dataDic];
    
    [option setDelegatorID:delegatorID];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_DEBUG_INFO];
    [NET_SERVICE doRequest:ADOP_AddAndEditConvertCenter forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_RegionGetAllBaiduRegionList(DelegatorID delegatorID)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Region/GetAllBaiduRegionList"];
    
    [option setDelegatorID:delegatorID];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    
    [NET_SERVICE doRequest:ADOP_RegionGetAllBaiduRegionList forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_SilverAdvertSaveSilverProduct(DelegatorID delegatorID, NSMutableDictionary * body)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/SilverAdvert/SaveSilverProduct"
                                                                    body:body ];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_SilverAdvertSaveSilverProduct forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_SilverAdvertDeleteProduct(DelegatorID delegatorID, NSString * prodId)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/SilverAdvert/DeleteProduct"
                                                         body:@{@"ProductId":prodId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_SilverAdvertDeleteProduct forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_SilverAdvertDeleteAdvert(DelegatorID delegatorID, NSString * advertId)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/SilverAdvert/DeleteAdvert"
                                                              body:@{@"AdvertId":advertId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_SilverAdvertDeleteAdvert forModule:ADVERT_MODULE withOption:option];
}


void ADAPI_SilverAdvertEnterpriseGetProductDetail(DelegatorID delegatorID, NSString * prodId)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/SilverAdvert/EnterpriseGetProductDetail"
                                                              parameters:@{@"ProductId":prodId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_SilverAdvertEnterpriseGetProductDetail forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_SilverAdvertGetExchangeAddress(DelegatorID delegatorID, NSString * pageIndex, NSString * pageSize)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/SilverAdvert/GetExchangeAddress"
                                                              parameters:@{@"PageIndex": pageIndex,
                                                                           @"PageSize": pageSize}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_SilverAdvertGetExchangeAddress forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_SilverAdvertCountUnreadAds(DelegatorID delegatorID)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/SilverAdvert/CountUnreadAds"];
    
    [option setDelegatorID:delegatorID];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    
    [NET_SERVICE doRequest:ADOP_SilverAdvertCountUnreadAds forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_SilverAdvertSaveSilverAdvert(DelegatorID delegatorID, NSMutableDictionary * body)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/SilverAdvert/SaveSilverAdvert"
                                                                    body:body ];
    
    
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
        
    [NET_SERVICE doRequest:ADOP_SilverAdvertSaveSilverAdvert forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_SilverAdvertEnterpriseGetAdvertDetail(DelegatorID delegatorID, NSString * advertId)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/SilverAdvert/EnterpriseGetAdvertDetail"
                                                              parameters:@{@"AdvertId":advertId}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_SilverAdvertEnterpriseGetAdvertDetail forModule:ADVERT_MODULE withOption:option];

}

void ADAPI_GoldMallRefresh(DelegatorID delegatorID, NSString * orderNo, int orderType)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Mall/RefreshOrder"
                                                                    body:@{
                                                                           @"OrderNo":orderNo,
                                                                           @"OrderType":[NSNumber numberWithInt:orderType]
                                                                           }];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    [NET_SERVICE doRequest:ADOP_GoldMallRefresh forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_GoldMallOrderDetail(DelegatorID delegatorID, NSString * orderNo, NSInteger productType)
{
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Mall/CustomerGetOrderDetail"
                                                              parameters:@{@"OrderNo":orderNo,
                                                                           @"productType": [NSNumber numberWithInteger: productType]}];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR_COVER];
    
    [NET_SERVICE doRequest:ADOP_GoldMallOrderDetail forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_adv23_PersonalPreferenceGet(DelegatorID delegatorID)
{
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/CustomerSurvey/GetQuestions"];
    [option setDelegatorID:delegatorID];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_DEBUG_INFO];
    
    [NET_SERVICE doRequest:ADOP_adv23_PersonalPreferenceGet forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_PersonalPreferenceSet(DelegatorID delegatorID, NSString* questionId, NSArray *array) {

    ServerRequestOption* option = [ServerRequestOption
                                   optionFromService:@"api/CustomerSurvey/AnswerQuestion"
                                   body:@{@"QuestionId":questionId,
                                                @"ChosenOptionIds":array
                                                }];
    
    [option setDelegatorID:delegatorID];
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    
    [NET_SERVICE doRequest:ADOP_PersonalPreferenceSet forModule:ADVERT_MODULE withOption:option];
}

IMPLEMENT_ADAPI(RecommandMerchantBanner, (DelegatorID delegatorID)) {
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/MidBannerAdvert/List"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_DEBUG_INFO];
    
    [NET_SERVICE doRequest:ADOP_RecommandMerchantBanner forModule:ADVERT_MODULE withOption:option];
}

IMPLEMENT_ADAPI(GetRedPacketHome, (DelegatorID delegatorID)) {
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/DirectAdvert/Summary"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    
    [NET_SERVICE doRequest:ADOP_GetRedPacketHome forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_GetMerchantInformation(DelegatorID delegatorID, int merchantID) {

    ServerRequestOption* option = [ServerRequestOption optionFromService:@"api/Enterprise/Detail"
                                                              parameters:@{@"EnterpriseId":[NSString stringWithFormat:@"%d", merchantID]}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_DEBUG_INFO];
    [NET_SERVICE doRequest:ADOP_GetMerchantInformation forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_CreatMerchant(DelegatorID delegatorID, NSDictionary* dataDic) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Enterprise/SaveEnterprise"
                                                                    body:dataDic];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    [NET_SERVICE doRequest:ADOP_CreatMerchant forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_GetRedPacketStatement(DelegatorID delegatorID) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/DirectAdvert/About"];
    
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_GetRedPacketStatement forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_GetConvertCenterInfo(DelegatorID delegatorID, int convertCenterId) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/SilverAdvert/GetExchangeAddressDetail"
                                                              parameters:@{
                                                                           @"ExchangeAddressId":[NSString stringWithFormat:@"%d", convertCenterId]
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_GetConvertCenterInfo forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_RedPacketDetail(DelegatorID delegatorID, int adsId) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/DirectAdvert/Details"
                                                              parameters:@{
                                                                           @"Id":[NSString stringWithFormat:@"%d", adsId]
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_RedPacketDetail forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_CollectRedPacketAds(DelegatorID delegatorID, int advertId) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Favorite/CollectAdvert"
                                                                    body:@{
                                                                           @"AdvertType":@"2",
                                                                           @"AdvertId":[NSString stringWithFormat:@"%d",advertId]
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CollectRedPacketAds forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_CancelCollectRedPacketAds(DelegatorID delegatorID, int advertId) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Favorite/RemoveAdvert"
                                                                    body:@{
                                                                           @"AdvertType":@"2",
                                                                           @"AdvertId":[NSString stringWithFormat:@"%d", advertId]
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CancelCollectRedPacketAds forModule:ADVERT_MODULE withOption:option];

}

void ADAPI_GoldMallCancel(DelegatorID delegatorID, NSString * orderId)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldMall/Cancel"
                                                                    body:@{
                                                                           @"OrderId":orderId
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_GoldMallCancel forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_GoldMallRemind(DelegatorID delegatorID, NSString * orderNo, int orderType)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Mall/Remind"
                                                                    body:@{
                                                                           @"OrderNo":orderNo,
                                                                           @"OrderType":[NSNumber numberWithInteger:orderType]
                                                                           }];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_GoldMallRemind forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_GoldMallDelay(DelegatorID delegatorID, NSString * orderId)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldMall/Delay"
                                                                    body:@{
                                                                           @"OrderId":orderId
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_GoldMallDelay forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_GoldMallEnsure(DelegatorID delegatorID, NSString * orderId,NSString * PayPwd)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldMall/Ensure"
                                                                    body:@{
                                                                           @"OrderId":orderId,@"PayPwd":PayPwd
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_GoldMallEnsure forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_MyGoldMallGetReturnReasons(DelegatorID delegatorID, int returnType)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/MyGoldMall/GetReturnReasons"
                                                                    parameters:@{
                                                                           @"returnType":[NSNumber numberWithInteger:returnType]
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_MyGoldMallGetReturnReasons forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_GoldMallDelete(DelegatorID delegatorID,  NSString * orderNo, int orderType)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Mall/DeleteOrder"
                                                                    body:@{
                                                                           @"OrderNo":orderNo,
                                                                           @"OrderType":[NSNumber numberWithInteger:orderType]
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_GoldMallDelete forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_CustomerGoldGetCustomerGoldSummary(DelegatorID delegatorID)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/CustomerGold/GetCustomerGoldSummary"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CustomerGoldGetCustomerGoldSummary forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_CustomerGoldCheckPhoneVerified(DelegatorID delegatorID, NSString * phone)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/CustomerGold/CheckPhoneVerified"
                                                              parameters:@{
                                                                           @"Phone":phone
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CustomerGoldCheckPhoneVerified forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_CashStatement(DelegatorID delegatorID) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/CustomerCash/AccountSnap"];

    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CashStatement forModule:ADVERT_MODULE withOption:option];
}


void ADAPI_PublicBenifitAccount(DelegatorID delegatorID) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/CustomerCash/LoveAccount"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_PublicBenifitAccount forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_DeleteConvertCenter(DelegatorID delegatorID, int convertCenterId) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/SilverAdvert/DeleteExchangeAddress"
                                                              body:@{@"ExchangeAddressId":[NSString stringWithFormat:@"%d",convertCenterId]}];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest: ADOP_DeleteConvertCenter forModule:ADVERT_MODULE withOption:option];
}
    
void ADAPI_CanclePermissionOfManager(DelegatorID delegatorID, int managerId, int convertCenterId) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/SilverAdvert/CancelExchangeAddressManager"
                                                              body:@{
                                                                           @"ExchangeManagerId":[NSString stringWithFormat:@"%d", managerId],
                                                                           @"ExchangeAddressId":[NSString stringWithFormat:@"%d", convertCenterId]
                                                                           }];

    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_CanclePermissionOfManager forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_OpenRedPacket(DelegatorID delegatorID, NSString* adsId) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/DirectAdvert/Read"
                                                              body:@{
                                                                           @"Id":adsId
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_OpenRedPacket forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_GetContentByCode(DelegatorID delegatorID, NSString* code) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Operator/GetContentByContentCode"
                                                              parameters:@{
                                                                           @"ContentCode":code
                                                                           }];

    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_GetContentByCode forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_GetMerchantBasicInfoToRepost(DelegatorID delegatorID) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Enterprise/GetBasicInfo"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_GetMerchantBasicInfoToRepost forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_GetBankCardList(DelegatorID delegatorID) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/CustomerCash/BankList"];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_GetBankCardList forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_AddNewBankCard(DelegatorID delegatorID,NSDictionary* dataDic) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/CustomerCash/AppendBank"
                                                                    body:dataDic];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_AddNewBankCard forModule:ADVERT_MODULE withOption:option];
}
void ADAPI_RemoveBankCard(DelegatorID delegatorID,int bankCardId) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/CustomerCash/RemoveBank"
                                                                    body:@{
                                                                           @"BankId":[NSString stringWithFormat:@"%d",bankCardId]
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_RemoveBankCard forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_ApplyToGetCash(DelegatorID delegatorID,NSDictionary* dataDic) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/CustomerCash/RequestCashOut"
                                                                    body:dataDic];

    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_ApplyToGetCash forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_AdsBidding(DelegatorID delegatorID, NSString* AdsType, NSString* RegionType, NSString* RegionIds) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/BiddingAdvert/GetTopList"
                                                              parameters:@{
                                                                           @"AdvertType":AdsType,
                                                                           @"RegionType":RegionType,
                                                                           @"RegionId":RegionIds
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_AdsBidding forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_UpdateBiddingPrice(DelegatorID delegatorID, NSString* biddingId, NSString* biddingCount, double biddingPrice) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/BiddingAdvert/UpdateBidding"
                                                                    body:@{
                                                                           @"BiddingId":biddingId,
                                                                               @"Count":biddingCount,
                                                                               @"Price":[NSString stringWithFormat:@"%f",biddingPrice]
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_UpdateBiddingPrice forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_DeleteConvertManager (DelegatorID delegatorID, int managerId) {


    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/SilverAdvert/DeleteExchangeManager"
                                                              body:@{
                                                                           @"ExchangeManagerId":[NSString stringWithFormat:@"%d",managerId]
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_DeleteConvertManager forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_GetCashRecord(DelegatorID delegatorID, NSString *month) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/CustomerCash/CashOutRecord"
                                                              parameters:@{
                                                                           @"searchMonth":month
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_GetCashRecord forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_VerifyConvertManagers(DelegatorID delegatorID, NSArray* array) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/SilverAdvert/ValidateExchangeManager"
                                                                    body:@{
                                                                           @"Phones":array
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_VerifyConvertManagers forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_ApealingResult(DelegatorID delegatorID, int orderId) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldOrder/OrderArbitrateDetails"
                                                              parameters:@{
                                                                           @"OrderId":[NSString stringWithFormat:@"%d",orderId]
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_ApealingResult forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_MerchantDisgreeReturn(DelegatorID delegatorID, int orderId, NSString* reason, NSArray* pictureIds){

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldOrder/EnterpriseNotAgreeReturn"
                                                                    body:@{
                                                                           @"OrderId":[NSString stringWithFormat:@"%d",orderId],
                                                                            @"Reason":reason,
                                                                          @"Pictures":pictureIds
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_MerchantDisgreeReturn forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_LogisticsCompanyData(DelegatorID delegatorID) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/MyGoldMall/GetCompanys"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_LogisticsCompanyData forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_SalesReturnAndAfterSaleDetail(DelegatorID delegatorID, int orderId) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/MyGoldMall/GetAfterSaleDetail"
                                                              parameters:@{
                                                                           @"OrderId":[NSString stringWithFormat:@"%d",orderId]
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_SalesReturnAndAfterSaleDetail forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_MallRefund(DelegatorID delegatorID, NSDictionary *dic) {
    
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Mall/Refund"
                                                                    body:dic];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_MallRefund forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_ApplyToReturn(DelegatorID delegatorID, NSDictionary *dic) {
    
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/MyGoldMall/ApplyforReturn"
                                                                    body:dic];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_ApplyToReturn forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_ConfirmReturn(DelegatorID delegatorID, NSDictionary *dic) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/MyGoldMall/ConfirmReturn"
                                                                    body:dic];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_ConfirmReturn forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_UserStartApealing(DelegatorID delegatorID, NSDictionary *dic) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/MyGoldMall/ApplyForArbitrate"
                                                                    body:dic];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_UserStartApealing forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_MercahntStartApealing(DelegatorID delegatorID,NSDictionary *dic) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldOrder/EnterpriseApplyArbitration"
                                                                    body:dic];

    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_MerchantStartApealing forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_NegotiateReturnDetail(DelegatorID delegatorID, int orderId) {


    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/MyGoldMall/GetAfterSaleDetail"
                                                              parameters:@{
                                                                           @"OrderId":[NSString stringWithFormat:@"%d",orderId]
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_NegotiateReturnDetail forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_MerchantNegotiateReturnDetail(DelegatorID delegatorID, int orderId) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldOrder/OrderReturnDetails"
                                                              parameters:@{
                                                                           @"OrderId":[NSString stringWithFormat:@"%d",orderId]
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_MerchantNegotiateReturnDetail forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_SalesAndAfterSaleStatusCount(DelegatorID delegatorID) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldOrder/GetAfterSaleStatusCount"];
    
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_DEBUG_INFO];
    [NET_SERVICE doRequest:ADOP_SalesAndAfterSaleStatusCount forModule:ADVERT_MODULE withOption:option];
}

void ADAPI_GetInformationOfSpecialQualification(DelegatorID delegatorID, int industuryId) {

    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Industry/GetIndustryCertificationList"
                                                              parameters:@{
                                                                           @"IndustryId":[NSString stringWithFormat:@"%d", industuryId]
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [option turnOn:OPTION_NEED_DEBUG_INFO];
    [NET_SERVICE doRequest:ADOP_GetInformationOfSpecialQualification forModule:ADVERT_MODULE withOption:option];
}

//------------------ 易货商城商品管理 ------------------

//查询商品管理各状态下的数量
#define ADOP_GoldSearchProductCount         @"ADOP_GoldSearchProductCount"
void ADAPI_GoldSearchProductCount(DelegatorID delegatorID)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldProductManagement/SearchProductCount"];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_GoldSearchProductCount forModule:ADVERT_MODULE withOption:option];
}

//详情
void ADAPI_GoldCommodityDetail(DelegatorID delegatorID, int productId)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldProductManagement/GetProductDetail"
                                                              parameters:@{
                                                                           @"ProductId":[NSString stringWithFormat:@"%d", productId],
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_GoldCommodityDetail forModule:ADVERT_MODULE withOption:option];
}

//修改商品名称及规格名称
#define ADOP_UpdateCommodityProductName
void ADAPI_UpdateCommodityProductName(DelegatorID delegatorID, int productId, NSString *productName, NSArray *specList)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldProductManagement/EditProductName"
                                                              parameters:@{
                                                                           @"ProductId":[NSString stringWithFormat:@"%d", productId],
                                                                           @"ProductName":productName,
                                                                           @"ProductSpecList":specList,
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_GoldCommodityDetail forModule:ADVERT_MODULE withOption:option];
}

//修改商品
#define ADOP_UpdateCommodity        @"ADOP_UpdateCommodity"
void ADAPI_UpdateCommodity(DelegatorID delegatorID, int productId, CGFloat deliveryPrice, int offlineType, NSString *dateTime, NSArray *standardList)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldProductManagement/EditProduct"
                                                                    body:@{
                                                                           @"ProductId":[NSString stringWithFormat:@"%d", productId],
                                                                           @"DeliveryPrice":[NSString stringWithFormat:@"%.2f", deliveryPrice],
                                                                           @"OfflineType":[NSString stringWithFormat:@"%d", offlineType],
                                                                           @"OfflineDate":dateTime,
                                                                           @"ProductSpecList":standardList,
                                                                           
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_UpdateCommodity forModule:ADVERT_MODULE withOption:option];
}

//预览宝贝
void ADAPI_PreviewCommodity (DelegatorID delegatorID, int productId)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldMall/GetProduct"
                                                              parameters:@{
                                                                           @"ProductId":[NSString stringWithFormat:@"%d", productId],
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_PreviewCommodity forModule:ADVERT_MODULE withOption:option];
}

//收藏宝贝
void ADAPI_FavoriteCommodity (DelegatorID delegatorID, int productId, int AdvertType)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Favorite/CollectProduct"
                                                                    body:@{
                                                                           @"ProductId":[NSString stringWithFormat:@"%d", productId],
                                                                           @"AdvertId" : @"0",
                                                                           @"ProductType":[NSString stringWithFormat:@"%d", AdvertType],
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_FavoriteCommodity forModule:ADVERT_MODULE withOption:option];
}

//收藏宝贝-new
void ADAPI_FavoriteCommodity_new (DelegatorID delegatorID, int productId, int advertId,int AdvertType)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Favorite/CollectProduct"
                                                                    body:@{
                                                                           @"ProductId":[NSString stringWithFormat:@"%d", productId],
                                                                           @"AdvertId" :[NSString stringWithFormat:@"%d", advertId],
                                                                           @"ProductType":[NSString stringWithFormat:@"%d", AdvertType],
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_FavoriteCommodity forModule:ADVERT_MODULE withOption:option];
}

//取消收藏宝贝
void ADAPI_UnFavoriteCommodity_new (DelegatorID delegatorID, int productId, int advertId,int AdvertType)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Favorite/RemoveProduct"
                                                                    body:@{
                                                                           @"ProductId":[NSString stringWithFormat:@"%d", productId],
                                                                           @"AdvertId" : [NSString stringWithFormat:@"%d", advertId],
                                                                           @"ProductType":[NSString stringWithFormat:@"%d", AdvertType],
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_UnFavoriteCommodity forModule:ADVERT_MODULE withOption:option];
}

//取消收藏宝贝
void ADAPI_UnFavoriteCommodity (DelegatorID delegatorID, int productId, int AdvertType)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/Favorite/RemoveProduct"
                                                                    body:@{
                                                                           @"ProductId":[NSString stringWithFormat:@"%d", productId],
                                                                           @"AdvertId" : @"0",
                                                                           @"ProductType":[NSString stringWithFormat:@"%d", AdvertType],
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_UnFavoriteCommodity forModule:ADVERT_MODULE withOption:option];
}

//重新发起上架申请
void ADAPI_ResendPutaway(DelegatorID delegatorID, int productId)
{
    ServerRequestOption *option = [ServerRequestOption optionFromService:@"api/GoldProductManagement/PutawayApplyFor"
                                                                    body:@{
                                                                           @"ProductId":[NSString stringWithFormat:@"%d", productId],
                                                                           }];
    option.delegatorID = delegatorID;
    [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    [NET_SERVICE doRequest:ADOP_UnFavoriteCommodity forModule:ADVERT_MODULE withOption:option];
}