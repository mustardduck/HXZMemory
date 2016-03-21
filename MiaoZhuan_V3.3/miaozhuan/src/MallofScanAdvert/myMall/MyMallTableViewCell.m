//
//  MyMallTableViewCell.m
//  miaozhuan
//
//  Created by apple on 14/12/20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyMallTableViewCell.h"

@implementation MyMallTableViewCell

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
    [_cellContent release];
    [_cellLine release];
    [_cellJiantou release];
    [super dealloc];
}
@end
