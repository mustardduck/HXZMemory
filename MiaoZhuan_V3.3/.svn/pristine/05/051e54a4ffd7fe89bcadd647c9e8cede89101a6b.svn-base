//
//  CRWebSupporter.m
//  miaozhuan
//
//  Created by abyss on 15/1/15.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "CRWebSupporter.h"
#import "WebhtmlViewController.h"

#import "VIPPrivilegeViewController.h"
#import "CRSliverDetailViewController.h"
#import "Preview_Commodity.h"
#import "BuyGoldViewController.h"
#import "VipPriviliegeViewController.h"
#import "Share_Method.h"
#import "AdsDetailViewController.h"
#import "MerchantDetailViewController.h"
#import "JSONKit.h"
#import "DetailBannerAdvertViewController.h"
#import "PSOrganizationInfoViewController.h"
#import "PSAsDetailController.h"
#import "DetailBannerAdvertViewController.h"
#import "OpenRedPacketViewController.h"

#import "ControlViewController.h"
#import "HandleOutAdsViewController.h"
#import "PersonalCenterViewController.h"

#import "ThankfulFruitViewController.h"
#import "AddAccurateAdsViewController.h"
#import "NotiftCenterViewController.h"
#import "RecommendMerchantViewController.h"
#import "ThankFulMechanismViewController.h"
#import "BuyGoldViewController.h"
#import "AdsViewController.h"
#import "GetRedPacketsViewController.h"
#import "AdvertCollectionViewController.h"
#import "RankListViewController.h"
#import "CRMallManagerViewContrillrtViewController.h"
#import "ConsumerPriviliegeViewController.h"
#import "FindShopController.h"
#import "YinYuanAdvertEditController.h"
#import "AddNextStepViewController.h"
#import "AdsBiddingAndManagement.h"
#import "ExchangeMangerViewController.h"
#import "VIPPrivilegeViewController.h"
#import "CustomerConsultationViewController.h"
#import "DataAnalysis.h"
#import "PersonalCertificateViewController.h"
#import "ThankFulMechanismViewController.h"
#import "OwnSliverManagerViewController.h"
#import "MyCashHomeViewController.h"
#import "MyGoldMainController.h"
#import "CommonSettingViewController.h"
#import "AboutViewController.h"
#import "PurchaseGoldByCarrieroperatorViewController.h"
#import "YinYuanAdvertEditController.h"
#import "MallScanAdvertMain.h"
#import "YinYuanAdvertMainController.h"
#import "ThankFulFansStatisticalViewController.h"
#import "YinYuanManageMainController.h"

static BOOL CRWebSupporter_Debug = YES;
#define crws_debug(_something) if (CRWebSupporter_Debug) { _something}
#define crws_push(_vc) \
_vc* model = WEAK_OBJECT(_vc, init); \
[UI_MANAGER.mainNavigationController pushViewController:model animated:NO]; \
[NSThread sleepForTimeInterval:0.6f]; \
crws_debug( NSLog(@"event:%d",(int)event);)

@interface CRWebSupporter ()
+ (void)responeseOption:(NSString *)option with:(DictionaryWrapper *)wrapper;
+ (void)responeseEvent:(CRWebEvent)event with:(DictionaryWrapper *)wrapper;
@end

@implementation CRWebSupporter

+ (void)responeseEventFrom:(NSDictionary *)indexData
{
    if (indexData == nil) return;
    //    NSString* option = [indexData.wrapper getString:@"Event"];
    //    [CRWebSupporter responeseOption:option with:[indexData.wrapper getDictionaryWrapper:@"Params"]];
    [CRWebSupporter bannerForward:[indexData wrapper]];
}

