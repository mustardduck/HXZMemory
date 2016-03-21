//
//  WatingShippingTableViewCell.m
//  miaozhuan
//
//  Created by apple on 14/12/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "WatingShippingTableViewCell.h"
#import "UIView+expanded.h"

@implementation WatingShippingTableViewCell

- (void)awakeFromNib
{
    [self.cellChanggeAddressBtn roundCornerBorder];
    
    [self.cellShipping roundCorner];
    
    [_cellArgeeTuihuoBtn roundCornerBorder];
    
    self.cellShipping.layer.borderWidth = 0.5;
    self.cellShipping.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];
    
    self.cellGoodsImage.layer.borderWidth = 0.5;
    self.cellGoodsImage.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    [_cellTopLine release];
    [_cellLastTwoLine release];
    [_cellUserName release];
    [_cellEndTime release];
    [_cellGoodsImage release];
    [_cellGoodsName release];
    [_cellGoodsNumPrice release];
    [_cellNeedmoney release];
    [_cellChanggeAddressBtn release];
    [_cellShipping release];
    [_cellTopView release];
    [_cellResultView release];
    [_cellArgeeTuihuoBtn release];
    [_cellArgeeTuiHuoLable release];
    [_cellChchangeAddressLable release];
    [_cellShippingLable release];
    [_cellShengTime release];
    [_cellLineTwo release];
    [super dealloc];
}
@end
