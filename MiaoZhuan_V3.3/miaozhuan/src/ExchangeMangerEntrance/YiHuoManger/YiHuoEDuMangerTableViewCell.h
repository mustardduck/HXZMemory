//
//  YiHuoEDuMangerTableViewCell.h
//  miaozhuan
//
//  Created by apple on 15/6/3.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRLineView.h"

@interface YiHuoEDuMangerTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *titleCell;
@property (retain, nonatomic) IBOutlet RRLineView *lineCell;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineCellLeft;

@end
