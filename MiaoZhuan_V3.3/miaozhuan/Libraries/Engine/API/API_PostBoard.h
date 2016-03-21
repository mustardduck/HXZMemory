//
//  API_Outside.h
//  MZFramework
//
//  Created by Nick on 15-3-26.
//  Copyright (c) 2015年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Definition.h"

typedef NS_ENUM(NSInteger, KInterfaceType){
    /**
     *  测试服务器
     */
    kInterfaceDebug = 0,
    /**
     *  预发布
     */
    kInterfaceIndoorRelease,
    /**
     *  正式环境
     */
    kInterfaceRelease,
};



@interface API_PostBoard : NSObject

//获取实例
//#define API_POSTBOARD [API_PostBoard getInstance]
+ (instancetype)getInstance;
/**
 *  服务器类型
 */
@property (nonatomic,assign) KInterfaceType interfaceType;


//登录
-(void) engine_outside_login:(NSString *)UserName passWord:(NSString *)Password imei :(NSString *)Imei;

//登出
-(void) engine_outside_logout;


//************************** 张贴栏 **************************//


/**
 *  张贴栏首页数据
 */
-(void) engine_outside_postBoard_index;


/**
 *  张贴栏列表数据
 *
 *  @param pageIndex         页码
 *  @param pageSize          每页条数
 *  @param boardType         1-招聘消息；2-招商消息；3-优惠消息
 *  @param regionType        区域类型 0-行政区域，1-附近，如果是附近，则返回结果含有距离
 *  @param provinceId        省份编号，未选传0
 *  @param cityId            城市编号，未选传0，非直辖市只到市级
 *  @param districtId        区域编号，未选传0，直辖市可传区级
 *  @param industryId        行业类别，0为全部
 *  @param companySalaryCode 公司薪水Code
 *  @param investAmountCode  投资金额Code
 */
-(void) engine_outside_postBoard_listIndex:(int) pageIndex
                                      size:(int) pageSize
                                      type:(PostBoardType) boardType
                                    region:(RegionType) regionType
                                provinceId:(NSString *)provinceId
                                    cityId:(NSString *) cityId districtId:(NSString *)districtId
                                industryId:(NSString *) industryId
                         companySalaryCode:(NSString *) companySalaryCode
                          investAmountCode:(NSString *)investAmountCode;


/**
 *  张贴栏招聘信息详情
 *
 *  @param recruitmentId 招聘信息ID
 */
-(void) engine_outside_postBoard_recruitmentDetailsId:(NSString *) recruitmentId;



/**
 *  张贴栏招商信息详情
 *
 *  @param attractBusinessId 招聘信息ID
 */
-(void) engine_outside_postBoard_attractBusinessDetailsID:(NSString *) attractBusinessId;




/**
 *  张贴栏优惠信息详情
 *
 *  @param discountId 优惠信息ID
 */
-(void) engine_outside_postBoard_DiscountDetailsID:(NSString *) discountId;




/**
 *  张贴栏热门搜索词
 */
-(void) engine_outside_postBoard_hotwordSearch;



/**
 *  张贴栏搜索
 *
 *  @param pageIndex     页码
 *  @param pageSize      每页条数
 *  @param postboardType 0-全部；1-招聘消息；2-招商消息；3-优惠消息
 *  @param keyword       搜索关键字
 */
-(void) engine_outside_postBoard_searchIndex:(int) pageIndex
                                        size:(int) pageSize
                                        type:(PostBoardType) postboardType
                                     keyword:(NSString *) keyword;




/**
 *  张贴栏收藏列表
 *
 *  @param pageIndex     页码
 *  @param pageSize      每页条数
 *  @param postBoardType 1-招聘消息；2-招商消息；3-优惠消息
 */
-(void) engine_outside_postBoard_colloctionListIndex:(int) pageIndex
                                                size:(int) pageSize
                                                type:(PostBoardType) postBoardType;


/**
 *  张贴栏收藏(增加收藏)
 *
 *  @param postBoardId   张贴栏Id
 *  @param postBoardType 1-招聘消息；2-招商消息；3-优惠消息
 */
-(void) engine_outside_postBoard_addCollectionId:(NSString *) postBoardId
                                            type:(PostBoardType) postBoardType;



