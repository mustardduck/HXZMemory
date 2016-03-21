//
//  HomeInfoCell.m
//  miaozhuan
//
//  Created by 孙向前 on 15/5/11.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "HomeInfoCell.h"

@implementation HomeInfoCell

+ (instancetype)newInstance {
    HomeInfoCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeInfoCell" owner:self options:nil] firstObject];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    if (cell) {
        
    }
    return cell;
}

- (void)awakeFromNib {
    _img.top = 1;
    _img.left = 291;
    [_iconImg setRoundCorner:11];
}

- (void)setDataArray:(DictionaryWrapper *)dataArray {
    
    if (!dataArray || [dataArray isKindOfClass:[NSNull class]]) {
        return;
    }
    
    [_iconImg requestWithRecommandSize:[dataArray getString:@"LogoUrl"]];
    _lblTitle.text = [dataArray getString:@"Title"];
    _lblContent.text = [dataArray getString:@"EnterpriseName"];
    
    [_btnLocation setTitle:[NSString stringWithFormat:@" %@", [dataArray getString:@"Region"]] forState:UIControlStateNormal];
    
    int type = [dataArray getInt:@"Type"];
    
    _lblLeft.width = 80.f;
    
    switch (type) {
        case 1:
        {
            _img.image = [UIImage imageNamed:@"home_zp"];
            NSString *keyword = [dataArray getString:@"KeyWord"];
            if([keyword isEqualToString:@"面议"]){
                _lblLeft.text = keyword;
            }else{
               _lblLeft.text = [NSString stringWithFormat:@"%@元/月",keyword];
            }
            
            _lblLeft.width = 120.f;
            _lblLeft.textColor = AppColorRed;
            _lblRight.hidden = YES;
            
        }
            break;
        case 2:
        {
            _img.image = [UIImage imageNamed:@"home_zs"];
            _lblLeft.text = [dataArray getString:@"KeyWord"];
            _lblLeft.textColor = AppColorRed;
            
            
            CGSize size = [UICommon getSizeFromString:[dataArray getString:@"KeyWord"] withSize:CGSizeMake(MAXFLOAT, 20) withFont:12];
            _lblLeft.width = size.width;
            
            _lblRight.left = _lblLeft.right + 5;
            
            _lblRight.text = [dataArray getString:@"Industry"];
            
        }
            break;
        case 3:
        {
             _img.image = [UIImage imageNamed:@"home_yh"];
            _lblLeft.text = [dataArray getString:@"Industry"];
            _lblLeft.textColor = AppColor(163);
            _lblRight.hidden = YES;
            
        }
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_iconImg release];
    [_lblTitle release];
    [_lblContent release];
    [_lblLeft release];
    [_lblRight release];
    [_btnLocation release];
    [_btnIcon release];
    [_line release];
    [_btnContent release];
    [_img release];
    [super dealloc];
}
@end
