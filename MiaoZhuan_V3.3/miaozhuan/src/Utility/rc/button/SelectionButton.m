//
//  SelectionButton.m
//  miaozhuan
//
//  Created by abyss on 14/10/31.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SelectionButton.h"

@implementation SelectionButton
@synthesize icon = _icon;
@synthesize border = _border;

- (void)dealloc
{
    [_icon release];
    [_border release];
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = AppColorWhite;
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = AppColorLightGray204.CGColor;
        self.layer.masksToBounds = NO;
        [self setRoundCorner];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = AppColorWhite;
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = AppColorLightGray204.CGColor;
        self.layer.masksToBounds = NO;
        [self setRoundCorner];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.backgroundColor = AppColorWhite;
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = AppColorLightGray204.CGColor;
        self.layer.masksToBounds = YES;
        [self setRoundCorner];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    if (selected)
    {
        self.layer.borderWidth = 0.f;
        if (!_icon)
        {
            self.clipsToBounds = NO;
            _icon = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 9, -8, 16, 16)];
            _icon.image = [UIImage imageNamed:@"010.png"];
            [self insertSubview:_icon atIndex:1];
        }
        else
        {
            _icon.hidden = NO;
        }
        if (!_border)
        {
            _border = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
            if (self.width > 125)
            {
                _border.image = [UIImage imageNamed:@"roger_add_001.png"];
            }
            else
            {
                _border.image = [UIImage imageNamed:@"017.png"];
            }
           [self insertSubview:_border atIndex:0];
        }
        else
        {
            _border.hidden = NO;
        }
    }
    else
    {
        if (_icon)
        {
            _icon.hidden = YES;
            _border.hidden = YES;
        }
        self.layer.borderWidth = 0.5f;
    }
}

- (void)setIcon:(UIImageView *)icon
{
    _icon = icon;
    [_icon retain];
    _icon.hidden = YES;
}

- (void)setBorder:(UIImageView *)border
{
    _border = border;
    [_border retain];
    _icon.hidden = YES;
}

//- (void)setHighlighted:(BOOL)highlighted
//{
//    
//}

@end
