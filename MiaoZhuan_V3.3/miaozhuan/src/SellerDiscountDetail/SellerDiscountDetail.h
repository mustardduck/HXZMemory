//
//  SellerDiscountDetail.h
//  sss
//
//  Created by luocena on 4/27/15.
//  Copyright (c) 2015 luocena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DotCViewController.h"

/**
 *  商家优惠
 */
@interface SellerDiscountDetail : DotCViewController

/**
 *  预览
 */
@property (nonatomic,assign) BOOL           isPreview;
/**
 *  下架
 */
@property (nonatomic,assign) BOOL           isOffline;


/**
 *  强制下架
 */
@property (nonatomic,assign) BOOL           isForceOffLine;


@property (nonatomic,strong) NSString   *   discountId;  //优惠ID


/**
 *  加载数据
 */

-(void) loadData;

@end
