//
//  Model_Outside.h
//  MZFramework
//
//  Created by Nick on 15-3-26.
//  Copyright (c) 2015年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Definition.h"

/** 用户信息 */
@interface PersonalInfo : NSObject

@property (nonatomic,strong) NSString * 	userCustomerId;			//
@property (nonatomic,strong) NSString * 	userBusinessCardId;		//
@property (nonatomic,strong) NSString * 	userUserName;			//用户名（phone）
@property (nonatomic,strong) NSString * 	userTrueName;			//用户姓名
@property (nonatomic,strong) NSString * 	userPhotoUrl;			//用户头像URL
@property (nonatomic,assign) UserGender     userGender;				//1-男，2-女
@property (nonatomic,strong) NSString * 	userBirthday;			//生日
@property (nonatomic,assign) BOOL           userIsPhoneVerified;	//是否通过电话验证
@property (nonatomic,assign) UserVirifyStatus userIdentityStatus;		//0-未认证，1-认证成功，2-认证失败，3-认证中
@property (nonatomic,assign) int            userVipLevel;			//VIP等级
@property (nonatomic,assign) int           userThankfulLevel;		//感恩层级
@property (nonatomic,strong) NSString * 	userHasParent;			//是否已感恩别人
@property (nonatomic,strong) NSString * 	userParentPhone;		//上级的电话号码
@property (nonatomic,assign) BOOL           userIsDeviceThankful;	//手机是否已经感恩过
@property (nonatomic,strong) NSString * 	userProvince;			//所在区域：省
@property (nonatomic,assign) int            userProvinceId;			//
@property (nonatomic,strong) NSString * 	userCity;				//所在区域：市
@property (nonatomic,assign) int            userCityId;				//
@property (nonatomic,strong) NSString * 	userDistrict;			//所在区域：区
@property (nonatomic,assign) int            userDistrictId;			//
@property (nonatomic,strong) NSString * 	userOtherPhone;			//其它电话
@property (nonatomic,strong) NSString * 	userQQ;					//
@property (nonatomic,strong) NSString * 	userEmail;				//
@property (nonatomic,strong) NSString * 	userWeibo;				//
@property (nonatomic,strong) NSString * 	userWeixin;				//
@property (nonatomic,strong) NSString * 	userEnterpriseId;		//创建商家返回-1
@property (nonatomic,strong) NSString * 	userEnterpriseName;		//商家名称
@property (nonatomic,strong) NSString * 	userEnterpriseLogoUrl;	//商家LOGO URL
@property (nonatomic,assign) EnterpriseVirifyStatus userEnterpriseStatus;	//0-未创建，1-审核中，2-审核失败，3-审核成功，4-已激活
@property (nonatomic,assign) BOOL           userIsDeleted;			//商家是否已删除
@property (nonatomic,assign) BOOL           userIsEnterpriseVip;	//商家是否VIP
@property (nonatomic,assign) BOOL           userIsSilver;			//商家是否成功发布过银元广告
@property (nonatomic,assign) BOOL           userIsGold;				//商家是否成功发布过金币广告
@property (nonatomic,assign) BOOL           userIsDirect;			//商家是否成功发布过直购商品
@property (nonatomic,assign) BOOL           userIsExchangeAdmin;	//是否为交易管理员
@property (nonatomic,assign) BOOL           userIsInfoGiftCompleted;//完善资料送银元是否完成。
@property (nonatomic,assign) BOOL           userIsAppStoreVersionOpen;//如果是app store下载的版本，判断是否打开屏蔽的接口

@property (nonatomic, strong) NSString *    userPassword;    //用户密码
@property (nonatomic, strong) NSString *    userImei;       //IMEI
@property (nonatomic, assign) BOOL         isAutoLogin;		//是否自动登录
@property (nonatomic, assign) BOOL         isAutoCleanCache;//是否自动清除缓存
@property (nonatomic, assign) BOOL         isVoiceRemind;	//是否开启音效


-(void)setupDataInfo:(NSDictionary *)dic;

@end

/**
 *  张贴栏数据
 */
@interface PostBoardInfo : NSObject

