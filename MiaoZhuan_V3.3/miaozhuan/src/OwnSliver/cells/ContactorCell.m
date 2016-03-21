//
//  ContactorCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-3.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ContactorCell.h"
#import "UIView+expanded.h"
@implementation ContactorCell

- (void)setDataDic:(NSDictionary *)dataDic {
    
    if (!dataDic.dictionary.count) {
        return;
    }
    DictionaryWrapper *dic = [dataDic wrapper];
    
    _lblName.text = [dic getString:@"Name"];
    _lblPhone.text = [dic getString:@"Phone"];
    [_headerImage requestWithRecommandSize:[dic getString:@"PictureUrl"]];
    
    if ([[dic getString:@"Name"] isEqualToString:@""])
    {
        _lblPhone.frame = CGRectMake(73, 29, 156, 21);
    }
    
    [_headerImage roundCornerRadiusBorder];
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
    [_headerImage release];
    [_lblName release];
    [_lblPhone release];
    [super dealloc];
}
@end
