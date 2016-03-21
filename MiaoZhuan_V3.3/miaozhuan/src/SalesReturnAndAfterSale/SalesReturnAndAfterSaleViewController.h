//
//  SalesReturnAndAfterSaleViewController.h
//  miaozhuan
//
//  Created by Santiago on 14-12-8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalesReturnAndAfterSaleViewController : DotCViewController

//退货售后
//1发起退货
//2待退货
//3待确认退货
//4退货成功
//5申诉中
//6申诉完毕
@property(assign, nonatomic)int type;
@end
