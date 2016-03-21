//
//  GetRedPacketsCell.m
//  miaozhuan
//
//  Created by Santiago on 14-10-23.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "GetRedPacketsCell.h"

@implementation GetRedPacketsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_redPacketPic release];
    [_adName release];
    [_companyName release];
    [_amountOfReward release];
    [_expireDays release];
    [_redPacketMarkImage release];
    [_UILineView release];
    [super dealloc];
}
@end
