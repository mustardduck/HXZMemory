//
//  viewCategory.m
//  cloud
//
//  Created by jack ray on 11-4-16.
//  Copyright 2011年 oulin. All rights reserved.
//

#import "UIView+expanded.h"
#import <QuartzCore/QuartzCore.h>

//static tapGestureBlock _tapBlock;
@implementation UIView(Addition)

-(BOOL) containsSubView:(UIView *)subView
{
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}
//-(BOOL) isKindOfClass: classObj 判断是否是这个类，包括这个类的子类和父类的实例；
//-(BOOL) isMemberOfClass: classObj 判断是否是这个类的实例,不包括子类或者父类；
//-(BOOL) containsSubViewOfClassType:(Class)pClass {
//    for (UIView *view in [self subviews]) {
//        if ([view isMemberOfClass:pClass]) {
//            return YES;
//        }
//    }
//    return NO;
//}

- (CGPoint)frameOrigin {
	return self.frame.origin;
}

- (void)setFrameOrigin:(CGPoint)newOrigin {
	self.frame = CGRectMake(newOrigin.x, newOrigin.y, self.frame.size.width, self.frame.size.height);
}

- (CGSize)frameSize {
	return self.frame.size;
}

- (void)setFrameSize:(CGSize)newSize {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
							newSize.width, newSize.height);
}

- (CGFloat)frameX {
	return self.frame.origin.x;
}

- (void)setFrameX:(CGFloat)newX {
	self.frame = CGRectMake(newX, self.frame.origin.y,
							self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameY {
	return self.frame.origin.y;
}

- (void)setFrameY:(CGFloat)newY {
	self.frame = CGRectMake(self.frame.origin.x, newY,
							self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameRight {
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setFrameRight:(CGFloat)newRight {
	self.frame = CGRectMake(newRight - self.frame.size.width, self.frame.origin.y,
							self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameBottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setFrameBottom:(CGFloat)newBottom {
	self.frame = CGRectMake(self.frame.origin.x, newBottom - self.frame.size.height,
							self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameWidth {
	return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)newWidth {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
							newWidth, self.frame.size.height);
}

- (CGFloat)frameHeight {
	return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)newHeight {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
							self.frame.size.width, newHeight);
}

-(void)allRoundCorner
{
    self.layer.cornerRadius = self.frameWidth/2.0;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [RGBCOLOR(217, 216, 210) CGColor];
    
//    self.layer.shouldRasterize = YES;
//    self.layer.rasterizationScale = 1;
//    self.layer.borderColor = [[UIColor clearColor] CGColor];
}

- (void) borderLayer
{
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [RGBCOLOR(217, 216, 210) CGColor];
}

-(void)roundCorner
{
    self.layer.masksToBounds = YES;  
    self.layer.cornerRadius = 5.0;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [[UIColor clearColor] CGColor];
}

//圆角为11
-(void) roundCornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 11.0;
}
//圆角11，加边框线
-(void) roundCornerRadiusBorder
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 11.0;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
}


-(void) roundCornerBorder
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
}

-(void)lightGrayCorner
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3.0;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [RGBCOLOR(217, 216, 210)  CGColor];
    
    //    self.layer.shouldRasterize = YES;
    //    self.layer.rasterizationScale = self.window.screen.scale;
    //    self.layer.borderColor = [[UIColor clearColor] CGColor];
    
}

-(void)rotateViewStart;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * 2 ];
    rotationAnimation.duration = 2;
    //rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 0; 
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
-(void)rotateViewStop
{
    //CFTimeInterval pausedTime=[self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
//    self.layer.speed=0.0;
//    self.layer.timeOffset=pausedTime;
    //self.layer.timeOffset = 0.0;  
    //self.layer.beginTime = 0.0; 
//    CFTimeInterval timeSincePause =4+ (pausedTime - (int)pausedTime);
//    NSLog(@".....%f",timeSincePause);
//    self.layer.timeOffset=timeSincePause;
//    self.layer.beginTime = 0.0;
//    [NSTimer timerWithTimeInterval:timeSincePause target:self selector:@selector(removeAnimation:) userInfo:nil repeats:NO];
    [self.layer removeAllAnimations];
}
- (void)removeAnimation:(id)obj
{
    [self.layer removeAllAnimations];
}
-(void)addSubviews:(UIView *)view,...
{
    [self addSubview:view];
    va_list ap;
    va_start(ap, view);
    UIView *akey=va_arg(ap,id);
    while (akey) {
        [self addSubview:akey];
        akey=va_arg(ap,id);
    }
    va_end(ap);
}

//- (void)addTapGesture:(tapGestureBlock)tapBlock
//{
//    _tapBlock = [tapBlock copy];
//    UITapGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)] autorelease];
//    self.userInteractionEnabled = YES;
//    [self addGestureRecognizer:recognizer];
//}
//
//- (void)viewTap
//{
//    _tapBlock(self);
//}


@end
