//
//  IWCompanyNatureChooseTableViewCell.m
//  miaozhuan
//
//  Created by admin on 15/4/27.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWCompanyTreatmentCell.h"

@implementation IWCompanyTreatmentCell

- (void)awakeFromNib {
    // Initialization code
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIsSelected:(BOOL)selected{
    isSelected = selected;
    [self updateButton];
}

- (IBAction)buttonClicked:(id)sender {
    isSelected = !isSelected;
    [self updateButton];
    if(self.changed){
        self.changed(isSelected);
    }
}

-(void)updateButton{
    if(isSelected){
        [self.button setImage:[UIImage imageNamed:@"findShopfilterSelectBtn"] forState:UIControlStateNormal];
    }else{
        [self.button setImage:[UIImage imageNamed:@"findShopfilterBtn"] forState:UIControlStateNormal];
    }
}

@end
