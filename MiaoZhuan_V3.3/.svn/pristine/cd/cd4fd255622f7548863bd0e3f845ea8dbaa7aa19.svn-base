//
//  SalesReturnCell2.m
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SalesReturnCell2.h"
@implementation SalesReturnCell2

+ (instancetype)newInstance {

    SalesReturnCell2 *cell = [[[NSBundle mainBundle] loadNibNamed:@"SalesReturnCell2" owner:self options:nil] firstObject];
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
    [_ifYouAgreeTitle release];
    [_ifYouAgreeDetail release];
    [_ifYouRejectTitle release];
    [_ifYouRejectDetail release];
    [_ifYouNotHandleTitle release];
    [_ifYouNotHandleDetail release];
    [_backGroundView release];
    [_UILineView release];
    [super dealloc];
}
@end
