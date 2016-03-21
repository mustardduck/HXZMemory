//
//  IWBrowseADMainFilterTableViewCell.m
//  miaozhuan
//
//  Created by luo on 15/5/11.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWBrowseADMainFilterTableViewCell.h"

@implementation IWBrowseADMainFilterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_layoutConstraintLineTail release];
    [super dealloc];
}
@end
