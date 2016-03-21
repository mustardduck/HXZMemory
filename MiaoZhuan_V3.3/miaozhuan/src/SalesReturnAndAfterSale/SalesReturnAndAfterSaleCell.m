//
//  SalesReturnAndAfterSaleCell.m
//  miaozhuan
//
//  Created by Santiago on 14-12-8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SalesReturnAndAfterSaleCell.h"

@implementation SalesReturnAndAfterSaleCell
- (void)awakeFromNib {

    //加边框
    self.rejectReturn.layer.borderWidth = 0.5;
    self.rejectReturn.layer.borderColor = [RGBACOLOR(204, 204, 204, 1) CGColor];
    self.agreeReturn.layer.borderWidth = 0.5;
    self.agreeReturn.layer.borderColor = [RGBACOLOR(204, 204, 204, 1) CGColor];
    self.startArbitrament.layer.borderWidth = 0.5;
    self.startArbitrament.layer.borderColor = [RGBACOLOR(204, 204, 204, 1)CGColor];
    self.confirmProduct.layer.borderWidth = 0.5;
    self.confirmProduct.layer.borderColor = [RGBACOLOR(204, 204, 204, 1)CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_productPic release];
    [_userPhoneNumber release];
    [_productStatement release];
    [_productStyle release];
    [_littleX release];
    [_numberOfProducts release];
    [_price release];
    [_labelAfterPrice release];
    [_bottomView1 release];
    [_bottomView2 release];
    [_bottomView3 release];
    [_rejectReturn release];
    [_agreeReturn release];
    [_startArbitrament release];
    [_confirmProduct release];
    [_orderTime release];
    [_littleGrayLine1 release];
    [_littleGrayLine2 release];
    [_timeLeftLabel release];
    [_timeLeftLabel3 release];
    [_withoutView123VIew release];
    [_UILineView release];
    [_singlePrice release];
    [super dealloc];
}
@end
