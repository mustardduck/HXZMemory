//
//  MallGoodsCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-26.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MallGoodsCell.h"
#import "RRAttributedString.h"

@implementation MallGoodsCell

+ (instancetype)newInstance{
    MallGoodsCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MallGoodsCell" owner:self options:nil] firstObject];
    if (cell) {
        cell.line.top = 109.5f;
    }
    return cell;
}

- (void)setDataDic:(DictionaryWrapper *)dataDic{
    if (!dataDic.dictionary.count) {
        return;
    }
    DictionaryWrapper *dic = [dataDic wrapper];
    CGSize size = [UICommon getSizeFromString:[dic getString:@"Name"] withSize:CGSizeMake(_lblTitle.width, MAXFLOAT) withFont:16];
    if (size.height > 26) {
        _lblTitle.height = 38;
        _lblTitle.top = 25;
        _lblNeedPay.top = 67;
    }
    _imgPicture.layer.borderColor = RGBCOLOR(197, 197, 197).CGColor;
    _imgPicture.layer.borderWidth = 0.5;
    [_imgPicture requestWithRecommandSize:[dic getString:@"PictureUrl"]];
    _lblTitle.text = [dic getString:@"Name"];
    BOOL isGold = ([dic getInt:@"ProductType"] == 2);
    _imgType.image = [UIImage imageNamed:isGold ? @"mall_goldlogo.png" : @"mall_silverlogo.png"];
    NSString *str = @"";
    if (isGold) {
        str = [NSString stringWithFormat:@"所需易货码  %.2f", [dic getFloat:@"UnitPrice"]];
    } else {
        str = [NSString stringWithFormat:@"所需银元  %d", [dic getInt:@"UnitPrice"]];
    }
    NSAttributedString *attStr = [RRAttributedString setText:str font:Font(15) color:[UIColor redColor] range:NSMakeRange(5, str.length - 5)];
    _lblNeedPay.attributedText = attStr;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_imgType release];
    [_imgPicture release];
    [_lblTitle release];
    [_lblNeedPay release];
    [_line release];
    [super dealloc];
}
@end
