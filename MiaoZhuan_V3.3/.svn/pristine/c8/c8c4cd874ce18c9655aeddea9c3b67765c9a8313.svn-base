//
//  CALater+Strategy.h
//  CRCoreUnit
//
//  Created by abyss on 14/12/18.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CALayer (Strategy)

@property CGSize size;

@property CGPoint center;
@property CGPoint origin;

@property CGFloat width;
@property CGFloat height;

@property CGFloat top;
@property CGFloat left;
@property CGFloat right;
@property CGFloat bottom;

@property (readonly) CGPoint topRight;
@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;

/** 轻微圆角 */
- (void)setRoundCorner;
/** 圆 */
- (void)setRoundCornerAll;
/** 旋转 */
- (void)setAnimateRotation;
/** 边界 */
- (void)setBorderWithColor:(UIColor *)color;

/** 移动 */
- (void)moveBy:(CGPoint)delta;
/** 缩小 */
- (void)scaleBy:(CGFloat)scaleFactor;
/** 适应缩小 */
- (void)fitInSize:(CGSize)aSize;
/** 居中 */
- (void)centerToParent;

- (void)addLayers:(CALayer *)layer,...NS_REQUIRES_NIL_TERMINATION;
- (void)removeAllSublayers;

-(BOOL)containsSubLayer:(CALayer *)subLayer;
-(BOOL)containsSubLayerOfClassType:(Class)anyClass;

@end
