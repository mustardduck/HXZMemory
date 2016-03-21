//
//  CRTableSectionBar.m
//  miaozhuan
//
//  Created by abyss on 15/1/23.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "CRTableSectionBarController.h"

CGFloat CRTS_Callout_Padding    = 0;
CGFloat CRTS_FixTop             = 20;

@interface CRTableSectionBarController()
{
    CGFloat _fixheight;
    CGFloat _padding;
    
    NSInteger _highlightedSection;
    
    UIView* _callout;
    
    float   _fatherLeft;
    float   _fatgerTop;
}
@property (retain, nonatomic) NSMutableArray* sectionArray;

- (void)layoutSections;
- (void)highlightItemAtSection:(NSInteger)section;
- (void)unhighlightAllSections;
- (void)selectedSection:(NSInteger)selectedSection;
@end
@implementation CRTableSectionBarController

- (void)dealloc
{
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _sectionArray = [NSMutableArray new];
        
        self.clipsToBounds = NO;
        _showCallout = YES;
//        self.backgroundColor = AppColorRed;
        
        _padding     = CRTS_Callout_Padding;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

//    [self layoutSections];
    [self layoutPosition];
    [self reloadData];
}

- (void)layoutPosition
{
    if (_position == CRTablePositionRight)
    {
        _fatherLeft = self.superview.left + (self.superview.width - self.width);
        _fatgerTop = self.superview.top;
    }
    else
    {
        _fatherLeft = self.superview.left;
        _fatgerTop = self.superview.top;
    }
}

- (void)reloadData
{
    //clean
    {
        for (UIView *sectionView in _sectionArray)
        {
            [sectionView removeFromSuperview];
        }
        [_sectionArray removeAllObjects];
    }
    
    //getData
    {
        if (_delegate && [_delegate respondsToSelector:@selector(numberOfSectionsInSectionSelectionView:)]) {
            _numOfItems = [_delegate numberOfSectionsInSectionSelectionView:self];
            NSLog(@" ------- >%d",_numOfItems);
        }
        
        for (int section = 0; section < _numOfItems; section++)
        {
            
            if (_delegate && [_delegate respondsToSelector:@selector(sectionSelectionView:sectionSelectionItemViewForSection:)])
            {
                CRTableSectionBarItem *sectionView = [_delegate sectionSelectionView:self sectionSelectionItemViewForSection:section];
                sectionView.section = section;
                
                [_sectionArray addObject:sectionView];
                [self addSubview:sectionView];
                
            }
        }
    }
    
    [self layoutSections];
}

- (void)layoutSections
{
    CGFloat yOffset = 0;
    
    self.frame = CGRectMake(_fatherLeft, _fatgerTop + CRTS_FixTop, self.width, SCREENHEIGHT);
    for (UIView *sectionView in _sectionArray)
    {
        sectionView.frame = CGRectMake(0,yOffset, self.width, MAX(17,sectionView.height));
        yOffset += sectionView.height;
    }
    
    self.height = yOffset;
}

#pragma 点击效果

-(void)selectedSection:(NSInteger)selectedSection
{
    [self highlightItemAtSection:selectedSection];
    
    if (_showCallout)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(sectionSelectionView:callOutViewForSelectedSection:)]) {
            
            _callout = [_delegate sectionSelectionView:self callOutViewForSelectedSection:selectedSection];
            [self.superview addSubview:_callout];
            
            CRTableSectionBarItem *selectedSectionView = [_sectionArray objectAtIndex:selectedSection];
            
            CGFloat callOutHeight   = _callout.height;
            CGFloat centerY         = selectedSectionView.center.y;
            
            //居中
            if (centerY - callOutHeight/2 < 0)
            {
                centerY = callOutHeight/2;
            }
            
            if (selectedSectionView.center.y + callOutHeight/2 > selectedSectionView.height*[_sectionArray count])
            {
                centerY = selectedSectionView.height * [_sectionArray count] - callOutHeight/2;
            }
            
            switch (_position)
            {
                case CRTablePositionLeft:
                    
                    _callout.center = CGPointMake(0, centerY);
                    _callout.left   = self.left + 40;
                    break;
                case CRTablePositionRight:
                    
                    _callout.center = CGPointMake(0, centerY);
                    _callout.left   = self.left - selectedSectionView.width - 20;
                    break;
                default:
                    break;
            }
            
            _callout.top += (_fatgerTop + CRTS_FixTop);
        }
    }
    
    // Inform the delegate about the selection
    
    if (_delegate && [_delegate respondsToSelector:@selector(sectionSelectionView:didSelectSection:)])
    {
        [_delegate sectionSelectionView:self didSelectSection:selectedSection];
    }
}

-(void)unhighlightAllSections
{
    
    if (_showCallout)
    {
        // Remove the callout if it exists
        if (_callout) [_callout removeFromSuperview];
        _callout = nil;
    }
    
    for (CRTableSectionBarItem *sectionView in _sectionArray)
    {
        [sectionView setHighlighted:NO animated:NO];
    }
}

-(void)highlightItemAtSection:(NSInteger)section
{
    
    [self unhighlightAllSections];
    
    CRTableSectionBarItem *item = [_sectionArray objectAtIndex:section];
    
    [item setHighlighted:YES animated:YES];
}

#pragma mark - Touch handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    
    for (CRTableSectionBarItem *sectionView in _sectionArray)
    {
        if (CGRectContainsPoint(sectionView.frame, touchPoint))
        {
            [self selectedSection:sectionView.section];
            _highlightedSection = sectionView.section;
            return;
        }
    }
    _highlightedSection = -1; // nothing is highlighted
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    for (CRTableSectionBarItem *sectionView in _sectionArray)
    {
        if (CGRectContainsPoint(sectionView.frame, touchPoint))
        {
            // just highlight again if the section has changed
            if (sectionView.section != _highlightedSection) {
                [self selectedSection:sectionView.section];
                _highlightedSection = sectionView.section;
                
                return;
            }
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesCancelled:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self unhighlightAllSections];
    _highlightedSection = -1; // nothing is highlighted
}


#pragma mark --

+ (CRTableSectionBarController *)controllerFrom:(UITableView *)tableView
{
    return [CRTableSectionBarController controllerFrom:tableView on:CRTablePositionRight with:20.f];
}

+ (CRTableSectionBarController *)controllerFrom:(UITableView *)tableView
                                             on:(CRTablePosition)diretion
                                           with:(CGFloat)width
{
    CRTableSectionBarController* ret = STRONG_OBJECT(CRTableSectionBarController, init);
    [tableView.superview addSubview:ret];
    ret.position = diretion;
    ret.width    = width;
    return ret;
}

@end


@implementation CRTableSectionBarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
        
        _bgImgView = [[UIImageView alloc] init];
        [_contentView addSubview:_bgImgView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(12);
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = RGBACOLOR(101, 148, 248, 1);
        _titleLabel.highlightedTextColor = AppColorRed;
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [_contentView addSubview:_titleLabel];
        
    }
    return self;
}


-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
    [_titleLabel setHighlighted:highlighted];
    [_bgImgView setHighlighted:highlighted];
    
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [self setHighlighted:selected animated:animated];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _contentView.frame  = self.bounds;
    _bgImgView.frame    = self.contentView.bounds;
    _titleLabel.frame   = self.contentView.bounds;
    
}

@end