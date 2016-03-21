//
//  RRPointView.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRPointView : UIView

- (instancetype)initWithFrame:(CGRect)rect
                          bgColor:(UIColor *)bgcolor
                        textColor:(UIColor *)textcolor
                         fontSize:(float)fontsize
                              num:(NSInteger)num;

@end
