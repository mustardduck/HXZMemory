//
//  IWPublishAttractBusinessViewController.h
//  miaozhuan
//
//  Created by admin on 15/4/29.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "DotCViewController.h"

typedef NS_ENUM(NSInteger, IWPublishAttactBusinessUploadImageType) {
    IWPublishAttactBusinessUploadImageType_BrandLogo = 0, //品牌logo
    IWPublishAttactBusinessUploadImageType_AD,  //宣传广告
};

typedef NS_ENUM(NSInteger, IWPublishAttractBusinessType) {//详情类型
    IWPublishAttractBusinessType_Default = 0,//在草稿箱中编辑
    IWPublishAttractBusinessType_FromDraft,  //重新开始编辑
    IWPublishAttractBusinessType_FromOffline,  //从下架中编辑
};

@interface IWPublishAttractBusinessViewController : DotCViewController

@property (strong, nonatomic) NSString *detailsId;
@property (assign, nonatomic) IWPublishAttractBusinessType publishAttractBuinessType;

@end
