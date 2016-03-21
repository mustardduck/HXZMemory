//
//  PayTypeCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PayTypeCell.h"

@implementation PayTypeCell

- (void)setDataDic:(NSDictionary *)dataDic{
    if (!dataDic.count) {
        return;
    }
    _imgIcon.image = [UIImage imageNamed:[dataDic valueForKey:@"Icon"]];
    
    NSString *name = [dataDic valueForKey:@"Type"];
    CGSize size = [UICommon getSizeFromString:name withSize:CGSizeMake(MAXFLOAT, 21) withFont:15];
    _lblType.width = size.width;
    
    _btnRecommand.left = _lblType.right + 4;
    
    if ([name isEqualToString:@"支付宝"] || [name isEqualToString:@"微信支付"]) {
        _btnRecommand.hidden = NO;
    } else {
        _btnRecommand.hidden = YES;
    }
    
    _lblType.text = name;
    _lblTypeDetail.text = [dataDic valueForKey:@"Detail"];
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
    [_imgIcon release];
    [_lblType release];
    [_lblTypeDetail release];
    [_btnSelection release];
    [_btnRecommand release];
    [super dealloc];
}
@end
