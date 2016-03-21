//
//  CRHtmlManager.h
//  miaozhuan
//
//  Created by abyss on 14/12/17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* CRHtmlManager_Code_UserPrivilige_Json;
extern NSString* CRHtmlManager_Code_HelpFeedback_Json;

extern NSString* CRHtmlManager_Code_RankList;
extern NSString* CRHtmlManager_Code_UsualQuestion;
extern NSString* CRHtmlManager_Code_ComplanyHistory;
extern NSString* CRHtmlManager_Code_FunctionIntroduce;
extern NSString* CRHtmlManager_Code_UserPriviligeBanner;
extern NSString* CRHtmlManager_Code_ComplanyInformation;

extern NSString* CRHtmlManager_Code_RecruitSupplement;
extern NSString* CRHtmlManager_Code_AttractBusiness;
extern NSString* CRHtmlManager_Code_SellerDiscount;

typedef void (^JsonResponse) (NSDictionary *dic);
typedef void (^UrlResponse) (NSString *url);

@interface CRHtmlManager : NSObject

- (void)getUrlFromOperationServerce:(NSString *)code block:(UrlResponse)block;
- (void)getJsonFromOperationServerce:(NSString *)code block:(JsonResponse)block;

@end
