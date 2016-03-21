//
//  CRCommonCell.m
//  miaozhuan
//
//  Created by abyss on 15/1/17.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "CRCommonCell.h"

@interface CRCommonCell ()
{
    BOOL _unPrepare;
}
@end
@implementation CRCommonCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
//    if (!_needHighlight) return;
    
    if (!_unPrepare)
    {
        _unPrepare = YES;
        [super setHighlighted:highlighted];
    }
    
    if (highlighted)
    {
        self.contentView.backgroundColor = AppColor(220);
        _unPrepare = NO;
    }
    else
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _unPrepare = NO;
    }
}

@end
