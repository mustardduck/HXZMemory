//
//  ScreenResListCell.m
//  guanggaoban
//
//  Created by CQXianMai on 14-8-11.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import "ScreenResListCell.h"
#import "UIView+expanded.h"

@implementation ScreenResListCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCellWithDic:(NSDictionary *)dic
{
    NSString *rankStr = [dic valueForJSONStrKey:@"Rank"];
    self.rankLbl.text = [rankStr length] > 0 ? rankStr : @"未知";
    
    [self.comLogoImg allRoundCorner];
    self.comLogoImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.comLogoImg requestIcon:[dic valueForJSONStrKey:@"PictureUrl"] placeHolder:nil];
    
    NSString *comNameStr = [dic valueForJSONStrKey:@"Title"];
    self.comNameLbl.text = [comNameStr length] > 0 ? comNameStr : @"暂无";
    
    NSString *tipStr = [dic valueForJSONStrKey:@"Value"];
    if (![tipStr length]) {
        tipStr = @"暂无";
    }
    
    [self adjustViewWithContent:tipStr strFont:Font(14)];
    self.tipCatogryView.frameX = (320 -  15 - self.tipCatogryView.frameWidth) < 200 ? 200 : (320 -  15 - self.tipCatogryView.frameWidth);
    self.tipCatogryView.frameY = 25.f;

}

- (void) adjustViewWithContent:(NSString *) _strContent strFont:(UIFont *)_strFont
{
    CGSize sizeLabel = [_strContent sizeWithFont:_strFont];
    
    sizeLabel.width = sizeLabel.width > 90 ? 90 : sizeLabel.width;
    
    CGSize sizeRealLabel;
    
    sizeRealLabel = CGSizeMake(sizeLabel.width + 20, sizeLabel.height + 12);
    
    CGRect frontRect = CGRectMake(0,0,sizeRealLabel.width , sizeRealLabel.height);
    
    [self.tipCatogryLbl setFrame:frontRect];
    
    [self.tipCatogryLbl setTextAlignment: NSTextAlignmentCenter];
    
    [self.tipCatogryLbl setBackgroundColor:[UIColor clearColor]];
    
    [self.tipCatogryLbl setText:_strContent];
    
    [self.tipCatogryLbl setFont:_strFont];
    
//    self.tipCatogryLbl.textColor = [TouchShareAppConfig titleBlueColor_Advert];
    
    
    self.tipCatogryView.frame = frontRect;
    
    self.tipCatogryView.layer.cornerRadius = 5.0f;
    
//    self.tipCatogryView.layer.borderColor = [TouchShareAppConfig titleBlueColor_Advert].CGColor;
    
    self.tipCatogryView.layer.borderWidth = 1.0f;
}

- (void)dealloc {
    [_rankLbl release];
    [_comLogoImg release];
    [_comNameLbl release];
    [_tipCatogryLbl release];
    [_tipCatogryView release];
    [super dealloc];
}
@end
