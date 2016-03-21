//
//  YinYuanBindingHelpView.m
//  miaozhuan
//
//  Created by momo on 14-12-12.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanBindingHelpView.h"

@implementation YinYuanBindingHelpView

- (instancetype)initView
{
    self = [[[[NSBundle mainBundle] loadNibNamed:@"YinYuanBindingHelpView" owner:self options:nil] firstObject] retain];
    
    return self;
}

- (void)dealloc {
    [_mainScrollView release];
    [_bottomImg release];
    [super dealloc];
}
@end