@property (nonatomic, strong) NSString     * postBoardId;				//张贴栏ID
@property (nonatomic, assign) PostBoardType  postBoardType;				//1-招聘消息；2-招商消息；3-优惠消息
@property (nonatomic, strong) NSString     * postBoardTitle;			//张贴栏标题
@property (nonatomic, strong) NSString     * postBoardEnterpriseName;	//商家名称
@property (nonatomic, strong) NSString     * postBoardLogoUrl;			//商家Logo或品牌Logo的Url
@property (nonatomic, strong) NSString     * postBoardIndustry;			//行业类别
@property (nonatomic, strong) NSString     * postBoardRegion;			//所在区域
@property (nonatomic, strong) NSString     * postBoardKeyWord;			//消息关键字
@property (nonatomic, strong) NSString     * postBoardRefreshTime;		//刷新时间或创建时间  兼容列表数据
@property (nonatomic, assign) double         postBoardDistance;			//距离，在「附近」的模块才会返回 兼容列表数据

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void)setupDataInfo:(NSDictionary *)dic;

@end


/**
 *  招聘消息的数据
 */
@interface RecruitmentInfo : NSObject
@property (nonatomic, strong) NSString        * recruitmentId;              //招聘信息的ID
@property (nonatomic, strong) NSString        * recruitmentTitle;           //招聘标题
@property (nonatomic, strong) NSString        * recruitmentSalary;          //薪水
@property (nonatomic, strong) NSString        * recruitmentSalaryCode;          //薪水Code
@property (nonatomic, strong) NSString        * recruitmentEducation;       //学历
@property (nonatomic, strong) NSString        * recruitmentEducationCode;       //学历Code
@property (nonatomic, strong) NSString        * recruitmentWorkingYears;    //工作年限
@property (nonatomic, strong) NSString        * recruitmentWorkingYearsCode;    //工作年限Code
@property (nonatomic, strong) NSString        * recruitmentRecruitmentCount;//招聘人数
@property (nonatomic, strong) NSString        * recruitmentRecruitmentCountCode;//招聘人数code
@property (nonatomic, assign) UserGender        recruitmentGender;          //0-不限，1-男，2-女
@property (nonatomic, strong) NSString        * recruitmentResponsibility;  //职责与要求
@property (nonatomic, assign) int               recruitmentOnlineDayCount;  //信息在线天数的设定
@property (nonatomic, assign) PostBoardStatus   recruitmentStatus;          //0-未提交；1-播放中；2-播放结束；99-强制下架
@property (nonatomic, strong) NSString        * recruitmentOfflineTime;     //结束时间
@property (nonatomic, strong) NSString        * recruitmentRefreshTime;     //刷新时间
@property (nonatomic, strong) NSString        * recruitmentPublishTime;     //发布时间
@property (nonatomic, strong) NSString        * recruitmentAuditInfo;       //如果状态为强制下架，显示审核信息
/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void)setupDataInfo:(NSDictionary *)dic;

@end



/**
 *  张贴栏的企业信息
 */
@interface EnterpriseNewInfo : NSObject
@property (nonatomic, strong) NSString        * enterpriseId;				//企业编号
@property (nonatomic, strong) NSString        * enterpriseName;				//企业名称
@property (nonatomic, strong) NSString        * enterpriseIndustry;			//行业类别
@property (nonatomic, strong) NSString        * enterpriseAddress;			//公司地址
@property (nonatomic, strong) NSString        * enterpriseContactPhone;		//联系电话
@property (nonatomic, strong) NSString        * enterpriseProperty;			//商家特色
@property (nonatomic, strong) NSString        * enterpriseIntroduction;		//商家简介
@property (nonatomic, strong) NSString        * enterpriseLogo;				//商家LOGO的URL
@property (nonatomic, strong) NSString        * enterpriseCompanyKind;		//公司性质
@property (nonatomic, strong) NSString        * enterpriseCompanySize;		//公司规模
@property (nonatomic, strong) NSArray         * enterpriseCompanyBenefits;	//公司福利
@property (nonatomic, strong) NSString        * enterpriseRecruitmentPhone;	//招聘电话
@property (nonatomic, assign) BOOL              enterPriseIsVIP;            //是否VIP
@property (nonatomic, assign) BOOL              enterPriseIsSilver;         //是否有银元商品
@property (nonatomic, assign) BOOL              enterPriseIsGold;           //是否有金币商品
@property (nonatomic, assign) BOOL              enterPriseIsDirect;         //是否有直购商品

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void)setupDataInfo:(NSDictionary *)dic;

@end


/**
 *  图片信息
 */
@interface PictureInfo : NSObject

@property (nonatomic, strong) NSString *pictureId;                  //图片ID
@property (nonatomic, strong) NSString *pictureURL;                 //图片URL

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;
@end



/**
 *  张贴栏招聘信息详情
 */
@interface PostBoardRecruitment : NSObject

