//
//  RecruitDetailViewController.h
//  miaozhuan
//
//  Created by admin on 15/4/28.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "DotCViewController.h"
#import "SharedData.h"

typedef NS_ENUM(NSInteger, IWRecruitDetailType) {//详情类型
    IWRecruitDetailType_PreView = 0, //预览
    IWRecruitDetailType_Browse,  //浏览
    IWRecruitDetailType_Offline,  //下架
    IWRecruitDetailType_ForceOffline,  //强制下架
};

@interface IWRecruitDetailViewController : DotCViewController

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraints_vertical_Bottom_BottomView;
@property (strong, nonatomic) NSString *detailsId;
@property (strong, nonatomic) RecruitmentInfo *recruitmentInfo;
@property (strong, nonatomic) EnterpriseNewInfo *enterpriseNewInfo;

@property (assign, nonatomic) IWRecruitDetailType detailType;

-(void)loadData;

@end
