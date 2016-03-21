//
//  CRHtmlManager.m
//  miaozhuan
//
//  Created by abyss on 14/12/17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CRHtmlManager.h"

NSString* CRHtmlManager_Code_UserPrivilige_Json     = @"34dc66b2b7fdfd4044f410ff31b615c0";
NSString* CRHtmlManager_Code_HelpFeedback_Json      = @"8971dea9df80b308ca34606f9e9bfa23";

NSString* CRHtmlManager_Code_RankList               = @"6dc1bc7a300876ae3abce5367b652a62";
NSString* CRHtmlManager_Code_UsualQuestion          = @"3656f4c5f028484b0cf47540f25e4b9d";
NSString* CRHtmlManager_Code_ComplanyHistory        = @"01e0b095ae89cac3398ad362784edd15";
NSString* CRHtmlManager_Code_FunctionIntroduce      = @"21329a5d2f069ccb6cd9c0071f94a910";
NSString* CRHtmlManager_Code_UserPriviligeBanner    = @"148f9765f322a0d1bd478b6eeae3d684";
NSString* CRHtmlManager_Code_ComplanyInformation    = @"458a7934b00e2571e1c647a099722de9";

NSString*  CRHtmlManager_Code_RecruitSupplement     = @"be41fae3f8c9c65d59990f1f9e954c00"; //招聘信息说明
NSString*  CRHtmlManager_Code_AttractBusiness       = @"241119c03375473e8f9969b6af5c3546"; //招商信息说明
NSString*  CRHtmlManager_Code_SellerDiscount        = @"24547669387f37caffbcd086e2ff4733"; //商家优惠说明

@interface CRHtmlManager ()
{
    JsonResponse _jsonResponseBlock;
    UrlResponse _urlResponseBlock;
}
@end
@implementation CRHtmlManager

- (void)getFromOperationServerce:(NSString *)code
{
    ADAPI_adv3_registerGetContentByContentCode([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(eventBack:)], code);
}

- (void)getUrlFromOperationServerce:(NSString *)code block:(UrlResponse)block
{
    _urlResponseBlock = nil;
    _urlResponseBlock = [block copy];
    
    [self getFromOperationServerce:code];
}

- (void)getJsonFromOperationServerce:(NSString *)code block:(JsonResponse)block
{
    _jsonResponseBlock = nil;
    _jsonResponseBlock = [block copy];
    
    [self getFromOperationServerce:code];
}

#pragma mark - Event 

- (void)eventBack:(DelegatorArguments *)arg
{
    DictionaryWrapper* wrapper = arg.ret;
    NSLog(@"%@",wrapper.dictionary);
    NSLog(@"===============================\n wait to fix =========");
}

@end
