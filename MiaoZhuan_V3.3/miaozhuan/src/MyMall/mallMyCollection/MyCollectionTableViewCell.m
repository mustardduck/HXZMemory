//
//  MyCollectionTableViewCell.m
//  miaozhuan
//
//  Created by apple on 14/12/19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyCollectionTableViewCell.h"

@implementation MyCollectionTableViewCell

- (void)awakeFromNib
{
    _cellImages.layer.borderWidth = 0.5;
    _cellImages.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_cellImages release];
    [_cellTitle release];
    [_cellNeedMoney release];
    [_cellneedLable release];
    [_cellTypeImage release];
    [super dealloc];
}
@end