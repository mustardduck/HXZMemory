//
//  CashSection.m
//  miaozhuan
//
//  Created by Santiago on 14-12-22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CashSection.h"

@implementation CashSection

- (void)setDate:(NSString*)date{
    
    ((UILabel*)[self viewWithTag:1]).text = date;
    UIView *topLineView = WEAK_OBJECT(UIView, init);
    [topLineView setFrame:CGRectMake(0, 0, 320, 0.5)];
    [topLineView setBackgroundColor:RGBCOLOR(204, 204, 204)];
    [self addSubview:topLineView];
}
- (void)dealloc {
    [_UILineVIew release];
    [super dealloc];
}
@end
