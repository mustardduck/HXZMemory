//
//  GoldChoiceAddressTableViewCell.m
//  miaozhuan
//
//  Created by apple on 14/12/16.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "GoldChoiceAddressTableViewCell.h"

@implementation GoldChoiceAddressTableViewCell

- (void)awakeFromNib
{
    
}



- (void)setCheckFlag:(BOOL)checkFlag
{
    _checkFlag = checkFlag;
    if (_checkFlag)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            _cellChoiceImage.image = [UIImage imageNamed:@"ads_list_right.png"];
            
            _cellTitle.textColor = RGBCOLOR(240, 5, 0);
        });
    }
    else
    {
        _cellChoiceImage.image = [UIImage imageNamed:@""];
        
        _cellTitle.textColor = RGBCOLOR(34, 34, 34);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_cellTitle release];
    [_cellChoiceImage release];
    [_cellLine release];
    [super dealloc];
}
@end
