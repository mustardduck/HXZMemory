//
//  CashFromFansCell.m
//  miaozhuan
//
//  Created by Santiago on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CashFromFansCell.h"

@implementation CashFromFansCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_headPic release];
    [_vipIcon release];
    [_nameLabel release];
    [_fromFansLevelLabel release];
    [_acountLabel release];
    [super dealloc];
}
@end
