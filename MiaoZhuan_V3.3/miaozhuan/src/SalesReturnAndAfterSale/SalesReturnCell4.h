//
//  SalesReturnCell4.h
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSalesReturnCell.h"

//用户已退货
@interface SalesReturnCell4 : BaseSalesReturnCell

@property (retain, nonatomic) IBOutlet UILabel *userLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;

@property (retain, nonatomic) IBOutlet UILabel *cellTitle;

@property (retain, nonatomic) IBOutlet UILabel *logicticCompanyTitle;
@property (retain, nonatomic) IBOutlet UILabel *logisticsName;

@property (retain, nonatomic) IBOutlet UILabel *logisticsNumberTitle;
@property (retain, nonatomic) IBOutlet UILabel *logisticsNumberDetail;

@property (retain, nonatomic) IBOutlet UIView *backGroundView;
@property (retain, nonatomic) IBOutlet UIView *UILineView;

+ (instancetype)newInstance;
@end
