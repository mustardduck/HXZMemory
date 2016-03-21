//
//  CRPoint.h
//  miaozhuan
//
//  Created by abyss on 14/12/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//


#import <UIKit/UIKit.h>

extern CGFloat cr_REDPOINT_SIZE;
extern CGFloat cr_REDPOINT_FONT;

@protocol cr_RedPointDelegate;
@interface CRPoint : UIControl
@property (assign, nonatomic) NSInteger num;
@property (retain, nonatomic) UIColor *color;
@property (assign, nonatomic, getter=isAllowDrag) BOOL allowDrag;
@property (assign, nonatomic) id<cr_RedPointDelegate> delegate;
- (instancetype)initWithNum:(NSInteger)num In:(UIColor *)color at:(CGPoint)point;
- (void)display:(BOOL)show;
@end

@interface CRPointFather : CRPoint
@property (retain, nonatomic) NSArray *children;
@end

@protocol cr_RedPointDelegate <NSObject>
@optional
- (void)point:(CRPoint *)point shouldBeDelete:(NSInteger)num;
- (void)point:(CRPoint *)point dic:(NSInteger)num;

- (void)point:(CRPoint *)point beginDrag:(CGPoint)point;
- (void)point:(CRPoint *)point draging:(CGPoint)point offset:(CGFloat)offset;
- (void)point:(CRPoint *)point endDrag:(CGPoint)point;
@end