//
//  AppPopView.m
//  miaozhuan
//
//  Created by abyss on 14/10/31.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AppPopView.h"

@interface AppPopView ()
{
    UIView *_oldView;
    UIViewController *_old;
    
    UIView *_coverView;
    UIButton *_bt;
    UIView *_header;
    
    UILabel  *_title;
    UIButton *_left;
    UIButton *_right;
    
    CGFloat keyboardHeight;
    BOOL isHidden;
}
@end

@implementation AppPopView
{
    leftRCAppPopViewCallBackBlock _blockLeft;
    rightRCAppPopViewCallBackBlock _blockRight;
    drawRectBlock _drawRectBlock;
}
@synthesize titleName = _titleName;
@synthesize contentView = _contentView;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_bt removeFromSuperview];
    [_bt release];
    [_contentView removeFromSuperview];
    [_contentView release];
//    
//    [_oldView release];
//    _oldView = nil;
//
    [_coverView release];
    [_header release];
    [_left release];
    [_right release];
    [_title release];
    [_titleName release];
    
    NSLog(@"dealloc");
    [super dealloc];
}

- (id)initWithAnimateUpOn:(UIViewController *)Con frame:(CGRect)frame left:(leftRCAppPopViewCallBackBlock)block1 right:(rightRCAppPopViewCallBackBlock)block2
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(PopViewKeyboardChange:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(PopViewKeyboardChange:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(PopViewKeyboardChange:)
                                                     name:UIKeyboardDidChangeFrameNotification
                                                   object:nil];
        
//        self.height += 10;
        _old = Con;
        _oldView = Con.view;
        [self initView];
        self.frame = CGRectMake(0,SCREENHEIGHT, self.width, self.height + _header.height);
        
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _coverView.alpha = 0;
        _coverView.backgroundColor = [UIColor blackColor];
        [APP_DELEGATE.window addSubview:_coverView];
        
        
        _bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, SCREENHEIGHT - self.height)];
        [_bt addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
        [APP_DELEGATE.window addSubview:_bt];
        
        _blockLeft = nil;
        _blockRight = nil;
        _blockLeft = [block1 copy];
        _blockRight = [block2 copy];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = AppColorWhite;
    //头
    _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    _header.backgroundColor = AppColor(220);
    [self addSubview:_header];
    
    //标题
    _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 320, 39)];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = AppColorBlack43;
    _title.text = @"弹出视图";
    _title.font = Font(19);
    [_header addSubview:_title];
    
    //左右
    _left = [[UIButton alloc] initWithFrame:CGRectMake(0, 6, 50, 37)];
    _right = [[UIButton alloc] initWithFrame:CGRectMake(_header.width - 52 , 6, 50, 37)];
    [_left setTitle:@"取消" forState:UIControlStateNormal];
    [_right setTitle:@"完成" forState:UIControlStateNormal];
    [_left setTitle:@"取消" forState:UIControlStateHighlighted];
    [_right setTitle:@"完成" forState:UIControlStateHighlighted];
    _left.titleLabel.font = Font(16);
    _right.titleLabel.font = Font(16);
    [_left setTitleColor:AppColor(85) forState:UIControlStateNormal];
    [_right setTitleColor:AppColor(85) forState:UIControlStateNormal];
    [_left setTitleColor:AppColor(162) forState:UIControlStateHighlighted];
    [_right setTitleColor:AppColor(162) forState:UIControlStateHighlighted];
    [_left addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
    [_right addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    [_header addSubview:_right];
    [_header addSubview:_left];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, _header.bottom, _header.width, self.height)];
    [self addSubview:_contentView];
}

- (void)layoutSubviews
{
    _title.text = _titleName;
}

- (void)setBlock:(drawRectBlock)block
{
//    UIView *blockView = nil;
//    if (block != nil) blockView = block;
//    if (blockView == nil) return;
//    _drawRectBlock(blockView);
//    [_contentView addSubview:blockView];
}

- (void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    [_titleName retain];
}

- (void)show:(BOOL)show
{
    if (show)
    {
        [APP_DELEGATE.window addSubview:self];
    }

    __block AppPopView *weakself = self;
    _bt.hidden = !show;
    [UIView animateWithDuration:0.3 animations:^{
        if (show)
        {
            self.frame = CGRectMake(0, SCREENHEIGHT - self.height, self.width, self.height);
            _coverView.alpha = 0.5;
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            if (!show)
            {
                _coverView.alpha = 0.0;
                self.frame = CGRectMake(0,SCREENHEIGHT, self.width, self.height);
            }
        } completion:^(BOOL finished) {
            if (!show)
            {
                [weakself removeFromSuperview];
            }
        }];
    }];
}

- (void)up:(int64_t)height
{
    __block AppPopView *weak = self;
    [UIView animateWithDuration:0.3 animations:^{
            weak.bottom -= height;
    } completion:^(BOOL finished) {}];
}

- (void)adjustKeyboard
{
    if (!self) return;
    [UIView animateWithDuration:0.3 animations:^{
        self.bottom = keyboardHeight;
    } completion:^(BOOL finished) {}];
}

#pragma mark - event

- (void)left:(UIButton *)sender
{
    _blockLeft();
    [APP_DELEGATE.window endEditing:YES];
    [self show:NO];
}

- (void)right:(UIButton *)sender
{
    _blockRight();
}

- (void)PopViewKeyboardChange:(NSNotification *)notification
{
    if(notification)
    {
        NSDictionary* keyboardInfo = [notification userInfo];
        CGFloat top = ((CGRect)[[keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]).origin.y;
        if(notification.name == UIKeyboardWillShowNotification)
        {
            keyboardHeight = top;
            [self adjustKeyboard];
        }
        
        if(notification.name == UIKeyboardWillHideNotification)
        {
            keyboardHeight = top;
            [self adjustKeyboard];
        }
        
        if(notification.name == UIKeyboardDidChangeFrameNotification)
        {
            if (keyboardHeight == top) return;
            keyboardHeight = top;
            [self adjustKeyboard];
        }
    }
}

@end
