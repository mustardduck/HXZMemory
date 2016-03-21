//
//  ModelSliverDetail.h
//  miaozhuan
//
//  Created by abyss on 14/12/30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>
#define crDECStro(_p, _type) @property (retain, nonatomic) _type*   _p
#define crDECWeak(_p, _type) @property (assign, nonatomic) _type    _p
@interface ModelSliverDetail : NSObject
crDECWeak(sdProductId,int);                           //否 	兑换商品编号
crDECWeak(sdAdvertId,int);                            //否 	绑定广告编号
crDECWeak(sdEnterpriseId,int);                        //否 	供货商家编号
crDECStro(sdName,NSString);                           //否 	商品名称
crDECStro(sdDescribe,NSString);                       //否 	商品描述
crDECWeak(sdUnitPrice,double);                        //否 	商家定价（RMB）
crDECWeak(sdUnitIntegral,long);                       //否 	银元价格
crDECWeak(sdExchangeType,int);                        //否 	兑换类型：0：邮寄兑换1：现场兑换
crDECWeak(sdExchangedCount,int);                      //否 	已兑换数量
crDECWeak(sdRemainExchangeCount,int);                 //否	剩余兑换数量（即将上架）
crDECWeak(sdExchangeableCount,int);                   //否 	可兑换量（已出炉）
crDECWeak(sdExchangeTotal,int);                       //否 	兑换总量
crDECWeak(sdPerPersonNumber,int);                     //否 	每人可兑换数
crDECWeak(sdPerPersonPerDayNumber,int);               //否   每人每天可兑换数
crDECWeak(sdCustomerSilverBalance,int);               //否   用户银元余额
crDECWeak(sdIsCollect,bool);                          //否 	是否收藏
crDECStro(sdPictures,NSArray);                        //否 	商家信息
crDECStro(sdEnterpriseInfo,NSDictionary);             //否   商家信息
crDECStro(sdProductExchangeAddress,NSArray);          //否   兑换点
- (instancetype)initWith:(DictionaryWrapper *)wrapper;
@end
