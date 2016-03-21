//
//  DisagreeCell.m
//  miaozhuan
//
//  Created by Santiago on 15-1-14.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "DisagreeCell.h"

@implementation DisagreeCell

- (void)awakeFromNib {
    // Initialization code
    self.pictureEvidenceDetail1.layer.borderWidth = 0.5;
    self.pictureEvidenceDetail1.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    self.pictureEvidenceDetail2.layer.borderWidth = 0.5;
    self.pictureEvidenceDetail2.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    self.picEvidenceDetail3.layer.borderWidth = 0.5;
    self.picEvidenceDetail3.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    self.pictureEvidenceDetail4.layer.borderWidth = 0.5;
    self.pictureEvidenceDetail4.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    self.pictureEvidenceDetail5.layer.borderWidth = 0.5;
    self.pictureEvidenceDetail5.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
}

+ (instancetype)newInstance{
    DisagreeCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DisagreeCell" owner:self options:nil] firstObject];
    if (cell) {
        
        [cell.UILineView setSize:CGSizeMake(252, 0.5)];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_userTitle release];
    [_timeLabel release];
    [_cellTitle release];
    [_returnReason release];
    [_returnReasonDetail release];
    [_pictureEvidence release];
    [_pictureEvidenceDetail1 release];
    [_pictureEvidenceDetail2 release];
    [_picEvidenceDetail3 release];
    [_backGroundView release];
    [_UILineView release];
    [_pictureEvidenceDetail4 release];
    [_pictureEvidenceDetail5 release];
    [_picBtn1 release];
    [_picBtn2 release];
    [_picBtn3 release];
    [_picBtn4 release];
    [_picBtn5 release];
    [super dealloc];
}
@end
