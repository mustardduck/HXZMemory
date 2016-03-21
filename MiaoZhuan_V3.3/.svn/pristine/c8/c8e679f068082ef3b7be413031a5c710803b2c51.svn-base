//
//  RRNavBarDrawer.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-3.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RRNavBarDrawer.h"

@implementation RRNavBarDrawer

#pragma mark - Action Method

- (void)itemBtnPressed:(UIButton *)itemBtn
{
    if (nil != _delegate && [_delegate respondsToSelector:@selector(didClickItem:atIndex:)])
    {
        [self closeNavBarDrawer];
        [_delegate didClickItem:self atIndex:itemBtn.tag - 1];
    }
}

/**
 * 实例化抽屉视图
 * @param theView 指定的UIView
 */
- (id)initWithView:(UIView *)view andInfoArray:(NSArray *)array{
    self = [super init];
    if (self)
    {
        if (array) {
            // Initialization code
            
            _isOpen = NO;
            
            UIView *background = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0.f, 0.f, 85.f, 40.f * array.count + 5));
            
            UIImageView *imageview = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(62.f, 0.f, 11.f, 5.f));
            imageview.image = [UIImage imageNamed:@"ads_navArrowBg.png"];
            [self addSubviews:background,imageview, nil];
            
            [self createButtonWithArray:array];
        
            self.frame = CGRectMake(SCREENWIDTH - 90, -(40.f * array.count + 5), 85, 40.f * array.count + 5);
            [view addSubview:self];
            
        }
    }
    return self;
}

- (void)setFrameX:(float)frameX{
    self.left = frameX;
}

- (void)createButtonWithArray:(NSArray *)array{
    
    UIView *background = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0.f, 5.f, 85.f, 40.f * array.count));
    background.backgroundColor = RGBCOLOR(76, 76, 76);
    for (int i = 0; i < array.count; i++) {
        NSDictionary *datadic = array[i];
       
        UIButton *btnItem = [UIButton buttonWithType:UIButtonTypeCustom];
        btnItem.frame = CGRectMake(0.f, i * 40.f, 85.f, 40.f);
        btnItem.tag = i+1;
        btnItem.titleLabel.font = Font(16);
        [btnItem setImage:[UIImage imageNamed:[[datadic wrapper] get:@"normal"]] forState:UIControlStateNormal];
        [btnItem setImage:[UIImage imageNamed:[[datadic wrapper] get:@"hilighted"]] forState:UIControlStateHighlighted];
        [btnItem setTitle:[NSString stringWithFormat:@" %@",[[datadic wrapper] get:@"title"]] forState:UIControlStateNormal];
        [btnItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btnItem setTitleColor:RGBCOLOR(186, 186, 186) forState:UIControlStateHighlighted];
        
        [btnItem addTarget:self action:@selector(itemBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(12, (i + 1) * 40.f, 60.f, 0.5));
        line.image = [UIImage imageNamed:@"line.png"];
        [background addSubviews:btnItem,line,nil];
    }
    [background setRoundCorner];
    [self addSubview:background];

}

/**
 * 打开抽屉
 */
- (void)openNavBarDrawer{
    _isOpen = YES;
    [UIView animateWithDuration:.3 animations:^{
        self.top = -self.height;
    }];
}

/**
 * 关起抽屉
 */
- (void)closeNavBarDrawer{
    _isOpen = NO;
    [UIView animateWithDuration:.3 animations:^{
        self.top = 0;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
