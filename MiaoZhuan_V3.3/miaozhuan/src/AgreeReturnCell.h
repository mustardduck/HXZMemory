//
//  AgreeReturnCell.h
//  miaozhuan
//
//  Created by Santiago on 15-1-14.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSalesReturnCell.h"
@interface AgreeReturnCell: BaseSalesReturnCell
@property (retain, nonatomic) IBOutlet UILabel *userLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UILabel *cellTitle;

@property (retain, nonatomic) IBOutlet UILabel *waitingUserReturn;

@property (retain, nonatomic) IBOutlet UIView *backGroundView;
@property (retain, nonatomic) IBOutlet UIView *UILineView;
+ (instancetype)newInstance;
@end
