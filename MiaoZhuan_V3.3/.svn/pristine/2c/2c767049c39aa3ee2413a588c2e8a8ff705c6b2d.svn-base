//
//  IWAttractBusinessViewController.h
//  miaozhuan
//
//  Created by admin on 15/4/30.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "DotCViewController.h"
#import "SharedData.h"

typedef NS_ENUM(NSInteger, IWAttractBusinessDetailType) {//详情类型
    IWAttractBusinessDetailType_PreView = 0, //预览
    IWAttractBusinessDetailType_Browse,  //别人浏览
    IWAttractBusinessDetailType_Offline,  //下架
    IWAttractBusinessDetailType_ForceOffline,  //强制下架
};

@interface IWAttractBusinessDetailViewController : DotCViewController

@property (strong, nonatomic) NSString *detailsId;
@property (strong, nonatomic) AttractBusinessInfo *attractBusinessInfo;
@property (strong, nonatomic) EnterpriseNewInfo *enterpriseNewInfo;
@property (assign, nonatomic) IWAttractBusinessDetailType detailType;

-(void)loadData;

@end
