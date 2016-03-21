//
//  CRDrawHelper.m
//  test
//
//  Created by abyss on 14/11/24.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import "CRDrawHelper.h"
#import "UIKit+DrawingHelpers.h"

@implementation CRDrawHelper

void cr_CGContextAddRoundedRectWithHookSimple(CGContextRef c, CGRect rect, CGFloat radius) {
    CGFloat hookSize = CR_DRAW_HOOKSIZE;
    CGContextAddArc(c, rect.origin.x + radius, rect.origin.y + radius, radius, M_PI, M_PI * 1.5, 0);
    CGContextAddArc(c, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, radius, M_PI * 1.5, M_PI * 2, 0);
    CGContextAddArc(c, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height - radius, radius, M_PI * 2, M_PI * 0.5, 0);
    {
        CGContextAddLineToPoint(c, rect.origin.x + rect.size.width / 2 + hookSize, rect.origin.y + rect.size.height);
        CGContextAddLineToPoint(c, rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height + hookSize);
        CGContextAddLineToPoint(c, rect.origin.x + rect.size.width / 2 - hookSize, rect.origin.y + rect.size.height);
    }
    CGContextAddArc(c, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, radius, M_PI * 0.5, M_PI, 0);
    CGContextAddLineToPoint(c, rect.origin.x, rect.origin.y + radius);
}

void cr_CGContextAddRoundedRectWithHookSimpleRight(CGContextRef c, CGRect rect, CGFloat radius)
{
    CGFloat hookSize = CR_DRAW_HOOKSIZE;
    CGContextAddArc(c, rect.origin.x + radius, rect.origin.y + radius, radius, M_PI, M_PI * 1.5, 0);
    CGContextAddArc(c, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, radius, M_PI * 1.5, M_PI * 2, 0);
    CGContextAddArc(c, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height - radius, radius, M_PI * 2, M_PI * 0.5, 0);
    {
        CGContextAddLineToPoint(c, rect.origin.x + rect.size.width - 10.f + hookSize, rect.origin.y + rect.size.height);
        CGContextAddLineToPoint(c, rect.origin.x + rect.size.width - 10.f, rect.origin.y + rect.size.height + hookSize);
        CGContextAddLineToPoint(c, rect.origin.x + rect.size.width - 10.f - hookSize - 1, rect.origin.y + rect.size.height);
    }
    CGContextAddArc(c, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, radius, M_PI * 0.5, M_PI, 0);
    CGContextAddLineToPoint(c, rect.origin.x, rect.origin.y + radius);
}
@end
