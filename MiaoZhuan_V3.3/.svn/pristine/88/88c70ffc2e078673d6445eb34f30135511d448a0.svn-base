//
//  CRPoint.m
//  miaozhuan
//
//  Created by abyss on 14/12/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CRPoint.h"
#import "Define+RCMethod.h"

CGFloat cr_REDPOINT_SIZE = 10.f;
CGFloat cr_REDPOINT_FONT = 12.f;
@interface CRPoint ()
{
    UILabel *_label;
}
@end
@implementation INSTANCE_CLASS_SETUP(CRPoint)
- (void)dealloc
{
    [_color release];
    [super dealloc];
}

- (instancetype)initWithNum:(NSInteger)num In:(UIColor *)color at:(CGPoint)point
{
    if ((self = [super initWithFrame:CGRectMake(point.x - cr_REDPOINT_SIZE/2, point.y - cr_REDPOINT_SIZE/2, cr_REDPOINT_SIZE, cr_REDPOINT_SIZE)]))
    {
        _num = num;
        _color = color;
        [_color retain];
        [self setup];
    }
    return self;
}

- (void)setup
{
    _allowDrag = YES;
    
    CGFloat size = MIN(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds));
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = size/2;
    self.layer.backgroundColor = (_color?_color:RGBCOLOR(243, 116, 23)).CGColor;
    self.backgroundColor = (_color?_color:RGBCOLOR(243, 116, 23));
    
    _label = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(0, -.5, size, size));
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = Font(cr_REDPOINT_FONT);
    [self addSubview:_label];
}

- (void)layoutSubviews
{
    NSString *outPut = nil;
    if (0 == _num)
    {
        [self display:NO];
    }
    else if (_num > 0)
    {
        [self display:YES];
        outPut = [NSString stringWithFormat:@"%d",(int)_num];
    }
    else
    {
        [self display:YES];
        outPut = @"";
    }
    _label.text = outPut;
}

- (void)setNum:(NSInteger)num
{
    _num = num;
    [self layoutSubviews];
}

#pragma mark - animation

- (void)display:(BOOL)show
{
    [UIView animateWithDuration:0.3f animations:^{
        self.hidden = !show;
    }];
}

#pragma mark - drag

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end

