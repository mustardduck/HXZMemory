//
//  ConsumptionCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ConsumptionCell.h"
#import "UIView+expanded.h"

@implementation ConsumptionCell

+ (instancetype)newInstance{
    ConsumptionCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ConsumptionCell" owner:self options:nil] firstObject];
    if (cell) {
        
    }
    return cell;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    if (!dataDic.dictionary.count) {
        return;
    }
    DictionaryWrapper *dic = dataDic.wrapper;
    
    [_headImageView requestWithRecommandSize:[dic getString:@"PictureUrl"]];
    _headImageView.layer.borderWidth = 0.5;
    _headImageView.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    _lblTitle.text = [dic getString:@"SuperName"];
    _lblMethod.text = [dic getString:@"Name"];
    _lblTime.text = [[dic getString:@"RecordTime"] substringWithRange:NSMakeRange(11, 8)];
    if ([dic getInt:@"Integral"] > 0) {
        _lblNum.text = [NSString stringWithFormat:@"+%@", [dic getString:@"Integral"]];
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
    [_dataDic release];
    [_headImageView release];
    [_lblTitle release];
    [_lblMethod release];
    [_lblTime release];
    [_lblNum release];
    [super dealloc];
}
@end
