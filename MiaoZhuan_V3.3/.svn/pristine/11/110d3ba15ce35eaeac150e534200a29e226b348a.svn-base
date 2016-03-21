//
//  MoreChooseCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MoreChooseCell.h"

@implementation MoreChooseCell

+ (instancetype)newInstance{
    MoreChooseCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MoreChooseCell" owner:self options:nil] firstObject];
    if (self) {
        
    }
    return cell;
}

- (void)setDataDic:(DictionaryWrapper *)dataDic{
    _lblItemName.text = [dataDic getString:@"Answer"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_lblItemName release];
    [_btnSelected release];
    [super dealloc];
}
@end