+(void)bannerForward:(DictionaryWrapper *)wrapper
{
    NSLog(@"\n\n%@\n\n", wrapper);
    
    //事件类型
    int eventType = [wrapper getInt:@"Type"];
    
    switch (eventType) {
            
            //显示商品
        case 1:
        {
            [CRWebSupporter responeseEvent:CRWebEventShowProduct with:wrapper];
        }
            break;
            
            //显示商家
        case 2:
        {
            [CRWebSupporter responeseEvent:CRWebEventShowEnterprise with:wrapper];
        }
            break;
            
            //显示广告
        case 3:
        {
            [CRWebSupporter responeseEvent:CRWebEventShowAdvert with:wrapper];
        }
            break;
            
            //购买用户VIP
        case 6:
        {
            [CRWebSupporter responeseEvent:CRWebEventBuyCustomerVIP with:wrapper];
        }
            break;
            
            //购买商家VIP
        case 7:
        {
            [CRWebSupporter responeseEvent:CRWebEventBuyEnterpriseVIP with:wrapper];
        }
            break;
            
            //购买金币
        case 8:
        {
            [CRWebSupporter responeseEvent:CRWebEventBuyGold with:wrapper];
        }
            break;
            
            //显示网页
        case 9:
        {
            [CRWebSupporter responeseEvent:CRWebEventShowContent with:wrapper];
        }
            break;
            
            //竞价广告
        case 999:
            //竞价广告
        {
            DetailBannerAdvertViewController *detailBanner = WEAK_OBJECT(DetailBannerAdvertViewController, init);
            detailBanner.adId = [wrapper getString:@"BiddingId"];
            detailBanner.advertId = [wrapper getString:@"AdvertId"];
            [UI_MANAGER.mainNavigationController pushViewController:detailBanner animated:YES];
        }
            break;
            
        default:
            break;
    }
}

//解析url为 方法名 与 参数
+ (void)responeseEventFor:(NSString *)url
{
    crws_debug( NSLog(@"url:%@",url);)
    //Ensure html will call app.
    if (![url hasPrefix:@"h5callapp"]) return;
    
    NSString* methodName = nil;
    NSDictionary* paraDic = nil;
    
    //Get Method.name and .objct
    NSString* option = [url substringFromIndex:11];
    crws_debug( NSLog(@"option:%@",option);)
    
    NSString* sepFlag = @":";
    if (![option containsString:sepFlag])
    {
        //Send event without objct
        [CRWebSupporter responeseOption:option with:nil];
        return;
    }
    
    NSRange   flagPos = [option rangeOfString:sepFlag];
    crws_debug( NSLog(@"flagPos:%d-%d",(int)flagPos.length,(int)flagPos.location);)
    
    methodName = [option substringToIndex:flagPos.location];
    NSString* objectStr = [option substringFromIndex:flagPos.location + 1];
    crws_debug( NSLog(@"name:%@ \n objct:%@",methodName,objectStr);)
    
    // GetWrapper: type=0&id=97&advertId=77&readonly=1
    {
        sepFlag = @"&";
        NSMutableArray *paraArray = [NSMutableArray array];
        while ([objectStr containsString:sepFlag])
        {
            flagPos = [objectStr rangeOfString:sepFlag];
            NSString* paraString = [objectStr substringToIndex:flagPos.location];
            
            objectStr   = [objectStr substringFromIndex:flagPos.location + 1];
            crws_debug( NSLog(@"str:%@",objectStr);)
            [paraArray addObject:paraString];
        }
        
        sepFlag = @"=";
        if ([objectStr containsString:sepFlag]) [paraArray addObject:objectStr];
        crws_debug( NSLog(@"array:%@",paraArray);)
        
        NSMutableDictionary *retDic = [NSMutableDictionary dictionary];
        NSString* key   = nil;
        NSString* value = nil;
        for (NSString* para in paraArray)
        {
            if ([objectStr containsString:sepFlag])
            {
                flagPos = [para rangeOfString:sepFlag];
                
                key     = [para substringToIndex:flagPos.location];
                value   = [para substringFromIndex:flagPos.location + 1];
                crws_debug( NSLog(@"key:%@ value:%@",key,value);)
                
                if (key && key.length > 0) [retDic setObject:value forKey:key];
            }
        }
        
        paraDic = retDic.dictionary;
        crws_debug( NSLog(@"dictionary:%@",paraDic);)
    }
    
    [CRWebSupporter responeseOption:methodName with:paraDic.wrapper];
}

