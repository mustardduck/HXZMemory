//
//  BaseMainCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-10-31.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BaseMainCell.h"
#import "GoodsCell.h"
#import "ShopCell.h"
#import "HomeInfoCell.h"

@implementation BaseMainCell

+ (instancetype)createCell:(NSInteger)type withData:(id)data{
    
    switch (type) {
        case 0:
        {
            ShopCell *cell = [ShopCell newInstance];
            cell.dataArray = data;
            return cell;
        }
            break;
        case 1:
        {
            GoodsCell *cell = [GoodsCell newInstance];
            cell.dataArray = data;
            return cell;
        }
            break;
        case 2:
        {
            HomeInfoCell *cell = [HomeInfoCell newInstance];
            cell.dataArray = data;
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
