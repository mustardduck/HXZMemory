//
//  AreaListCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AreaListCell.h"

@implementation AreaListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _lblArea.text = [[dataDic wrapper] getString:@"Name"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_lblArea release];
    [_btnSelected release];
    [_imgArrow release];
    [_line release];
    [super dealloc];
}
@end
