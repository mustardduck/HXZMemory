//
//  CustomBaseCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CustomBaseCell.h"
#import "CustomAgeCell.h"
#import "SingleChooseCell.h"
#import "MoreChooseCell.h"

@implementation CustomBaseCell

+ (instancetype)createCellWithType:(NSInteger)type data:(WDictionaryWrapper *)data{
    switch (type) {
        case -1:
        {
            CustomAgeCell *cell = [CustomAgeCell newInstance];
            cell.dataDic = data;
            return cell;
        }
            break;
        case 0:
        {
            SingleChooseCell *cell = [SingleChooseCell newInstance];
            cell.dataDic = data;
            return cell;
        }
            break;
        case 1:
        {
            MoreChooseCell *cell = [MoreChooseCell newInstance];
            cell.dataDic = data;
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
