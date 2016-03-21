//
//  HeaderView.m
//  miaozhuan
//
//  Created by 孙向前 on 14-10-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "HeaderView.h"
#import "RRLineView.h"

@implementation HeaderView


- (id)initWithData:(id)data{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREENWIDTH, 30);
        
        RRLineView *lineview = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5));
        [self addSubview:lineview];
        
        UILabel *lblTitle = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(15, 15, SCREENWIDTH, 15));
        lblTitle.textColor = RGBCOLOR(34, 34, 34);
        lblTitle.font = BoldFont(15);
        lblTitle.text = data;
        [self addSubview:lblTitle];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
