//
//  SalesReturnCell3.h
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSalesReturnCell.h"

//您同意退货
@interface SalesReturnCell3 : BaseSalesReturnCell

@property (retain, nonatomic) IBOutlet UILabel *userLabel;
@property (retain, nonatomic) IBOutlet UILabel *tiemLabel;

@property (retain, nonatomic) IBOutlet UILabel *cellTitle;

@property (retain, nonatomic) IBOutlet UILabel *waitingForReturn;
@property (retain, nonatomic) IBOutlet UILabel *waitingForReturnDetail;

@property (retain, nonatomic) IBOutlet UILabel *ifYouRejectTitle;
@property (retain, nonatomic) IBOutlet UILabel *ifYouRejectDetail;

@property (retain, nonatomic) IBOutlet UIView *backGroundView;

@property (retain, nonatomic) IBOutlet UIView *UILineView;
+ (instancetype)newInstance;
@end
