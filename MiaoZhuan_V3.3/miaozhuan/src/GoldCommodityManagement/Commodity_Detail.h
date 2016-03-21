//
//  Commodity_Detail.h
//  miaozhuan
//
//  Created by xm01 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "ModelData.h"

@interface Commodity_Detail : UIViewController
{
    UIScrollView    *_scrollView;
    
    UIView          *_topView;
    UIView          *_centerView;
    UIView          *_bottomView;
    
    //topView
    UILabel         *_lab_productName;
    NetImageView    *_picture;
    UILabel         *_lab_unitPrice;
    UILabel         *_lab_deliveryPrice;
    UILabel         *_lab_onhandQty;
    UILabel         *_lab_offlineType;
    
    //centerView
    UILabel         *_lab_Info_producName;
    UILabel         *_lab_catagoryName;
    UILabel         *_lab_parameter;
    
    UILabel         *_title_catagoryName;
    UILabel         *_title_parameter;
    
    //bottomView
    UILabel         *_lab_feature;
    UILabel         *_lab_description;
    UILabel         *_lab_promise;
    
    UILabel         *_title_feature;
    UILabel         *_title_description;
    UILabel         *_title_promise;
    
    UpdateModel     *_updateModel;
}
//初始化传入参数
@property(nonatomic, assign) int              productId;

@property(nonatomic, retain) IBOutlet UIScrollView  *scrollView;

@property(nonatomic, retain) IBOutlet UIView        *topView;
@property(nonatomic, retain) IBOutlet UIView        *centerView;
@property(nonatomic, retain) IBOutlet UIView        *bottomView;


//topView
@property(nonatomic, retain) IBOutlet UILabel       *lab_productName;           //商品名称
@property(nonatomic, retain) IBOutlet NetImageView  *picture;
@property(nonatomic, retain) IBOutlet UILabel       *lab_unitPrice;             //单价
@property(nonatomic, retain) IBOutlet UILabel       *lab_deliveryPrice;         //邮寄费用
@property(nonatomic, retain) IBOutlet UILabel       *lab_onhandQty;             //库存数量
@property(nonatomic, retain) IBOutlet UILabel       *lab_offlineType;           //下架方式          1, 售完下架   2, 到期下架


//centerView
@property(nonatomic, retain) IBOutlet UILabel       *lab_Info_producName;       //商品名称
@property(nonatomic, retain) IBOutlet UILabel       *lab_catagoryName;          //商品类别
@property(nonatomic, retain) IBOutlet UILabel       *lab_parameter;             //颜色/参数

@property(nonatomic, retain) IBOutlet UILabel       *title_catagoryName;        //标题 - 商品类别
@property(nonatomic, retain) IBOutlet UILabel       *title_parameter;           //标题 - 颜色/参数

//bottomView
@property(nonatomic, retain) IBOutlet UILabel       *lab_feature;            //特色卖点
@property(nonatomic, retain) IBOutlet UILabel       *lab_description;        //商品描述
@property(nonatomic, retain) IBOutlet UILabel       *lab_promise;            //售后条款
@property(nonatomic, retain) IBOutlet UILabel       *title_feature;
@property(nonatomic, retain) IBOutlet UILabel       *title_description;      //标题 - 商品描述
@property(nonatomic, retain) IBOutlet UILabel       *title_promise;          //标题 - 售后条款

@property(nonatomic, retain) UpdateModel            *updateModel;

@end
