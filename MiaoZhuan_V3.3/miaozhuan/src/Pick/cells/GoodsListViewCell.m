//
//  GoodsListViewCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-10-28.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "GoodsListViewCell.h"

@implementation GoodsListViewCell

+ (instancetype)newInstance{
    GoodsListViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsListViewCell" owner:self options:nil] firstObject];
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
    
    self.imgIcon.layer.masksToBounds = YES;
    self.imgIcon.layer.borderWidth = 0.5f;
    self.imgIcon.layer.borderColor = AppColor(197).CGColor;
    
    DictionaryWrapper *dic = [dataDic wrapper];
    CGSize size = [UICommon getSizeFromString:[dic getString:@"Name"] withSize:CGSizeMake(_lblName.width, MAXFLOAT) withFont:15];
    if (size.height > 21) {
        _lblName.height = size.height > 35 ? 35 : size.height;
        _lblName.top = 18;
        _priceview.top = 56;
    }
    
    [_imgIcon requestWithRecommandSize:[dic getString:@"PictureUrl"]];
    _lblName.text = [dic getString:@"Name"];
    _lblNeedPay.text = [dic getString:@"UnitIntegral"];
    _lblWorth.text = [NSString stringWithFormat:@"￥%.2f",[dic getFloat:@"UnitPrice"]];
}

- (void)dealloc {
    [_imgIcon release];
    [_lblName release];
    [_lblNeedPay release];
    [_lblWorth release];
    [_priceview release];
    [_lineview release];
    [super dealloc];
}
@end
