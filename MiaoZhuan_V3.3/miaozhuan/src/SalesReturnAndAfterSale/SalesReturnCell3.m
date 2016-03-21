//
//  SalesReturnCell3.m
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SalesReturnCell3.h"

@implementation SalesReturnCell3

+ (instancetype)newInstance{
    SalesReturnCell3 *cell = [[[NSBundle mainBundle] loadNibNamed:@"SalesReturnCell3" owner:self options:nil] firstObject];
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
    [_tiemLabel release];
    [_cellTitle release];
    [_waitingForReturn release];
    [_waitingForReturnDetail release];
    [_ifYouRejectTitle release];
    [_ifYouRejectDetail release];
    [_backGroundView release];
    [_UILineView release];
    [super dealloc];
}
@end
