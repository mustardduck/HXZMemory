//
//  ExchangeMangerEntranceTableViewCell.m
//  miaozhuan
//
//  Created by apple on 14/12/4.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ExchangeMangerEntranceTableViewCell.h"
#import "UIView+expanded.h"
@implementation ExchangeMangerEntranceTableViewCell

- (void)awakeFromNib
{
    [self.cellImages roundCornerRadiusBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)dealloc {
    [_cellImages release];
    [_cellTitle release];
    [_cellContent release];
    [super dealloc];
}
@end
