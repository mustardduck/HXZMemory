//
//  CRWebSupporter.h
//  miaozhuan
//
//  Created by abyss on 15/1/15.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CRWebEvent)
{
    //已经实现功能列表
    CRWebEventUnknow            = 0,
    
//    CRWebEventMakeCall      = 1,
//    CRWebEventSendEmail     = 2,
//    CRWebEventGPSPositon    = 3,
//    CRWebEventGetApp        = 4,
    
    CRWebEventBuyCustomerVIP    = 5,
    CRWebEventBuyEnterpriseVIP  = 6,
    CRWebEventBuyGold           = 7,
    
    CRWebEventShowProduct       = 8,
    CRWebEventShowEnterprise    = 9,
    CRWebEventShowAdvert        = 10,
    
    CRWebEventShareAttr         = 20,
    CRWebEventShareKey          = 21,
    CRWebEventMessageCenter     = 22,
    CRWebEventPrimaryModel      = 23,
    CRWebEventSecondaryModel    = 24,
    CRWebEventTopEnterprise     = 25,
    CRWebEventMall              = 26,
    CRWebEventTanksgivingShare  = 27,
    
    CRWEBEventThanksgivingFruit = 28,
    CRWebEventShowAccount       = 29,
    CRWebEventPublishAdvert     = 30,
    
    CRWebEventClose             = 99,
    CRWebEventShowContent       = 100,
};

@interface CRWebSupporter : NSObject
@property (retain, nonatomic) NSMutableArray* urlStack;
@property (retain, nonatomic) UIWebView*      father;

+ (void)responeseEventFor:(NSString *)url;
+ (void)responeseEventFrom:(NSDictionary *)indexData;

+(void)bannerForward:(DictionaryWrapper *)wrapper;

/**
 * @brief  初始化CRWebSupporter
 * @param viewController 页面
 * @return CRWebSupporter
 */
+ (CRWebSupporter*) supportFromViewController:(UIWebView *)webView;
- (void) supportFor: (UIWebView *)webView;
- (void) getContent: (NSString *)content;
- (void) webBack;

@end

@interface NSString (fixByRoger)

- (BOOL)containsString:(NSString *)aString;
@end
