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

}

//初始化传入参数
@property(nonatomic, assign) int                                productId;
@property(nonatomic, assign) int                                whereFrom;                        //4:出售中, 3:等待上架, 5:已下架, 1:审核中, 2:审核失败

@end
