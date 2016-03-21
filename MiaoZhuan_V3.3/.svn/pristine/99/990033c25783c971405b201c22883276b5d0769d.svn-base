//
//  ManagerListCell.m
//  miaozhuan
//
//  Created by 孙向前 on 15/5/18.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "ManagerListCell.h"

@implementation ManagerListCell

- (void)awakeFromNib {
    // Initialization code
    
    _lblName.text = @"";
    _lblPhone.text = @"";
    [_iconImgView setRoundCorner:11];
    
}

- (void)setDataDic:(DictionaryWrapper *)dataDic {
    
    if (!dataDic) {
        return;
    }
    
    _lblPhone.text = [dataDic getString:@"Phone"];
    
    NSString *name = [dataDic getString:@"Name"];
    if (![name isEqualToString:@""] && name.length && [name isKindOfClass:[NSNull class]]) {
        name = [name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"*"];
    }
    _lblName.text = name;
    
    [_iconImgView requestWithRecommandSize:[dataDic getString:@"PictureUrl"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_lblName release];
    [_lblPhone release];
    [_iconImgView release];
    [_line release];
    [super dealloc];
}
@end
