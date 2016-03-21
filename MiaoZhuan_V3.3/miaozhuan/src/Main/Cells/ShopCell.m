//
//  ShopCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-10-22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ShopCell.h"

@implementation ShopCell

+ (instancetype)newInstance{
    ShopCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ShopCell" owner:self options:nil] firstObject];
    if (cell) {
        
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setDataArray:(NSArray *)dataArray{
    
    if (![dataArray[1] count]) {
        _lblTitleFollow.hidden = YES;
        _imgFollow.hidden = YES;
        _btnFollow.hidden = YES;
        _fview.hidden = YES;
    } else {
        _lblTitleFollow.text = [[dataArray[1] wrapper] getString:@"Name"];
        [_imgFollow requestWithRecommandSize:[[dataArray[1] wrapper] getString:@"LogoUrl"]];
    }
    
    _lblTitleFront.text = [[dataArray[0] wrapper] getString:@"Name"];
    [_imgFront requestWithRecommandSize:[[dataArray[0] wrapper] getString:@"LogoUrl"]];
    
    [_imgFollow setRoundCorner:11.f];
    [_imgFront setRoundCorner:11.f];
}

- (void)dealloc {
    _dataArray = nil;
    [_imgFront release];
    [_lblTitleFront release];
    [_imgFollow release];
    [_lblTitleFollow release];
    [_btnFront release];
    [_btnFollow release];
    [_fview release];
    [_hview release];
    [super dealloc];
}
@end
