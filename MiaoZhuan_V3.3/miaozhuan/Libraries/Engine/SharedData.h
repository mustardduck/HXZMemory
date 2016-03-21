//
//  SharedData.h
//  MZFramework
//
//  Created by Nick on 15-3-26.
//  Copyright (c) 2015年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Update_Type.h"

#import "API_Outside.h"
#import "Model_Outside.h"
#import "API_PostBoard.h"
#import "Model_PostBoard.h"


//@class PersonalInfo;

@interface SharedData : NSObject

@property(nonatomic, assign) BOOL           isUserLogoutManual;                 //用户手动退出登录

@property(nonatomic, strong) PersonalInfo   *personalInfo;                      //用户信息

@property(nonatomic, strong) NSMutableArray * postBoardIndex;                   //张贴栏首页数据(PostBoardInfo对象)
@property(nonatomic, strong) NSMutableArray * postBoardList;                    //张贴栏列表数据
@property(nonatomic, strong) PostBoardRecruitment *postBoardRecruitmentDetail;  //张贴栏招聘信息详情
@property(nonatomic, strong) PostBoardAttractBusiness *postBoardAttractBusinessDetail;//张贴栏招商信息详情
@property(nonatomic, strong) PostBoardDiscount      *postBoardDiscountDetail;       //张贴栏优惠信息详情
@property(nonatomic, strong) NSMutableArray * postBoardSearchResults;           //张贴栏搜索(结果)
@property(nonatomic, strong) NSMutableArray * postBoardCollectionLists;         //张贴栏收藏

@property(nonatomic, strong) NSMutableArray * postBoardReportReasionList;       //举报原因列表


@property (nonatomic, strong) NSMutableArray * hotSearchWords;                  //热门搜索词汇
@property (nonatomic, strong) EnterpriseNewInfo * enterpriseInfo;                  //张贴栏信息
@property (nonatomic, strong) PostBoardNeedFull *postBoardNeedFull;             //获取张贴栏需完善的信息
@property (nonatomic, strong) RecruitmentManageInfo *recruitmentManageInfo;     //招聘信息管理首页

@property (nonatomic, strong) RecruitmentInfo *recruitmentDraft;                //保存招聘信息到草稿箱
@property (nonatomic, strong) RecruitmentPublishInfo *recruitmentPublishInfo;   //发布招聘信息
@property (nonatomic, strong) NSMutableArray *recruitmentList;                  //招聘信息列表
@property (nonatomic, strong) RecruitmentInfo *recruitmentDetailInfo;           //招聘详情

@property (nonatomic, strong) AttractBusinessManageInfo *attractBusinessManageInfo; //招商信息管理首页
@property (nonatomic, strong) AttractBusinessInfo       *attractBusinessDraft;      //保存招商信息到草稿箱
@property (nonatomic, strong) AttractBusinessPublish    *attractBusinessPublish;    //发布招商信息
@property (nonatomic, strong) NSMutableArray            *attractBusinessList;       //招商信息列表
@property (nonatomic, strong) AttractBusinessInfo       *attractBusinessDetalInfo;  //招商信息详情

@property (nonatomic, strong) DiscountManageInfo        *discountManageInfo;        //优惠信息管理首页
@property (nonatomic, strong) DiscountInfo              *discountDraft;              //优惠信息到草稿箱
@property (nonatomic, strong) DiscountPublishInfo       *discountPublish;           //发布优惠信息
@property (nonatomic, strong) NSMutableArray            *discountList;              //优惠信息列表
@property (nonatomic, strong) DiscountInfo              *discountDetailInfo;        //优惠信息详情

@property (nonatomic,strong) NSMutableArray *       operatorCompanyKindCodeList;    //公司性质
@property (nonatomic,strong) NSMutableArray * 		operatorCompanySizeCodeList;	//公司规模	Value：最小值,最大值
@property (nonatomic,strong) NSMutableArray * 		operatorCompanyBenefitCodeList;	//公司福利
@property (nonatomic,strong) NSMutableArray * 		operatorCompanySalaryCodeList;	//公司薪水	Value：最小值,最大值
@property (nonatomic,strong) NSMutableArray * 		operatorEducationCodeList;		//学历
@property (nonatomic,strong) NSMutableArray * 		operatorWorkingYearsCodeList;	//工作年限	Value：最小值,最大值
@property (nonatomic,strong) NSMutableArray * 		operatorRecruitmentCountCodeList;//招聘人数	Value：最小值,最大值
@property (nonatomic,strong) NSMutableArray * 		operatorInvestAmountCodeList;	//投资金额	Value：最小值,最大值


//获取实例
//#define G_DATA [SharedData getInstance]
+ (instancetype)getInstance;

-(void)engine_request:(NSString *)url requestType:(update_type)utype meth:(NSString *)meth paramters:(NSDictionary *)dict;

@end
