//
//  CRHeaderView.m
//  CRCoreUnit
//
//  Created by abyss on 14/12/11.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import "CRHeaderView.h"
//#import "Define+Structer.h"
//#import "Define+Debug.h"
//#import "Define+UIBox.h"

#import "CRArrow.h"
#import "CRButtonContainer.h"
#import "Define+RCMethod.h"
#import "CALayer+Strategy.h"

CGFloat CRHeaderView_Default_Height = 40.f;
CGFloat CRHeaderView_Default_Line_Height = 2.f;
CGFloat CRHeaderView_Default_Line_ExtraWidth = 20.f;
CGFloat CRHeaderView_Default_Separator_Height = .5f;

@interface CRHeaderView () <CRArrowDelegate,CRButtonContainerDelegate>
{
    Class                  _buttonClass;
    
    CGFloat                _viewHeight;
    CGFloat                _scrollWidth;
    
    CRArrow*               _arrowLayer;
    CALayer*               _lineLayer;
    CALayer*               _separator;
}
@property (retain) CRButtonContainer *buttonContainer;
@end
@implementation INSTANCE_CLASS_SETUP(CRHeaderView)

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
    _arrowLayer         = nil;
    _lineLayer          = nil;
    _buttonClass        = _buttonContainer.buttonClass;
    
    self.lineWidthFit   = YES;
    self.hasLine        = YES;
    self.equalButtonWidh= YES;
    self.hasSeparator   = YES;
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator   = NO;
    self.opaque = YES;
    self.layer.masksToBounds = NO;
    
    self.panGestureRecognizer.delaysTouchesBegan = YES;
}

- (instancetype)initWithFrame:(CGRect)frame with:(NSArray *)buttonArray delegate:(id<CRHeaderViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setCr_delegate:delegate];
        
        _buttonContainer = OBJECT_NEW_STRONG(CRButtonContainer, initWith:[buttonArray copy] delegate:self height:self.height);

        [self setup];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    _buttonContainer.needAutoawak = _startPage;
    APP_ASSERT(cr_buttonObjectArray && [cr_buttonObjectArray count] > 0);
    _realHeight = _viewHeight + _lineLayer.height + CRHeaderView_Default_Separator_Height;
    
    CGFloat buttonWidth = ( self.width+(_hasArrow?-_arrowLayer.width:0) )/[cr_buttonObjectArray count];
    
    {
        if (_equalButtonWidh)
        {
            [self layoutButtons:buttonWidth];
        }
#warning fix soon <不定长滑动scroll>
        else
        {
            [self layoutButtons:-1];
        }
    }
    
    if(_arrowLayer)
    {
        [_arrowLayer setFrame:CGRectMake(SCREENWIDTH - self.height + self.contentOffset.x, 0, self.height, self.height)];
        [self bringSubviewToFront:_arrowLayer];
    }
    _separator.width = _separator.width + self.contentSize.width;
    
    if(!_cancelAutoAwak) [_buttonContainer needAutoawakNow];
}

#pragma mark - setter

- (void)setHasArrow:(BOOL)hasArrow
{
    _hasArrow = hasArrow;
    if (!hasArrow)
    {
        if (_arrowLayer) _arrowLayer.hidden = YES;
        return;
    }
    
    _arrowLayer = OBJECT_NEW_WEAK(CRArrow, initWithType:CRArrowLayerTypeBottom delegate:self);
    [_arrowLayer setFrame:CGRectMake(SCREENWIDTH - 40, (self.height - 40)/2.f, 40, 40)];
    
    [self addSubview:_arrowLayer];
}

- (void)setHasLine:(BOOL)hasLine
{
    _hasLine = hasLine;
    if (!hasLine)
    {
        if (_lineLayer)
        {
            _lineLayer.hidden = YES;
            _realHeight -= _lineLayer.height;
            _separator.top -= _lineLayer.height;
        }
        return;
    }
    
    _lineLayer = [CALayer layer];
    
    _lineLayer.size            = CGSizeMake(0, CRHeaderView_Default_Line_Height);
    _lineLayer.backgroundColor = [UIColor redColor].CGColor;
    
    [self.layer addSublayer:_lineLayer];
}

- (void)setHasSeparator:(BOOL)hasSeparator
{
    _hasSeparator = hasSeparator;
    if (!hasSeparator)
    {
        if (_separator)
        {
            _separator.hidden = YES;
            _realHeight -= _separator.height;
        }
        return;
    }
    
    CGRect   frame    = CGRectZero;
    CGFloat  height   = CRHeaderView_Default_Separator_Height;
    {
        frame = CGRectMake(- 100, _viewHeight + _lineLayer.height, SCREENWIDTH + 200, height);
        
        _separator = [CALayer layer];
        _separator.frame = frame;
        _separator.backgroundColor = AppColor(197).CGColor;
    }
    
    [self.layer addSublayer:_separator];
}

