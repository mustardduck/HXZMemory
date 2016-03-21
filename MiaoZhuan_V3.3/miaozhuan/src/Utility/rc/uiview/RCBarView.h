//
//  RCBarView.h
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCBarView : UIView
@property (assign, nonatomic) NSInteger data;
@property (retain, nonatomic) UIColor *color;

- (instancetype)initWithFrame:(CGRect)frame andAllData:(NSInteger)data;
@end
