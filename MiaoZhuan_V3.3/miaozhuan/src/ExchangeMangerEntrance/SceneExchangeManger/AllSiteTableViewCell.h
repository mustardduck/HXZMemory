//
//  AllSiteTableViewCell.h
//  miaozhuan
//
//  Created by apple on 14/12/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "RRLineView.h"

@interface AllSiteTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet NetImageView *cellsiteImage;
@property (retain, nonatomic) IBOutlet UILabel *cellTitle;
@property (retain, nonatomic) IBOutlet UILabel *cellPhoneandName;
@property (retain, nonatomic) IBOutlet UILabel *cellNum;
@property (retain, nonatomic) IBOutlet RRLineView *cellLine;

@end
