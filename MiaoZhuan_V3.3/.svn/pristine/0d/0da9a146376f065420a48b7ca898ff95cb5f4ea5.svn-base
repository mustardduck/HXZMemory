//
//  IWManagementTableViewCellForStyleValue2.m
//  miaozhuan
//
//  Created by admin on 15/4/27.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWManagementTableViewCellForStyleValue2.h"

@implementation IWManagementTableViewCellForStyleValue2

- (void)awakeFromNib {
    // Initialization code
    
//    self.constraint_top_TopLine.constant = -0.8;
    self.constraint_bottom_BottomLine.constant = -0.5f;
    self.view_Content.layer.masksToBounds = YES;
    
    if(self.label_SubTitle.text.length < 1){
        self.label_SubTitle.hidden = YES;
    }
    self.label_SubTitle.backgroundColor = RGBACOLOR(255, 133, 42, 1);
    self.label_SubTitle.layer.cornerRadius = self.label_SubTitle.width / 2.f;
    self.label_SubTitle.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCellAligningType:(IWManagementCellAligningType)aligningType{
    switch (aligningType) {
        case IWManagementCellAligningType_OnlyOne:
            self.bottomLine.hidden = YES;
//            self.topLine.hidden = NO;
//            self.constraint_left_Bottom.constant = 0.f;
            break;
        case IWManagementCellAligningType_Top:
            self.bottomLine.hidden = NO;
//            self.topLine.hidden = NO;
            self.constraint_left_Bottom.constant = 15.f;
            break;
        case IWManagementCellAligningType_Middle:
            self.bottomLine.hidden = NO;
//            self.topLine.hidden = YES;
            self.constraint_left_Bottom.constant = 15.f;
            break;
        case IWManagementCellAligningType_Bottom:
            self.bottomLine.hidden = YES;
//            self.topLine.hidden = YES;
//            self.constraint_left_Bottom.constant = 0.f;
            break;
            
            
        default:
            break;
    }
}

@end
