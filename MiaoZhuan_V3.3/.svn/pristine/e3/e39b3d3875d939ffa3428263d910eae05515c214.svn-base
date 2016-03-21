//
//  SysSendCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SysSendCell.h"

@implementation SysSendCell

+ (instancetype)newInstance{
    SysSendCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SysSendCell" owner:self options:nil] firstObject];
    if (cell) {
        
    }
    return cell;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    if (!dataDic.dictionary.count) {
        return;
    }
    DictionaryWrapper *dic = [dataDic wrapper];
    _lblTitle.text = [dic getString:@"Name"];
    _lblTime.text = [[dic getString:@"RecordTime"] substringWithRange:NSMakeRange(11, 8)];;
    _lblNum.text = [NSString stringWithFormat:@"+%@",[dic getString:@"Integral"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_lblTitle release];
    [_lblTime release];
    [_lblNum release];
    [super dealloc];
}
@end