+ (void)responeseOption:(NSString *)option with:(DictionaryWrapper *)wrapper
{
    crws_debug( NSLog(@"\noptionName:%@ \n wrapper:%@",option,wrapper.dictionary);)
    
    //购买用户VIP
    if ([option isEqualToString:@"buyCustomerVip"])
    {
        [CRWebSupporter responeseEvent:CRWebEventBuyCustomerVIP with:wrapper];
    }
    
    //购买商家VIP
    else if ([option isEqualToString:@"buyEnterpriseVip"])
    {
        [CRWebSupporter responeseEvent:CRWebEventBuyEnterpriseVIP with:wrapper];
    }
    
    //购买金币
    else if ([option isEqualToString:@"buyGold"])
    {
        [CRWebSupporter responeseEvent:CRWebEventBuyGold with:wrapper];
    }
    
    //购买感恩果
    else if([option isEqualToString:@"buyThanksgivingFruit"])
    {
        [CRWebSupporter responeseEvent:CRWEBEventThanksgivingFruit with:wrapper];
    }
    
    //显示商品详情
    else if ([option isEqualToString:@"showProduct"])
    {
        [CRWebSupporter responeseEvent:CRWebEventShowProduct with:wrapper];
    }
    
    //显示商家详情
    else if ([option isEqualToString:@"showEnterprise"])
    {
        [CRWebSupporter responeseEvent:CRWebEventShowEnterprise with:wrapper];
    }
    
    //显示广告详情
    else if ([option isEqualToString:@"showAdvert"])
    {
        [CRWebSupporter responeseEvent:CRWebEventShowAdvert with:wrapper];
    }
    
    //显示运维内容
    else if ([option isEqualToString:@"showContent"])
    {
        [CRWebSupporter responeseEvent:CRWebEventShowContent with:wrapper];
    }
    
    //显示我的账户
    else if([option isEqualToString:@"showMyAccount"])
    {
        [CRWebSupporter responeseEvent:CRWebEventShowAccount with:wrapper];
    }
    
    //发布广告
    else if([option isEqualToString:@"publishAdvert"])
    {
        [CRWebSupporter responeseEvent:CRWebEventPublishAdvert with:wrapper];
    }
    
    //自定义内容分享, 分享(方法一)
    else if ([option isEqualToString:@"shareByAttr"])
    {
        [CRWebSupporter responeseEvent:CRWebEventShareAttr with:wrapper];
    }
    
    //标准分享, 分享(方法二)
    else if ([option isEqualToString:@"shareByKey"])
    {
        [CRWebSupporter responeseEvent:CRWebEventShareKey with:wrapper];
    }
    
    //进入消息中心
    else if([option isEqualToString:@"gotoMessageCenter"])
    {
        [CRWebSupporter responeseEvent:CRWebEventMessageCenter with:wrapper];
    }
    
    //进入第一级功能模块
    else if([option isEqualToString:@"gotoPrimaryModel"])
    {
        [CRWebSupporter responeseEvent:CRWebEventPrimaryModel with:wrapper];
    }
    
    //进入第二级功能模块
    else if([option isEqualToString:@"gotoSecondaryModel"])
    {
        [CRWebSupporter responeseEvent:CRWebEventSecondaryModel with:wrapper];
    }
    
    //进入推荐商家
    else if([option isEqualToString:@"gotoTopEnterprise"])
    {
        [CRWebSupporter responeseEvent:CRWebEventTopEnterprise with:wrapper];
    }
    
    //进入商城
    else if([option isEqualToString:@"gotoMall"])
    {
        [CRWebSupporter responeseEvent:CRWebEventMall with:wrapper];
    }
    
    //进入 感恩分享
    else if([option isEqualToString:@"gotoThanksgivingShare"])
    {
        [CRWebSupporter responeseEvent:CRWebEventTanksgivingShare with:wrapper];
    }
    
    //关闭当前WebView
    else if ([option isEqualToString:@"closeWebView"])
    {
        [CRWebSupporter responeseEvent:CRWebEventClose with:wrapper];
    }
}



