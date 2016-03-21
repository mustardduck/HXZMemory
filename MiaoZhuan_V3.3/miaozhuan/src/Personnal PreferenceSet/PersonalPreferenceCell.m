//
//  PersonalPreferenceCell.m
//  miaozhuan
//
//  Created by Santiago on 14-10-27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PersonalPreferenceCell.h"
@implementation PersonalPreferenceCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_preferenceKind release];
    [_ifCompleted release];
    [_enterImage release];
    [_seperatorLine release];
    [super dealloc];
}
@end
