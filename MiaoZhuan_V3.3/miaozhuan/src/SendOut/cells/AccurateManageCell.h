//
//  AccurateManageCell.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRLineView.h"
@interface AccurateManageCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *lblTitle;

@property (retain, nonatomic) IBOutlet UILabel *lblAccAdsCount;
@property (retain, nonatomic) IBOutlet RRLineView *cellline;
@property (retain, nonatomic) IBOutlet UILabel *lblDJAdsCount;
@property (retain, nonatomic) IBOutlet UIView *lblAccView;
@property (retain, nonatomic) IBOutlet RRLineView *line1;
@property (retain, nonatomic) IBOutlet RRLineView *line2;

@end
