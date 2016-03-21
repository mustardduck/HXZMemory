//
//  FansListCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "FansListCell.h"
#import "UIView+expanded.h"
@implementation FansListCell

+ (instancetype)newInstance{
    FansListCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"FansListCell" owner:self options:nil] firstObject];
    if (cell) {
        
    }
    return cell;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    if (!dataDic.dictionary.count) {
        return;
    }
    DictionaryWrapper *dic = dataDic.wrapper;
    [_headerImage requestWithRecommandSize:[dic getString:@"PictureUrl"]];
    
    [_headerImage roundCornerRadiusBorder];
    
    NSString *str = [dic getString:@"Name"];

    CGSize size = [UICommon getSizeFromString:str withSize:CGSizeMake(MAXFLOAT, 21) withFont:15];
    _lblName.width = size.width;
    _lblName.text = str;
    
    _imgVip.left = _lblName.right + 2;
    int level = [dic getInt:@"VipLevel"];
    _imgVip.image = [UIImage imageNamed:[NSString stringWithFormat:@"VIP%d.png",level]];
    
    int campaignLevel = [dic getInt:@"CampaignLevel"];
    _lblSourse.text = [NSString stringWithFormat:@"来自第%d层粉丝",campaignLevel];
    
    _lblNum.text = [NSString stringWithFormat:@"+%.2f",[dic getFloat:@"Integral"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_headerImage release];
    [_lblName release];
    [_imgVip release];
    [_lblSourse release];
    [_lblNum release];
    [super dealloc];
}
@end
