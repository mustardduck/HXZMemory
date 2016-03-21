//
//  CRButtonBox_ArrowButton.m
//  CRCoreUnit
//
//  Created by abyss on 14/12/20.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import "CRButtonBox_ArrowButton.h"
#import "CRArrow.h"
#import "CALayer+Strategy.h"

@interface CRButtonBox_ArrowButton () <CRArrowDelegate>
//@property (retain) CRArrow*     arrow;
{
    UIImageView *_arrView;
}
//@property (retain) UIImage*     arrow;
@property (retain) NSString*    placeTitle;
@end
@implementation CRButtonBox_ArrowButton
@synthesize selected = _selected;

- (void)dealloc
{
    CRDEBUG_DEALLOC();
    
    [_arrView release];
//    [_arrow release];
//    _add_delegate = nil;
//    [_arrow release];
    
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - 12, 0, 0);
//        _arrow = [[UIImage alloc] init];
//        _arrow = [UIImage imageNamed:@"ads_list_down"];
//        _arrow =
        _arrView = STRONG_OBJECT(UIImageView, init);
        _arrView.image = [UIImage imageNamed:@"down"];
        [self addSubview:_arrView];
//        _arrow = [[CRArrow alloc] initWithType:CRArrowLayerTypeBottom delegate:self];
//        _arrow.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    _placeTitle = title;
    [_placeTitle retain];
    
    [self layoutSubviews];
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;

    NSMutableAttributedString *string1 = [[[NSMutableAttributedString alloc] initWithString:_placeTitle attributes:@{NSFontAttributeName:Font(14),NSForegroundColorAttributeName:AppColorRed}] autorelease];
    NSMutableAttributedString *string2 = [[[NSMutableAttributedString alloc] initWithString:_placeTitle attributes:@{NSFontAttributeName:Font(14),NSForegroundColorAttributeName:AppColorBlack43}] autorelease];
    [self setAttributedTitle:string2 forState:UIControlStateNormal];
    [self setAttributedTitle:string1 forState:UIControlStateSelected];
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - 3, 0, 0);
    
    
    if (_selected)
    {
//        [_arrow setUp];
        _arrView.image = [UIImage imageNamed:@"ads_list_up"];
    }
    else
    {
//        [_arrow setDown];
        _arrView.image = [UIImage imageNamed:@"down"];
    }
    
    if (_add_delegate && [_add_delegate respondsToSelector:@selector(button:)])
    {
        [_add_delegate button:self];
    }
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = CGSizeZero;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - 12, 0, 0);
    if([UICommon getSystemVersion] >= 7.0)
        size = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    else
        size = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    
    {
        CGFloat left    = ( self.width - size.width )/2 + 1;
        _arrView.frame  = CGRectMake(left + size.width - 5, 14, 10, 6);
        [_arrView.layer needsDisplay];
    }
}

//- (void)buttonAdditonTarget:(CRButtonBox_ArrowButton *)button
//{
//    self.selected   = !_selected;
//    
//    if (_add_delegate && [_add_delegate respondsToSelector:@selector(button:)])
//    {
//        [_add_delegate button:self];
//    }
//}

@end
