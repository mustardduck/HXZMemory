//
//  GetCashRecordCell.h
//  miaozhuan
//
//  Created by Santiago on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetCashRecordCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *bankIcon;
@property (retain, nonatomic) IBOutlet UILabel *bankName;
@property (retain, nonatomic) IBOutlet UILabel *tailNumber;
@property (retain, nonatomic) IBOutlet UILabel *accountName;
@property (retain, nonatomic) IBOutlet UILabel *treatTime;
@property (retain, nonatomic) IBOutlet UILabel *amount;
@property (retain, nonatomic) IBOutlet UILabel *state;
@property (retain, nonatomic) IBOutlet UILabel *orderNumber;
@property (strong, nonatomic) UIView *UILineView2;

@end
