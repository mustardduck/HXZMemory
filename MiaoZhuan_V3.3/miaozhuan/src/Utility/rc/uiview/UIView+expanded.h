//
//  viewCategory.h
//  cloud
//
//  Created by jack ray on 11-4-16.
//  Copyright 2011年 oulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//typedef void (^tapGestureBlock)(UIView *view);

@interface UIView(Addition)

@property (nonatomic) CGPoint frameOrigin;
@property (nonatomic) CGSize frameSize;

@property (nonatomic) CGFloat frameX;
@property (nonatomic) CGFloat frameY;

// Setting these modifies the origin but not the size.
@property (nonatomic) CGFloat frameRight;
@property (nonatomic) CGFloat frameBottom;

@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;

-(BOOL) containsSubView:(UIView *)subView;
-(BOOL) containsSubViewOfClassType:(Class)class;

-(void)lightGrayCorner;
-(void)allRoundCorner;
-(void)roundCorner;
-(void) roundCornerBorder;
-(void)rotateViewStart;
-(void)rotateViewStop;
-(void)addSubviews:(UIView *)view,...NS_REQUIRES_NIL_TERMINATION;
-(void)borderLayer;

-(void) roundCornerRadius;

-(void) roundCornerRadiusBorder;

//- (void)addTapGesture:(tapGestureBlock)tapBlock;
@end
