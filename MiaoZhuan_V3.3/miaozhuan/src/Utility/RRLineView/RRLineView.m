//
//  RRLineView.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RRLineView.h"
#import "Define+RCMethod.h"

@implementation INSTANCE_CLASS_SETUP(RRLineView)

- (void)setup
{
    self.image = [UIImage imageNamed:@"line.png"];
    self.contentMode = UIViewContentModeScaleToFill;
    NSLog(@"%f",[UIScreen mainScreen].scale);
    CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);;
//    if ([SystemUtil aboveIOS8_0]) {
//        lineHeight = 1.f / 3.f;
//    } else {
//       lineHeight = (1.f / [UIScreen mainScreen].scale);
//    }
    
    self.height = lineHeight;
}

@end
