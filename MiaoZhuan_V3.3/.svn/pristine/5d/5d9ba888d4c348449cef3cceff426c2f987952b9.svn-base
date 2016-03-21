//
//  BaserHoverView.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BaserHoverView.h"

@implementation BaserHoverView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message{
    self = [[[[NSBundle mainBundle] loadNibNamed:@"BaseHoverView" owner:self options:nil] firstObject] retain];
    if (self) {
        if (message.length || title.length) {
            CGSize size = [UICommon getSizeFromString:message withSize:CGSizeMake(_lblMessage.width, MAXFLOAT) withFont:15];
            _lblMessage.height = size.height;
            _lblMessage.text = message.length ? message : @"";
            _lblTitle.text = title.length ? title : @"";
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [_lblTitle release];
    [_lblMessage release];
    [_imgView release];
    [super dealloc];
}
@end
