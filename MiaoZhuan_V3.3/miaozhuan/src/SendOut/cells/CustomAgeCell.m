//
//  CustomAgeCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CustomAgeCell.h"

@implementation CustomAgeCell

+ (instancetype)newInstance{
    CustomAgeCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomAgeCell" owner:self options:nil] firstObject];
    if (self) {
        
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_txtMinAge release];
    [_txtMaxAge release];
    [super dealloc];
}
@end