+ (void)responeseEvent:(CRWebEvent)event with:(DictionaryWrapper *)wrapper
{
    
    //购买用户VIP
    if (event == CRWebEventBuyCustomerVIP)
    {
        crws_push(VipPriviliegeViewController);
    }
    
    //购买商家VIP
    else if (event == CRWebEventBuyEnterpriseVIP)
    {
        crws_push(VIPPrivilegeViewController);
    }
    
    //购买金币
    else if (event == CRWebEventBuyGold)
    {
        crws_push(BuyGoldViewController);
    }
    
    //购买感恩果
    else if (event == CRWEBEventThanksgivingFruit)
    {
        crws_push(ThankfulFruitViewController);
    }
    
    //显示商品详情
    else if (event == CRWebEventShowProduct)
    {
        
        DictionaryWrapper *dic = [[[wrapper getString:@"Params"] objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode] wrapper];
        
        //商品类型
        int productType = 0;
        int productId   = 0;
        BOOL readOnly   = NO;
        
        if(!dic || [dic isKindOfClass:[NSNull class]])
        {
            if(wrapper && ![wrapper isKindOfClass:[NSNull class]])
            {
                productType = [wrapper getInt:@"type"];
                productId   = [wrapper getInt:@"id"];
                readOnly   = [wrapper getBool:@"readonly"];
            }
        }
        else
        {
            //商品类型
            productType = [dic getInt:@"Type"];
            productId   = [dic getInt:@"Id"];
            readOnly   = [dic getBool:@"Readonly"];
        }
        if(productId == 0 || !productId)
            return;
        
        //银元商品
        if (productType == 0)
        {
            int advertId = 0;
            if(!dic || [dic isKindOfClass:[NSNull class]])
            {
                if(wrapper && ![wrapper isKindOfClass:[NSNull class]])
                {
                    advertId    = [wrapper getInt:@"advertId"];
                }
            }
            else
                advertId    = [dic getInt:@"AdvertId"];
            
            crws_push(CRSliverDetailViewController);
            model.productId = productId;
            model.advertId  = advertId;
        }
        
        //金币商品
        else if (productType == 1)
        {
            crws_push(Preview_Commodity);
            model.productId = productId;
            //是否只读
            if(readOnly)
                model.whereFrom = 0;
            else
                model.whereFrom = 1;
        }
        
        //直购商品
        else if(productType == 2)
        {
            
        }
    }
    
    //显示商家详情
    else if (event == CRWebEventShowEnterprise)
    {
        DictionaryWrapper *dic = [[[wrapper getString:@"Params"] objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode] wrapper];
//        int enterpriseType = [dic getInt:@"Type"];
//        NSString *enterpriseId = [dic getString:@"Id"];
//        if (!enterpriseId.length || [enterpriseId isKindOfClass:[NSNull class]]) {
//            return;
//        }
        
        //商品类型
        int enterpriseType = 0;
        NSString *enterpriseId = @"";
        BOOL readOnly   = NO;
        
        if(!dic || [dic isKindOfClass:[NSNull class]])
        {
            if(wrapper && ![wrapper isKindOfClass:[NSNull class]])
            {
                enterpriseType = [wrapper getInt:@"type"];
                enterpriseId   = [wrapper getString:@"id"];
                readOnly   = [wrapper getBool:@"readonly"];
            }
        }
        else
        {
            //商品类型
            enterpriseType = [dic getInt:@"Type"];
            enterpriseId   = [dic getString:@"Id"];
            readOnly   = [dic getBool:@"Readonly"];
        }
        if([enterpriseId isEqualToString:@"0"] || enterpriseId == nil || [enterpriseId isKindOfClass:[NSNull class]])
            return;
        
        switch (enterpriseType) {
                //运营商
            case 1:
            {
                crws_push(PurchaseGoldByCarrieroperatorViewController);
                
            }
                break;
                
                //公益组织
            case 2:
            {
                crws_push(PSOrganizationInfoViewController);
                model.orzId = enterpriseId;
                model.comeFrom = @"0";
            }
                break;
                
                //商家
            case 0:
            default:
            {
                crws_push(MerchantDetailViewController);
                model.comefrom = @"0";
                model.enId = enterpriseId;
            }
                break;
        }
    }
    
    
    //显示广告详情
    else if (event == CRWebEventShowAdvert)
    {
        DictionaryWrapper *dic = [[[wrapper getString:@"Params"] objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode] wrapper];
//        int advertType = [dic getInt:@"Type"];
//        NSString *advertId = [dic getString:@"Id"];
//        if (!advertId.length || [advertId isKindOfClass:[NSNull class]]) {
//            return;
//        }
        
        //商品类型
        int advertType = 0;
        NSString *advertId = @"";
        
        if(!dic || [dic isKindOfClass:[NSNull class]])
        {
            if(wrapper && ![wrapper isKindOfClass:[NSNull class]])
            {
                advertType = [wrapper getInt:@"type"];
                advertId   = [wrapper getString:@"id"];
            }
        }
        else
        {
            //商品类型
            advertType = [dic getInt:@"Type"];
            advertId   = [dic getString:@"Id"];
        }
        if([advertId isEqualToString:@"0"] || advertId == nil || [advertId isKindOfClass:[NSNull class]])
            return;
        
        
        switch (advertType) {
                
                //银元广告
            case 0:
            {
                crws_push(AdsDetailViewController);
                model.isMerchant = YES;
                model.adId = advertId;
            }
                break;
                
                //红包广告
            case 1:
            {
                crws_push(OpenRedPacketViewController);
                model.adsId = [advertId intValue];
            }
                break;
                
                //公益广告
            case 2:
            {
                crws_push(PSAsDetailController);
                model.adId = advertId;
                model.notShow = NO;
            }
                break;
                
                //首页竞价广告
            case 3:
            {
                crws_push(DetailBannerAdvertViewController);
                model.adId = advertId;
            }
                break;
                
            default:
                break;
        }
    }
    
    //显示运维内容
    else if (event == CRWebEventShowContent)
    {
        crws_push(WebhtmlViewController);
        
        if([wrapper getString:@"Code"] == nil || [[wrapper getString:@"Code"] isEqualToString:@""] || [[wrapper getString:@"Code"] isKindOfClass:[NSNull class]])
            model.ContentCode = [wrapper getString:@"code"];
        else
            model.ContentCode = [wrapper getString:@"Code"];
    }
    
    //显示我的账户
    else if (event == CRWebEventShowAccount)
    {
        int type = [wrapper getInt:@"type"];
        
        switch (type) {
                
                //我的银元
            case 0:
            {
                crws_push(OwnSliverManagerViewController);
            }
                break;
                
                //我的金币
            case 1:
            {
                crws_push(MyGoldMainController);
            }
                break;
                
                //我的现金
            case 2:
            {
                crws_push(MyCashHomeViewController);
            }
                break;
                
            default:
                break;
        }
    }
    
    //发布广告
    else if (event == CRWebEventPublishAdvert)
    {
        int type = [wrapper getInt:@"type"];
        
        switch (type) {
                
                //发布红包广告
            case 1:
                
                break;
                
                //发布公益广告
            case 2:
                
                break;
                
                //发布银元广告
            case 0:
            default:
            {
//                crws_push(YinYuanAdvertEditController);
                crws_push(YinYuanManageMainController);
            }
                break;
        }
        
    }
    
    //分享方法一
    else if (event == CRWebEventShareAttr)
    {
        [[Share_Method shareInstance] shareToPlatform:wrapper];
    }
    
    //分享方法二
    else if (event == CRWebEventShareKey)
    {
        NSString *str = [wrapper getString:@"targets"];
        
        NSMutableArray *tags = (NSMutableArray *)[str componentsSeparatedByString:@","];
        
        for(int i = 0; i < tags.count; i++)
        {
            [tags replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:[[tags objectAtIndex:i] intValue]]];
        }
        
        [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":[wrapper getString:@"key"]} withPlatforms:tags];
        
    }
    
    
    //进入消息中心
    else if( event == CRWebEventMessageCenter)
    {
        crws_push(NotiftCenterViewController);
    }
    
    //进入第一级功能模块
    else if( event == CRWebEventPrimaryModel)
    {
        
        int type = [wrapper getInt:@"index"];
        for (UIViewController *vc in UI_MANAGER.mainNavigationController.viewControllers) {
            if ([vc isKindOfClass:[ControlViewController class]]) {
                [UI_MANAGER.mainNavigationController popToViewController:vc animated:YES];
                UIButton *btn = (UIButton*)[vc.view viewWithTag:type + 1];
                [(ControlViewController*)vc tabbarItemClicked:btn];
            }
        }
    }
    
    //进入二级功能模块
    else if( event == CRWebEventSecondaryModel)
    {
        [CRWebSupporter showSecondModel:wrapper];
    }
    
    //进入推荐商家
    else if( event == CRWebEventTopEnterprise)
    {
        crws_push(RecommendMerchantViewController);
    }
    
    //进入商城
    else if( event == CRWebEventMall)
    {
        int type = [wrapper getInt:@"type"];
        
        switch (type) {
                
                //兑换商城
            case 0:
            {
#pragma mark --- 调整的地方 需要传参 确定商城类型
                crws_push(MallScanAdvertMain);
            }
                break;
                
                //易货商城
            case 1:
            {
#pragma mark --- 调整的地方 需要传参 确定商城类型
                crws_push(MallScanAdvertMain);
                model.startPage = 1;
                
            }
                break;
                
                //直购商城
            case 2:
            {
#pragma mark --- 调整的地方 需要传参 确定商城类型
                crws_push(ExchangeMangerViewController);
                
            }
                break;
                
            default:
            {
                crws_push(MallScanAdvertMain);
            }
                break;
        }
    }
    
    //进入感恩分享
    else if( event == CRWebEventTanksgivingShare)
    {
        crws_push(ThankFulFansStatisticalViewController);
        model.xtitle = @"感恩分享";
        
    }
    
    //关闭当前WebView
    else if (event == CRWebEventClose)
    {
        BOOL hasClosed = NO;//是否有其他页面关闭，没有其他页面关闭则关闭当前WebView
        
        for (UIView* subView in APP_DELEGATE.window.subviews)
        {
            if ([subView isKindOfClass:[DotCWebView class]])
            {
                [subView removeFromSuperview];
                
                hasClosed = YES;
            }
        }
        
        if (![UI_MANAGER.mainNavigationController.viewControllers.lastObject isKindOfClass:[WebhtmlViewController class]])
        {
            crws_debug( NSLog(@"stack:%@",UI_MANAGER.mainNavigationController.viewControllers);)
            
            NSMutableArray *newStack = [NSMutableArray new];
            for (UIViewController *view in UI_MANAGER.mainNavigationController.viewControllers)
            {
                if (! [view isKindOfClass:[WebhtmlViewController class]])
                {
                    [newStack addObject:view];
                }
            }
            UI_MANAGER.mainNavigationController.viewControllers = newStack;
            [newStack release];
            
            hasClosed = YES;
        }
        
        if(!hasClosed)
        {
            UIViewController *v = UI_MANAGER.mainNavigationController.visibleViewController;
            
            if([v isKindOfClass:[WebhtmlViewController class]])
            {
                [UI_MANAGER.mainNavigationController popToRootViewControllerAnimated:YES];
            }
        }
    }
}

