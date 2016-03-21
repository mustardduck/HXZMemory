//
//  otherButton.m
//  miaozhuan
//
//  Created by abyss on 14/10/30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "otherButton.h"

@interface otherButton()
{
    UIColor *enableColor;
}
@end
@implementation otherButton
@synthesize h_color = _h_color;
@synthesize n_color = _n_color;
@synthesize b_color = _b_color;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)init
{
    self = [super init];
    if (self)
    {
        _n_color = AppColorWhite;
        _h_color = AppColorWhite;
        enableColor = AppColorWhite;
        [self setRoundCorner];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _n_color = AppColorWhite;
        _h_color = AppColorWhite;
        enableColor = AppColorWhite;
        [self setRoundCorner];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _n_color = self.backgroundColor;
        _h_color = self.backgroundColor;
        enableColor = AppColorWhite;
        [self setRoundCorner];
    }
    return self;
}

- (UIColor *)h_color
{
    return _h_color;
}

- (void)setH_color:(UIColor *)h_color
{
    _h_color = h_color;
    [_h_color retain];
}

- (UIColor *)n_color
{
    return _n_color;
}

- (void)setN_color:(UIColor *)n_color
{
    _n_color = n_color;
    [_n_color retain];
}

- (UIColor *)b_color
{
    return _b_color;
}

- (void)setB_color:(UIColor *)b_color
{
    _b_color = b_color;
    [_b_color retain];
    self.layer.borderColor = _b_color.CGColor;
    self.layer.borderWidth = .5f;
    self.layer.masksToBounds = YES;
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted)
    {
        self.backgroundColor = self.h_color;
    }
    else
    {
        self.backgroundColor = enableColor;
    }
}

- (id)initWithColor:(UIColor *)color andHightedColor:(UIColor *)h_color frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
        if (self)
        {
            _n_color = color;
            _h_color = h_color;
            [self setRoundCorner];
        }
        return self;
}

- (void)setDisTouch:(BOOL)disTouch
{
    if (disTouch)
    {
        [self setEnabled:NO];
        enableColor = RGBCOLOR(239, 239, 244);
        [self setHighlighted:NO];
    }
    else
    {
        [self setEnabled:YES];
        enableColor = AppColorWhite;
        [self setHighlighted:NO];
    }
    [enableColor retain];
}


- (void)dealloc
{
    [enableColor release];
    enableColor = nil;
    [_h_color release];
    [_n_color release];
    [_b_color release];
    
    [super dealloc];
}
@end
