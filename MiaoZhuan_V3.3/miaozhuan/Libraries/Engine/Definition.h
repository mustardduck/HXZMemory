//
//  Definition.h
//  Demo
//
//  Created by luo on 15/4/21.
//  Copyright (c) 2015年 Nick. All rights reserved.
//

#ifndef Demo_Definition_h
#define Demo_Definition_h

/** 张贴栏类型 */
typedef enum _PostBoardType{
    /** 0-所有消息		*/  kPostBoardAll               = 0,
    /** 1-招聘消息		*/  kPostBoardRecruit           = 1,
    /** 2-招商消息       */  kPostBoardAttractBusiness   = 2,
    /** 3-优惠消息		*/  kPostBoardDiscount          = 3,
}PostBoardType;

/** 张贴栏地区类型 */
typedef enum _RegionType{
    /** 0-行政区域         */  kRegionAdministrativeDivision,
    /** 1-附近            */  kRegionNearby,
}RegionType;

/** 用户性别   */
typedef enum _UserGender{
    /** 0:全部       */  kUserAll        = 0,
    /** 1:男         */  kUserMan        = 1,
    /** 2:女         */  kUserWoman      = 2,
}UserGender;

/** 张贴栏状态   */
typedef enum _PostBoardStatus{
    /** 0-未提交       */  kPostBoardUncommit      = 0,
    /** 1-播放中       */  kPostBoardPlayOn        = 1,
    /** 2-播放结束     */  kPostBoardPlayOff       = 2,
    /** 99-强制下架    */  kPostBoardOffine        = 99,
}PostBoardStatus;

/** 用户认证状态 */
typedef enum _UserVirifyStatus{
    /** 0:未认证           */  kUserVirifyNo       = 0,
    /** 1:认证成功         */  kUserVirifySuccess   = 1,
    /** 2:认证失败         */  kUserVirifyFailed    = 2,
    /** 3:认证中           */  kUserVirifyProcessing= 3,
}UserVirifyStatus;

/** 商家审核状态状态 */
typedef enum _EnterpriseVirifyStatus{
    /** 0:未创建          */        kEnterpriseVirifyNo            = 0,
    /** 1:审核中          */        kEnterpriseVirifyProcessing    = 1,
    /** 2:审核失败        */        kEnterpriseVirifyFailed        = 2,
    /** 3:审核成功        */        kEnterpriseVirifySuccess       = 3,
    /** 4:已激活         */         kEnterpriseVirifyActivity      = 4,
}EnterpriseVirifyStatus;

/** 张贴栏搜索 */
typedef NS_ENUM(NSInteger, IWSearchType) {
    /** 0:搜索全部         */    IWSearchAll,
    /** 1:搜索招聘          */    IWSearchRecruit,
    /** 2:搜索招商        */    IWSearchAttract,
    /** 3:搜索优惠        */    IWSearchDiscount,
};

#endif
