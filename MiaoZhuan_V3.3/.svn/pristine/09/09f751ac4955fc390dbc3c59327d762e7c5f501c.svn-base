//
//  MallShopCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-26.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MallShopCell.h"

@implementation MallShopCell

+ (instancetype)newInstance{
    MallShopCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MallShopCell" owner:self options:nil] firstObject];
    if (cell) {
        cell.line.top = 109.5f;
    }
    return cell;
}

- (void)setDataDic:(DictionaryWrapper *)dataDic{
    
    if (!dataDic.dictionary.count) {
        return;
    }
    [_iconImg setRoundCorner:11.f];
    _lblCompany.text = [dataDic getString:@"Name"];
    [_iconImg requestPic:[dataDic getString:@"LogoUrl"] placeHolder:YES];
    _btnDirect.selected = [dataDic getBool:@"IsDirect"];
    _btnGolod.selected = [dataDic getBool:@"IsGold"];
    _btnSilver.selected = [dataDic getBool:@"IsSilver"];
    _btnVip.selected = [dataDic getBool:@"IsVip"];
    
    if (_btnVip.selected) {
        _lblCompany.textColor = AppColorRed;
    } else {
        _lblCompany.textColor = AppColor(34);
    }
    
    _lblDistance.text = [dataDic getString:@"DistanceRange"];
    _lblCompany.textColor = _btnVip.selected ? AppColorRed : AppColorBlack43;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_dataDic release];
    [_iconImg release];
    [_lblCompany release];
    [_btnVip release];
    [_btnSilver release];
    [_btnGolod release];
    [_btnDirect release];
    [_lblDistance release];
    [_line release];
    [super dealloc];
}
@end
