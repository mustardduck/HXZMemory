//
//  HistorySearchCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "HistorySearchCell.h"

@implementation HistorySearchCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_lblTitle release];
    [_btnDelete release];
    [_line release];
    [super dealloc];
}
@end
