//
//  BuyAdsListCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BuyAdsListCell.h"

@implementation BuyAdsListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataDic:(NSDictionary *)dataDic{
    if (!dataDic.count) {
        return;
    }
    DictionaryWrapper *dic = [dataDic wrapper];
    _lblAdsCount.text = [NSString stringWithFormat:@"%@条", [dic getString:@"Count"]];
    int cheap = [dic getDouble:@"Off"];
    if (cheap) {
        _lblCheap.text = [NSString stringWithFormat:@"立省%d元", cheap];
    }
    NSString *price = [NSString stringWithFormat:@"￥%@", [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[dic getDouble:@"Amount"] withAppendStr:@""]];
    CGSize size = [UICommon getSizeFromString:price withSize:CGSizeMake(MAXFLOAT, 21) withFont:11];
    
    _btnClicked.width = size.width + 15;
    _btnClicked.titleLabel.textAlignment = UITextAlignmentCenter;
    _btnClicked.left = SCREENWIDTH - size.width - 30;
    [_btnClicked setContentEdgeInsets:UIEdgeInsetsMake(1, 0, 0, 0)];
    [_btnClicked setTitle:price forState:UIControlStateNormal];
    [_btnClicked setRoundCorner];
    _btnClicked.layer.borderWidth = 0.5;
    _btnClicked.layer.borderColor = RGBCOLOR(250, 4, 0).CGColor;
    
}

- (void)dealloc {
    [_dataDic release];
    [_lblAdsCount release];
    [_lblCheap release];
    [_lblPrice release];
    [_btnClicked release];
    [super dealloc];
}
@end
