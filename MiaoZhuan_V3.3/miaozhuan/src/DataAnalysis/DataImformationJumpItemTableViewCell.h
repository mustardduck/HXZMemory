//
//  DataImformationJumpItemTableViewCell.h
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"

@interface DataImformationJumpItemTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet NetImageView *img;
@property (retain, nonatomic) IBOutlet UIImageView *icon;
@property (retain, nonatomic) IBOutlet UILabel *titleL;
@property (retain, nonatomic) IBOutlet UILabel *phoneL;
@property (retain, nonatomic) IBOutlet UILabel *placeL;
@property (retain, nonatomic) IBOutlet UILabel *timeL;
@property (retain, nonatomic) IBOutlet UIImageView *vipIcon;
@property (retain, nonatomic) IBOutlet UIImageView *line;
@property (nonatomic, retain) IBOutlet UILabel *isRead;

@end
