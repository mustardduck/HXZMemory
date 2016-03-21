//
//  FansLevel1Cell.m
//  miaozhuan
//
//  Created by 孙向前 on 15-3-12.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "FansLevel1Cell.h"

@implementation FansLevel1Cell

- (void)awakeFromNib {
    // Initialization code
    [_btnNotice setRoundCorner];
    [_iconImg setRoundCorner];
    [_btnNotice.layer setBorderWidth:0.5];
    _lblIsConfirm.text = _lblName.text = _lblUnFansNum.text = _lblVerFansNum.text = @"";
}

- (void)setDataDic:(DictionaryWrapper *)dataDic{
    if (!dataDic) {
        return;
    }
    _lblVerFansNum.text = [NSString stringWithFormat:@"已发展合格粉丝：%@人", [dataDic getString:@"VerifyCount"]];
    _lblUnFansNum.text = [NSString stringWithFormat:@"未手机认证粉丝：%@人", [dataDic getString:@"UnVerifyCount"]];
    
    BOOL isVer = [dataDic getBool:@"IsVerified"];
    _lblIsConfirm.textColor = !isVer ? AppColorRed : AppColor(85);
    _lblIsConfirm.text = isVer ? @"已验证" : @"未验证";
    _btnNotice.hidden = isVer;
    
    [_iconImg requestWithRecommandSize:[dataDic getString:@"IconUrl"]];
    [_iconImg setRoundCorner:11];
    
    NSString *name = [dataDic getString:@"Name"];
     NSString *phone = [dataDic getString:@"Phone"];
    name = [NSString stringWithFormat:@"%@（%@）", name, phone];
    if (![[dataDic getString:@"Name"] isEqualToString:@"匿名用户"]) {
        name = [name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"*"];
    }
    
    CGSize size = [UICommon getSizeFromString:name withSize:CGSizeMake(MAXFLOAT, 21) withFont:15];
    _lblName.width = size.width;
    _imgVip.left = _lblName.right - 6;
    
    _lblName.text = name;
    NSInteger vipLevel = [dataDic getInt:@"VipLevel"];
    _imgVip.image = [UIImage imageNamed:[NSString stringWithFormat:@"VIP%d", vipLevel]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_lblIsConfirm release];
    [_iconImg release];
    [_lblName release];
    [_imgVip release];
    [_lblVerFansNum release];
    [_lblUnFansNum release];
    [_btnNotice release];
    [_lineview release];
    [super dealloc];
}
@end
