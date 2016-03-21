//
//  MyCollectionTableViewCell.m
//  miaozhuan
//
//  Created by apple on 14/12/19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyCollectionTableViewCell.h"

@implementation MyCollectionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_cellImages release];
    [_cellTitle release];
    [_cellNeedMoney release];
    [super dealloc];
}
@end
