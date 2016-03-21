//
//  FindShopCell.m
//  miaozhuan
//
//  Created by momo on 14-10-22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "FindShopCell.h"

@implementation FindShopCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_titleLbl release];
    [_distanceLbl release];
    [_vipIcon release];
    [_yinyuanIcon release];
    [_jinbiIcon release];
    [_zhigouIcon release];
    [_imgView release];
    [super dealloc];
}
@end
