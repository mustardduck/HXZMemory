//
//  DataImformationJumpItemTableViewCell.m
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DataImformationJumpItemTableViewCell.h"

@implementation DataImformationJumpItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_img release];
    [_icon release];
    [_titleL release];
    [_phoneL release];
    [_placeL release];
    [_timeL release];
    [_vipIcon release];
    [_line release];
    [_isRead release];
    [super dealloc];
}
@end
