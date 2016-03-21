//
//  IWRecruitWelfareLabelView.m
//  miaozhuan
//
//  Created by admin on 15/4/28.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWRecruitWelfareLabelView.h"
#import "MarkView.h"

@implementation IWRecruitWelfareLabelView

-(float)updateItems:(NSArray *)items{
    
    [self removeAllSubviews];
    
    NSUInteger row = 0;
    CGFloat x = 0;
    CGFloat padding_y = 10;
    CGFloat padding_x = 4;
    
    for (int i = 0; i < items.count; i++)
    {
        MarkView *mark = [[MarkView alloc] initWithMark:items[i]  Frame:CGRectMake(x, (row * 25) + (row * padding_y), 0, 25)];
  
        x += mark.width + padding_x;
        if (x > self.maxWidth)
        {
            x = 0;
            row++;
            mark.frame = CGRectMake(x, (row * 25) + (row * padding_y), mark.width, mark.height);
            x += mark.width + padding_x;
        }
        [self addSubview:mark];
    }
    return (row * 25) + (row * padding_y) + 25.f;
}

@end