/**
 *  张贴栏收藏过滤
 *
 *  @param postBoardType 0-全部；1-招聘消息；2-招商消息；3-优惠消息
 */
-(void) engine_outside_postBoard_filterCollectionType:(PostBoardType) postBoardType;



/**
 *  张贴栏取消收藏
 *
 *  @param collectionID  张贴栏ID
 *  @param postBoardType 1-招聘消息；2-招商消息；3-优惠消息
 */
-(void) engine_outside_postBoard_cancelCollectionID:(NSString *)collectionID type:(PostBoardType) postBoardType;


/**
 *  举报张贴栏信息
 *
 *  @param postId        张贴栏ID
 *  @param postType      1-招聘消息；2-招商消息；3-优惠消息
 *  @param code          举报原因代码
 *  @param reasonContent 举报原因中文内容
 */
-(void) engine_outside_postBoard_reportId:(NSString *) postId type:(PostBoardType) postType reasonCode:(NSString *) code reason:(NSString *) reasonContent;


/**
 *  获取举报原因列表
 */
-(void) engine_outside_postBoard_reportReasonList;


//************************** 张贴栏 **************************//


/**
 *  张贴栏的企业信息
 */
-(void) engine_outside_postBoardManage_enterpriseInfo;




/**
 *  获取张贴栏需完善的信息
 */
-(void) engine_outside_postBoardManage_detail;




/**
 *  完善张贴栏信息
 *
 *  @param companySizeCode     公司规模Code
 *  @param companyKindCode     公司性质Code
 *  @param companyBenefitCodes 公司福利Code集合(List<string>)
 *  @param recruitmentPhone    招聘电话
 */
-(void) engine_outside_postBoardManage_fillInfoSize:(NSString *) companySizeCode
                                               kind:(NSString *) companyKindCode
                                           denefits:(NSArray *) companyBenefitCodes
                                              phone:(NSString *) recruitmentPhone;


//********  招聘信息管理

/**
 *  招聘信息管理首页
 */
-(void) engine_outside_recruitmentManage_index;



/**
 *  保存招聘信息到草稿箱
 *
 *  @param recruitmentId        招聘信息ID
 *  @param title                招聘标题
 *  @param companySalaryCode    薪水Code
 *  @param educationCode        学历Code
 *  @param workingYearsCode     工作年限Code
 *  @param recruitmentCountCode 招聘人数Code
 *  @param gender               0-不限，1-男，2-女
 *  @param responsibility       职责与要求
 *  @param onlineDayCount       信息在线天数
 */
-(void) engine_outside_recruitmentManage_saveDraft:(NSString *) recruitmentId
                                             title:(NSString *) title
                                        salaryCode:(NSString *) companySalaryCode
                                     educationCode:(NSString *) educationCode
                                          yearCode:(NSString *) workingYearsCode
                                      recruitCount:(NSString *)recruitmentCountCode
                                            gender:(UserGender) gender
                                    responsibility:(NSString *) responsibility
                                       onlineCount:(int) onlineDayCount;



/**
 *  发布招聘信息
 *
 *  @param recruitmentId        招聘信息ID
 *  @param title                招聘标题
 *  @param companySalaryCode    薪水Code
 *  @param educationCode        学历Code
 *  @param workingYearsCode     工作年限Code
 *  @param recruitmentCountCode 招聘人数Code
 *  @param gender               0-不限，1-男，2-女
 *  @param responsibility       职责与要求
 *  @param onlineDayCount       信息在线天数
 */
-(void) engine_outside_recruitmentManage_publish:(NSString *) recruitmentId
                                           title:(NSString *)title
                                      salaryCode:(NSString *) companySalaryCode
                                   educationCode:(NSString *) educationCode
                                        yearCode:(NSString *) workingYearsCode
                                    recruitCount:(NSString *)recruitmentCountCode
                                          gender:(UserGender) gender
                                  responsibility:(NSString *) responsibility
                                     onlineCount:(int) onlineDayCount;



/**
 *  招聘信息列表
 *
 *  @param status    0-未提交；1-播放中；2-播放结束；99-强制下架
 *  @param pageIndex 页码
 *  @param pageSize  每页条数
 */
