//
//  YinYuanBindingProdCell.m
//  miaozhuan
//
//  Created by momo on 14-11-20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanBindingProdCell.h"

@implementation YinYuanBindingProdCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_imgview release];
    [_titleLbl release];
    [_yinyuanLbl release];
    [_countField release];
    [_jianBtn release];
    [_jiaBtn release];
    [super dealloc];
}
@end