//
//  CRDrawHelper.h
//  test
//
//  Created by abyss on 14/11/24.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit+DrawingHelpers.h"

static CGFloat CR_DRAW_HOOKSIZE = 4.f;
@interface CRDrawHelper : NSObject

//画hook
void cr_CGContextAddRoundedRectWithHookSimple(CGContextRef c, CGRect rect, CGFloat radius);
void cr_CGContextAddRoundedRectWithHookSimpleRight(CGContextRef c, CGRect rect, CGFloat radius);

@end
