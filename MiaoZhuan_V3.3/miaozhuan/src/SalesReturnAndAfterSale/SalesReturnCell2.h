//
//  SalesReturnCell2.h
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSalesReturnCell.h"

//系统等待您处理退货申请
@interface SalesReturnCell2 : BaseSalesReturnCell

@property (retain, nonatomic) IBOutlet UILabel *userLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;

@property (retain, nonatomic) IBOutlet UILabel *cellTitle;

@property (retain, nonatomic) IBOutlet UILabel *ifYouAgreeTitle;
@property (retain, nonatomic) IBOutlet UILabel *ifYouAgreeDetail;

@property (retain, nonatomic) IBOutlet UILabel *ifYouRejectTitle;
@property (retain, nonatomic) IBOutlet UILabel *ifYouRejectDetail;

@property (retain, nonatomic) IBOutlet UILabel *ifYouNotHandleTitle;
@property (retain, nonatomic) IBOutlet UILabel *ifYouNotHandleDetail;

@property (retain, nonatomic) IBOutlet UIView *backGroundView;
@property (retain, nonatomic) IBOutlet UIView *UILineView;

+ (instancetype)newInstance;
@end
