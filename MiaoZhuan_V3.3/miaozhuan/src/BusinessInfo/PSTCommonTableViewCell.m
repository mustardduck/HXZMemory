//
//  PSTCommonTableViewCell.m
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PSTCommonTableViewCell.h"

UIEdgeInsets ContentInsets = { .top = 0, .left = 0, .right = 0, .bottom = 0 };
CGFloat SubTitleLabelHeight = 30;
@interface PSTCommonTableViewCell ()
{
    NetImageView *_img;
    UILabel *_label;
}
@end

@implementation PSTCommonTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _img = WEAK_OBJECT(NetImageView, initWithFrame:CGRectMake(0, 0, self.width, self.width));
        [_img setBorderWithColor:AppColor(204)];
        _label = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(0, _img.height, self.width, SubTitleLabelHeight));
        [self.contentView addSubview:_img];
        [self.contentView addSubview:_label];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = Font(12);
        _label.textColor = AppColorBlack43;
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return self;
}

@end
