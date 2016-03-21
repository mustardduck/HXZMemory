//
//  CRLabel.m
//  test
//
//  Created by abyss on 14/11/25.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import "CRLabel.h"
#import "Define+RCMethod.h"
#import "CRBezierCurve.h"

@interface CRLabel ()
{
    CGFloat _currentNumber;
    CGFloat _limitUnitNum;
    CGFloat _duration;
    CGFloat lastTime;
    
    BOOL _animating;
    NSInteger indexNumber;
    NSMutableArray *numberPoints; //记录每次textLayer更改值的间隔时间及输出值。
    
    //Bezer
    Point2D startPoint;
    Point2D controlPoint1;
    Point2D controlPoint2;
    Point2D endPoint;
}
@end
@implementation INSTANCE_CLASS_SETUP(CRLabel)

- (void)dealloc
{
    [super dealloc];
}

- (void)setup
{
    _currentNumber = 0;
    _limitUnitNum  = 999999;
    self.isAnimatingNumbers = YES;
    self.hasUnit = YES;
    self.randAnmation = YES;
    
    if(self.text != nil && [self isPureInt:self.text]) self.numbers = @(self.text.integerValue).floatValue;
}

- (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark - subViews

- (void)layoutSubviews
{
    
    CGSize size = CGSizeZero;
    
    if([UICommon getSystemVersion] >= 7.0)
        size = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    else
        size = [self.text sizeWithFont:self.font];
    
    if (size.width > CGRectGetWidth(self.bounds))
    {
        self.frame = CGRectMake(0, 0, size.width, size.height);
        if (_delegate && [_delegate respondsToSelector:@selector(label:didChangeTheFrame:)])
        {
            [_delegate label:self didChangeTheFrame:self.frame];
        }
        else
        {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
        }
    }
    
    [super layoutSubviews];
}

#pragma mark - animation

- (void)jumpNumberWithDuration:(CGFloat)duration from:(CGFloat)start to:(CGFloat)end
{
    _animating = YES;
    _duration = duration;
    _currentNumber = start;
    _numbers = end;
    
    lastTime = 0;
    indexNumber = 0;
    [self initPoints];
    [self changeNumberBySelector];
}

- (void)initPoints
{
    [self initBezierPoints_sqs];
    Point2D bezierCurvePoints[4] = {startPoint, controlPoint1, controlPoint2, endPoint};
    numberPoints = [[NSMutableArray alloc] init];
    float dt;
    dt = 1.0 / (cr_CRLABEL_ANIMATION_JUMTIMES - 1);
    for (int i = 0; i < cr_CRLABEL_ANIMATION_JUMTIMES; i++) {
        Point2D point = PointOnCubicBezier(bezierCurvePoints, i*dt);
        float durationTime = point.x * _duration;
        float value = point.y * (_numbers - _currentNumber) + _currentNumber;
        [numberPoints addObject:[NSArray arrayWithObjects:[NSNumber numberWithFloat:durationTime], [NSNumber numberWithFloat:value], nil]];
    }
}

#pragma mark - 贝塞尔曲线

- (void)initBezierPoints_sqs
{
    startPoint.x = 0;
    startPoint.y = 0;
    
    controlPoint1.x = 0.95;
    controlPoint1.y = 0.5;
    
    controlPoint2.x = 0.5;
    controlPoint2.y = 0.95;
    
    endPoint.x = 1;
    endPoint.y = 1;
}

#pragma mark - setter

- (void)setNumbers:(CGFloat)numbers
{
    _numbers = numbers;
    if (_isAnimatingNumbers)
    {
        CGFloat rand = 0.f;
        if (self.randAnmation) rand = [self animateDifferent];
        CGFloat time = MIN(2, MAX(0.3, cr_CRLABEL_ANIMATION_JUMDURATION + rand));
        [self jumpNumberWithDuration:time from:_currentNumber to:_numbers];
    }
    else [self printfResult:_numbers];
}

- (CGFloat)animateDifferent
{
    CGFloat rand = (int64_t)(arc4random()%10000)/9000.f;
    int64_t mark = (int64_t)(arc4random()%2);
    rand = mark?rand:-rand;
    if (_numbers < 200)
    {
        rand --;
    }
    else if(_numbers > 10000)
    {
        rand ++;
    }
    
    return  rand;
}

#pragma mark - numberChange

- (void)changeNumberBySelector
{
    if (indexNumber >= cr_CRLABEL_ANIMATION_JUMTIMES)
    {
        _animating = NO;
        
        if (_delegate && [_delegate respondsToSelector:@selector(label:didFinishedAnimationg:)])
        {
            [_delegate label:self didFinishedAnimationg:_numbers];
        }
        
        [self printfResult:_numbers];

        return;
    }
    else
    {
        NSArray *pointValues = [numberPoints objectAtIndex:indexNumber];
        indexNumber++;
        float value = [(NSNumber *)[pointValues objectAtIndex:1] intValue];
        float currentTime = [(NSNumber *)[pointValues objectAtIndex:0] floatValue];
        float timeDuration = currentTime - lastTime;
        lastTime = currentTime;
            
        [self printfResult:value];
        
        [self setNeedsLayout];
        [self setNeedsDisplay];
        
        [self performSelector:@selector(changeNumberBySelector) withObject:nil afterDelay:timeDuration];
    }
}

#pragma mark - printf

- (void)printfResult:(CGFloat)value
{
    NSString *format = nil;
    CGFloat result = 0;
    
    if (_delegate && [_delegate respondsToSelector:@selector(label:shouldPrintfResultSelf:)])
    {
        [_delegate label:self shouldPrintfResultSelf:value];
    }
    else
    {
        if (self.hasUnit && value > _limitUnitNum)
        {
            result = value / 10000;
        }
        else result = value;
        
        if (_delegate && [_delegate respondsToSelector:@selector(label:shouldPrintfResult:)])
        {
            format = [_delegate label:self shouldPrintfResult:result];
        }
        
        
        if (self.hasUnit && value > _limitUnitNum)
        {
            self.text = [NSString stringWithFormat:format?format:cr_CRLABEL_UI_FORMAT_UNIT,result];
        }
        else
        {
            self.text = [NSString stringWithFormat:format?format:cr_CRLABEL_UI_FORMAT_NORMAL,result];
        }
    }
}
@end
