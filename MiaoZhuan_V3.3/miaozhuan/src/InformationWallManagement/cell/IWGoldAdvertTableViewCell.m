//
//  GoldAdvertTableViewCell.m
//  miaozhuan
//
//  Created by Junnpy Zhong on 15/5/14.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWGoldAdvertTableViewCell.h"

@implementation IWGoldAdvertTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.constraint_width_Title1.constant = SCREENWIDTH - 15.f - 15.f - self.constraint_width_Title5.constant - 15.f;
    self.label_Title1.width = self.constraint_width_Title1.constant;
    self.constraint_top_Title1.constant = 15.f;
    self.constraint_width_Title2.constant = self.constraint_width_Title1.constant;
    self.label_Title2.width = self.constraint_width_Title1.constant;
    self.constraint_top_Title2.constant = 3.f;
    
    self.constraint_top_Title3.constant = 9.f;
    
    self.constraint_width_Title4.constant = self.constraint_width_Title1.constant;
    self.label_Title4.width = self.constraint_width_Title1.constant;
    self.constraint_top_Title4.constant = 3.f;
    self.constraint_bottom_Title4.constant = 15.f;
    
    self.label_Title1.font = [UIFont systemFontOfSize:15.f];
    self.label_Title1.textColor = RGBACOLOR(34, 34, 34, 1);
    
    self.label_Title2.font = [UIFont systemFontOfSize:12.f];
    self.label_Title2.textColor = RGBACOLOR(85, 85, 85, 1);
    
    self.label_Title3.font = [UIFont systemFontOfSize:12.f];
    self.label_Title3.textColor = RGBACOLOR(153, 153, 153, 1);
    
    self.label_Title4.font = [UIFont systemFontOfSize:12.f];
    self.label_Title4.textColor = RGBACOLOR(153, 153, 153, 1);
    
    self.label_Title5.font = [UIFont systemFontOfSize:12.f];
    self.label_Title5.textColor = RGBACOLOR(65, 65, 65, 1);
    self.label_Title5.textAlignment = RTTextAlignmentRight;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(float)updateConstraintsSelf:(DictionaryWrapper *)dic Type:(MyGoldType)cellType{
    
    self.label_Title1.text = [dic getString:@"TypeName"];
    if(cellType == DiscountGoldConsume){
        self.label_Title2.text = @"发布商家优惠信息，扣除金币";
    }else if (cellType == RecruitmentGoldConsume){
        self.label_Title2.text = @"发布招聘信息，扣除金币";
    }else if (cellType == InvestmentGoldConsume){
        self.label_Title2.text = @"发布招商信息，扣除金币";
    }
    
    self.label_Title3.text = [dic getString:@"Name"];
    
    NSString * time = [dic getString:@"RecordTime"];
    time = [UICommon formatDate:time withRange:NSMakeRange(11, 8)];
    self.label_Title4.text = time;
    
    float num = [dic getFloat:@"GoldNumber"];
    
    NSString * text = [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:num withAppendStr:nil];;
    
    if(num > 0)
    {
        self.label_Title5.text = [NSString stringWithFormat:@"+%@", text];
    }
    else
    {
        self.label_Title5.text = [NSString stringWithFormat:@"%@", text];
    }
    
    self.constraint_height_LabelTitle1.constant = self.label_Title1.optimumSize.height;
    
    self.constraint_height_LabelTitle2.constant = self.label_Title2.optimumSize.height;
    
    self.constraint_height_LabelTitle4.constant = self.label_Title4.optimumSize.height;
    
    self.constraint_height_LabelTitle5.constant = self.label_Title5.optimumSize.height;
    self.constraint_width_Title5.constant = ceilf(self.label_Title5.optimumSize.width);
    self.label_Title5.width = self.constraint_width_Title5.constant;
    
    self.constraint_width_Title3.constant = SCREENWIDTH - 15.f - 15.f - self.constraint_width_Title5.constant - 10.f;
    self.label_Title3.width = self.constraint_width_Title3.constant;
    self.constraint_height_LabelTitle3.constant = self.label_Title3.optimumSize.height;
    self.label_Title3.height = self.constraint_height_LabelTitle3.constant;
    
    
    self.constraint_height_ContentView.constant = self.constraint_top_Title1.constant + self.constraint_height_LabelTitle1.constant + self.constraint_top_Title2.constant + self.constraint_height_LabelTitle2.constant + self.constraint_top_Title3.constant + self.constraint_height_LabelTitle3.constant + self.constraint_top_Title4.constant + self.constraint_height_LabelTitle4.constant + self.constraint_bottom_Title4.constant;
    
    return self.constraint_height_ContentView.constant + 1;
}

@end