@property (nonatomic, strong) RecruitmentInfo        * recruitmentInfo;				//招聘消息的数据
@property (nonatomic, strong) EnterpriseNewInfo         * enterpriseInfo;              //张贴栏的企业信息

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *)dic;

@end



/**
 *  招商消息数据
 */
@interface AttractBusinessInfo : NSObject

@property (nonatomic, strong) NSString        *attractBusinessId;               //招商信息ID
@property (nonatomic, strong) NSString        *attractBusinessTitle;            //招商标题
@property (nonatomic, strong) NSString        *attractBusinessBrand;            //招商品牌
@property (nonatomic, strong) NSString        *attractBusinessOfficialLink;     //官网链接
@property (nonatomic, strong) NSString        *attractBusinessInvestAmount;     //投资金额
@property (nonatomic, strong) NSString        *attractBusinessInvestAmountCode; //投资金额Code
@property (nonatomic, strong) NSString        *attractBusinessDescription;      //招商说明
@property (nonatomic, strong) PictureInfo     *attractBusinessLogoPic;          //Logo图片ID
@property (nonatomic, strong) NSMutableArray  *attractBusinessPublicPics;       //宣传图片ID (PictureInfo列表)
@property (nonatomic, assign) int              attractBusinessOnlineDayCount;   //信息在线天数的设定
@property (nonatomic, assign) PostBoardStatus  attractBusinessStatus;           //0-未提交；1-播放中；2-播放结束；99-强制下架
@property (nonatomic, strong) NSString        *attractBusinessOfflineTime;      //结束时间
@property (nonatomic, strong) NSString        *attractBusinessPublishTime;      //发布时间
@property (nonatomic, strong) NSString        *attractBusinessRefreshTime;      //刷新时间
@property (nonatomic, strong) NSString        *attractBusinessAuditInfo;        //如果状态为强制下架，显示审核信息

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end



/**
 *  张贴栏招商信息详情
 */
@interface PostBoardAttractBusiness : NSObject

@property (nonatomic, strong) AttractBusinessInfo * attractBusinessInfo;        //招聘消息的数据
@property (nonatomic, strong) EnterpriseNewInfo      * enterpriseInfo;             //张贴栏的企业信息

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end

/**
 *  优惠详情
 */
@interface DiscountInfo : NSObject


@property (nonatomic, strong) NSString	* discountId;					//	优惠信息ID
@property (nonatomic, strong) NSString	* discountTitle;				//	优惠标题
@property (nonatomic, strong) NSString	* discountContent;				//	优惠内容
@property (nonatomic, strong) NSMutableArray * discountPublicPics;		//	宣传图片（PictureInfo）
@property (nonatomic, assign) BOOL        discountIsNeedVoucher;		//	是否需要凭证
@property (nonatomic, strong) PictureInfo	* discountVoucherPic;			//	凭证图片
@property (nonatomic, assign) BOOL        discountHasDiscountDate;		//	是否有优惠时段
@property (nonatomic, strong) NSString	* discountDiscountStartDate;	//	优惠开始时间
@property (nonatomic, strong) NSString	* discountDiscountEndDate;      //	优惠结束时间
@property (nonatomic, assign) int         discountOnlineDayCount;		//	信息在线天数
@property (nonatomic, assign) PostBoardStatus discountStatus;           //	0-未提交；1-播放中；2-播放结束；99-强制下架
@property (nonatomic, strong) NSString	* discountOfflineTime;			//	结束时间
@property (nonatomic, strong) NSString	* discountRefreshTime;			//	刷新时间
@property (nonatomic, strong) NSString	* discountPublishTime;			//	发布时间
@property (nonatomic, strong) NSString  * discountAuditInfo;            //如果状态为强制下架，显示审核信息

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end

/**
 *  张贴栏优惠信息详情
 */
@interface PostBoardDiscount : NSObject

@property (nonatomic, strong) DiscountInfo      * discountInfo;     //优惠信息的数据
@property (nonatomic, strong) EnterpriseNewInfo    * enterpriseInfo;   //张贴栏的企业信息

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end


/**
 *  张贴栏搜索(结果)
 */
@interface PostBoardSearchResultInfo : NSObject

