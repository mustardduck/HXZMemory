//
//  SilverGoodsCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-10-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SilverGoodsCell.h"

@implementation SilverGoodsCell

+ (instancetype)newInstance{
    SilverGoodsCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SilverGoodsCell" owner:self options:nil] firstObject];
    if (cell) {
        
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setDataDic:(NSDictionary *)dataDic{
    if (!dataDic.dictionary.count) {
        return;
    }
    DictionaryWrapper *dic = [dataDic wrapper];
    CGSize size = [UICommon getSizeFromString:[dic getString:@"Name"] withSize:CGSizeMake(_lblName.width, MAXFLOAT) withFont:15];
    if (size.height > 21) {
        _lblName.height = size.height > 38 ? 38 : size.height;
        _lblName.top = 18;
        _priceview.top = 56;
    }
    
    [_imgIcon requestWithRecommandSize:[dic getString:@"PictureUrl"]];
    _imgIcon.layer.masksToBounds = YES;
    _imgIcon.layer.borderWidth = 0.5f;
    _imgIcon.layer.borderColor = AppColor(197).CGColor;
    
    _lblName.text = [dic getString:@"Name"];
    _lblNeedPay.text = [dic getString:@"UnitPrice"];
    _lblWorth.text = [NSString stringWithFormat:@"￥%.2f", [dic getFloat:@"MarketPrice"]];
}

- (void)dealloc {
    [_imgIcon release];
    [_lblName release];
    [_lblNeedPay release];
    [_lblWorth release];
    [_priceview release];
    [_line release];
    [super dealloc];
}

@end