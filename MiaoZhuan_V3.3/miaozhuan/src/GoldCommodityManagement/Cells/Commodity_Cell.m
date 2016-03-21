//
//  Commodity_Cell.m
//  miaozhuan
//
//  Created by xm01 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "Commodity_Cell.h"
#import "AppUtils.h"
@implementation Commodity_Cell

//-(void)awakeFromNib
//{
//////    self.contentView.frame.size.height-0.5
//////    UIView *line = [AppUtils LineView:_picture.frame.origin.x y:80.0f];
//////    line.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
//////    [self.contentView addSubview:line];
//////    [line release];
//    
////    [_lineView addSubview:[AppUtils LineView:15.0f y:1.0f]];
//}

-(void)updateCellData:(DictionaryWrapper *)fileInfo
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dealloc
{
    [_productName release];
    [_picture release];
    [_offlineImage release];
    [_unitPrice release];
    [_onhandQty release];
    [_remainingTime release];
    [_lineView release];
    
    [super dealloc];
}

@end
