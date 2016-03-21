//
//  RRPageControl.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRPageControl : UIPageControl{
    UIImage *imagePageStateNormal;
    UIImage *imagePageStateHighlighted;
}

- (id)initWithFrame:(CGRect)frame;
@property (nonatomic, retain) UIImage *imagePageStateNormal;
@property (nonatomic, retain) UIImage *imagePageStateHighlighted;

@end
