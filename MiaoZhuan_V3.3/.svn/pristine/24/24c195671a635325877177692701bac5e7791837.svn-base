//
//  RCBarView.m
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RCBarView.h"

@interface RCBarView ()
{
    UILabel *_label;
    UIView  *_bar;
    
    float _allData;
}
@end
@implementation RCBarView

- (instancetype)initWithFrame:(CGRect)frame andAllData:(NSInteger)data
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _allData = (float)data;
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 10)];
        _label.font = Font(10);
        _bar   = [[UIView alloc] initWithFrame:CGRectMake(30, 0, 0, 10)];
        _bar.backgroundColor = AppColorRed;
        [self addSubview:_label];
        [self addSubview:_bar];
    }
    return self;
}

- (void)setData:(NSInteger)data
{
    float myData = (float)data;
    float width = myData/_allData;
    _label.text = [NSString stringWithFormat:@"%.1f%@",100*width,@"%"];
    _bar.width = width*self.width;
}


@end

//@interface RCBarViewNormal : UIView
//@property (assign, nonatomic) NSInteger data;
//@property (retain, nonatomic) UIColor *color;
//
//- (instancetype)initWithFrame:(CGRect)frame andAllData:(NSInteger)data;
//@end