- (void)setNeedCheckReTouch:(BOOL)needCheckReTouch
{
    _needCheckReTouch = needCheckReTouch;
    _buttonContainer.needCheckReTouch = _needCheckReTouch;
}

#pragma mark - Event

- (void)buttonContainer:(CRButtonContainer *)view button:(id)button shouldResponseButtonTouchAt:(NSInteger)buttonIndex
{
    [self configureCurrentLineAt:button];
    
    if (_cr_delegate && [_cr_delegate respondsToSelector:@selector(headerView:button:didTouchedAt:)])
    {
        [_cr_delegate headerView:self button:button didTouchedAt:buttonIndex];
    }
}

#pragma mark - private
#pragma mark - LayoutButtons
- (void)layoutButtons:(CGFloat)buttonWidth
{
    if (0 == buttonWidth) LOG_DBUG(@"button width is nil");
    
    for (int i = 0; i < [cr_buttonObjectArray count]; i++)
    {
        if (!_equalButtonWidh)
        {
            buttonWidth = ((UIButton *)cr_buttonObjectArray[i]).width;
            if (0 == buttonWidth) LOG_DBUG(@"button width is nil");
        }
        
        CGRect frame = CGRectZero;
        {
            CGFloat left = i * buttonWidth;
            frame = CGRectMake(left, 0, buttonWidth, _viewHeight);
        }
        
        ((UIButton *)cr_buttonObjectArray[i]).frame = frame;
        [self addSubview:((UIButton *)cr_buttonObjectArray[i])];
    }
    
    //Configure ScrollWidth
    if ( 0 == _scrollWidth)
    {
        for (id objct in self.subviews)
        {
            if ( [objct isKindOfClass:_buttonClass])
            {
                _scrollWidth += ((UIButton *)objct).width;
            }
        }
        
        [self setHeight:_realHeight];
        [self.layer needsDisplay];
        [self setContentSize:CGSizeMake(_scrollWidth, _realHeight)];
    }
}

#pragma mark - CreateButton
- (UIButton *)buttonContainer:(CRButtonContainer *)view willbuttonCustomBy:(CGFloat)height
{
    UIButton *button = nil;
    
    if (_cr_delegate && [_cr_delegate respondsToSelector:@selector(headerView:buttonNeedCustomAt:)])
    {
        button = [_cr_delegate headerView:self buttonNeedCustomAt:self.height];
    }
    
    if (!button) button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _viewHeight = MAX(self.height, button.height);
    
    _buttonClass = [button class];
        
    return button;
}

#pragma mark - LayoutButton
- (UIButton *)buttonContainer:(CRButtonContainer *)view the:(UIButton *)button shouldLayoutBy:(NSDictionary *)data
{
    APP_ASSERT(data);
    
    NSString *title = [data objectForKey:@"title"];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    
    if (_cr_delegate && [_cr_delegate respondsToSelector:@selector(headerView:button:shouldLayout:)])
    {
        if (![_cr_delegate headerView:self button:button shouldLayout:data])
        {
            goto DEAFAULT_SETTING;
        }
        button = [_cr_delegate headerView:self button:button shouldLayout:data];
    }
    else
    {
    DEAFAULT_SETTING:
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:Font(14),NSForegroundColorAttributeName:AppColorBlack43}];
            [button setAttributedTitle:string forState:UIControlStateNormal];
            [string release];
            
            NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:Font(17),NSForegroundColorAttributeName:AppColorRed}];
            [button setAttributedTitle:string1 forState:UIControlStateSelected];
            [string1 release];
        }
    }
    
    return button;
}

#pragma mark - LayoutLine
- (void)configureCurrentLineAt:(UIButton *)button
{
    if (CGRectIsEmpty(button.bounds) && !_equalButtonWidh) LOG_WARN(@"button frame is nil");
    
    if (_lineLayer)
    {
        CGSize size = CGSizeZero;
        
        if([UICommon getSystemVersion] >= 7.0)
            size = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
        else
            size = [button.titleLabel.text sizeWithFont:button.titleLabel.font];
        
        CGFloat w = _lineWidthFit ? size.width + CRHeaderView_Default_Line_ExtraWidth:button.width;
        CGFloat x = button.frame.origin.x + button.width/2 - w/2;
        CGFloat h = _lineLayer.height;
        CGFloat y = _viewHeight;
        _lineLayer.frame = CGRectMake(x, y, w, h);
    }
}

#pragma mark - delegate

- (void)arrow:(CRArrow *)arrow click:(BOOL)open
{
    if (open)
    {
    }
}
@end
