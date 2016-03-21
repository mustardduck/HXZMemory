//
//  GetRedPacketsCell.h
//  miaozhuan
//
//  Created by Santiago on 14-10-23.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
@interface GetRedPacketsCell : UITableViewCell

@property (retain, nonatomic) IBOutlet NetImageView *redPacketPic;

@property (retain, nonatomic) IBOutlet UILabel *adName;

@property (retain, nonatomic) IBOutlet UILabel *companyName;

@property (retain, nonatomic) IBOutlet UILabel *amountOfReward;

@property (retain, nonatomic) IBOutlet UILabel *expireDays;

@property (retain, nonatomic) IBOutlet UIImageView *redPacketMarkImage;

@property (retain, nonatomic) IBOutlet UIView *UILineView;

@end
