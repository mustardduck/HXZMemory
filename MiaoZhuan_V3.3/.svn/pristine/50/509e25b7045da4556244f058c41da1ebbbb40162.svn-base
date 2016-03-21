//
//  PutInCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-10-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PutInCell.h"

@implementation PutInCell

+ (instancetype)newInstance{
    PutInCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PutInCell" owner:self options:nil] firstObject];
    if (cell) {
        
    }
    return cell;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    if (!dataDic.dictionary.count) {
        return;
    }
    DictionaryWrapper *dic = [dataDic wrapper];
    [_imgLogo requestWithRecommandSize:[dic getString:@"PictureUrl"]];
    
    _imgLogo.layer.masksToBounds = YES;
    _imgLogo.layer.borderWidth = 0.5f;
    _imgLogo.layer.borderColor = AppColor(197).CGColor;
    
    [_lblSubTitle setText:[dic getString:@"Slogen"]];
    
    CGSize size = [UICommon getSizeFromString:[dic getString:@"Name"] withSize:CGSizeMake(_lblTitle.width, MAXFLOAT) withFont:14];
    if (size.height > 21) {
        _lblTitle.height = size.height > 38 ? 38 : size.height;
    } else {
        _lblTitle.top = 45;
    }
    _lblSubTitle.top = _lblTitle.bottom;
    
    _lblTitle.text = [dic getString:@"Name"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_imgLogo release];
    [_lblTitle release];
    [_lblSubTitle release];
    [_line release];
    [super dealloc];
}
@end
