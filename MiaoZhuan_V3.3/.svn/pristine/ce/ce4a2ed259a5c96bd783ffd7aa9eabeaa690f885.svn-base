//
//  BarDataTableViewCell.m
//  miaozhuan
//
//  Created by abyss on 14/11/17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BarDataTableViewCell.h"

@interface BarDataTableViewCell ()
@end

@implementation BarDataTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(double)data
{
    _data = data;
    _bar.percentNum = _data;
}
- (void)dealloc {
    [_bar release];
    [_titleL release];
    [_num release];
    [super dealloc];
}
@end
