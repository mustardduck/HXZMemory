//
//  RRPointView.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RRPointView.h"

@implementation RRPointView

- (instancetype)initWithFrame:(CGRect)rect
                          bgColor:(UIColor *)bgcolor
                        textColor:(UIColor *)textcolor
                         fontSize:(float)fontsize
                              num:(NSInteger)num;{
    self = [super initWithFrame:rect];
    if (self) {
        
        [self createPointWithbgColor:bgcolor
                           textColor:textcolor
                            fontSize:fontsize
                                 num:num];
    }
    return self;
}

- (void)createPointWithbgColor:(UIColor *)bgcolor
                     textColor:(UIColor *)textcolor
                      fontSize:(float)fontsize
                           num:(NSInteger)num{
    
    if (!num) {
        self.hidden = YES;
        return;
    }
    
    if (!bgcolor) {
        bgcolor = RGBCOLOR(243, 116, 23);
    }
    
    if (!textcolor) {
        textcolor = AppColorWhite;
    }
    
    if (!fontsize) {
        fontsize = 12;
    }
    
    UIButton *btn = WEAK_OBJECT(UIButton, initWithFrame:self.bounds);
    
    btn.userInteractionEnabled = NO;
    btn.backgroundColor = bgcolor;
    [btn setTitleColor:textcolor forState:UIControlStateNormal];
    [btn.titleLabel setFont:Font(fontsize)];
    [btn.titleLabel setContentMode:UIViewContentModeCenter];
    [btn.titleLabel setMinimumFontSize:9];
    if (num > 99) {
        [btn setTitle:@"∙∙∙" forState:UIControlStateNormal];
    } else {
        [btn setTitle:[NSString stringWithFormat:@"%ld", (long)num] forState:UIControlStateNormal];
    }
    
    
    [btn setRoundCornerAll];
    [self addSubview:btn];
    
}

- (void)dealloc{
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
