//
//  AreaTitleCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AreaTitleCell.h"

@implementation AreaTitleCell

- (void)setDataArray:(NSArray *)dataArray{
    
    self.lineview.top = 49.5;
    
    _lblTitle.text = dataArray[0];
    NSString *content = dataArray[1];
    if (![content isEqualToString:@"未设置"]) {
        _lblContent.textColor = RGBCOLOR(34, 34, 34);
    } else {
        _lblContent.textColor = RGBCOLOR(204, 204, 204);
    }
    _lblContent.text = content;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_dataArray release];
    [_lblTitle release];
    [_lblContent release];
    [_areaSwitch release];
    [_lblSwitch release];
    [_lineview release];
    [super dealloc];
}
@end
