//
//  CRBezierCurve.h
//  test
//
//  Created by abyss on 14/11/26.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct
{
    float x;
    float y;
} Point2D;

@interface CRBezierCurve : NSObject

Point2D PointOnCubicBezier(Point2D* cp, float t);
@end
