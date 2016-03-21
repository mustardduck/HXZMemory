//
//  ModelData.h
//  miaozhuan
//
//  Created by xm01 on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateModel : NSObject

@property(nonatomic, assign) int              productId;
@property(nonatomic, assign) CGFloat          deliveryPrice;         //邮寄费用
@property(nonatomic, assign) int              offlineType;
@property(nonatomic, retain) NSArray          *standardList;

@end

@interface StyleMode : NSObject

@property(nonatomic, retain) NSString *productSpec;
@property(nonatomic, assign) int      onhandQty;
@property(nonatomic, assign) CGFloat  unitPrice;

@end

//供货商家对象
@interface Enterprise : NSObject

@property(nonatomic, assign) int            enterpriseId;
@property(nonatomic, retain) NSString       *enterpriseName;
@property(nonatomic, retain) NSString       *enterpriseLogo;
@property(nonatomic, assign) BOOL           isVip;
@property(nonatomic, assign) BOOL           isSilver;
@property(nonatomic, assign) BOOL           isGold;

@end

@interface ModelData : NSObject

@end
