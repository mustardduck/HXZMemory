//
//  CRHolderView.m
//  miaozhuan
//
//  Created by abyss on 14/12/22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CRHolderView.h"
#import "Redbutton.h"
#import "Define+RCMethod.h"

#import <objc/runtime.h>

NSString *CRHolderViewKey = @"__CRHolderViewKey";
NSString* CRHolderView_DefualtHolder = @"006@2x.png";

@interface CRHolderView ()
{
    UIView*         _ori;
    
    UILabel*        _textLabel;
    UILabel*        _mainTextLabel;
    
    UIImageView*    _img;
}
@end

@implementation CRHolderView
{
    holderBlock _block;
}

- (void)dealloc
{
    _block = nil;
    
    [_ori release];
    [_img release];
    [_textLabel release];
    [_mainTextLabel release];
    
    [super dealloc];
}

- (instancetype)initWithImg:(NSString *)img text1:(NSString *)mainText text2:(NSString *)text button:(NSArray *)button block:(holderBlock)block;
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    if (self)
    {
        _ori            = STRONG_OBJECT(UIView, init);
        _textLabel      = STRONG_OBJECT(UILabel, init);
        _mainTextLabel  = STRONG_OBJECT(UILabel, init);
        _img            = STRONG_OBJECT(UIImageView, init);
        
        _ori.backgroundColor = AppColorRed;
        CGSize size     = CGSizeZero;
        CGRect frame    = CGRectZero;
        {
            APP_ASSERT(@"img can`t be nil");
            UIImage* image = [UIImage imageNamed:img];
            BOOL     flag  = [img containsString:@"@2x"];
            
            size    = CGSizeMake(image.size.width/(flag?1.f:2.f), image.size.height/(flag?1.f:2.f));
//            if (image.size.width > 180 || image.size.height > 160)
//            {
//                size    = CGSizeMake(size.width/2.f, size.height/2.f);
//            }
            frame   = CGRectMake((SCREENWIDTH - size.width) /2.f, 60, size.width, size.height);
            
            [_img setFrame:frame];
            [_img setImage:image];
            [_ori addSubview:_img];
        }
        
        CGFloat top = 60 + size.height + 25;
        
        if (mainText)
        {
            [_mainTextLabel setFont:Font(19)];
            [_mainTextLabel setText:mainText];
            [_mainTextLabel setTextColor:AppColorBlack43];
            [_mainTextLabel setTextAlignment:NSTextAlignmentCenter];
            [_mainTextLabel setLineBreakMode:NSLineBreakByCharWrapping];
            [_mainTextLabel setNumberOfLines:0];
            [_mainTextLabel setFrame:CGRectMake(0, top, SCREENWIDTH, 38 + 10)];
            
            top += 20;
            [_ori addSubview:_mainTextLabel];
        }
        
        if (text)
        {
            [_textLabel setFont:Font(15)];
            [_textLabel setText:text];
            [_textLabel setTextColor:AppColorGray153];
            [_textLabel setTextAlignment:NSTextAlignmentCenter];
            [_textLabel setLineBreakMode:NSLineBreakByCharWrapping];
            [_textLabel setNumberOfLines:0];
            [_textLabel setFrame:CGRectMake(0, top, SCREENWIDTH, 30 + 10)];
            
            top += 20;
            [_ori addSubview:_textLabel];
        }
        
#warning now noly allow 1 button in array, fix later
        if (button && [button count] == 1)
        {
            int tag = 0;
            
            for (id object in button)
            {
                if ([object isKindOfClass:[NSString class]])
                {
                    Redbutton *button = [Redbutton buttonWithType:UIButtonTypeCustom];
                    
                    [button setFrame:CGRectMake(50, top + 25, 220, 40)];
                    [button setTitle:object forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(EVENT:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [button setTag:tag++];
                    [_ori addSubview:button];
                }
                else
                {
                    LOG_WARN(@"fix later");
                }
            }
        }
        
        [_ori setBackgroundColor:AppColorWhite];
        [_ori setFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        [self addSubview:_ori];
        
        //block
        {
            _block = nil;
            _block = [block copy];
        }
    }
    return self;
}

- (void)EVENT:(UIButton *)sender
{
    _block((int)sender.tag);
}

- (void)display:(BOOL)show
{
    self.hidden = !show;
}
@end


@implementation UIViewController (CRUnit)

- (void)showHolderDefault
{
    [self showHolderWithImg:@"028_a" text2:@"暂时没有对应数据"];
}

- (void)showHolderWithImg:(NSString *)imgName text2:(NSString *)text
{
    [self showHolderWithImg:imgName text1:nil text2:text button:nil block:NULL];
}

- (void)showHolderWithImg:(NSString *)imgName text1:(NSString *)mainText text2:(NSString *)text
{
    [self showHolderWithImg:imgName text1:mainText text2:text button:nil block:NULL];
}

- (void)showHolderWithImg:(NSString *)imgName
                    text1:(NSString *)mainText
                    text2:(NSString *)text
                   button:(NSArray *)buttonArray
                    block:(holderBlock)block;
{
    CRHolderView *holder = [self realHolder];
    if (!imgName || imgName.length == 0) imgName = CRHolderView_DefualtHolder;
    if (!holder)
    {
        holder = [[[CRHolderView alloc] initWithImg:imgName
                                             text1:mainText
                                             text2:text
                                            button:buttonArray
                                             block:block] autorelease];
        
        [self setrealHolder:holder];
        [self.view addSubview:holder];
    }
    else
    {
        [holder display:YES];
    }
}

- (void)setHolderDefaultHight:(CGFloat)height
{
    CRHolderView *holder = [self realHolder];
    if (holder)
    {
        [holder setTop:height];
        [holder.layer needsDisplay];
    }
}

- (void)displayHoder:(BOOL)show
{
    CRHolderView *holder = [self realHolder];
    if (holder) [holder display:show];
}

- (CRHolderView *)realHolder
{
    return objc_getAssociatedObject(self, &CRHolderViewKey);
}

- (void)setrealHolder:(CRHolderView *)realHolder
{
    objc_setAssociatedObject(self, &CRHolderViewKey, realHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
