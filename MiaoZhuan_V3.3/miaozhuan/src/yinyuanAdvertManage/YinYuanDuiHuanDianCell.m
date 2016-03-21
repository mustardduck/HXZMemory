//
//  YinYuanDuiHuanDianCell.m
//  miaozhuan
//
//  Created by momo on 14-12-8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanDuiHuanDianCell.h"

@implementation YinYuanDuiHuanDianCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_titleLbl release];
    [_telLbl release];
    [_addressLbl release];
    [_iconView release];
    [_line release];
    [super dealloc];
}
@end
