//
//  CRArrowLayer.m
//  CRCoreUnit
//
//  Created by abyss on 14/12/17.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import "CRArrow.h"

@interface CRArrow ()
{
    CALayer *_layer;
    
    CGFloat _nowPosition;
}
@end
@implementation CRArrow
- (instancetype)initWithArrow:(NSString *)imgName delegate:(id<CRArrowDelegate>)delegate
{
    self = [super init];
    if (self) {
#warning fix later
    }
    return self;
}

- (instancetype)initWithType:(CRArrowLayerType)type delegate:(id<CRArrowDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _nowPosition  = 0;
        _needTurnDown = YES;
        _cr_delegate  = delegate;
        
        _layer = [CALayer layer];
        _layer.contents = (id)[UIImage imageNamed:@"ads_up"].CGImage;
        
        [self setType:type];
        [self.layer addSublayer:_layer];
    }
    return self;
}

- (void)layoutSubviews
{
    
    if (CGRectIsEmpty(_layer.bounds))
    {
        if (!CGRectIsEmpty(_realRect))
        {
            _layer.frame = CGRectMake((self.width - 12)/2.f, (self.height - 8)/2.f, _realRect.size.width, _realRect.size.height);
        }
        else
        {
            _layer.frame = CGRectMake((self.width - 12)/2.f, (self.height - 8)/2.f, 12, 8);
        }
    }
}

#pragma mark - setter

- (void)setType:(CRArrowLayerType)type
{
    _type = type;
    
    switch (_type)
    {
        case CRArrowLayerTypeBottom:
            [self setDown];
            break;
        case CRArrowLayerTypeTop:
            [self setUp];
            break;
            
            
        default:
            break;
    }
}

#pragma mark - TouchEvent

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_needTurnDown)
    {
        _arrowOpen = !_arrowOpen;
        
        if (_arrowOpen)
            [self setUp];
        else
            [self setDown];
        
        if (_cr_delegate && [_cr_delegate respondsToSelector:@selector(arrow:click:)])
        {
            [_cr_delegate arrow:self click:_arrowOpen];
        }
    }
}


- (void)turnAsClockwise
{
    [self turn:YES];
}

- (void)turnAsClockwiseUpsidedown
{
    for (int i = 0; i < 2; i ++)
    {
        [self performSelector:@selector(turnAsClockwise) withObject:nil afterDelay:0.001];
    }
}

- (void)turnAsEastern
{
    [self turn:NO];
}

- (void)turnAsEasternUpsidedown
{
    for (int i = 0; i < 2; i ++)
    {
        [self performSelector:@selector(turnAsEastern) withObject:nil afterDelay:0.001];
    }
}

- (void)turn:(BOOL)Clockwise
{
    CGFloat position;
    
    {
        if (Clockwise) position = 0.5;
        else position = - 0.5;
    
        _nowPosition += position;
    }
    
    _layer.transform = CATransform3DMakeRotation(M_PI*_nowPosition, 0, 0, 1);
}


- (void)setUp
{
    _layer.transform = CATransform3DMakeRotation(M_PI*0, 0, 0, 1);
}

- (void)setDown
{
    _layer.transform = CATransform3DMakeRotation(M_PI*1, 0, 0, 1);
}
@end
