//
//  LookAdsCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "LookAdsCell.h"
#import "UIView+expanded.h"

@implementation LookAdsCell

+ (instancetype)newInstance{
    LookAdsCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"LookAdsCell" owner:self options:nil] firstObject];
    if (cell) {
        
    }
    return cell;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    if (!dataDic.dictionary.count) {
        return;
    }
    
    DictionaryWrapper *dic = [dataDic wrapper];
    CGSize size = [UICommon getSizeFromString:[dic getString:@"Name"] withSize:CGSizeMake(_lblName.width, MAXFLOAT) withFont:15];
    if (size.height > 21) {
        _lblName.height = size.height > 37 ? 37 : size.height;
        _lblName.top = 22;
        _lblTime.top = 62;
    }
    
    [_iconimgView requestWithRecommandSize:[dic getString:@"PictureUrl"]];
    
    _iconimgView.layer.borderWidth = 0.5;
    _iconimgView.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    _lblName.text = [dic getString:@"Name"];
    _lblTime.text = [[dic getString:@"RecordTime"] substringWithRange:NSMakeRange(11, 8)];;
    _lblNum.text = [NSString stringWithFormat:@"+%@",[dic getString:@"Integral"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_iconimgView release];
    [_lblName release];
    [_lblTime release];
    [_lblNum release];
    [super dealloc];
}
@end
