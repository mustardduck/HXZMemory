//
//  MallRecommondCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MallRecommondCell.h"

@implementation MallRecommondCell
+ (instancetype)newInstance{
    MallRecommondCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MallRecommondCell" owner:self options:nil] firstObject];
    if (cell) {
        [cell.imgCompanyLogo setRoundCorner:11];
        [cell.leftImgIcon setRoundCorner:0.f withBorderColor:AppColorLightGray204];
        [cell.middleImgIcon setRoundCorner:0.f withBorderColor:AppColorLightGray204];
        [cell.bottomImgIcon setRoundCorner:0.f withBorderColor:AppColorLightGray204];
    }
    return cell;
}

- (void)setDataDic:(DictionaryWrapper *)dataDic{
    
    if (!dataDic.dictionary.count) {
        return;
    }
    NSArray *goldGoods = [dataDic getArray:@"GoldProducts"];
    NSArray *silverGoods = [dataDic getArray:@"SilverProducts"];
    if ([goldGoods count] || [silverGoods count]) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:goldGoods];
        [temp addObjectsFromArray:silverGoods];
        if (temp.count) {
            _leftName.text = [[temp[0] wrapper] getString:@"Name"];
            
            NSString *name = [[temp[0] wrapper] getString:@"Name"];
            CGSize size = [UICommon getSizeFromString:name withSize:CGSizeMake(80, MAXFLOAT) withFont:11];
            if (size.height < 17) {
                _leftName.height = size.height;
                _leftPrice.top = _leftName.bottom - 4;
            } else {
                _leftName.top = 88;
                _leftPrice.top = 109;
            }
            
            [_leftImgIcon requestIcon:[[temp[0] wrapper] getString:@"PictureUrl"]];
            
            _leftPrice.text = [NSString stringWithFormat:@"%@%@", [[temp[0] wrapper] getString:@"UnitPrice"],goldGoods.count ? @"易货码" : @"银元"];
            
            switch (temp.count) {
                case 1:
                {
                    _middleView.hidden = _bottomView.hidden = YES;
                }
                    break;
                case 2:
                {
                    _bottomView.hidden = YES;
                    _middleName.text = [[temp[1] wrapper] getString:@"Name"];
                    [_middleImgIcon requestIcon:[[temp[1] wrapper] getString:@"PictureUrl"]];
                    
                    NSString *name = [[temp[1] wrapper] getString:@"Name"];
                    CGSize size = [UICommon getSizeFromString:name withSize:CGSizeMake(80, MAXFLOAT) withFont:11];
                    if (size.height < 17) {
                        _middleName.height = size.height;
                        _middlePrice.top = _middleName.bottom - 4;
                    } else {
                        _middleName.top = 88;
                        _middlePrice.top = 109;
                    }
                    
                    _middlePrice.text = [NSString stringWithFormat:@"%@%@", [[temp[1] wrapper] getString:@"UnitPrice"],goldGoods.count > 1 ? @"易货码" : @"银元"];
                }
                    break;

                default:
                {
                    _middleName.text = [[temp[1] wrapper] getString:@"Name"];
                    
                    NSString *name = [[temp[1] wrapper] getString:@"Name"];
                    CGSize size = [UICommon getSizeFromString:name withSize:CGSizeMake(80, MAXFLOAT) withFont:11];
                    if (size.height < 17) {
                        _middleName.height = size.height;
                        _middlePrice.top = _middleName.bottom - 4;
                    } else {
                        _middleName.top = 88;
                        _middlePrice.top = 109;
                    }
                    
                    [_middleImgIcon requestIcon:[[temp[1] wrapper] getString:@"PictureUrl"]];
                    _middlePrice.text = [NSString stringWithFormat:@"%@%@", [[temp[1] wrapper] getString:@"UnitPrice"],goldGoods.count > 1 ? @"易货码" : @"银元"];
                    
                    _bottomName.text = [[temp[2] wrapper] getString:@"Name"];
                    
                    NSString *name1 = [[temp[2] wrapper] getString:@"Name"];
                    CGSize size1 = [UICommon getSizeFromString:name1 withSize:CGSizeMake(80, MAXFLOAT) withFont:11];
                    if (size1.height < 17) {
                        _bottomName.height = size1.height;
                        _bottomPrice.top = _bottomName.bottom - 4;
                    } else {
                        _bottomName.top = 88;
                        _bottomPrice.top = 109;
                    }
                    
                    [_bottomImgIcon requestIcon:[[temp[2] wrapper] getString:@"PictureUrl"]];
                    _bottomPrice.text = [NSString stringWithFormat:@"%@%@", [[temp[2] wrapper] getString:@"UnitPrice"],goldGoods.count > 2 ? @"易货码" : @"银元"];

                }
                    break;
            }
        }
    }
    _lblCompanyName.text = [dataDic getString:@"Name"];
    NSString *ys = [dataDic getString:@"Feature"];
    NSString *str = @"商家优势：";
    if (ys.length && ![ys isKindOfClass:[NSNull class]]) {
        str = [NSString stringWithFormat:@"商家优势：%@",ys];
    }
    CGSize size = [UICommon getSizeFromString:str withSize:CGSizeMake(290, MAXFLOAT) withFont:14];
    
    _lblGood.height = size.height > 35 ? 35 : size.height;
    self.line.top = _lblGood.bottom + 13;
    _lblGood.font = Font(14);
    _lblGood.text = str;
    
    if ([goldGoods count] || [silverGoods count]) {
        _shopVIew.top = _line.bottom + 8;
        self.height = _shopVIew.bottom + 5;
    } else {
        _hoverview.top = _line.bottom + 8;
        self.height = _hoverview.bottom + 5;
    }
    
    _lineB.top = self.height - 0.5;
    
    [_imgCompanyLogo requestIcon:[dataDic getString:@"LogoUrl"]];
    _btnDirect.selected = [dataDic getBool:@"IsDirect"];
    _btnGold.selected = [dataDic getBool:@"IsGold"];
    _btnSiver.selected = [dataDic getBool:@"IsSilver"];
    _btnVip.selected = [dataDic getBool:@"IsVip"];
    
    self.lblTitle.font = Font(14);
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)dealloc {
    [_imgCompanyLogo release];
    [_lblCompanyName release];
    [_btnVip release];
    [_btnDirect release];
    [_btnGold release];
    [_btnSiver release];
    [_lblGood release];
    [_leftView release];
    [_middleView release];
    [_bottomView release];
    [_leftImgIcon release];
    [_leftName release];
    [_leftPrice release];
    [_middleImgIcon release];
    [_middleName release];
    [_middlePrice release];
    [_bottomImgIcon release];
    [_bottomName release];
    [_bottomPrice release];
    [_mainView release];
    [_hoverview release];
    [_line release];
    [_lineB release];
    [_lblTitle release];
    [super dealloc];
}
@end
