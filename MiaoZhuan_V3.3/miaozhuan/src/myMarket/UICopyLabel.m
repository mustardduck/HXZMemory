//
//  UICopyLabel.m
//  miaozhuan
//
//  Created by momo on 15/1/21.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "UICopyLabel.h"

@implementation UICopyLabel

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

// 可以响应的方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return (action == @selector(copy:));
}

//针对于响应方法的实现
-(void)copy:(id)sender
{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    
    NSString * coText = @"";
    
    if(self.text.length > 5)
    {
        coText = [self.text substringFromIndex:5];
    }
    else
    {
        [HUDUtil showErrorWithStatus:@"暂无可复制的内容"];
        
        return;
    }
    
    pboard.string = coText;
}

//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)attachTapHandler
{
    self.userInteractionEnabled = YES;  //用户交互的总开关
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    touch.numberOfTapsRequired = 1;
    [self addGestureRecognizer:touch];
    [touch release];
}

//绑定事件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self attachTapHandler];
    }
    return self;
}

//同上
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self attachTapHandler];
}

-(void)handleTap:(UIGestureRecognizer*) recognizer
{
    [self becomeFirstResponder];
    UIMenuItem *copyLink = [[[UIMenuItem alloc] initWithTitle:@"复制"
                                                      action:@selector(copy:)]autorelease];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyLink, nil]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
}

@end
