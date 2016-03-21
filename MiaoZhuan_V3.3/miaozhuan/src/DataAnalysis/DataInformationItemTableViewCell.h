//
//  DataInformationItemTableViewCell.h
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
@interface DataInformationItemTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet NetImageView *img;
@property (retain, nonatomic) IBOutlet UILabel *advertName;

@property (retain, nonatomic) IBOutlet UILabel *price;
@property (retain, nonatomic) IBOutlet UILabel *bandNum;
@property (retain, nonatomic) IBOutlet UILabel *changeNum;
@end
