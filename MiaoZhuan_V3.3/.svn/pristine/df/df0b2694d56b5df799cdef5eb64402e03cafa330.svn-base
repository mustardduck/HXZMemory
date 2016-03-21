//
//  AgreeReturnCell.m
//  miaozhuan
//
//  Created by Santiago on 15-1-14.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "AgreeReturnCell.h"

@implementation AgreeReturnCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)newInstance{
    AgreeReturnCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"AgreeReturnCell" owner:self options:nil] firstObject];
    if (cell) {
     
        [cell.UILineView setSize:CGSizeMake(252, 0.5)];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_userLabel release];
    [_timeLabel release];
    [_cellTitle release];
    [_backGroundView release];
    [_UILineView release];
    [super dealloc];
}
@end
