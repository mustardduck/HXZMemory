//
//  SelectIncomeCell.m
//  miaozhuan
//
//  Created by momo on 14-11-28.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SelectIncomeCell.h"

@implementation SelectIncomeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_titleLbl release];
    [_iconView release];
    [_iconBtn release];
    [super dealloc];
}
@end
