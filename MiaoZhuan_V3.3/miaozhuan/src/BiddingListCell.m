//
//  BiddingListCell.m
//  miaozhuan
//
//  Created by Santiago on 14-11-7.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BiddingListCell.h"

@implementation BiddingListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_rankingNumber release];
    [_companyName release];
    [_location release];
    [_biddingPrice release];
    [_UILineBottomView release];
    [super dealloc];
}
@end
