//
//  YinYuanProdCell.m
//  miaozhuan
//
//  Created by momo on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanProdCell.h"

@implementation YinYuanProdCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_imgView release];
    [_titleLbl release];
    [_desLbl release];
    [_yinyuanLbl release];
    [super dealloc];
}
@end
