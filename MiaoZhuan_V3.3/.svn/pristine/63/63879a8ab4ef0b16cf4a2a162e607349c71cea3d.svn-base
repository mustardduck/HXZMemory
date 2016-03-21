//
//  DetailYiHuoEDuTableViewCell.m
//  miaozhuan
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "DetailYiHuoEDuTableViewCell.h"
#import "UIView+expanded.h"
#import "AppUtils.h"

@implementation DetailYiHuoEDuTableViewCell

- (void)setDataDic:(NSDictionary *)dataDic
{

    DictionaryWrapper *dic = [dataDic wrapper];
    
    _titleCell.text = [dic getString:@"TypeName"];
    
    _contentCell.text = [dic getString:@"Name"];
    
    if ([dic getInt:@"Type"] == 101 || [dic getInt:@"Type"] == 102 || [dic getInt:@"Type"] == 1 || [dic getInt:@"Type"] == 2 || [dic getInt:@"Type"] == 201 || [dic getInt:@"Type"] == 4)
    {
        _imageCell.image = [UIImage imageNamed:@"detailedu"];
    }
    else
    {
        [_imageCell requestPic:[dic getString:@"PictureUrl"] placeHolder:YES];
    }

    _timeCell.text = [UICommon format19Time:[dic getString:@"RecordTime"]];
    
//    if ([dic getDouble:@"Number"] > 0)
//    {
//        _numCell.text = [NSString stringWithFormat:@"+%@", [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[dic getDouble:@"Number"]withAppendStr:nil]];
//    }
//    else
//    {
//        _numCell.text = [NSString stringWithFormat:@"%@", [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[dic getDouble:@"Number"]withAppendStr:nil]];
//    }
    
    //计算千分位
    _numCell.text = [AppUtils calculateThousands:[dic getString:@"Number"]];
    
    
    _lineHightCell.constant = 0.5;
    
    
    [self addSubview:[AppUtils LineView:self.frame.size.height]];
}

- (void)awakeFromNib
{
    [_imageCell roundCornerRadiusBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)dealloc {
    [_imageCell release];
    [_lineHightCell release];
    [_titleCell release];
    [_titleWidthCell release];
    [_contentCell release];
    [_contentWidthCell release];
    [_timeCell release];
    [_numCell release];
    [_lineLeft release];
    [super dealloc];
}
@end
