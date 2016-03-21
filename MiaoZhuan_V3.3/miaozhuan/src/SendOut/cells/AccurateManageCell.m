//
//  AccurateManageCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AccurateManageCell.h"

@implementation AccurateManageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)dealloc {
    [_lblTitle release];
    [_lblAccAdsCount release];
    [_lblDJAdsCount release];
    [_lblAccView release];
    [_cellline release];
    [_line1 release];
    [_line2 release];
    [super dealloc];
}
@end
