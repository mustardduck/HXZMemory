//
//  BarDataTableViewCell.h
//  miaozhuan
//
//  Created by abyss on 14/11/17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRBar.h"

@interface BarDataTableViewCell : UITableViewCell
@property (assign, nonatomic) double data;
@property (retain, nonatomic) IBOutlet CRBar *bar;
@property (retain, nonatomic) IBOutlet UILabel *titleL;
@property (retain, nonatomic) IBOutlet UILabel *num;
@end
