//
//  HeaderCollectionCell.m
//  guanggaoban
//
//  Created by abyss on 14-8-22.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import "HeaderCollectionCell.h"

@implementation HeaderCollectionCell
@synthesize coverView = _coverView;
@synthesize dragable = _dragable,showHolder = _showHolder;
@synthesize data = _data;
@synthesize curTag = _curTag;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        _btnItem = STRONG_OBJECT(UIButton, initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height));
        [self initContent];
        
        self.coverView = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height));
        [self initCover];
    }
    return self;
}


- (void)initContent
{
    
    _btnItem.autoresizingMask    = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _btnItem.titleLabel.textAlignment       = NSTextAlignmentCenter;
    _btnItem.titleLabel.font                = [UIFont boldSystemFontOfSize:16.0];
    _btnItem.backgroundColor     = [UIColor whiteColor];
    [_btnItem setBackgroundImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [_btnItem setBackgroundImage:[UIImage imageNamed:@"white_hover.png"] forState:UIControlStateHighlighted];
    
    [_btnItem setTitleColor:RGBACOLOR(34, 34, 34, 1) forState:UIControlStateNormal];
    [_btnItem setTitleColor:RGBACOLOR(34, 34, 34, 1) forState:UIControlStateHighlighted];
    _btnItem.layer.cornerRadius  = 5.0f;
    _btnItem.layer.masksToBounds = YES;
    _btnItem.layer.borderColor   = [RGBACOLOR(204, 204, 204, 1) CGColor];
    _btnItem.layer.borderWidth   = 0.5f;
    
    [self.contentView addSubview:_btnItem];
    
}


- (void)initCover
{
    _coverView.image = [UIImage imageNamed:@"xuline.png"];
    
    [self.contentView addSubview:_coverView];
    _coverView.hidden = YES;
}


- (void)setShowHolder:(BOOL)showHolder
{
    _showHolder = showHolder;
    if (_showHolder) _coverView.hidden = NO;
    else _coverView.hidden             = YES;
}


- (void)setDragable:(BOOL)dragable
{
    _dragable = dragable;
    
    if (!_dragable)
    {
        [_btnItem setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _btnItem.backgroundColor = RGBACOLOR(239, 239, 244, 1);
        [_btnItem setTitleColor:RGBACOLOR(204, 204, 204, 1) forState:UIControlStateNormal];
    }
    
}

- (void)setCurTag:(BOOL)curTag
{
    _curTag = curTag;
    
    if (_curTag)
    {
        [_btnItem setTitleColor:RGBACOLOR(240, 5, 0, 1) forState:UIControlStateNormal];
    }
}

- (void)getData:(NSDictionary *)data
{
    self.data = data;
    [_btnItem setTitle:[_data objectForKey:@"Text"] forState:UIControlStateNormal];
    [_btnItem setTitle:[_data objectForKey:@"Text"] forState:UIControlStateHighlighted];
}

- (void)dealloc
{
    [_data release];
    [_btnItem release];
    [_coverView release];
    
    [super dealloc];
}
@end


@implementation FloatCell : HeaderCollectionCell
@synthesize floatData   = _floatData;

- (void)floatWithCell:(HeaderCollectionCell *)Cell data:(NSDictionary *)floatData
{
    self.curTag                 = Cell.curTag;
    
    [self.btnItem setTitleColor:RGBACOLOR(34, 34, 34, 1) forState:UIControlStateNormal];
    self.floatData              = floatData;
    [self.btnItem setBackgroundImage:[UIImage imageNamed:@"white_hover.png"] forState:UIControlStateNormal];
    [self.btnItem setTitle:[Cell.btnItem titleForState:UIControlStateNormal] forState:UIControlStateNormal];
    self.hidden                 = FALSE;
    
    if (Cell.curTag == YES)
    {
        self.btnItem.titleLabel.textColor = RGBACOLOR(240, 5, 0, 1);
    }
}


- (void)stopFloat
{
    self.hidden = YES;
}

- (BOOL)isFloating      { return !self.hidden;}


- (void)dealloc
{
    [_floatData release];
    [super dealloc];
}
@end
