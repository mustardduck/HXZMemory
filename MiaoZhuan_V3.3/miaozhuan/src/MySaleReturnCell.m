//
//  MySaleReturnCell.m
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MySaleReturnCell.h"
#import "UIView+expanded.h"
@implementation MySaleReturnCell
@synthesize startApealBtn = _startApealBtn;
@synthesize startReturnBtn = _startReturnBtn;
- (void)awakeFromNib {
    
    [_startApealBtn roundCornerBorder];
    [_confirmreceiptBtn roundCornerBorder];
    
    _confirmreceiptBtn.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];
    
    [_startReturnBtn roundCornerBorder];
    self.startReturnBtn.layer.borderColor = [[UIColor colorWithRed:240/255.0 green:5/255.0 blue:0.0 alpha:1] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_startApealBtn release];
    [_startReturnBtn release];
    [_view1 release];
    [_view2 release];
    [_companyName release];
    [_statusString release];
    [_timeLeftString release];
    [_productImage release];
    [_productIntroduce release];
    [_productCount release];
    [_productPrice release];
    [_orderNumber release];
    [_orderPriceLeft release];
    [_orderPriceRight release];
    [_returnPriceLeft release];
    [_returnPriceRight release];
    [_UILineView1 release];
    [_UILineView2 release];
    [_UILineView3 release];
    [_UILineView4 release];
    [_UILineView5 release];
    [_UILineView6 release];
    [_UILineView7 release];
    [_UILineView8 release];
    [_UILineView9 release];
    [_UILineView41 release];
    [_confirmreceiptBtn release];
    [super dealloc];
}
@end
