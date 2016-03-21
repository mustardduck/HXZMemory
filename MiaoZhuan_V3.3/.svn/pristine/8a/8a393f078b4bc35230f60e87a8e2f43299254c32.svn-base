//
//  WaitMerchantEnsureCell.m
//  miaozhuan
//
//  Created by Santiago on 15-1-22.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "WaitMerchantEnsureCell.h"

@implementation WaitMerchantEnsureCell

+ (instancetype)newInstance{
    WaitMerchantEnsureCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"WaitMerchantEnsureCell" owner:self options:nil] firstObject];
    if (cell) {
        
        [cell.uiLine setSize:CGSizeMake(252, 0.5)];
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

- (void)dealloc {
    [_uiLine release];
    [_creatTime release];
    [super dealloc];
}
@end
