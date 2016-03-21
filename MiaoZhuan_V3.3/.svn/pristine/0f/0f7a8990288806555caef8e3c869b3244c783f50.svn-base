//
//  CRBarView.m
//  test
//
//  Created by abyss on 14/11/21.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import "CRBar.h"
#import "Define+RCMethod.h"

@interface CRBar ()
{
    //animation
    BOOL _animating;
    double _animationPercent;
}
@property (nonatomic, retain) CALayer *barLayer;
@property (nonatomic, retain) CALayer *parentLayer;
@end

@implementation INSTANCE_CLASS_SETUP(CRBar)

- (void)setup
{
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    self.clipsToBounds = NO;
    self.layer.masksToBounds = NO;
    _animationPercent = 0.0;
//    cr_parentBarImage = [UIImage imageNamed:CRBAR_PARENTBAR_IMAGE_NAME];
    
    CGFloat cr_height = CGRectGetHeight(self.bounds);
    
    _percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(- CRBAR_LABEL_WIDTH, 0, CRBAR_LABEL_WIDTH, cr_height)];
    if (cr_height < 25)
        _percentLabel.frame = CGRectMake(- CRBAR_LABEL_WIDTH, (cr_height - 25)/2, CRBAR_LABEL_WIDTH, 25);
    
    _percentLabel.font = [UIFont systemFontOfSize:12];
    _percentLabel.textAlignment = NSTextAlignmentRight;
    
    _parentLayer = [CALayer layer];
    _parentLayer.contentsScale = [UIScreen mainScreen].scale;
    _parentLayer.backgroundColor = [UIColor clearColor].CGColor;
    _parentLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds),cr_height);
    _parentLayer.contents = (id)cr_parentBarImage.CGImage;
    
    _barLayer = [CALayer layer];
    _barLayer.contentsScale = [UIScreen mainScreen].scale;
#pragma mark - barColor
    _barLayer.backgroundColor = [UIColor redColor].CGColor;
    _barLayer.frame = CGRectMake(0, 0, 0, cr_height);

    self.smoothCorner = NO;
    
    
    [_parentLayer addSublayer:_barLayer];
    [self addSubview:_percentLabel];
    [self.layer addSublayer:_parentLayer];
}

- (void)layoutSubviews
{
//    _percentLabel.text = [NSString stringWithFormat:@"%@", [CRHttpAddedManager show_numbersLimitNum:_animationPercent*100 toPoint:2]];
    _percentLabel.textColor = AppColor(34);
    if(_animationPercent == 1.f) _percentLabel.text = [NSString stringWithFormat:@"%@",    [CRHttpAddedManager show_numbersLimitNum:_animationPercent*100 toPoint:2]];
    _barLayer.frame = CGRectMake(0, 0, _animationPercent * CGRectGetWidth(_parentLayer.bounds), CGRectGetHeight(self.bounds));

    [super layoutSubviews];
}

#pragma mark - animation
- (void)animationFPS:(NSNumber *)percent
{
    _animating = YES;
    double perc = [percent doubleValue];
    if (perc < _percentNum) perc++;
    _animationPercent = perc / 100.0;
    
    [self setNeedsLayout];
    [_barLayer setNeedsDisplay];
    
    if (perc != _percentNum)
    {
        [self performSelector:@selector(animationFPS:) withObject:@(perc) afterDelay:.012];
    }
    else
    {
        _animating = NO;
    }
}

#pragma mark - setter
- (void)setPercentNum:(double)percentNum
{
    _percentLabel.text = [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:percentNum withAppendStr:nil];//[NSString stringWithFormat:@"%.2f", percentNum];
    
    _percentNum = percentNum;
    double oldPercent = _animationPercent * 100.0;
    [self performSelector:@selector(animationFPS:) withObject:@(oldPercent) afterDelay:0.6];
}

- (void)setSmoothCorner:(BOOL)smoothCorner
{
    _smoothCorner = smoothCorner;
    if (_smoothCorner)
    {
        _parentLayer.cornerRadius = CGRectGetHeight(_parentLayer.bounds)/2;
    }
    else
    {
        _parentLayer.cornerRadius = CRBAR_CORNERRADIUS;
    }
    _barLayer.cornerRadius = _parentLayer.cornerRadius;
}

- (void)setShowLabel:(BOOL)showLabel
{
    _showLabel = showLabel;
    if (!_showLabel)
    {
        _percentLabel.hidden = YES;
        
        _parentLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds),CGRectGetHeight(self.bounds));
        _barLayer.frame = CGRectMake(0, 0, 0, CGRectGetHeight(self.bounds));
        self.percentNum = _percentNum;
    }
    else
    {
    }
}
@end
