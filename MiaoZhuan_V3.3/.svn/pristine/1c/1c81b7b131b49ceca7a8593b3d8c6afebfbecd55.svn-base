
//
//  CALater+Strategy.m
//  CRCoreUnit
//
//  Created by abyss on 14/12/18.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import "CALayer+Strategy.h"

#define SCREEN_SCALE ([[UIScreen mainScreen] scale])
#define PIXEL_INTEGRAL(pointValue) (round(pointValue * SCREEN_SCALE) / SCREEN_SCALE)

@implementation CALayer (Strategy)

- (CGPoint)center
{
    CGPoint c;
    c.x = CGRectGetMidX(self.bounds);
    c.y = CGRectGetMidY(self.bounds);
    return c;
}

- (void)setCenter:(CGPoint)center
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x - CGRectGetMidX(self.bounds);
    newrect.origin.y = center.y - CGRectGetMidY(self.bounds);
    newrect.size = self.bounds.size;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin: (CGPoint) aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}


- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize: (CGSize) aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

- (CGPoint)bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (void)moveBy: (CGPoint) delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

- (void)scaleBy: (CGFloat) scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

- (void)fitInSize: (CGSize) aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}

- (void)centerToParent
{
    if(self.superlayer)
    {
        switch ([UIApplication sharedApplication].statusBarOrientation)
        {
            case UIInterfaceOrientationUnknown:
            {
                NSLog(@"UIInterfaceOrientationUnknown");
                break;
            }
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
            {
                self.left = PIXEL_INTEGRAL((self.superlayer.height / 2.0) - (self.width / 2.0));
                self.top = PIXEL_INTEGRAL((self.superlayer.width / 2.0) - (self.height / 2.0));
                break;
            }
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationPortraitUpsideDown:
            {
                self.left = PIXEL_INTEGRAL((self.superlayer.width / 2.0) - (self.width / 2.0));
                self.top = PIXEL_INTEGRAL((self.superlayer.height / 2.0) - (self.height / 2.0));
                break;
            }
        }
    }
}

- (void)addSublayers:(CALayer *)layer,...
{
    [self addSublayer:layer];
    va_list ap;
    va_start(ap, layer);
    CALayer *akey=va_arg(ap,id);
    while (akey) {
        [self addSublayer:akey];
        akey=va_arg(ap,id);
    }
    va_end(ap);
}

- (void)removeAllSublayers
{
    while (self.sublayers.count)
    {
        UIView* child = self.sublayers.lastObject;
        [child removeFromSuperview];
    }
}

- (void)setRoundCorner
{
    self.masksToBounds = YES;
    self.cornerRadius = 5.0;
}

- (void)setRoundCornerAll
{
    self.cornerRadius = self.width/2.0;
    self.masksToBounds = YES;
}

- (void)setAnimateRotation
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * 2 ];
    rotationAnimation.duration = 2;
    //rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 0;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    //        [self.layer removeAllAnimations];
}

- (void)setBorderWithColor:(UIColor *)color
{
    self.borderWidth = 1.0;
    self.borderColor = color.CGColor;
}

-(BOOL) containsSubLayer:(CALayer *)subLayer
{
    for (UIView *view in [self sublayers])
    {
        if ([view isEqual:subLayer]) {
            return YES;
        }
    }
    return NO;
}
//-(BOOL) isKindOfClass: classObj 判断是否是这个类，包括这个类的子类和父类的实例；
//-(BOOL) isMemberOfClass: classObj 判断是否是这个类的实例,不包括子类或者父类；
-(BOOL) containsSubLayerOfClassType:(Class)anyClass
{
    for (CALayer *layer in [self sublayers]) {
        if ([layer isMemberOfClass:anyClass]) {
            return YES;
        }
    }
    return NO;
}

@end
