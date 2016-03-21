//
//  SalesReturnCell4.m
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SalesReturnCell4.h"

@implementation SalesReturnCell4

+ (instancetype)newInstance{
    SalesReturnCell4 *cell = [[[NSBundle mainBundle] loadNibNamed:@"SalesReturnCell4" owner:self options:nil] firstObject];
    if (cell) {
        
        [cell.UILineView setSize:CGSizeMake(252, 0.5)];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_userLabel release];
    [_timeLabel release];
    [_cellTitle release];
    [_logicticCompanyTitle release];
    [_logisticsName release];
    [_logisticsNumberTitle release];
    [_logisticsNumberDetail release];
    [_backGroundView release];
    [_UILineView release];
    [super dealloc];
}
@end