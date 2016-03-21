//
//  CommonTextView.h
//  miaozhuan
//
//  Created by abyss on 14/11/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTextView : UITextView
// ADDTITON 20 HEIGHT
@property (assign, nonatomic) NSInteger limitNum;
@property (retain, nonatomic) NSString *beforeStr;
@property (retain, nonatomic) NSString *endStr;
@property (assign, nonatomic) CGFloat realHeight;
@property (retain, nonatomic) UIView* parent;

- (void)TextDidChange:(id)notity;
- (instancetype)initWithFrame:(CGRect)frame parent:(UIView *)view;
@end