+ (CRWebSupporter*) supportFromViewController:(DotCWebView *)webView
{
    CRWebSupporter* ret = STRONG_OBJECT(CRWebSupporter, init);
    //    webView.dotCDelegate = ret;
    ret.father = webView;
    
    return ret;
}

+ (CRWebSupporter*) supportFrom:(id)object
{
    CRWebSupporter* ret = STRONG_OBJECT(CRWebSupporter, init);
    ret.father = object;
    
    return ret;
}

- (void) getUrlFrom: (UIWebView *)webView
{
    NSString* newUrl = webView.request.URL.absoluteString;
    
    if (![newUrl hasPrefix:@"http"]) return;
    
    if (_urlStack && _urlStack.count > 0)
    {
        if (![_urlStack containsObject:newUrl])
        {
            [_urlStack addObject:newUrl];
        }
    }
    else
    {
        _urlStack = [NSMutableArray new];
        [_urlStack addObject:newUrl];
    }
}

- (void) supportFor: (UIWebView *)webView
{
    [self getUrlFrom:webView];
    [self setNavTitleFor:webView];
    [self addTool];
}

- (void) getContent: (NSString *)content
{
    if (_urlStack && _urlStack.count > 0)
    {
        [_urlStack addObject:content];
    }
    else
    {
        _urlStack = [NSMutableArray new];
        [_urlStack addObject:content];
    }
}

