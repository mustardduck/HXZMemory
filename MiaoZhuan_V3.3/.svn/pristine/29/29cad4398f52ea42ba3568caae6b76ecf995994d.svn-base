//
//  SingleChooseCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SingleChooseCell.h"

@implementation SingleChooseCell

+ (instancetype)newInstance{
    SingleChooseCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SingleChooseCell" owner:self options:nil] firstObject];
    if (self) {
        
    }
    return cell;
}

- (void)setDataDic:(DictionaryWrapper *)dataDic{
    [_btnItem setTitle:[dataDic getString:@"Answer"] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc{
    [_dataDic release];
    [_btnItem release];
    [_imgRight release];
    [super dealloc];
}

@end
