//
//  ConsultTationDetailTableViewCell.m
//  miaozhuan
//
//  Created by apple on 14/11/11.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ConsultTationDetailTableViewCell.h"

@implementation ConsultTationDetailTableViewCell

@synthesize type = _type;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setType:(BOOL)type
{
    _type = type;
    [self layoutTheViewBubbleWithImage:nil type:type];
}

- (void)dealloc
{
    [super dealloc];
}
@end
