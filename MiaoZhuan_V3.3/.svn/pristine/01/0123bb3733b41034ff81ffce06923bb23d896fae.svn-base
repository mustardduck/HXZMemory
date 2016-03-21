//
//  MyGoldMarketCell.m
//  miaozhuan
//
//  Created by momo on 14-12-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyGoldMarketCell.h"

@implementation MyGoldMarketCell

+ (instancetype)newInstance{
    MyGoldMarketCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MyGoldMarketCell" owner:self options:nil] firstObject];
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
    _headImageView.layer.borderColor = [UIColor borderPicGreyColor].CGColor;
    _headImageView.layer.borderWidth = 0.5f;
    
    _lblTitle.text = [dic getString:@"Name"];
    _lblMethod.text = [dic getString:@"UserName"];
    
    NSString * time = [dic getString:@"RecordTime"];
    time = [UICommon formatDate:time withRange:NSMakeRange(11, 8)];
    _lblTime.text = time;
    
    double num;
    
    if (_type == 4)
    {
        num = [dic getFloat:@"GoldNumber"];
    }
    else
    {
        num = [dic getFloat:@"BarterCode"];
    }
    
    if(num > 0)
    {
        _lblNum.text = [NSString stringWithFormat:@"+%0.2f", num];
    }
    else
    {
        _lblNum.text = [NSString stringWithFormat:@"%0.2f", num];
    }
    
    _lblOrder.text = [NSString stringWithFormat:@"订单编号：%@", [dic getString:@"OrderNumber"]];
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
    [_lblOrder release];
    [super dealloc];
}
@end
