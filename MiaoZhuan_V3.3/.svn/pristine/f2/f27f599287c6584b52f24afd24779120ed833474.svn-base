//
//  RedPoint.m
//  miaozhuan
//
//  Created by abyss on 14/11/15.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RedPoint.h"
#import "Define+RCMethod.h"
#import "UICommon.h"

@interface RedPoint ()
{
    UIButton *_bt;
}
@end
@implementation INSTANCE_CLASS_SETUP(RedPoint)
@synthesize num = _num;
@synthesize color = _color;

- (void)setup
{
    _bt = WEAK_OBJECT(UIButton, initWithFrame:self.bounds);
    self.color = RGBCOLOR(255, 132, 0);
    _bt.titleLabel.textColor = AppColorWhite;
    _bt.titleLabel.font = Font(12);
    _num = INTMAX_MIN;
    
    _bt.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self addSubview:_bt];
    [self setRoundCornerAll];
}

- (void)dealloc
{
//    [_bt release];
    [_color release];
    
    [super dealloc];
}

- (int64_t)num
{
    return _num;
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    [_color retain];
    _bt.backgroundColor = _color;
}

- (void)setNum:(int64_t)num
{
    __block int64_t t = num;
    __block int64_t ori_t = _num;
    __block UIButton *weakButton = _bt;
    BLOCK_GET_SEALF(RedPoint);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (ori_t != t )
        {
            if (t < 0)
            {
                [weakButton setTitle:@"" forState:UIControlStateNormal];
            }
            else if (0 == t)
            {
                blockself.hidden = YES;
            }
            else if (t > 99)
            {
                blockself.hidden = NO;
                _bt.titleEdgeInsets = UIEdgeInsetsMake(-7, 0, 0, 0);
                [weakButton setTitle:@"..." forState:UIControlStateNormal];
            }
            else
            {
                blockself.hidden = NO;
                [weakButton setTitle:[NSString stringWithFormat:@"%lld",t] forState:UIControlStateNormal];
            }
        }
        _num = t;
    });
}

- (void)layoutSubviews
{
    if (_otherImg)
    {
        [_bt setBackgroundImage:_otherImg forState:UIControlStateNormal];
    }
}
@end

