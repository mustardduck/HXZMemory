//
//  RRButton.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RRButton.h"
#import "Define+RCMethod.h"

@implementation INSTANCE_CLASS_SETUP(RRButton)

- (void)setup{
    [self setRoundCorner];
    self.layer.borderColor = AppColorLightGray204.CGColor;
    self.layer.borderWidth = 1.f;
}

- (void)setHighlighted:(BOOL)highlighted{
    if (highlighted)
    {
        self.backgroundColor = AppColorLightGray204;
    }
    else
    {
        self.backgroundColor = AppColorWhite;
    }
}

@end
