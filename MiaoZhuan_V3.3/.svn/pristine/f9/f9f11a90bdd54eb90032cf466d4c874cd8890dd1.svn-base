//
//  LevelsCell.m
//  miaozhuan
//
//  Created by 孙向前 on 15-3-12.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "LevelsCell.h"

@implementation LevelsCell

- (void)awakeFromNib {
    // Initialization code
    _lblRecFans.text = _lblTotalSilver.text = _lblVerFans.text = @"";
    _hoverView.hidden = YES;
    _btnUnlock.hidden = YES;
}

- (void)setDataDic:(DictionaryWrapper *)dataDic {
    if (!dataDic) {
        return;
    }
    
    //是否解锁
    BOOL isUnLocked = [dataDic getBool:@"IsUnLocked"];
    if (!isUnLocked) {
        _hoverView.hidden = NO;
        _btnUnlock.hidden = NO;
        _lblVerFans.textColor = AppColor(204);
        _lblRecFans.textColor = _lblTotalSilver.textColor = AppColor(204);
    } else {
        _lblRecFans.textColor = _lblTotalSilver.textColor = AppColor(34);
    }
    
    //粉丝数量
    _lblVerFans.text = [dataDic getString:@"VerifyCount"];
    _lblRecFans.text = [dataDic getString:@"FansCount"];
    
    _lblTotalSilver.text = [NSString stringWithFormat:@"%.2f", [dataDic getDouble:@"EarnByFans"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_lblRecFans release];
    [_lblVerFans release];
    [_lblTotalSilver release];
    [_hoverView release];
    [_btnUnlock release];
    [_lineView release];
    [super dealloc];
}
@end
