//
//  MyGoldConsumptionCell.m
//  miaozhuan
//
//  Created by momo on 14-12-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyGoldConsumptionCell.h"

@implementation MyGoldConsumptionCell

+ (instancetype)newInstance{
    MyGoldConsumptionCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MyGoldConsumptionCell" owner:self options:nil] firstObject];
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
    
    _lblTitle.text = [dic getString:@"TypeName"];
    _lblMethod.text = [dic getString:@"Name"];
    
    NSString * time = [dic getString:@"RecordTime"];
    time = [UICommon formatDate:time withRange:NSMakeRange(11, 8)];
    _lblTime.text = time;
    
    double num = 0.00;
    
    if (_type == 1)
    {
         num = [dic getDouble:@"GoldNumber"];
    }
    else
    {
        num = [dic getDouble:@"BarterCode"];
    }
   
    if(num > 0)
    {
        _lblNum.text = [NSString stringWithFormat:@"+%.2f", num];
    }
    else
    {
        _lblNum.text = [NSString stringWithFormat:@"%.2f", num];
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
