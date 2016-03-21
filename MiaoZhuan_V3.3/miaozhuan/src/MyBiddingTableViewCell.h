//
//  MyBiddingTableViewCell.h
//  miaozhuan
//
//  Created by Santiago on 14-11-7.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBiddingTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIButton *updatePriceBtn;
@property (retain, nonatomic) IBOutlet UILabel *adName;
@property (retain, nonatomic) IBOutlet UILabel *biddingCount;
@property (retain, nonatomic) IBOutlet UILabel *price;
@property (retain, nonatomic) IBOutlet UIView *UIBottomLineView;

@end
