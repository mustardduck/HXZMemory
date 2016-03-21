//
//  ChooseManagerFromListCell.m
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ChooseManagerFromListCell.h"

@implementation ChooseManagerFromListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_checkImage release];
    [_name release];
    [_phoneNumber release];
    [_headImage release];
    [_choosedImage release];
    [super dealloc];
}
@end
