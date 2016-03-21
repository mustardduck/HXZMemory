//
//  CRLayoutView.m
//  CRCoreUnit
//
//  Created by abyss on 14/12/19.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import "CRLayoutView.h"
//#import "Define+Structer.h"
//#import "Define+Debug.h"
//#import "Define+UIBox.h"

#import "CRButtonContainer.h"

@interface CRLayoutView () <CRButtonContainerDelegate>
{
    Class _buttonClass;
}
#define cr_buttonHeight (self.height/_lineNumber)
@property (retain, nonatomic) CRButtonContainer *buttonContainer;
@end
@implementation CRLayoutView

#pragma mrak - Life Syscle

- (void)dealloc
{
    _cr_delegate = nil;
    [_buttonContainer release];
    
    CRDEBUG_DEALLOC();
    [super dealloc];
}

- (void)setup
{
    _buttonClass       = _buttonContainer.buttonClass;
}

- (instancetype)initWithFrame:(CGRect)frame with:(NSArray *)buttonArray delegate:(id<CRLayoutViewDelegate>)delegate
 line:(NSInteger)line
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setCr_delegate:delegate];
        
        _buttonContainer = OBJECT_NEW_STRONG(CRButtonContainer,
                                             initWith:[buttonArray copy]
                                             delegate:self
                                             height:cr_buttonHeight);
        
        _lineNumber = line <= 0 ? 1:line;
        [self setup];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    APP_ASSERT(cr_buttonObjectArray && [cr_buttonObjectArray count] > 0);
    
    CGFloat buttonWidth = self.width/[cr_buttonObjectArray count] * _lineNumber;
    
    {
        if (0 == buttonWidth) LOG_DBUG(@"button width is nil");
        
        int j = 0;
        for (int i = 0; i < [cr_buttonObjectArray count]; i++)
        {
            CGRect frame = CGRectZero;
            {
                CGFloat left = i * buttonWidth - j*320;
                CGFloat top  = j * cr_buttonHeight;
                if (left + buttonWidth >= 319) j++;
                
                frame = CGRectMake(left, top, buttonWidth, cr_buttonHeight);
            }
            
            ((UIButton *)cr_buttonObjectArray[i]).frame = frame;
            [self addSubview:((UIButton *)cr_buttonObjectArray[i])];
        }
    }
    
    [_buttonContainer needAutoawakNow];
}

#pragma mark - ButtonDelegate

- (UIButton *)buttonContainer:(CRButtonContainer *)view the:(id)button shouldLayoutBy:(NSDictionary *)data
{
    if (_cr_delegate && [_cr_delegate respondsToSelector:@selector(layoutView:the:shouldLayoutBy:)])
    {
        button = [_cr_delegate layoutView:self the:button shouldLayoutBy:data];
    }
    else
    {
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    return button;
}

- (UIButton *)buttonContainer:(CRButtonContainer *)view willbuttonCustomBy:(CGFloat)height
{
    UIButton *button = nil;
    
    if (_cr_delegate && [_cr_delegate respondsToSelector:@selector(layoutView:willbuttonCustomBy:)])
    {
        button = [_cr_delegate layoutView:self willbuttonCustomBy:height];
    }
    else
    {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
//        _height = self.height == 0 ? CRButtonContainer_Height:_height;
    }
    
    return button;
}

- (void)buttonContainer:(CRButtonContainer *)view willRefreshData:(BOOL)shouldRemoveAllButtonsBefore
{
    for (id object in self.subviews)
    {
        if ([object isKindOfClass:[_buttonClass class]])
        {
            [object removeFromSuperview];
        }
    }
}

#pragma mark - EventCenter

- (void)buttonContainer:(CRButtonContainer *)view button:(id)button shouldResponseButtonTouchAt:(NSInteger)buttonIndex
{
    if (_cr_delegate && [_cr_delegate respondsToSelector:@selector(layoutView:button:shouldResponseButtonTouchAt:)])
    {
        [_cr_delegate layoutView:self button:button shouldResponseButtonTouchAt:buttonIndex];
    }
}


@end
