//
//  Share_Method.m
//  miaozhuan
//
//  Created by 孙向前 on 14-10-27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "Share_Method.h"
#import <ShareSDK/ShareSDK.h>

@interface Share_Method(){
    NSArray *list;
}

@end

//NSString *keyword = @"index";
static Share_Method *shareInstance = nil;
@implementation Share_Method

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!shareInstance)
        {
            shareInstance = [[Share_Method alloc] init];
        }
    });
    return shareInstance;
}

/*
 *  分享请求
 */
- (void)getShareDataWithShareData:(NSDictionary *)shareInfo{
    ADAPI_adv2_Share([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleShare:)], shareInfo);
}

- (void)getShareDataWithShareData:(NSDictionary *)shareInfo withPlatforms:(NSArray *)platfroms{
    [self getShareDataWithShareData:shareInfo];
    list = [NSArray arrayWithArray:platfroms];
}

- (void)handleShare:(DelegatorArguments *)arguments{
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        [self shareToPlatform:wrapper.data];
    } else {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

/*
 *  分享方法
 */
- (void)shareToPlatform:(DictionaryWrapper *)shareDic{
    
    //构造分享内容
    if (!shareDic || [shareDic isKindOfClass:[NSNull class]]) {
        return;
    }
    
    //    list = [shareDic getArray:@"targets"];
    
    NSString *str = [shareDic getString:@"targets"];
    
    
    NSMutableArray *tags = (NSMutableArray *)[str componentsSeparatedByString:@","];
    
    for(int i = 0; i < tags.count; i++)
    {
        [tags replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:[[tags objectAtIndex:i] intValue]]];
    }
    
    list = tags;
    
    if (!list.count) {
        list = [ShareSDK getShareListWithType:ShareTypeWeixiTimeline,ShareTypeWeixiSession,ShareTypeSinaWeibo,ShareTypeQQSpace,ShareTypeQQ,ShareTypeSMS,ShareTypeMail, nil];
    }
    
    [self shareToPlatforms:list withShareData:shareDic];
}

- (void)shareToPlatforms:(NSArray *)platfroms withShareData:(DictionaryWrapper *)shareDic {
    
    NSString * url = [shareDic getString:@"ClickUrl"]?[shareDic getString:@"ClickUrl"]:[shareDic getString:@"clickUrl"];
    NSString *postStatusText = [shareDic getString:@"Content"]?[shareDic getString:@"Content"]:[shareDic getString:@"content"];
    NSString *imagePath = [shareDic getString:@"PictureUrl"]?[shareDic getString:@"PictureUrl"]:[shareDic getString:@"pictureUrl"];
    NSString *title = [shareDic getString:@"Title"]?[shareDic getString:@"Title"]:[shareDic getString:@"title"];
    
#warning !!!?
    url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    postStatusText = [postStatusText stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    imagePath = [imagePath stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    title = [title stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:postStatusText
                                       defaultContent:@"请输入您要分享的内容"
                                                image:[imagePath isKindOfClass:[NSNull class]] ? nil : [ShareSDK imageWithUrl:imagePath]
                                                title:title
                                                  url:url
                                          description:@""
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [self shareWithPublishContent:publishContent withShareList:platfroms];
    
}

- (void)shareWithPublishContent:(id<ISSContent>)publishContent withShareList:(NSArray *)array{
    [ShareSDK showShareActionSheet:nil
                         shareList:array
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    //                                    NSArray *indexs = @[@0, @1, @2, @6, @22, @23, @24, @7, @18, @19];
                                    //                                    //分享成功
                                    //                                    NSDictionary *para = @{@"Key" : keyword, @"Method" : @([indexs indexOfObject:@(type)])};
                                    //                                    ADAPI_Share_Stub([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleShareStub:)], para);
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
                                    [AlertUtil showAlert:@"提示" message:@"分享失败，请选择其他平台分享!" buttons:@[@"确定"]];
                                }
                            }];
}

//保存分享后结果
- (void)handleShareStub:(DelegatorArguments *)arguments{
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
    } else {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

@end
