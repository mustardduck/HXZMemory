//
//  CirculateRecordsCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-2.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CirculateRecordsCell.h"
#import "UIView+expanded.h"
@implementation CirculateRecordsCell

+ (instancetype)newInstance{
    CirculateRecordsCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"CirculateRecordsCell" owner:self options:nil] firstObject];
    if (cell) {
        
    }
    return cell;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    if (!dataDic.dictionary.count) {
        return;
    }
    DictionaryWrapper *dic = dataDic.wrapper;
    
    [_headerImg requestWithRecommandSize:[dic getString:@"PictureUrl"]];
    
    [_headerImg roundCornerRadiusBorder];
    
    if ([dic getInt:@"Type"] == 0)
    {
        _lblTitle.text = [dic getString:@"Name"];
    }
    else if ([dic getInt:@"Type"] == 1)
    {
        _lblTitle.text = [NSString stringWithFormat:@"赠送给好友 %@",[dic getString:@"Name"]];
    }
    else if ([dic getInt:@"Type"] == 2)
    {
        _lblTitle.text = [NSString stringWithFormat:@"好友 %@ 向您赠送",[dic getString:@"Name"]];
    }
    
    _lblTime.text = [[dic getString:@"RecordTime"] substringWithRange:NSMakeRange(11, 8)];
    if ([dic getInt:@"Integral"] >= 0) {
        _lblNum.text = [NSString stringWithFormat:@"+%@",[dic getString:@"Integral"]];
    } else {
        _lblNum.text = [dic getString:@"Integral"];
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_headerImg release];
    [_lblTitle release];
    [_lblTime release];
    [_lblNum release];
    [super dealloc];
}
@end
