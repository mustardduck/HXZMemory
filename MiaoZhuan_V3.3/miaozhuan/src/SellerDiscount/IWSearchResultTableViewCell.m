//
//  IWSearchResultTableViewCell.m
//  miaozhuan
//
//  Created by luo on 15/4/24.
//  Copyright (c) 2015年 zdit. All rights reserved.
//


#import "IWSearchResultTableViewCell.h"

@implementation IWSearchResultTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imageViewCover.layer.masksToBounds = YES;
    self.imageViewCover.clipsToBounds = YES;
    self.imageViewCover.layer.cornerRadius = 10.0;
    self.imageViewCover.layer.borderWidth = 0.5;
    self.imageViewCover.layer.borderColor = RGBCOLOR(197, 197, 197).CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setupContent:(PostBoardSearchResultInfo *) resultInfo{
    
    [_imageViewCover requestWithRecommandSize:resultInfo.resultLogoUrl];
    
    _lableTitle.text = resultInfo.resultTitle;
    _lableComplay.text = resultInfo.resultEnterpriseName;
    _lableComplay.textColor = RGBACOLOR(136, 136, 136, 1);

    NSString *resultRefreshTime  = [resultInfo.resultRefreshTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    _lableTime.text = [resultRefreshTime componentsSeparatedByString:@"."][0];//resultRefreshTime.length > 16 ? [resultRefreshTime substringToIndex:16]:resultRefreshTime;
    _lablePlace.text = resultInfo.resultRegion;
//    NSLog(@"type:%d name:%@",resultInfo.resultType,resultInfo.resultTitle);
    
    switch (resultInfo.resultType) {
        case kPostBoardRecruit:
        {
            _lableType.text = @"[招聘]";
            _lableType.textColor = RGBACOLOR(61, 144, 238, 1);
            if([resultInfo.resultKeyWord isEqualToString:@"面议"]){
                _lableSalary.text = resultInfo.resultKeyWord;
            }else{
                _lableSalary.text = [NSString stringWithFormat:@"%@元/月",resultInfo.resultKeyWord];
            }
            _lableSalary.textColor = RGBACOLOR(243, 55, 51, 1);
            _label_Type.text = @"";
        }
            
            break;
        case kPostBoardAttractBusiness:
        {
            _lableType.text = @"[招商]";
            _lableType.textColor = RGBACOLOR(45, 157, 1, 1);
            _lableSalary.text = resultInfo.resultKeyWord.length > 0 ? resultInfo.resultKeyWord : @"投资金额未填写";
            _lableSalary.textColor = RGBACOLOR(243, 55, 51, 1);
            _label_Type.text = resultInfo.resultIndustry;
        }
            
            break;
        case kPostBoardDiscount:
        {
            _label_Type.text = @"";
            _lableType.text = @"[优惠]";
            _lableType.textColor = RGBACOLOR(255, 41, 135, 1);
            _lableSalary.text = resultInfo.resultIndustry;
            _lableSalary.textColor = RGBACOLOR(136, 136, 136, 1);
        }
        default:
            break;
    }
    CGSize contentSize = [_lableLocation.text sizeWithFont:_lableLocation.font constrainedToSize:CGSizeMake(MAXFLOAT, _lableLocation.height)];
    float maxWidht = SCREENWIDTH - 108.f - 117.f - 10.f - 8.f - 3.f - 15.f - 13.f;
    if(contentSize.width > maxWidht){
        contentSize = CGSizeMake(maxWidht, contentSize.height);
    }
    _constraint_width_Address.constant = contentSize.width;

}
- (void)dealloc {
    [_lableLocation release];
    [_imageViewCover release];
    [_lableType release];
    [_lableTitle release];
    [_lableComplay release];
    [_lableSalary release];
    [_lableTime release];
    [_lablePlace release];
    [_label_Type release];
    [_constraint_width_Address release];
    [super dealloc];
}
@end
