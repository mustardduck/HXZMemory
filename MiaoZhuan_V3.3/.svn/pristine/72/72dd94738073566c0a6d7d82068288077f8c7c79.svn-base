//
//  CRButtonContainer.m
//  CRCoreUnit
//
//  Created by abyss on 14/12/19.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import "CRButtonContainer.h"

//#import "Define+Structer.h"
//#import "Define+Debug.h"
//#import "Define+UIBox.h"

CGFloat CRButtonContainer_Height = 40.f;

@interface CRButtonContainer ()
{
    BOOL _awak;
    
    id   _sameButton;
    
    NSMutableArray *_dataArray;
}
@end
@implementation CRButtonContainer

#pragma mrak - Life Syscle

- (void)dealloc
{
    _cr_delegate = nil;
    [_dataArray release];
    
    CRDEBUG_DEALLOC();
    [super dealloc];
}

- (void)setup
{
    _needAutoawak = 0;
    _needCheckReTouch = YES;
}

- (instancetype)initWith:(NSArray *)buttonArray delegate:(id<CRButtonContainerDelegate>)delegate height:(CGFloat)height
{
    self = [super init];
    if (self)
    {
        [self setCr_delegate:delegate];
        
        _dataArray = OBJECT_NEW_STRONG(NSMutableArray, init);
        
        [self setButtonArray:[NSMutableArray arrayWithArray:buttonArray]];
        [self setup];
    }
    return self;
}

#pragma mark - setter

- (void)setButtonArray:(NSMutableArray *)buttonArray
{
    APP_ASSERT(buttonArray);
    _buttonArray = buttonArray;
    [_buttonArray retain];
    
    //refresh
    {
        if (_dataArray && [_dataArray count] > 0)
        {
            [_dataArray removeAllObjects];
            
            APP_ASSERT("buttonContainer:willRefreshData:)");
            if (_cr_delegate && [_cr_delegate respondsToSelector:@selector(buttonContainer:willRefreshData:)])
            {
                [_cr_delegate buttonContainer:self willRefreshData:YES];
            }
        }
    }
    
    int      enumCount  = 0;
    NSString *title     = nil;
    UIButton *button    = nil;
    
    for (id objct in buttonArray)
    {
        if ([objct isKindOfClass:[NSString class]])
        {
            title   = (NSString *)objct;
            button  = nil;
            
            if (!title) return;
            
            button      = [self createOn:button];
            button      = [self layoutOn:button title:title with:@{@"title":title}];
        }
        else if ([objct isKindOfClass:[NSDictionary class]])
        {
            title   = [(NSDictionary *)objct objectForKey:@"title"];
            button  = nil;
            
            if (!title)
            {
                LOG_WARN(@"no key<title>");
                return;
            }
            
            button      = [self createOn:button];
            button      = [self layoutOn:button title:title with:objct];
        }
        else
        {
            APP_ASSERT(@"unkown type of buttonArray");
        }
        
        [button setTag:++enumCount];
        [button addTarget:self action:@selector(containerEventCenter:) forControlEvents:UIControlEventTouchUpInside];
        
        [_dataArray addObject:button];
    }
}

#pragma mark - CreateButton

- (UIButton *)createOn:(UIButton *)button
{
    if (_cr_delegate && [_cr_delegate respondsToSelector:@selector(buttonContainer:willbuttonCustomBy:)])
    {
        button = [_cr_delegate buttonContainer:self willbuttonCustomBy:_height];
        _height = button.height == 0 ? CRButtonContainer_Height:button.height;
    }
    else
    {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        _height = self.height == 0 ? CRButtonContainer_Height:_height;
    }
    
    _buttonClass = [button class];
    
    return button;
}

#pragma mark - LayoutButton

- (UIButton *)layoutOn:(UIButton *)button title:(NSString *)title with:(id)data
{
    [button setTitle:title forState:UIControlStateNormal];
    
    if (_cr_delegate && [_cr_delegate respondsToSelector:@selector(buttonContainer:the:shouldLayoutBy:)])
    {
        button = [_cr_delegate buttonContainer:self the:button shouldLayoutBy:data];
    }
    else
    {
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    return button;
}

#pragma mark - EventCenter

- (void)containerEventCenter:(UIButton *)button
{
    if (button == _sameButton && _needCheckReTouch) return;
    
    for (id objct in _dataArray)
    {
        if ( [objct isKindOfClass:_buttonClass] && objct != button)
        {
            [objct setSelected:NO];
        }
    }
    
    
    [button setSelected:!button.selected];
    
    if (_cr_delegate && [_cr_delegate respondsToSelector:@selector(buttonContainer:button:shouldResponseButtonTouchAt:)])
    {
        [_cr_delegate buttonContainer:self button:button shouldResponseButtonTouchAt:button.tag];
    }
    
    _sameButton = button;
}

#pragma mark - addtion

- (void)needAutoawakNow
{
    if (_awak) return;
    
    if (_needAutoawak >= 0)
    {
        for (UIButton *button in _dataArray)
        {
            if (button.tag - 1 == _needAutoawak)
            {
                [self containerEventCenter:button];
                _awak = YES;
            }
        }
    }
}

- (void)exchangeButton:(NSInteger)changeIndex to:(NSInteger)arrayIndex
{
    [_dataArray exchangeObjectAtIndex:changeIndex withObjectAtIndex:arrayIndex];
    [_buttonArray exchangeObjectAtIndex:changeIndex withObjectAtIndex:arrayIndex];
}

@end
