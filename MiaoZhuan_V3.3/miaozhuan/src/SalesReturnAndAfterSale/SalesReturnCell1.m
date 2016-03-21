//
//  SalesReturnCell1.m
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SalesReturnCell1.h"

@implementation SalesReturnCell1

+ (instancetype)newInstance{
    SalesReturnCell1 *cell = [[[NSBundle mainBundle] loadNibNamed:@"SalesReturnCell1" owner:self options:nil] firstObject];
    if (cell) {
        [cell.UILineView setSize:CGSizeMake(252, 1)];
    
    }
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
    self.pictureEvidence1.layer.borderWidth = 0.5;
    self.pictureEvidence1.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    self.pictureEvidence2.layer.borderWidth = 0.5;
    self.pictureEvidence2.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    self.pictureEvidence3.layer.borderWidth = 0.5;
    self.pictureEvidence3.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    self.pictureEvidence4.layer.borderWidth = 0.5;
    self.pictureEvidence4.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    self.pictureEvidence5.layer.borderWidth = 0.5;
    self.pictureEvidence5.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_creatTimeLabel release];
    [_cellTitle release];
    [_returnReason release];
    [_returnReasonDetail release];
    [_returnAmount release];
    [_returnAmountDetail release];
    [_moreStatement release];
    [_moreStatementDetail release];
    [_pictureEvidence release];
    [_pictureEvidence1 release];
    [_pictureEvidence2 release];
    [_pictureEvidence3 release];
    [_userLabel release];
    [_UILineView release];
    [_theBackGroundView release];
    [_pictureEvidence4 release];
    [_pictureEvidence5 release];
    [_picBtn1 release];
    [_picBtn2 release];
    [_picBtn3 release];
    [_picBtn4 release];
    [_picBtn5 release];
    [super dealloc];
}
@end
