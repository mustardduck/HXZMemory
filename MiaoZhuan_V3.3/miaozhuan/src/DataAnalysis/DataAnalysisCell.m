//
//  DataAnalysisCell.m
//  miaozhuan
//
//  Created by abyss on 14/11/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DataAnalysisCell.h"

@implementation DataAnalysisCell

- (void)awakeFromNib
{
    // Initialization code
    
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 119.5, 320, 0.5));
    view.backgroundColor = AppColor(204);
    [self.contentView addSubview:view];
    
    [self.layer needsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_titleL release];
    [_text1 release];
    [_text2 release];
    [_data1 release];
    [_data2 release];
    [_img release];
    [super dealloc];
}
@end
