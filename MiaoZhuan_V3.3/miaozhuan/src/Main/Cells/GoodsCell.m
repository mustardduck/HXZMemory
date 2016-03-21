//
//  GoodsCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-10-22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "GoodsCell.h"

@implementation GoodsCell

+ (instancetype)newInstance{
    GoodsCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCell" owner:self options:nil] firstObject];
    if (cell) {
        
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
    _v1.width = _v2.width = _v3.height = 0.5;
    _v3.top = _v1.height = _v2.height = 161.5;
    _v1.left = _v2.left = 106.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataArray:(NSArray *)dataArray{
    if (![dataArray[1] count] && ![dataArray[2] count]) {
        _followView.hidden = _lastView.hidden = YES;
    } else if (![dataArray[2] count]) {
        _lastView.hidden = YES;
        [_imgFollow requestWithRecommandSize:[[dataArray[1] wrapper] getString:@"Image"]];
        _lblNameFollow.text = [[dataArray[1] wrapper] getString:@"Name"];
        int type = [[dataArray[1] wrapper] getInt:@"Type"];
        _lblPriceFollow.text = [NSString stringWithFormat:@"%@%@", [[dataArray[1] wrapper] getString:@"Price"],(type ? @"易货码" : @"银元")];
    } else {
        [_imgFollow requestWithRecommandSize:[[dataArray[1] wrapper] getString:@"Image"]];
        _lblNameFollow.text = [[dataArray[1] wrapper] getString:@"Name"];
        int type = [[dataArray[1] wrapper] getInt:@"Type"];
        _lblPriceFollow.text = [NSString stringWithFormat:@"%@%@", [[dataArray[1] wrapper] getString:@"Price"],(type ? @"易货码" : @"银元")];
        
        [_imgLast requestWithRecommandSize:[[dataArray[2] wrapper] getString:@"Image"]];
        _lblNameLast.text = [[dataArray[2] wrapper] getString:@"Name"];
        int type1 = [[dataArray[2] wrapper] getInt:@"Type"];
        _lblPriceLast.text = [NSString stringWithFormat:@"%@%@", [[dataArray[2] wrapper] getString:@"Price"],(type1 ? @"易货码" : @"银元")];
        
    }
    [_ImgFront requestWithRecommandSize:[[dataArray[0] wrapper] getString:@"Image"]];
    _lblNameFront.text = [[dataArray[0] wrapper] getString:@"Name"];
    int type = [[dataArray[0] wrapper] getInt:@"Type"];
    _lblPriceFront.text = [NSString stringWithFormat:@"%@%@", [[dataArray[0] wrapper] getString:@"Price"],(type ? @"易货码" : @"银元")];
    
}

- (void)dealloc {
    _dataArray = nil;
    [_ImgFront release];
    [_imgFollow release];
    [_lblNameFront release];
    [_lblNameFollow release];
    [_lblPriceFront release];
    [_lblPriceFollow release];
    [_btnFront release];
    [_btnFollow release];
    [_frontView release];
    [_followView release];
    [_lastView release];
    [_imgLast release];
    [_lblPriceLast release];
    [_lblNameLast release];
    [_btnLast release];
    [_v1 release];
    [_v2 release];
    [_v3 release];
    [super dealloc];
}
@end
