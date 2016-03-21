//
//  RankListCell.m
//  miaozhuan
//
//  Created by abyss on 14/10/21.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RankListCell.h"
#import "RankListModelViewController.h"

@interface RankListCell ()
@property (retain, nonatomic) IBOutlet UIImageView *line;
@end
@implementation RankListCell
@synthesize leftImg        = _leftImg;
@synthesize leftText       = _leftText;
@synthesize leftTitle      = _leftTitle;
@synthesize rightImg       = _rightImg;
@synthesize rightText      = _rightText;
@synthesize rightTitle     = _rightTitle;

- (void)awakeFromNib
{
    // Initialization code
    _line.width = .5f;
    
    UIImageView *line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(159.5, 0, 0.5, 90));
    [self.contentView addSubview:line];
    line.backgroundColor = RGBACOLOR(239, 239, 244, 1);
    if(!_last)
    {
        UIImageView *line_new = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, 89.5, 320, 0.5));
        [self.contentView addSubview:line_new];
        line_new.backgroundColor = RGBACOLOR(239, 239, 244, 1);
        [self.layer needsDisplay];
    }
    [_leftImg setRoundCornerAll];
    [_rightImg setRoundCornerAll];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [_leftImg release];
    [_leftTitle release];
    [_leftText release];
    
    [_rightImg release];
    [_rightTitle release];
    [_rightText release];
    
    [_leftButton release];
    [_rightButton release];
    
    [_leftView release];
    [_rightView release];
    [_line release];
    [super dealloc];
}

- (IBAction)leftButton:(id)sender
{
    [self eventCenterData:_leftDic];
}

- (IBAction)rightButton:(id)sender
{
    [self eventCenterData:_rightDic];
}

- (void)eventCenterData:(DictionaryWrapper *)dic
{
#warning 事件
    RankListModelViewController *model = [RankListModelViewController new];
    NSInteger tag = [dic getInteger:@"Type"];
    model.topDic = dic;
    model.categregyId = tag;
    switch (tag/100)
    {
        case 1:
        {
        }
        case 2:
        {
            
        }
        case 3:
        {
        }
        default:
            break;
    }
    [UI_MANAGER.mainNavigationController pushViewController:model animated:YES];
    model.hisData = _data;
    [model release];
}
@end
