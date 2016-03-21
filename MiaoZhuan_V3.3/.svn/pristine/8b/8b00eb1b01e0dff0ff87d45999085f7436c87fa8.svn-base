//
//  BuyYiHuoEDuTableViewCell.m
//  miaozhuan
//
//  Created by apple on 15/6/3.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "BuyYiHuoEDuTableViewCell.h"

@implementation BuyYiHuoEDuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setDataDic:(NSDictionary *)dataDic{
    if (!dataDic.count) {
        return;
    }
    
    DictionaryWrapper *dic = [dataDic wrapper];

    _titleLableCell.text = [dic getString:@"Name"];

    NSString *price = [NSString stringWithFormat:@" ￥%@   ", [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[dic getDouble:@"TotalPrice"] withAppendStr:@""]];
    
    CGSize size = [UICommon getSizeFromString:price withSize:CGSizeMake(MAXFLOAT, 25) withFont:13];
    
    _buyBtnCell.width = size.width + 35;
    _buyBtnCell.titleLabel.textAlignment = UITextAlignmentCenter;
    _buyBtnCell.left = SCREENWIDTH - size.width - 30;
    [_buyBtnCell setContentEdgeInsets:UIEdgeInsetsMake(1, 0, 0, 0)];
    [_buyBtnCell setTitle:price forState:UIControlStateNormal];
    [_buyBtnCell setRoundCorner];
    _buyBtnCell.layer.borderWidth = 0.5;
    _buyBtnCell.layer.borderColor = RGBCOLOR(250, 4, 0).CGColor;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_titleLableCell release];
    [_buyBtnCell release];
    [_lineCell release];
    [super dealloc];
}
@end
