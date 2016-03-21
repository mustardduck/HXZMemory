//
//  ConvertionForAManagerCell.m
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ConvertionForAManagerCell.h"
#import "AppUtils.h"

@implementation ConvertionForAManagerCell

- (void)awakeFromNib {
    // Initialization code
    self.cancelPermissionOfManagement.layer.borderWidth = 1;
    self.cancelPermissionOfManagement.layer.borderColor = [[UIColor redColor] CGColor];
    
    [self.contentView addSubview:[AppUtils LineView:10.f]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_cancelPermissionOfManagement release];
    [_companyNameLabel release];
    [_convertTimeLabel release];
    [_convertLocationLabel release];
    [_convertManagersLabel release];
    [_phoneNumberLabel release];
    [super dealloc];
}
@end
