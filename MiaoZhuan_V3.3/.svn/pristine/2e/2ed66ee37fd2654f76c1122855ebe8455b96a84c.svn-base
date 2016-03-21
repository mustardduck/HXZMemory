//
//  NotifyCenterDefine.h
//  miaozhuan
//
//  Created by abyss on 14/11/29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#ifndef miaozhuan_NotifyCenterDefine_h
#define miaozhuan_NotifyCenterDefine_h

//消息中心标题头
typedef NS_ENUM(NSUInteger, CRENUM_NCHeaderType)
{
    CRENUM_NCHeaderTypeAccount              = 0,
    
    CRENUM_NCHeaderTypeUser                 = 1 << 0,
    CRENUM_NCHeaderTypeEnterprise           = 1 << 1,
};

//消息中心内容1
typedef NS_ENUM(NSUInteger, CRENUM_NCContentType)
{
    //0
    CRENUM_NCContentTypeConsultMsgFromEnterprise   = 1 << 0,
    CRENUM_NCContentTypeConsultMsgFromOfficial     = 1 << 1,
    CRENUM_NCContentTypeTradeMsg                   = 1 << 2,
    CRENUM_NCContentTypeProductMsg                 = 1 << 3,
    //1
    CRENUM_NCContentTypePostOrder                  = 1 << 4,
    CRENUM_NCContentTypePostOrderRefund            = 1 << 5,
    CRENUM_NCContentTypeLiveOrder                  = 1 << 6,
    CRENUM_NCContentTypeSilverProduct              = 1 << 7,
    CRENUM_NCContentTypeGoldProduct                = 1 << 8,
    CRENUM_NCContentTypeSilverAdvert               = 1 << 9,
    CRENUM_NCContentTypeGoldAdvert                 = 1 << 10,
    CRENUM_NCContentTypeBiddingAdvert              = 1 << 11,
    CRENUM_NCContentTypeSystemAdvert               = 1 << 12,
    //2
    CRENUM_NCContentTypeCurrency                   = 1 << 13,
    CRENUM_NCContentTypeOfficial                   = 1 << 14,
    CRENUM_NCContentTypeRemind                     = 1 << 15,
    
    CRENUM_NCContentType10                  = CRENUM_NCContentTypeConsultMsgFromEnterprise|CRENUM_NCContentTypeConsultMsgFromOfficial,
    CRENUM_NCContentType11                  = CRENUM_NCContentTypeTradeMsg,
    CRENUM_NCContentType12                  = CRENUM_NCContentTypeProductMsg,
    CRENUM_NCContentType20                  = CRENUM_NCContentTypePostOrder|CRENUM_NCContentTypePostOrderRefund,
    CRENUM_NCContentType21                  = CRENUM_NCContentTypeLiveOrder,
    CRENUM_NCContentType22                  = CRENUM_NCContentTypeSilverProduct|CRENUM_NCContentTypeGoldProduct,
    CRENUM_NCContentType23                  = CRENUM_NCContentTypeSilverAdvert|CRENUM_NCContentTypeGoldAdvert|CRENUM_NCContentTypeBiddingAdvert,
    CRENUM_NCContentType24                  = CRENUM_NCContentTypeSystemAdvert,
    CRENUM_NCContentType30                  = CRENUM_NCContentTypeCurrency,
    CRENUM_NCContentType31                  = CRENUM_NCContentTypeOfficial,
    CRENUM_NCContentType32                  = CRENUM_NCContentTypeRemind,
};
//最新消息本地缓存
#define CRNC_TIMEOFHEADER_KEY @"CRNC_TIMEOFHEADER_KEY"
#endif
