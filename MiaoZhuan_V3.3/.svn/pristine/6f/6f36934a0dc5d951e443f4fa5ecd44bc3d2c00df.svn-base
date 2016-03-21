//
//  MyGoldCirculateRecordsCell.m
//  miaozhuan
//
//  Created by momo on 14-12-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyGoldCirculateRecordsCell.h"

@implementation MyGoldCirculateRecordsCell

+ (instancetype)newInstance{
    MyGoldCirculateRecordsCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MyGoldCirculateRecordsCell" owner:self options:nil] firstObject];
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
    
    NSString * name = [dic getString:@"Name"];
    int type = [dic getInt:@"Type"];
    
    if(type == 1)
    {
        name = [NSString stringWithFormat:@"赠送给好友 %@", name];
    }
    else if (type == 2)
    {
        name = [NSString stringWithFormat:@"好友 %@ 向您赠送", name];
    }
    else
    {
        name = @"其他";
    }
    _lblTitle.text = name;
    
    NSString * time = [dic getString:@"RecordTime"];
    time = [UICommon formatDate:time withRange:NSMakeRange(11, 8)];
    _lblTime.text = time;
    
    double num = [dic getDouble:@"GoldNumber"];
    if(num > 0)
    {
        _lblNum.text = [NSString stringWithFormat:@"+%0.2f", num];
    }
    else
    {
        _lblNum.text = [NSString stringWithFormat:@"%0.2f", num];
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
