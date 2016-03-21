//
//  PeopleSetCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PeopleSetCell.h"

@implementation PeopleSetCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_lblTitle release];
    [_lblStatus release];
    [_lineview release];
    [super dealloc];
}
@end
