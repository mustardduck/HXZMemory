//
//  IWAttractBusinessCellTableViewCell.m
//  miaozhuan
//
//  Created by Junnpy Zhong on 15/5/9.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWBrowseADCellTableViewCell.h"

@implementation IWBrowseADCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imageView_Logo.layer.masksToBounds = YES;
    self.imageView_Logo.clipsToBounds = YES;
    self.imageView_Logo.layer.cornerRadius = 10.0;
    self.imageView_Logo.layer.borderWidth = 0.5;
    self.imageView_Logo.layer.borderColor = RGBCOLOR(197, 197, 197).CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setupDataContent:(PostBoardInfo *) obj PostBoardType:(PostBoardType)type{

    [_imageView_Logo requestPicture:obj.postBoardLogoUrl];
    _label_Title.text = obj.postBoardTitle;
    _label_Company.text = obj.postBoardEnterpriseName;
    if(type == kPostBoardDiscount){
        _label_Money.text = obj.postBoardIndustry;
        _label_Money.textColor = RGBACOLOR(153, 153, 153, 1);
        _label_Type.text = @"";
    }else if(type == kPostBoardAttractBusiness){
        _label_Money.text = obj.postBoardKeyWord;
        _label_Money.textColor = RGBACOLOR(249, 0, 0, 1);
        _label_Type.text = obj.postBoardIndustry;
        _label_Type.textColor = RGBACOLOR(153, 153, 153, 1);
    }else if(type == kPostBoardRecruit){
        if([obj.postBoardKeyWord isEqualToString:@"面议"]){
            _label_Money.text = obj.postBoardKeyWord;
        }else{
            _label_Money.text = [NSString stringWithFormat:@"%@元/月",obj.postBoardKeyWord];
        }
        _label_Money.textColor = RGBACOLOR(249, 0, 0, 1);
        _label_Type.text = @"";
    }
    
    [self updateConstraints];
    
    NSString *date = [obj.postBoardRefreshTime componentsSeparatedByString:@"T"][1];
    NSRange range = [date rangeOfString:@"." options:NSBackwardsSearch];
    if(range.location != NSNotFound){
        date = [date substringToIndex:range.location];
    }
    _label_Date.text = date;
    
    _label_Address.text = obj.postBoardRegion;
    
    CGSize contentSize = [_label_Address.text sizeWithFont:_label_Address.font constrainedToSize:CGSizeMake(MAXFLOAT, _label_Address.height)];
    float maxWidht = SCREENWIDTH - _label_Date.right - 5.f - 15.f - 3.f - 8.f - 10.f;
    if(contentSize.width > maxWidht){
        contentSize = CGSizeMake(maxWidht, contentSize.height);
    }
    _constraint_width_Address.constant = contentSize.width + 5.f;
}

@end
