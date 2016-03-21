//
//  NCSupporter.m
//  miaozhuan
//
//  Created by abyss on 14/12/6.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "NCSupporter.h"
#import "NotifyCenterDefine.h"

BOOL CRNC_SUPPORTCONFIH_DEGUG = NO;
@implementation NCSupporter
+ (NSMutableArray *)fitData:(DictionaryWrapper *)dic at:(NSMutableArray *)_netData
{
    int isExist = 0;
    if (CRNC_SUPPORTCONFIH_DEGUG)
    {
        [_netData[0] addObject:@{@"type":@(CRENUM_NCContentTypeConsultMsgFromOfficial),
                                 @"count":@(2),
                                 @"cell":@11}];
        [_netData[0] addObject:@{@"type":@(CRENUM_NCContentTypeTradeMsg),
                                 @"count":@(2),
                                 @"cell":@12}];
        [_netData[0] addObject:@{@"type":@(CRENUM_NCContentTypeProductMsg),
                                 @"count":@(1),
                                 @"cell":@13}];
        [_netData[1] addObject:@{@"type":@(CRENUM_NCContentTypePostOrder),
                                 @"count":@(3),
                                 @"cell":@21}];
        [_netData[1] addObject:@{@"type":@(CRENUM_NCContentTypeLiveOrder),
                                 @"count":@(1),
                                 @"cell":@22}];
        [_netData[1] addObject:@{@"type":@(CRENUM_NCContentTypeSilverProduct|CRENUM_NCContentTypeGoldProduct),
                                 @"count":@(23),
                                 @"cell":@23}];
        [_netData[1] addObject:@{@"type":@(CRENUM_NCContentTypeGoldAdvert),
                                 @"count":@(2),
                                 @"cell":@24}];
        [_netData[1] addObject:@{@"type":@(CRENUM_NCContentTypeSystemAdvert),
                                 @"count":@(0),
                                 @"cell":@25}];
        [_netData[2] addObject:@{@"type":@(CRENUM_NCContentTypeCurrency),
                                 @"count":@(0),
                                 @"cell":@31}];
        [_netData[2] addObject:@{@"type":@(CRENUM_NCContentTypeOfficial),
                                     @"count":@(1),
                                     @"cell":@32}];
        [_netData[2] addObject:@{@"type":
            @(CRENUM_NCContentTypeRemind),
                                 @"count":@(2),
                                 @"cell":@33}];
    }
    else
    {
    
    DictionaryWrapper *userDic = [dic getDictionaryWrapper:@"UserMsgCounts"];
    
    isExist = [userDic getBool:@"ConsultMsgFromEnterpriseExist"]?CRENUM_NCContentTypeConsultMsgFromEnterprise:0
    |[userDic getBool:@"ConsultMsgFromOfficialExist"]?CRENUM_NCContentTypeConsultMsgFromOfficial:0;
            if (isExist)
            {
    [_netData[0] addObject:@{@"type":@(isExist),
                             @"count":@([userDic getInt:@"ConsultMsgFromEnterpriseCount"] + [userDic getInt:@"ConsultMsgFromOfficialCount"]),
                             @"cell":@11}];
            }
    isExist = [userDic getBool:@"TradeMsgExist"]?CRENUM_NCContentTypeTradeMsg:0;
            if (isExist)
            {
    [_netData[0] addObject:@{@"type":@(isExist),
                             @"count":@([userDic getInt:@"TradeMsgCount"]),
                             @"cell":@12}];
            }
    isExist = [userDic getBool:@"ProductMsgExist"]?CRENUM_NCContentTypeProductMsg:0;
            if (isExist)
            {
    [_netData[0] addObject:@{@"type":@(isExist),
                             @"count":@([userDic getInt:@"ProductMsgCount"]),
                             @"cell":@13}];
            }
    
    DictionaryWrapper *enterpriseDic = [dic getDictionaryWrapper:@"EnterpriseMsgCounts"];
    
    isExist = [enterpriseDic getBool:@"PostOrderMsgExist"]?CRENUM_NCContentTypePostOrder:0
            |[enterpriseDic getBool:@"PostOrderRefundMsgExist"]?CRENUM_NCContentTypePostOrderRefund:0;
    if (isExist)
    {
        [_netData[1] addObject:@{@"type":@(isExist),
                             @"count":@([enterpriseDic getInt:@"PostOrderMsgCount"] + [enterpriseDic getInt:@"PostOrderRefundMsgCount"]),
                             @"cell":@21}];
    }
    isExist = [enterpriseDic getBool:@"LiveOrderMsgExist"]?CRENUM_NCContentTypeLiveOrder:0;
    if (isExist)
    {
        [_netData[1] addObject:@{@"type":@(isExist),
                                 @"count":@([enterpriseDic getInt:@"LiveOrderMsgCount"]),
                                 @"cell":@22}];
    }
    isExist = [enterpriseDic getBool:@"SilverProductMsgExist"]?CRENUM_NCContentTypeSilverProduct:0
            |[enterpriseDic getBool:@"GoldProductMsgExist"]?CRENUM_NCContentTypeGoldProduct:0;
    if (isExist)
    {
        [_netData[1] addObject:@{@"type":@(isExist),
                             @"count":@([enterpriseDic getInt:@"SilverProductMsgCount"] + [enterpriseDic getInt:@"GoldProductMsgCount"]),
                             @"cell":@23}];
    }
    isExist = [enterpriseDic getBool:@"SilverAdvertMsgExist"]?CRENUM_NCContentTypeSilverAdvert:0
    |[enterpriseDic getBool:@"GoldAdvertMsgExist"]?CRENUM_NCContentTypeGoldAdvert:0
    |[enterpriseDic getBool:@"BiddingAdvertMsgExist"]?CRENUM_NCContentTypeBiddingAdvert:0;
    if (isExist)
    {
        [_netData[1] addObject:@{@"type":@(isExist),
                             @"count":@([enterpriseDic getInt:@"GoldAdvertMsgCount"] + [enterpriseDic getInt:@"SilverAdvertMsgCount"] + [enterpriseDic getInt:@"BiddingAdvertMsgCount"]),
                             @"cell":@24}];
    }
    isExist = [enterpriseDic getBool:@"SystemAdvertMsgExist"]?CRENUM_NCContentTypeSystemAdvert:0;
    if (isExist)
    {
        [_netData[1] addObject:@{@"type":@(isExist),
                             @"count":@([enterpriseDic getInt:@"SystemAdvertMsgCount"]),
                             @"cell":@25}];
    }
    
    DictionaryWrapper *accountDic = [dic getDictionaryWrapper:@"AccountMsgCounts"];
    
    isExist = [accountDic getBool:@"CurrencyMsgExist"]?CRENUM_NCContentTypeCurrency:0;
    if (isExist)
    {
        [_netData[2] addObject:@{@"type":@(isExist),
                                 @"count":@([accountDic getInt:@"CurrencyMsgCount"]),
                                 @"cell":@31}];
    }
    isExist = CRENUM_NCContentTypeOfficial;
    isExist = [accountDic getBool:@"OfficialMsgExist"]?CRENUM_NCContentTypeOfficial:0;
    if (isExist)
    {
        [_netData[2] addObject:@{@"type":@(isExist),
                                 @"count":@([accountDic getInt:@"OfficialMsgCount"]),
                                 @"cell":@32}];
    }

    isExist = CRENUM_NCContentTypeRemind;
    isExist = [accountDic getBool:@"PhoneVerifyMsgExist"]?CRENUM_NCContentTypeRemind:0;
        
    if (isExist)
    {
        [_netData[2] addObject:@{@"type":@(isExist),
                                 @"count":@([accountDic getInt:@"PhoneVerifyMsgCount"]),
                                 @"cell":@33}];
    }
        
        
    [dic release];
    }

    return _netData;
}



+ (NSArray *)getDeleteArrayBy:(DictionaryWrapper *)dic
{
    NSArray *array = nil;
    int64_t type = [dic getInt:@"type"];
    
    if (type & CRENUM_NCContentType10)
    {
        array = @[@"101",@"102"];
    }
    else if (type & CRENUM_NCContentType11)
    {
        array = @[@"111"];
    }
    else if (type & CRENUM_NCContentType12)
    {
        array = @[@"121"];
    }
    else if (type & CRENUM_NCContentType20)
    {
        array = @[@"211",@"212"];
    }
    else if (type & CRENUM_NCContentType21)
    {
        array = @[@"213"];
    }
    else if (type & CRENUM_NCContentType22)
    {
        array = @[@"221",@"222"];
    }
    else if (type & CRENUM_NCContentType23)
    {
        array = @[@"231",@"232",@"233"];
    }
    else if (type & CRENUM_NCContentType24)
    {
        array = @[@"241"];
    }
    else if (type & CRENUM_NCContentType30)
    {
        array = @[@"301"];
    }
    else if (type & CRENUM_NCContentType31)
    {
        array = @[@"311"];
    }
    else if (type & CRENUM_NCContentType32)
    {
        array = @[@"321"];
    }
    return array;
}
@end
