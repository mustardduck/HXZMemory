//
//  SaleReturnCell5.h
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSalesReturnCell.h"
@interface SalesReturnCell5 : BaseSalesReturnCell

@property (retain, nonatomic) IBOutlet UILabel *userLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;

@property (retain, nonatomic) IBOutlet UILabel *cellTitle;

@property (retain, nonatomic) IBOutlet UILabel *ifYouAgree;
@property (retain, nonatomic) IBOutlet UILabel *ifYouAgreeDetail;

@property (retain, nonatomic) IBOutlet UILabel *ifYouReject;
@property (retain, nonatomic) IBOutlet UILabel *ifYouRejectDetail;

@property (retain, nonatomic) IBOutlet UILabel *ifYouNotHandle;
@property (retain, nonatomic) IBOutlet UILabel *ifYouNotHandleDetail;
@property (retain, nonatomic) IBOutlet UIView *backGroundView;
@property (retain, nonatomic) IBOutlet UIView *UILineView;

+ (instancetype)newInstance;
@end
