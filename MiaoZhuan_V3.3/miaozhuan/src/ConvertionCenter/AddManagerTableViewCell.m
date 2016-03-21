//
//  AddManagerTableViewCell.m
//  miaozhuan
//
//  Created by Santiago on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AddManagerTableViewCell.h"
#import "AppUtils.h"
@implementation AddManagerTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.contentView addSubview:[AppUtils LineView:10.f]];
    [self.contentView addSubview:[AppUtils LineView:60.f]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)dealloc {
    [_deleteBtn release];
    [_checkFromList release];
    [_managerNumberField release];
    [_managerLabel release];
    [super dealloc];
}
@end
