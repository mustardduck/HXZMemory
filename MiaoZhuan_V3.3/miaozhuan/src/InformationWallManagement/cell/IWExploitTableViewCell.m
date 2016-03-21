//
//  IWExploitIWTableViewCell.m
//  miaozhuan
//
//  Created by Junnpy Zhong on 15/5/14.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWExploitTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation IWExploitTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateContent:(DictionaryWrapper *)dic{
    [_imageView_User setImageWithURL:[NSURL URLWithString:[dic getString:@"IconUrl"]] placeholderImage:[UIImage imageNamed:@"Icon1024"]];
    [_label_Title1 setText:[dic getString:@"MessionName"]];
    
    NSRange range = {0,1};
    NSString *Name = [dic getString:@"Name"];
    Name = [Name stringByReplacingCharactersInRange:range withString:@"*"];
    NSString *Account = [dic getString:@"Account"];
    NSRange range2 = {3,4};
    Account = [Account stringByReplacingCharactersInRange:range2 withString:@"****"];
    NSString *title2 = [NSString stringWithFormat:@"%@(%@)",Name,Account];
    [_label_Title2 setText:title2];
    
    NSString *Time = [dic getString:@"Time"];
    NSArray *timeArr = [Time componentsSeparatedByString:@" "];
    if(timeArr.count == 2){
        Time = timeArr[1];
    }
    [_label_Title3 setText:Time];
    NSString *Amount = [dic getString:@"Amount"];
    Amount = [NSString stringWithFormat:@"+￥%@",Amount];
    [_label_Title4 setText:Amount];
}

@end
