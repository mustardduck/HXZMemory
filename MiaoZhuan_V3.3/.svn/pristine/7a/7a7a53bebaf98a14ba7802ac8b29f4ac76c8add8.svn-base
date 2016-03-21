//
//  BaseMallCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-26.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BaseMallCell.h"
#import "MallGoodsCell.h"
#import "MallShopCell.h"
#import "MallRecommondCell.h"

@implementation BaseMallCell

+ (instancetype)createCell:(NSInteger)type withData:(id)data{
    if (type == 1) {
        MallShopCell *cell = [MallShopCell newInstance];
        cell.dataDic = data;
        return cell;
    } else if (type == 0) {
        MallGoodsCell *cell = [MallGoodsCell newInstance];
        cell.dataDic = data;
        return cell;
    } else {
        MallRecommondCell *cell = [MallRecommondCell newInstance];
        cell.dataDic = data;
        return cell;
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
