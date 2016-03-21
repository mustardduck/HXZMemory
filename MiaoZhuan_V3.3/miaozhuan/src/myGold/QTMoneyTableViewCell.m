//
//  QTMoneyTableViewCell.m
//  miaozhuan
//
//  Created by apple on 15/6/30.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "QTMoneyTableViewCell.h"

@implementation QTMoneyTableViewCell

+ (instancetype)newInstance{
    QTMoneyTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"QTMoneyTableViewCell" owner:self options:nil] firstObject];
    if (cell) {
        
    }
    return cell;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    if (!dataDic.dictionary.count) {
        return;
    }
    
    DictionaryWrapper *dic = dataDic.wrapper;
    
    _titlecell.text = [dic getString:@"MessionName"];
    
    NSString *account = [dic getString:@"Account"];
    
    //加星号, 6 : 前后3位字符显示
    if(account.length > 6)
    {
       NSString *subStr = [account substringWithRange:NSMakeRange(3, account.length - 6)];
        
        NSString *appending_char = @"";
        
        for(int i = 0; i < subStr.length; i++)
        {
           appending_char = [appending_char stringByAppendingString:@"*"];
        }
        
        _contentcell.text = [account stringByReplacingOccurrencesOfString:subStr withString:appending_char];
    }
    else
    {
        _contentcell.text = [dic getString:@"Account"];
    }
    
    NSString * time = [dic getString:@"Time"];
    if(time.length > 18)
        time = [UICommon formatDate:time withRange:NSMakeRange(11, 8)];
    else
        time = [UICommon formatDate:time withRange:NSMakeRange(11, 5)];
//    _titlecell.text = time;
    _timecell.text = time;
    
    float num = [dic getFloat:@"Amount"];
    
    
    if(num > 0)
    {
        _numcell.text = [NSString stringWithFormat:@"+%0.2f", num];
    }
    else
    {
        _numcell.text = [NSString stringWithFormat:@"%0.2f", num];
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
    [_titlecell release];
    [_numcell release];
    [_timecell release];
    [_contentcell release];
    [super dealloc];
}
@end