-(void) engine_outside_recruitmentManage_listStatus:(PostBoardStatus) status
                                              index:(int) pageIndex
                                               size:(int) pageSize;




/**
 *  招聘信息详情
 *
 *  @param recruitmentId 招聘信息的ID
 */
-(void) engine_outside_recruitmentManage_detailsId:(NSString *)recruitmentId;



/**
 *  刷新招聘信息
 *
 *  @param recruitmentId 招聘信息的ID
 */
-(void) engine_outside_recruitmentManage_refreshId:(NSArray *)recruitmentIds;




/**
 *  下架招聘信息
 *
 *  @param recruitmentIds 要下架的招聘信息ID （List<string>）
 */
-(void) engine_outside_recruitmentManage_offlineIds:(NSArray *)recruitmentIds;




/**
 *  删除招聘信息
 *
 *  @param recruitmentId 招聘信息的ID
 */
-(void) engine_outside_recruitmentManage_deleteId:(NSString *)recruitmentId;




//********   招商信息管理  ********//

/**
 *  招商信息管理首页
 */
-(void) engine_outside_attractBusinessManage_index;



/**
 *  保存招商信息到草稿箱
 *
 *  @param attractBusinessId 招商信息ID
 *  @param title             招商标题
 *  @param brand             招商品牌
 *  @param officicalLink     官网链接
 *  @param investAmountCode  投资金额Code
 *  @param description       招商说明
 *  @param logoUrlString     Logo图片ID
 *  @param propagandaPicIds  宣传图片ID
 *  @param onlineDayCount    信息在线天数
 */
-(void) engine_outside_attractBusinessManage_saveDraft:(NSString *)attractBusinessId
                                                 title:(NSString *) title
                                                 brand:(NSString *) brand
                                                  link:(NSString *) officicalLink
                                            investCode:(NSString *)investAmountCode
                                           description:(NSString *) description
                                                  logo:(NSString *) logoUrlString
                                          publicImages:(NSArray *) propagandaPicIds
                                           onlineCount:(int) onlineDayCount;




/**
 *  发布招商信息
 *
 *  @param attractBusinessId 招商信息ID
 *  @param title             招商标题
 *  @param brand             招商品牌
 *  @param officicalLink     官网链接
 *  @param investAmountCode  投资金额Code
 *  @param description       招商说明
 *  @param logoUrlString     Logo图片ID
 *  @param propagandaPicIds  宣传图片ID
 *  @param onlineDayCount    信息在线天数
 */
-(void) engine_outside_attractBusinessManage_publish:(NSString *)attractBusinessId
                                               title:(NSString *) title
                                               brand:(NSString *) brand
                                                link:(NSString *) officicalLink
                                          investCode:(NSString *)investAmountCode
                                         description:(NSString *) description
                                                logo:(NSString *) logoUrlString
                                        publicImages:(NSArray *) propagandaPicIds
                                         onlineCount:(int) onlineDayCount;




/**
 *  招商信息列表:获取招商信息列表。已发布的招商信息、下架的招商信息、被强制下架的招商信息都将使用此接口
 *
 *  @param status    0-未提交；1-播放中；2-播放结束；99-强制下架
 *  @param pageIndex 页码
 *  @param pageSize  每页条数
 */
-(void) engine_outside_attractBusinessManage_listStatus:(PostBoardStatus) status
                                                  index:(int) pageIndex
                                                   size:(int) pageSize;




/**
 *  招商信息详情
 *
 *  @param attractBusinessId 招商信息的ID
 */
-(void) engine_outside_attractBusinessManage_detailsId:(NSString *)attractBusinessId;




/**
 *  刷新招商信息
 *
 *  @param attractBusinessIds 招商信息的ID
 */
-(void) engine_outside_attractBusinessManage_refreshId:(NSArray *)attractBusinessIds;




/**
 *  下架招商信息
 *
 *  @param attractBusinessIds 招商信息的ID
 */
-(void) engine_outside_attractBusinessManage_offlineId:(NSArray *)attractBusinessIds;



/**
 *  删除招商信息
 *
 *  @param attractBusinessId 招商信息的ID
 */
-(void) engine_outside_attractBusinessManage_deleteIds:(NSString *)attractBusinessId;




