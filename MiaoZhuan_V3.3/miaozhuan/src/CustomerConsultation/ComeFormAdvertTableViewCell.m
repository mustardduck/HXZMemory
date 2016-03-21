//
//  ComeFormAdvertTableViewCell.m
//  miaozhuan
//
//  Created by apple on 14/11/6.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ComeFormAdvertTableViewCell.h"

@implementation ComeFormAdvertTableViewCell

- (void)awakeFromNib
{
    [_redVIew setRoundCornerAll];
}

- (void)setImageFlag:(BOOL)imageFlag
{
    _imageFlag = imageFlag;
    if (_imageFlag)
    {
        __block ComeFormAdvertTableViewCell *weak = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            weak.contentView.left = 35;
            _redVIew.hidden = YES;
        });
    }
    else
    {
        self.contentView.left = 0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [_cellTitles release];
    [_cellImages release];
    [_cellContent release];
    [_cellTimes release];
    [_cellLines release];
    [_redVIew release];
    [super dealloc];
}
@end
