//
//  OrderByTimeCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-3.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "OrderByTimeCell.h"

@implementation OrderByTimeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setData:(id)data{
    [self.btnOrderType setTitle:[NSString stringWithFormat:@"   %@",data] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_data release];
    [_btnOrderType release];
    [super dealloc];
}
@end
