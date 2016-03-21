//
//  Redbutton.m
//  miaozhuan
//
//  Created by abyss on 14/10/30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "Redbutton.h"

//文字不变，背景改变
@implementation Redbutton

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = AppColorRed;
        self.tintColor = AppColorWhite;
        [self setRoundCorner];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = AppColorRed;
        self.tintColor = AppColorWhite;
        [self setRoundCorner];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.backgroundColor = AppColorRed;
        self.tintColor = AppColorWhite;
        [self setRoundCorner];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted)
    {
        self.backgroundColor = RGBACOLOR(192, 4, 0, 1);
    }
    else
    {
        self.backgroundColor = AppColorRed;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
