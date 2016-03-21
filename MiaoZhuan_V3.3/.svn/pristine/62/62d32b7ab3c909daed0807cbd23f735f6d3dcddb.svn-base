//
//  YiHuoMaTableViewCell.m
//  miaozhuan
//
//  Created by apple on 15/6/19.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "YiHuoMaTableViewCell.h"

@implementation YiHuoMaTableViewCell

+ (instancetype)newInstance{
    YiHuoMaTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"YiHuoMaTableViewCell" owner:self options:nil] firstObject];
    if (cell) {
        
    }
    return cell;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    if (!dataDic.dictionary.count) {
        return;
    }
    DictionaryWrapper *dic = [dataDic wrapper];
    _titleLable.text = [dic getString:@"Name"];
    
    NSString * time = [dic getString:@"RecordTime"];
    time = [UICommon formatDate:time withRange:NSMakeRange(11, 8)];
    _timeLable.text = time;
    
    _contentLable.text = [dic getString:@"ConsumeGold"];
    
    double num = 0.00;
    
    num = [dic getDouble:@"BarterCode"];
    
    if(num > 0)
    {
        _numlable.text = [NSString stringWithFormat:@"+%0.2f", num];
    }
    else
    {
        _numlable.text = [NSString stringWithFormat:@"%0.2f", num];
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
    [_titleLable release];
    [_contentLable release];
    [_numlable release];
    [_timeLable release];
    [super dealloc];
}
@end