//***********************   优惠信息管理  **************** //

/**
 *  优惠信息管理首页
 */
-(void) engine_outside_discountManage_index;



/**
 *  保存优惠信息到草稿箱
 *
 *  @param discountId       优惠信息ID
 *  @param title            优惠标题
 *  @param content          优惠内容
 *  @param propagandaPicIds 宣传图片ID
 *  @param isNeedVoncher    是否需要凭证
 *  @param voncherPicId     凭证图片ID
 *  @param hasDiscountData  是否有优惠时段
 *  @param startDate        优惠开始时间
 *  @param endDate          优惠结束时间
 *  @param onlineDayCount   信息在线天数
 */
-(void) engine_outside_discountManage_saveDraft:(NSString *) discountId
                                          title:(NSString *) title
                                        content:(NSString *) content
                                         images:(NSArray *) propagandaPicIds
                                  isNeedVoucher:(BOOL) isNeedVoncher
                                      voucherId:(NSString *) voncherPicId
                                    hasDiscount:(BOOL) hasDiscountData
                                  discountStart:(NSString *) startDate
                                    discountEnd:(NSString *) endDate
                                    onlineCount:(int) onlineDayCount;


/**
 *  发布优惠信息
 *
 *  @param discountId       优惠信息ID
 *  @param title            优惠标题
 *  @param content          优惠内容
 *  @param propagandaPicIds 宣传图片ID
 *  @param isNeedVoncher    是否需要凭证
 *  @param voncherPicId     凭证图片ID
 *  @param hasDiscountData  是否有优惠时段
 *  @param startDate        优惠开始时间
 *  @param endDate          优惠结束时间
 *  @param onlineDayCount   信息在线天数
 */
-(void) engine_outside_discountManage_publish:(NSString *) discountId
                                        title:(NSString *) title
                                      content:(NSString *) content
                                       images:(NSArray *) propagandaPicIds
                                isNeedVoucher:(BOOL) isNeedVoncher
                                    voucherId:(NSString *) voncherPicId
                                  hasDiscount:(BOOL) hasDiscountData
                                discountStart:(NSString *) startDate
                                  discountEnd:(NSString *) endDate
                                  onlineCount:(int) onlineDayCount;



/**
 *  优惠信息列表
 *
 *  @param status    0-未提交；1-播放中；2-播放结束；99-强制下架
 *  @param pageIndex 页码
 *  @param pageSize  每页条数
 */
-(void) engine_outside_discountManage_listType:(PostBoardStatus) status
                                         index:(int) pageIndex
                                          size:(int) pageSize;




/**
 *  优惠信息详情
 *
 *  @param discountId 优惠信息Id
 */
-(void) engine_outside_discountManage_detailsId:(NSString *) discountId;



/**
 *  刷新优惠信息
 *
 *  @param discountIds 刷新优惠信息(List<string>)
 */
-(void) engine_outside_discountManage_refreshIds:(NSArray *) discountIds;



/**
 *  下架优惠信息
 *
 *  @param discountIds 下架优惠信息Ids(List<string>)
 */
-(void) engine_outside_discountManage_offlineIds:(NSArray *) discountIds;



/**
 *  删除优惠信息
 *
 *  @param discountId 优惠信息Id
 */
-(void) engine_outside_discountManage_deleteId:(NSString *) discountId;




/**
 *  按字典Code获取字典项:公司性质
 */
-(void) engine_outside_operator_complayKind;


/**
 *  按字典Code获取字典项:公司规模
 */
-(void) engine_outside_operator_companySize;


/**
 *  按字典Code获取字典项:公司福利
 */
-(void) engine_outside_operator_companyBenefit;


/**
 *  按字典Code获取字典项:公司薪水
 */
-(void) engine_outside_operator_companySalary;


/**
 *  按字典Code获取字典项:学历
 */
-(void) engine_outside_operator_education;


/**
 *  按字典Code获取字典项:工作年限
 */
-(void) engine_outside_operator_workingYears;


/**
 *  按字典Code获取字典项:招聘人数
 */
-(void) engine_outside_operator_recruitmentCount;

/**
 *  按字典Code获取字典项:投资金额
 */
-(void) engine_outside_operator_investAmount;



@end
