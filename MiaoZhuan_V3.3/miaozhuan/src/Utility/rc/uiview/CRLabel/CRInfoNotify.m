//
//  CRInfoNotify.m
//  test
//
//  Created by abyss on 14/11/24.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import "CRInfoNotify.h"
#import "Define+RCMethod.h"
#import "CRDrawHelper.h"
#import <objc/runtime.h>

@interface CRInfoNotify ()
{
    UILabel *_label;
    UIFont *_font;
    
    CGFloat max_width;
    CGFloat shadowSize;
    CGFloat shadowBlur;
}
@end

@implementation INSTANCE_CLASS_SETUP(CRInfoNotify)
@synthesize rootPoint = _rootPoint;
@synthesize info = _info;
@synthesize isAutoHidden = _isAutoHidden;

- (void)dealloc
{
//    [_font release];
    [_info release];
    [_color release];
    [_label release];
    CRDEBUG_DEALLOC();
    
    [super dealloc];
}

- (instancetype)initWith:(NSString *)title at:(CGPoint)point
{
    if (self = [super init])
    {
        self.rootPoint = point;
        self.info = title;
        self.alpha = 0.9;
        self.color = AppColor(85);
    }
    return self;
}

- (void)setup
{
    max_width = 320.f;
    shadowSize = 3.f;
    shadowBlur = 5.f;
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    _rootPoint = CGPointMake((CGRectGetMaxX(self.frame) + CGRectGetMinX(self.frame))/2, CGRectGetHeight(self.frame));
    _isAutoHidden = NO;
    _alpha = 1;
    _font = [[UIFont systemFontOfSize:12] copy];
    if ([self isKindOfClass:[UILabel class]]) _info = [((UILabel *)self).text copy];
    
    [self configureLabel];
}

- (void)configureLabel
{
    _label = [[UILabel alloc] init];
    _label.font = _font;
    _label.textColor = [UIColor whiteColor];
    _label.backgroundColor = [UIColor clearColor];
    _label.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"CRInfoNotify";
    
    [self addSubview:_label];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGRect theRect = self.bounds;

    theRect.size.height -= shadowSize * 2;
    theRect.origin.x += shadowSize;
    theRect.size.width -= shadowSize * 2;
    theRect.size.height -= shadowSize * 2;
    
    if (_color) [_color set];
    else [[UIColor colorWithWhite:0.0 alpha:1.0] set];
    
    CGContextSetAlpha(c,  MAX(0, MIN(1.0, _alpha)));
    
    CGContextSaveGState(c);
    
    CGContextSetShadow(c, CGSizeMake(0.0, shadowSize), shadowBlur);
    
    CGContextBeginPath(c);
    if (_HookCenter == YES)
        cr_CGContextAddRoundedRectWithHookSimple(c, theRect, 5);
    else cr_CGContextAddRoundedRectWithHookSimpleRight(c, theRect, 5);
    CGContextFillPath(c);
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self sizeToFit];
    [self recalculateFrame];
    [_label sizeToFit];
    
    _label.frame = CGRectMake(7,2, _label.frame.size.width, _label.frame.size.height);
}

- (CGSize)sizeThatFits:(CGSize)size
{
    // TODO: replace with new text APIs in iOS 7 only version
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGSize s = [_label.text sizeWithFont:_font];
#pragma clang diagnostic pop
    s.height += 15;
    s.height += shadowSize;
    
    s.width += 2 * shadowSize + 7;
    s.width = MAX(s.width, CR_DRAW_HOOKSIZE * 2 + 2 * shadowSize + 10);
    
    return s;
}

- (void)recalculateFrame
{
    CGRect theFrame = self.frame;
    theFrame.size.width = MIN(max_width, theFrame.size.width);
    
    CGRect theRect = self.frame;
    theRect.origin = CGPointZero;
    
    {
        theFrame.origin.y = _rootPoint.y - theFrame.size.height + 2 * shadowSize + 1;
//        theFrame.origin.x = round(_rootPoint.x - ((theFrame.size.width - 2 * shadowSize)) / 2.0);
        theFrame.origin.x = round(_rootPoint.x - ((theFrame.size.width - 2 * shadowSize)) - 10);
    }
    
    self.frame = theFrame;
}

#pragma mark - setter

- (void)setInfo:(NSString *)info
{
    if (!info) return;
    _label.text = info;
}

#pragma mark - touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    if (_isAutoHidden) self.hidden = YES;
    
    if (_delegate && [_delegate respondsToSelector:@selector(infoNotify:didTouchedAt:)]) {
        [_delegate infoNotify:self didTouchedAt:point];
    }
}

#pragma mark - animation

- (void)display:(BOOL)show
{
//    [UIView animateWithDuration:0.3f animations:^{
//        NSLog(@"%d",(int)show);
//        self.alpha = (int)show;
//    }];
    
    self.hidden = !show;

}

@end

static NSString *cr_InfoNotifyKey = @"cr_InfoNotifyKey";
@implementation UIViewController (UIViewController_CRInfoNotify)

- (void)cr_showInfoNotify:(NSString *)str at:(CGPoint)point inColor:(UIColor *)color
{
    CRInfoNotify *notify = [self real_CRInfoNotify];
    if (!notify)
    {
        notify = [[[CRInfoNotify alloc] init] autorelease];
        notify.rootPoint = point;
        notify.color = color;
        notify.info = str;
        notify.alpha = 0.9;
        
        [self setRea_CRInfoNotify:notify];
        [self.view addSubview:notify];
    }
}

- (void)cr_showInfoNotify:(NSString *)str at:(CGPoint)point
{
    [self cr_showInfoNotify:str at:point inColor:[UIColor blackColor]];
}
- (CRInfoNotify *)getInfoObject { return [self real_CRInfoNotify];}
- (CRInfoNotify *)real_CRInfoNotify
{
    return objc_getAssociatedObject(self, &cr_InfoNotifyKey);
}

- (void)cr_mz_showInfoNotify:(NSString *)str at:(CGPoint)point
{
    [self cr_showInfoNotify:str at:point inColor:AppColor(85)];
}

- (void)setRea_CRInfoNotify:(CRInfoNotify *)real_CRInfoNotify
{
    objc_setAssociatedObject(self, &cr_InfoNotifyKey, real_CRInfoNotify, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