@property (nonatomic, strong) NSString	* resultId;				//	张贴栏ID
@property (nonatomic, assign) PostBoardType resultType;			//	1-招聘消息；2-招商消息；3-优惠消息
@property (nonatomic, strong) NSString	* resultTitle;			//	张贴栏标题
@property (nonatomic, strong) NSString	* resultEnterpriseName;	//	商家名称
@property (nonatomic, strong) NSString	* resultLogoUrl;		//	商家Logo或品牌Logo的Url
@property (nonatomic, strong) NSString	* resultIndustry;		//	行业类别
@property (nonatomic, strong) NSString	* resultRegion;			//	所在区域
@property (nonatomic, strong) NSString	* resultKeyWord;		//	消息关键字
@property (nonatomic, strong) NSString	* resultRefreshTime;	//	刷新时间或创建时间

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end

/**
 *  张贴栏收藏
 */
@interface CollectionInfo : NSObject

@property (nonatomic, strong) NSString	* collectionId;					//	张贴栏ID
@property (nonatomic, assign) PostBoardType collectionType;				//	1-招聘消息；2-招商消息；3-优惠消息
@property (nonatomic, strong) NSString	* collectionTitle;				//	张贴栏标题
@property (nonatomic, strong) NSString	* collectionLogoUrl	;			//	商家Logo或品牌Logo的Url
@property (nonatomic, strong) NSString	* collectionFavoriteTime;		//	收藏时间

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end


/**
 *  举报原因
 */
@interface ReportReasonInfo : NSObject

@property (nonatomic, strong) NSString * code;              //举报原因代码
@property (nonatomic, strong) NSString * reason;            //举报原因中文内容

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end


/**
 *  福利
 */
@interface Welfare : NSObject

@property (nonatomic, strong) NSString * code;              //福利编码
@property (nonatomic, strong) NSString * text;              //福利内容

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end


/**
 *  公司福利
 */
@interface CompanyBenefitsInfo : NSObject
@property (nonatomic,strong) NSString *benefitsCode;        //福利code
@property (nonatomic,strong) NSString *benefitsText;        //福利描述
/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end


/**
 *  获取张贴栏需完善的信息
 */
@interface PostBoardNeedFull : NSObject

@property (nonatomic, strong) NSString * needCompanySizeCode;          //公司规模Code
@property (nonatomic, strong) NSString * needCompanySize;              //公司规模
@property (nonatomic, strong) NSString * needCompanyKindCode;          //公司性质Code
@property (nonatomic, strong) NSString * needCompanyKind;              //公司性质名称
@property (nonatomic, strong) NSMutableArray * needCompanyBenefits;    //公司福利Code集合
@property (nonatomic, strong) NSString * needRecruitmentPhone;         //招聘电话

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end

/**
 *  招聘信息管理
 */
@interface RecruitmentManageInfo : NSObject

@property (nonatomic, assign) int       recruitmentTodayRestCount;         //当天剩余条数
@property (nonatomic, assign) int       recruitmentOfflineCount;         //被下架的招聘信息数量
@property (nonatomic, assign) int       recruitmentForceOfflineCount;         //被强制下架的招聘信息数量
@property (nonatomic, assign) BOOL      recruitmentIsInfoCompleted;         //企业招聘信息是否完善
@property (nonatomic, assign) float     recruitmentCurrentGoldAmount;         //用户当前金币数量

@property (nonatomic, assign) int       recruitmentNormalPublishCount;         //每天普通商家能够发布多少条招聘信息
@property (nonatomic, assign) int    	recruitmentVipPublishCount;        	 //每天Vip商家能够发布多少条招聘信息
@property (nonatomic, assign) int   	recruitmentNormalRefreshCount;         //每天普通商家能够刷新多少条
@property (nonatomic, assign) int   	recruitmentVipRefreshCount;         //每天Vip商家能够刷新多少条
@property (nonatomic, assign) int   	recruitmentPublishGoldCount;         //发布所需金币数

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end

/**
 *  发布招聘信息
 */
@interface RecruitmentPublishInfo : NSObject

@property (nonatomic, strong) NSString * publishId;                 //招聘信息ID
@property (nonatomic, assign) double      publishGoldCount;         //发布所需金币
@property (nonatomic, assign) double      publishRemainGoldCount;   //	剩余金币

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end

/**
 *  招聘信息列表数据
 */
@interface RecruitmentListInfo : NSObject

@property (nonatomic, strong) NSString *listId;                 //招聘信息的ID
@property (nonatomic, strong) NSString *listTitle;              //招聘标题
@property (nonatomic, strong) NSString *listTimeDesc;           //关于时间的描述
@property (nonatomic, assign) BOOL      listIsRefreshed;        //是否已刷新
@property (nonatomic, assign) BOOL      listIsSelected;         //是否已选中
/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end

