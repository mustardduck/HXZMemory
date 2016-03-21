//
//  BankCardCell.m
//  miaozhuan
//
//  Created by Santiago on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BankCardCell.h"

@implementation BankCardCell

- (void)awakeFromNib {
    // Initialization code
    self.icon.layer.borderWidth = 0.5;
    self.icon.layer.borderColor = [RGBCOLOR(197, 197, 197) CGColor];
    self.icon.layer.cornerRadius = 11;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_icon release];
    [_bankName release];
    [_tailNumber release];
    [_typeName release];
    [_checkImageView release];
    [_UIBottomLineView release];
    [super dealloc];
}
@end
