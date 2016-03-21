//
//  RRPageControl.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RRPageControl.h"

@interface RRPageControl(private) // 声明一个私有方法, 该方法不允许对象直接使用
- (void)updateDots;
@end

@implementation RRPageControl // 实现部分
@synthesize imagePageStateNormal;
@synthesize imagePageStateHighlighted;
- (id)initWithFrame:(CGRect)frame
{ // 初始化
    self = [super initWithFrame:frame];
    return self;
}
- (void)setImagePageStateNormal:(UIImage *)image
{ // 设置正常状态点按钮的图片
    [imagePageStateHighlighted release];
    imagePageStateHighlighted = [image retain];
    [self updateDots];
}
- (void)setImagePageStateHighlighted:(UIImage *)image
{ // 设置高亮状态点按钮图片
    [imagePageStateNormal release];
    imagePageStateNormal = [image retain];
    [self updateDots];
}
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{ // 点击事件
    return;
}
- (void)updateDots
{ // 更新显示所有的点按钮
    if (imagePageStateNormal || imagePageStateHighlighted)
    {
        NSArray *subview = self.subviews; // 获取所有子视图

        //添加视图
        for (NSInteger i = 0; i < [subview count]; i++)
        {
            if ([SystemUtil aboveIOS7_0])
            {
                UIView *parent = subview[i];
                parent.width    = 5;
                parent.height   = 5;
                parent.layer.cornerRadius = 2.5f;
                parent.layer.masksToBounds = YES;
                
                UIView *view = [[parent subviews] firstObject];
                if (!view || ![view isKindOfClass:[UIImageView class]]) {
                    UIImageView *dot = WEAK_OBJECT(UIImageView, initWithFrame:[subview[i] bounds]);
                    dot.image = self.currentPage == i ? imagePageStateNormal : imagePageStateHighlighted;
                    [subview[i] addSubview:dot];
                } else {
                    ((UIImageView *) view).image = (self.currentPage == i ? imagePageStateNormal : imagePageStateHighlighted);
                }
        
            } else {
                UIImageView *dot = [subview objectAtIndex:i]; // 以下不解释, 看了基本明白
                dot.contentMode = UIViewContentModeCenter;
                dot.image = self.currentPage == i ? imagePageStateNormal : imagePageStateHighlighted;
            }
        }
    }
}

- (void)dealloc
{ // 释放内存
    [imagePageStateNormal release],
    imagePageStateNormal = nil;
    [imagePageStateHighlighted release],
    imagePageStateHighlighted = nil;
    [super dealloc];
}
// 覆寫setCurrentPage
- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    [self updateDots];
}


@end
