//
//  SJYHCell.m
//  miaozhuan
//
//  Created by momo on 15/6/8.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "SJYHCell.h"
#import "Definition.h"

@implementation SJYHCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)newInstance{
    SJYHCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SJYHCell" owner:self options:nil] firstObject];
    if (cell) {
        
    }
    return cell;
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    if (!dataDic.dictionary.count) {
        return;
    }
    DictionaryWrapper *dic = [dataDic wrapper];
    
    _titlelbl.text = [dic getString:@"Title"];
    
    int type = [dic getInt:@"Type"];
    
    if(type == kPostBoardDiscount)//优惠
    {
        self.timeCons.constant = 100;
    }
    else if (type == kPostBoardRecruit)//招聘
    {
        self.timeCons.constant = 177;
        
        _redLbl.hidden = NO;
    }
    else if (type == kPostBoardAttractBusiness)//招商
    {
        self.timeCons.constant = 177;
        
        _redLbl.hidden = NO;
    }
    
    NSString * time = [UICommon format19Time:[dic getString:@"PublishTime"]];
    
    _timeLbl.text = time;
    
    _redLbl.text = [dic getString:@"KeyWord"];
    
    [_imgView requestWithRecommandSize:[dic getString:@"LogoUrl"]];
    [_imgView setRoundCorner:11];
    
}

- (void)dealloc {
    [_titlelbl release];
    [_imgView release];
    [_line release];
    [_timeView release];
    [_timeLbl release];
    [_redLbl release];
    [_timeCons release];
    [super dealloc];
}
@end