- (void) addTool
{
    UIViewController* ret = [UICommon getOldViewController:[WebhtmlViewController class]];
    if (_urlStack.count == 1)
    {
        ret.navigationItem.leftBarButtonItems = nil;
        
        UIButton* btn = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake( - 9, 5, 15, 34));
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        [btn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(webBack) forControlEvents:UIControlEventTouchUpInside];
        
        ret.navigationItem.leftBarButtonItem = WEAK_OBJECT(UIBarButtonItem, initWithCustomView:btn);
    }
    else
    {
        UIButton *closeBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBt addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        closeBt.frame = CGRectMake(0, 0, 40, 30);
        [closeBt setTitle:@"关闭" forState:UIControlStateNormal];
        ret.navigationItem.leftBarButtonItems = @[ret.navigationItem.leftBarButtonItem,WEAK_OBJECT(UIBarButtonItem, initWithCustomView:closeBt)];
    }
}

- (void)webBack
{
    if (_urlStack.count == 1)
    {
        [self close];
    }
    else
    {
        [_urlStack removeLastObject];
        if ([_urlStack.lastObject hasPrefix:@"http"])
        {
            [_father goBack];
        }
        else
        {
            [_father loadHTMLString:_urlStack.lastObject baseURL:nil];
        }
    }
}

