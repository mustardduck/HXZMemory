//
//  CommonSection.m
//  miaozhuan
//
//  Created by Santiago on 15-1-29.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "CommonSection.h"

@implementation CommonSection

+ (UIView*)initCommonSection {

    UIView *temp = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 320, 10));
    [temp setBackgroundColor:RGBCOLOR(239, 239, 244)];
    UIView *topLine = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 320, 0.5));
    UIView *buttomLine = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 9.5, 320, 0.5));
    [topLine setBackgroundColor:RGBCOLOR(204, 204, 204)];
    [buttomLine setBackgroundColor:RGBCOLOR(204, 204, 204)];
    [temp addSubview:topLine];
    [temp addSubview:buttomLine];
    return temp;
}
@end
