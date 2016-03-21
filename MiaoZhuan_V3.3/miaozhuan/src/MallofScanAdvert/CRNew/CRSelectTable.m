//
//  CRSelectTable.m
//  miaozhuan
//
//  Created by abyss on 14/12/23.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CRSelectTable.h"

CGFloat CRSeletctTable_CellHeight = 45.f;
@interface CRSelectTable () <UITableViewDataSource,UITableViewDelegate>
@property (retain) UITableView* tableView;
@end
@implementation CRSelectTable

- (void)dealloc
{
    CRDEBUG_DEALLOC();
    
    [_tableView release];
    [_buttonArray release];
    
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<CRSeletctTableDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setCr_delegate:delegate];
        _tableView = STRONG_OBJECT(UITableView, initWithFrame:self.bounds);
        
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBackgroundColor:AppColorBackground];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
//        self.buttonArray = @[@"1",@"1",@"1"];;
        {
            
            
            _cover = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 320, 20));
            _cover.backgroundColor = AppColorBackground;
            
            
            UIView* view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 320, 0.5));
            view.backgroundColor = AppColor(204);
            [_cover addSubview:view];
            
            UIImageView* img = WEAK_OBJECT(UIImageView, init);
            img.image = [UIImage imageNamed:@"selectCategoryBottom"];
            img.size = CGSizeMake(25, 6);
            img.center = CGPointMake(160, 10);
            [_cover addSubview:img];
            img.userInteractionEnabled = YES;
            [self addSubview:_cover];
        }
        _cover.userInteractionEnabled = YES;
        [self addSubview:_tableView];
        [self setBackgroundColor:AppColorBackground];
    }
    return self;
}

- (void)setButtonArray:(NSArray *)buttonArray
{
    _buttonArray = buttonArray;
    [_buttonArray retain];
    
    if (_buttonArray)
    {
        [_tableView reloadData];
        
        CGFloat height = MIN(CRSeletctTable_CellHeight * [_buttonArray count], SCREENHEIGHT - self.top - 20);
        ;
        _cover.top = height;
        [_tableView setHeight:height];
        [_tableView setBounces:NO];
    }
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return _buttonArray.count;}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath { return CRSeletctTable_CellHeight;}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SelectCRTable = @"SelectCRTable";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectCRTable];
    
    UIView *line        = nil;
    UIImageView *gougou = nil;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = AppColorWhite;
        //custom Cell
        
        cell.textLabel.font         = Font(14.f);
        cell.textLabel.textColor    = AppColorBlack43;
        
        {
            line                    = WEAK_OBJECT(UIView,initWithFrame:CGRectMake(15, 44.5, 320, 0.5));
            line.backgroundColor    = RGBCOLOR(235, 235, 235);
            
            gougou          = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(320 - 40, 17.5, 13, 10));
            gougou.image    = [UIImage imageNamed:@"ads_list_right@2x.png"];
            gougou.tag      = 999;
            gougou.hidden   = YES;
        }
        
        [cell.contentView addSubview:line];
        [cell.contentView addSubview:gougou];
    }
    
    cell.textLabel.text = [[_buttonArray[indexPath.row] wrapper] getString:@"Name"]
    ;
    if (indexPath.row == _buttonArray.count - 1) line.left = 0;
    if (indexPath.row == _selectCell)
    {
//        NSIndexPath *selectPath = [NSIndexPath indexPathForRow:_selectCell inSection:0];
//        [self tableView:tableView didSelectRowAtIndexPath:selectPath];
        
        for (UIView *viw in cell.contentView.subviews)
        {
            if (viw.tag == 999) viw.hidden = NO;
        }
        cell.textLabel.textColor = AppColorRed;
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *hcell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_selectCell inSection:0]];
    for (UIView *viw in hcell.contentView.subviews)
    {
        if (viw.tag == 999)
        {
            hcell.textLabel.textColor = AppColorBlack43;
            viw.hidden = YES;
        }
    }
    for (UIView *viw in cell.contentView.subviews)
    {
        if (viw.tag == 999) viw.hidden = NO;
    }
    cell.textLabel.textColor = AppColorRed;
    
    if (_cr_delegate && [_cr_delegate respondsToSelector:@selector(selectTable:didSelectedAt:with:)])
    {
        [_cr_delegate selectTable:self didSelectedAt:indexPath.row with:cell.textLabel.text];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    for (UIView *viw in cell.contentView.subviews)
    {
        if (viw.tag == 999) viw.hidden = YES;
    }
    cell.textLabel.textColor = AppColorBlack43;
}

@end