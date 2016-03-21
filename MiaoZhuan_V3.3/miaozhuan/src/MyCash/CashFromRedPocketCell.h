//
//  CashFromRedPocketCell.h
//  miaozhuan
//
//  Created by Santiago on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
@interface CashFromRedPocketCell : UITableViewCell

@property (retain, nonatomic) IBOutlet NetImageView *adsPic;
@property (retain, nonatomic) IBOutlet UILabel *adsName;
@property (retain, nonatomic) IBOutlet UILabel *seeAdsTime;
@property (retain, nonatomic) IBOutlet UILabel *moneyAcount;

@end
