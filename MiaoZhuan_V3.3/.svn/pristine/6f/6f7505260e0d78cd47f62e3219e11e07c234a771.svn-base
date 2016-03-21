//
//  YinYuanAdvertDisplayCell.m
//  miaozhuan
//
//  Created by momo on 15/3/16.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "YinYuanAdvertDisplayCell.h"
#import "RRAttributedString.h"

@implementation YinYuanAdvertDisplayCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) displayView
{
    NSAttributedString *attrStr = [RRAttributedString setText:_displayedCountLbl.text
                                                         font:Font(12)
                                                        color:RGBCOLOR(34, 34, 34)
                                                        range:NSMakeRange(6, _displayedCountLbl.text.length - 6)];
    _displayedCountLbl.attributedText = attrStr;
    
    attrStr = [RRAttributedString setText:_reviewedCountLbl.text
                                     font:Font(12)
                                    color:RGBCOLOR(34, 34, 34)
                                    range:NSMakeRange(6, _reviewedCountLbl.text.length - 6)];
    _reviewedCountLbl.attributedText = attrStr;
}

- (void)dealloc {
    [_titleLbl release];
    [_displayedCountLbl release];
    [_reviewedCountLbl release];
    [_countView release];
    [_line release];
    [super dealloc];
}
@end
