//
//  CRSegHeader.m
//  miaozhuan
//
//  Created by abyss on 14/11/29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CRSegHeader.h"
#import "Define+RCMethod.h"
#import "CRPoint.h"

@interface CRSegHeader ()
{
    CGFloat _currentLine;
    CGFloat _width;
    UIImageView *_exline;
    
    BOOL _needAutoAwak;
}
@property (retain, nonatomic) CALayer *line;
@end
@implementation INSTANCE_CLASS_SETUP(CRSegHeader)

- (void)dealloc
{
    [_buttonArray release];
    _buttonArray = nil;
    CRDEBUG_DEALLOC();
    [super dealloc];
}

- (void)layoutSubviews
{
    _exline.top = self.bottom - 0.5;
}

- (instancetype)initWithDelegate:(id<cr_SegHeaderDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
    }
    return self;
}

- (void)setup
{
    _needAutoAwak = YES;
    
    _line = [CALayer layer];
    self.lineSize = 2.0;
    _line.backgroundColor = AppColorRed.CGColor;
    [self.layer addSublayer:_line];
    
    _exline = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, self.height - 0.5, 320, 0.5));
    _exline.backgroundColor = AppColor(204);
    [self addSubview:_exline];
}

- (void)setButtonArray:(NSArray *)buttonArray
{
    if (_buttonArray.count > 0)
    {
        [_buttonArray release];
        for (UIView *view in self.subviews)
        {
            if ([view isKindOfClass:[UIButton class]]) [view removeFromSuperview];
        }
    }
    
    _buttonArray = buttonArray;
    [_buttonArray retain];
    if (_buttonArray)
    {
        for (int i = 0; i < _buttonArray.count; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:_buttonArray[i] attributes:@{NSFontAttributeName:Font(14),NSForegroundColorAttributeName:AppColorBlack43}];
            [button setAttributedTitle:string forState:UIControlStateNormal];
            [string release];
            
            NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:_buttonArray[i] attributes:@{NSFontAttributeName:Font(17),NSForegroundColorAttributeName:AppColorRed}];
            [button setAttributedTitle:string1 forState:UIControlStateSelected];
            [string1 release];
            
            button.tag = i;
            [self addSubview:button];
            
            [button addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
        }
        __block UIButton *holder = nil;
        for (UIView *view in self.subviews)
        {
            if ([view isKindOfClass:[UIButton class]])
            {
                if (view.tag == _autoawakIndex && _autoawakIndex >= 0) holder = (UIButton *)view;
                _width = (self.width/_buttonArray.count);
                view.frame = CGRectMake(_width*view.tag, 0, _width, self.height);
                
                if (_hasPoint)
                {
                    CGSize size = [((UIButton *)view).titleLabel.text sizeWithFont:Font(15)];
                    CGFloat nowW = view.width/2 + size.width/2 + 5;
                    CRPoint *point = WEAK_OBJECT(CRPoint, initWithNum:0 In:AppColorRed at:CGPointMake(nowW, self.height/2));
                    point.hidden = YES;
                    [view addSubview:point];
                }
            }
        }
//        if (_needAutoAwak)
            [self buttonTouch:holder];
//        else [self layoutButton:holder];
        [self bringSubviewToFront:_exline];
//        _needAutoAwak = NO;
    }
}

- (void)layoutButton:(UIButton *)sender
{
    
    CGSize size = CGSizeZero;
    
    if([UICommon getSystemVersion] >= 7.0)
        size = [sender.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:Font(17)}];
    else
        size = [sender.titleLabel.text sizeWithFont:Font(17)];
    
    _line.frame = CGRectMake(sender.left +  (sender.width - size.width)/2 - cr_SegHeader_Line_AddWidth/2, self.height-_line.frame.size.height - 0.5, size.width + cr_SegHeader_Line_AddWidth, _line.frame.size.height);
    
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            ((UIButton *)view).selected = NO;
        }
    }
    sender.selected = YES;
    if (_hasPoint) [self bringPointForIndex:sender.tag show:NO];
}

- (void)buttonTouch:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(button:didBetouch:)])
    {
        [_delegate button:sender didBetouch:sender.tag];
    }
    [self layoutButton:sender];
    [self setNeedsDisplay];
}

- (void)bringPointForIndex:(NSInteger)index show:(BOOL)show
{
    if (!_hasPoint) assert(false && "hasPoint = No");
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            if ( ((UIButton *)view).tag == index)
            {
                    ((CRPoint *)view.subviews[1]).num = show?-1:0;
                    [((CRPoint *)view.subviews[1]).layer needsDisplay];
            }
        }
    }
}

#pragma mark - delegate

- (void)setLineSize:(CGFloat)lineSize
{
    _line.frame = CGRectMake(_line.frame.origin.x, self.frame.size.height - lineSize - 0.5, _line.frame.size.width, lineSize);
}
@end
