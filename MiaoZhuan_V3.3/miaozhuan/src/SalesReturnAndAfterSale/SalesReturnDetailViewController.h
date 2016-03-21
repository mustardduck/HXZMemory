//
//  SalesReturnViewController.h
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalesReturnDetailViewController : DotCViewController
//1看广告我的协商退货，2发广告商家协商退货
@property (assign, nonatomic)int type;
@property (assign, nonatomic)int orderId;
@property (assign, nonatomic)int status;
@property (strong, nonatomic)NSString *creatTime;
@end
