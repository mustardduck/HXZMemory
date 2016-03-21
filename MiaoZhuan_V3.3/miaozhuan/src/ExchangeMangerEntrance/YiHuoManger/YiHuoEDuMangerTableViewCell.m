//
//  YiHuoEDuMangerTableViewCell.m
//  miaozhuan
//
//  Created by apple on 15/6/3.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "YiHuoEDuMangerTableViewCell.h"

@implementation YiHuoEDuMangerTableViewCell

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void)dealloc
{
    [_titleCell release];
    [_lineCell release];
    [_lineCellLeft release];
    [super dealloc];
}
@end
