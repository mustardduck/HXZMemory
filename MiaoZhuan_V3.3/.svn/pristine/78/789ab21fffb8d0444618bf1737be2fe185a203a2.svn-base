//
//  CheckAddressTableViewCell.m
//  miaozhuan
//
//  Created by apple on 14/12/31.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CheckAddressTableViewCell.h"

@implementation CheckAddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCheckFlag:(BOOL)checkFlag
{
    _checkFlag = checkFlag;
    if (_checkFlag)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            _cellCheckImage.image = [UIImage imageNamed:@"ads_list_right.png"];
        });
    }
    else
    {
        _cellCheckImage.image = [UIImage imageNamed:@""];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_cellImage release];
    [_cellTitle release];
    [_cellAddress release];
    [_cellCheckImage release];
    [_cellPhone release];
    [super dealloc];
}
@end
