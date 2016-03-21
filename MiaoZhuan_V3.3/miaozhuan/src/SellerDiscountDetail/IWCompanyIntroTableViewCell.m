//
//  IWCompanyIntroTableViewCell.m
//  miaozhuan
//
//  Created by luo on 15/5/15.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWCompanyIntroTableViewCell.h"

@implementation IWCompanyIntroTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_lableTelePhone release];
    [super dealloc];
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (self.cellButtonClick) {
        self.cellButtonClick();
    }
}
@end
