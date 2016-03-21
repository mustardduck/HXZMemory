//
//  MyGoldAdvertCell.m
//  miaozhuan
//
//  Created by momo on 14-12-16.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyGoldAdvertCell.h"

@implementation MyGoldAdvertCell

+ (instancetype)newInstance{
    MyGoldAdvertCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MyGoldAdvertCell" owner:self options:nil] firstObject];
    if (cell) {
        
    }
    return cell;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    if (!dataDic.dictionary.count) {
        return;
    }
    
    DictionaryWrapper *dic = [dataDic wrapper];
    
    _typeNameLbl.text = [dic getString:@"TypeName"];
    if(_type == 7){
        _subNameLbl.text = @"发布商家优惠信息，扣除金币";
    }else if (_type == 8){
        _subNameLbl.text = @"发布招聘信息，扣除金币";
    }else if (_type == 9){
        _subNameLbl.text = @"发布招商信息，扣除金币";
    }else{
        _subNameLbl.text = [dic getString:@"SubName"];
    }
    
    _nameLbl.text = [dic getString:@"Name"];
    
    NSString * time = [dic getString:@"RecordTime"];
    time = [UICommon formatDate:time withRange:NSMakeRange(11, 8)];
    _recordTimeLbl.text = time;

    float num = [dic getFloat:@"GoldNumber"];
    
    NSString * text = [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:num withAppendStr:nil];;

    if(num > 0)
    {
        _goldNumberLbl.text = [NSString stringWithFormat:@"+%@", text];
    }
    else
    {
        _goldNumberLbl.text = [NSString stringWithFormat:@"%@", text];
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
    [_typeNameLbl release];
    [_subNameLbl release];
    [_nameLbl release];
    [_recordTimeLbl release];
    [_goldNumberLbl release];
    [super dealloc];
}
@end
