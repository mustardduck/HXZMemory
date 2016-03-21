//
//  KDGoalBarPercentLayer.h
//  AppearanceTest
//
//  Created by Kevin Donnelly on 1/10/12.
//  Copyright (c) 2012 -. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

static CGFloat CR_GOALBAR_R_OUTTER = 59.f;
static CGFloat CR_GOALBAR_R_INNER = 57.f;
@interface KDGoalBarPercentLayer : CALayer

@property (nonatomic) CGFloat percent;
@property (nonatomic, retain) UIColor *color;
@end
