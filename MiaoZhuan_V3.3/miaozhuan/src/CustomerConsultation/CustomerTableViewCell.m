//
//  CustomerTableViewCell.m
//  miaozhuan
//
//  Created by apple on 14/11/5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CustomerTableViewCell.h"

@implementation CustomerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_customerCellTitle release];
    [_customerCellContents release];
    [_customerCellLine release];
    [_numCellImage release];
    [super dealloc];
}
@end