- (void)dealloc
{
    [_urlStack release];
    [_father release];
    
    [super dealloc];
}

- (void)close
{
    [UI_MANAGER.mainNavigationController popViewControllerAnimated:YES];
}

- (void)setNavTitleFor: (UIWebView *)webView
{
    UIViewController* ret = [UICommon getOldViewController:[WebhtmlViewController class]];
    NSString *theTitle= [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    if(![theTitle isEqualToString:@""] && theTitle != nil && ![theTitle isEqual:[NSNull null]])
    {
        ret.title = theTitle;
        
        if([theTitle isEqualToString:@"公司资质"]) webView.scrollView.bounces = NO;
        
//        if([theTitle isEqualToString:@"用户兑换区"] )
//            ret.title = @"用户兑换区";
//        else if([theTitle isEqualToString:@"商家兑换区"] )
//            ret.title = @"商家兑换区";
    }
}

-(void)a{
    
}

//进入第二级功能模块
+(void)showSecondModel:(DictionaryWrapper *)wrapper
{
    int parentIndex = [wrapper getInt:@"parentIndex"];
    int index = [wrapper getInt:@"index"];
    
    switch (parentIndex) {
            
            //看广告
        case 0:
        {
            switch (index) {
                    
                    //捡银元
                case 0:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AdsViewController, init) animated:NO];
                }
                    break;
                    
                    //收红包
                case 1:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(GetRedPacketsViewController, init) animated:NO];
                }
                    break;
                    
                    //广告收藏
                case 2:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AdvertCollectionViewController, init) animated:NO];
                }
                    break;
                    
                    //排行榜
                case 3:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(RankListViewController, init) animated:NO];
                }
                    break;
                    
                    //商城
                case 4:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(CRMallManagerViewContrillrtViewController, init) animated:NO];
                }
                    break;
                    
                    //用户特权
                case 5:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(ConsumerPriviliegeViewController, init) animated:NO];
                    
                }
                    break;
                    
                    //寻找商家
                case 6:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(FindShopController, init) animated:NO];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
            //发广告
        case 1:
        {
            switch (index) {
                    
                    //发布银元广告
                case 0:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(YinYuanAdvertEditController, init) animated:NO];
                    
                }
                    break;
                    
                    //发布精准直投
                case 1:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AddNextStepViewController, init) animated:NO];
                }
                    break;
                    
                    //发布竞价广告
                case 2:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AdsBiddingAndManagement, init) animated:NO];
                }
                    break;
                    
                    //商城管理
                case 3:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(ExchangeMangerViewController, init) animated:NO];
                }
                    break;
                    
                    //商家特权
                case 4:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(VIPPrivilegeViewController, init) animated:NO];
                }
                    break;
                    
                    //客户咨询
                case 5:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(CustomerConsultationViewController, init) animated:NO];
                }
                    break;
                    
                    //数据分析
                case 6:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(DataAnalysis, init) animated:NO];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
            //我
        case 2:
        {
            switch (index) {
                    
                    //个人认证
                case 0:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(PersonalCertificateViewController, init) animated:NO];
                }
                    break;
                    
                    //感恩机制
                case 1:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(ThankFulMechanismViewController, init) animated:NO];
                }
                    break;
                    
                    //我的银元
                case 2:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(OwnSliverManagerViewController, init) animated:NO];
                }
                    break;
                    
                    //我的现金
                case 3:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(MyCashHomeViewController, init) animated:NO];
                }
                    break;
                    
                    //我的金币
                case 4:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(MyGoldMainController, init) animated:NO];
                }
                    break;
                    
                    //通用设置
                case 5:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(CommonSettingViewController, init) animated:NO];
                }
                    break;
                    
                    //关于秒赚
                case 6:
                {
                    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AboutViewController, init) animated:NO];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
}


@end

@implementation NSString (fixByRoger)

- (BOOL)containsString:(NSString *)aString
{
    return ([self rangeOfString:aString].length>0);
}

@end