/**
 *  招商信息管理首页
 */
@interface AttractBusinessManageInfo : NSObject

@property (nonatomic, assign) int       businessTodayRestCount;                 //当天剩余条数
@property (nonatomic, assign) int       businessOfflineCount;                 //被下架的招聘信息数量
@property (nonatomic, assign) int       businessForceOfflineCount;                 //被强制下架的招聘信息数量
@property (nonatomic, assign) double    businessCurrentGoldAmount;                 //用户当前金币数量
@property (nonatomic, assign) int       businessNormalPublishCount;                 //每天普通商家能够发布多少条招聘信息
@property (nonatomic, assign) int       businessVipPublishCount;                 //每天Vip商家能够发布多少条招聘信息
@property (nonatomic, assign) int       businessNormalRefreshCount;                 //每天普通商家能够刷新多少条
@property (nonatomic, assign) int       businessVipRefreshCount;                 //每天Vip商家能够刷新多少条
@property (nonatomic, assign) int       businessPublishGoldCount;                 //发布所需金币数

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end

/**
 *  发布招商信息
 */
@interface AttractBusinessPublish : NSObject

@property (nonatomic, strong) NSString *    publishId;                //招聘信息ID
@property (nonatomic, assign) double        publishGoldCount;       //发布所需金币
@property (nonatomic, assign) double        publishRemainGoldCount;   //剩余金币

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end

/**
 *  招商信息列表
 */
@interface AttractBusinessListInfo : NSObject

@property (nonatomic, strong) NSString *    listId;   //招商信息的ID
@property (nonatomic, strong) NSString *    listTitle;   //招商标题
@property (nonatomic, strong) NSString *    listTimeDesc;   //关于时间的描述
@property (nonatomic, assign) BOOL          listIsRefreshed;   //是否已刷新
@property (nonatomic, assign) BOOL          listIsSelected;//是否已选中

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;
@end


/**
 *  优惠信息管理首页
 */
@interface DiscountManageInfo : NSObject

@property (nonatomic, assign) int     discountTodayRestCount;   //当天剩余条数
@property (nonatomic, assign) int     discountOfflineCount;   //被下架的优惠信息数量
@property (nonatomic, assign) int     discountForceOfflineCount;   //被强制下架的优惠信息数量
@property (nonatomic, assign) double  discountCurrentGoldAmount;   //用户当前金币数量
@property (nonatomic, assign) int     discountNormalPublishCount;   //每天普通商家能够发布多少条招聘信息
@property (nonatomic, assign) int     discountVipPublishCount;   //每天Vip商家能够发布多少条招聘信息
@property (nonatomic, assign) int     discountNormalRefreshCount;   //每天普通商家能够刷新多少条
@property (nonatomic, assign) int     discountVipRefreshCount;   //每天Vip商家能够刷新多少条
@property (nonatomic, assign) int     discountPublishGoldCount;   //发布所需金币数

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end

/**
 *  优惠列表数据
 */
@interface DiscountListInfo : NSObject

@property (nonatomic, strong) NSString * listId;   			 //优惠信息的ID
@property (nonatomic, strong) NSString * listTitle;  		 //优惠标题
@property (nonatomic, strong) NSString * listTimeDesc;  	 //关于时间的描述
@property (nonatomic, assign) BOOL       listIsRefreshed;    //是否已刷新
@property (nonatomic, assign) BOOL       listIsSelected;         //是否已选中

-(void) setupDataInfo:(NSDictionary *) dic;

@end


/**
 *  发布招聘信息优惠
 */
@interface DiscountPublishInfo : NSObject

@property (nonatomic, strong) NSString *    publishId;                //招聘信息ID
@property (nonatomic, assign) double        publishGoldCount;       //发布所需金币
@property (nonatomic, assign) double        publishRemainGoldCount;   //剩余金币

/**
 *  设置相关信息
 *
 *  @param dic 待设置的值
 */
-(void) setupDataInfo:(NSDictionary *) dic;

@end

/**
 *  字典项
 */
@interface OperatorCodeInfo : NSObject


@property (nonatomic, strong) NSString * codeId;        //字典项编号
@property (nonatomic, strong) NSString * codeText;      //	字典项内容
@property (nonatomic, strong) NSString * codeValue;     //字典项值
@property (nonatomic, strong) NSString * codeSortId;    //字典项排序

-(void) setupDataInfo:(NSDictionary *) dic;

@end


@interface Model_PostBoard : NSObject

@end
