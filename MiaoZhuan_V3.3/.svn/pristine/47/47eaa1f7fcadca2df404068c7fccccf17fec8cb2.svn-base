//
//  MyGoldSystemSendCell.m
//  miaozhuan
//
//  Created by momo on 14-12-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyGoldSystemSendCell.h"

@implementation MyGoldSystemSendCell

+ (instancetype)newInstance{
    MyGoldSystemSendCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MyGoldSystemSendCell" owner:self options:nil] firstObject];
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
    
    NSString * time = [dic getString:@"RecordTime"];
    time = [UICommon formatDate:time withRange:NSMakeRange(11, 8)];
    _lblTime.text = time;
    
    double num = 0.00;
    
    if(_isYHM)
    {
        num = [dic getDouble:@"BarterCode"];
    }
    else
    {
        num = [dic getDouble:@"GoldNumber"];
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
    [_lblTitle release];
    [_lblTime release];
    [_lblNum release];
    [super dealloc];
}


-(CGFloat) getCellHeight:(NSDictionary *)dataDic{
    if (!dataDic.dictionary.count) {
        return 80;
    }
    DictionaryWrapper *dic = [dataDic wrapper];
    _lblTitle.text = [dic getString:@"Name"];
    
    NSString * time = [dic getString:@"RecordTime"];
    time = [UICommon formatDate:time withRange:NSMakeRange(11, 8)];
    _lblTime.text = time;
    
    double num = 0.00;
    
    if(_isYHM)
    {
        num = [dic getDouble:@"BarterCode"];
    }
    else
    {
        num = [dic getDouble:@"GoldNumber"];
    }
    
    if(num > 0)
    {
        _lblNum.text = [NSString stringWithFormat:@"+%0.2f", num];
    }
    else
    {
        _lblNum.text = [NSString stringWithFormat:@"%0.2f", num];
    }
    
    NSLog(@"[dic getString:@Name] :::%@",[dic getString:@"Name"]);
    CGSize size = [UICommon getSizeFromString:[dic getString:@"Name"]
                                         withSize:CGSizeMake(_lblTitle.width, MAXFLOAT)
                                         withFont:15];
    
    _lblTitle.frame = CGRectMake(_lblTitle.frame.origin.x, _lblTitle.frame.origin.y, size.width, size.height);
    
    _lblTime.frame = CGRectMake(_lblTime.frame.origin.x, _lblTitle.frame.origin.y + _lblTitle.frame.size.height + 10, _lblTime.frame.size.width, _lblTime.frame.size.height);
    
    CGFloat height = size.height + 69;
    return height;
    
}
@end
