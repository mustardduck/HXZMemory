//
//  Preview_Commodity.h
//  UIAnimation
//
//  Created by apple on 14/12/31.
//
//

#import <UIKit/UIKit.h>
#import "RCScrollView.h"
@class NetImageView;
@class Enterprise;

@interface Preview_Commodity : UIViewController
{
    NSArray                 *_specifications;           //产品
    NSArray                 *_pictures;                 //商品图片
    NSArray                 *_introductionPictures;     //商品介绍图片
    
    int                     _productId;
    
    UIScrollView            *_baseScroll;
    
    UIView                  *_imageScroll;
    
    UIView                  *_top0;
    UILabel                 *_productName;
    UILabel                 *_productFeature;
    UILabel                 *_priceRange;
    UIImageView             *_freeShipping;
    UILabel                 *_onhandQty;
    
    UIView                  *_top1;
    UITextField             *_tf_count;
    
    UIView                  *_top2;
    UIButton                *_btn_consult;
    UIButton                *_btn_shop;
    Enterprise              *_obj_enterprise;
    UILabel                 *_postil;
    UILabel                 *_enterpriseName;
    
    UIView                  *_top3;
    UILabel                 *_title_introduce;
    UILabel                 *_title_service;
    UIView                  *_slipBar;
    NetImageView            *_headImage;
    
    
    UIView                  *_view_introduce;
    UILabel                 *_lab_introduce;
    UIView                  *_view_service;
    UILabel                 *_lab_service;
    
    UIView                  *_view_illustrate;                  //接口 /Services/CustomerService/V2/CustomerCollect 3, AdvertType 银元商品。 4金币商品
    
    UIView                  *_view_tools;
    UIImageView             *_img_favorite;
    UIButton                *_btn_favorite;
    
    NSString                *_chooseSpecification;              //选中的型号，用于生成订单
}

//@property(nonatomic, retain)     NSArray                 *specifications;
@property(nonatomic, assign) int                            whereFrom;             //0: 预览，1: others
@property(nonatomic, assign) int                            productId;
@property(nonatomic, retain) IBOutlet UIScrollView          *baseScroll;

@property(nonatomic, retain) IBOutlet UIView                *imageScroll;

@property(nonatomic, retain) IBOutlet UIView                *top0;
@property(nonatomic, retain) IBOutlet UILabel               *productName;           //商品名称
@property(nonatomic, retain) IBOutlet UILabel               *productFeature;        //商品特色
@property(nonatomic, retain) IBOutlet UILabel               *priceRange;            //价格范围
@property(nonatomic, retain) IBOutlet UIImageView           *freeShipping;          //包邮图片
@property(nonatomic, retain) IBOutlet UILabel               *onhandQty;             //库存

@property(nonatomic, retain) IBOutlet UIView                *top1;
@property(nonatomic, retain) IBOutlet UITextField           *tf_count;

@property(nonatomic, retain) IBOutlet UIView                *top2;
@property(nonatomic, retain) IBOutlet UIButton              *btn_consult;           //咨询
@property(nonatomic, retain) IBOutlet UIButton              *btn_shop;              //店铺
@property(nonatomic, retain) Enterprise                     *obj_enterprise;        //商家对象
@property(nonatomic, retain) IBOutlet UILabel               *postil;                //批注
@property(nonatomic, retain) IBOutlet UILabel               *enterpriseName;        //企业名称

@property(nonatomic, retain) IBOutlet UIView                *top3;
@property(nonatomic, retain) IBOutlet UILabel               *title_introduce;         //商品介绍
@property(nonatomic, retain) IBOutlet UILabel               *title_service;           //售后服务
@property(nonatomic, retain) IBOutlet UIView                *slipBar;                 //滑动条
@property(nonatomic, retain) IBOutlet NetImageView          *headImage;

//@property(nonatomic, retain) IBOutlet UIView                *top3;
@property(nonatomic, retain) IBOutlet UIView                *view_introduce;          //介绍页
@property(nonatomic, retain) IBOutlet UILabel               *lab_introduce;           //内容
@property(nonatomic, retain) IBOutlet UIView                *view_service;            //售后页
@property(nonatomic, retain) IBOutlet UILabel               *lab_service;             //内容
@property(nonatomic, retain) IBOutlet UIView                *view_illustrate;         //说明页

@property(nonatomic, retain) IBOutlet UIView                *view_tools;              //功能页，收藏，购买
@property(nonatomic, retain) IBOutlet UIImageView           *img_favorite;            //收藏图片
@property(nonatomic, retain) IBOutlet UIButton              *btn_favorite;            //收藏按钮


@end
