//
//  BankCardCell.h
//  miaozhuan
//
//  Created by Santiago on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
@interface BankCardCell : UITableViewCell
@property (retain, nonatomic) IBOutlet NetImageView *icon;
@property (retain, nonatomic) IBOutlet UILabel *bankName;
@property (retain, nonatomic) IBOutlet UILabel *tailNumber;
@property (retain, nonatomic) IBOutlet UILabel *typeName;
@property (retain, nonatomic) IBOutlet UIImageView *checkImageView;
@property (retain, nonatomic) IBOutlet UIView *UIBottomLineView;


@end
