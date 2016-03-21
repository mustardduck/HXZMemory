//
//  BaseMerchatCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-10-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BaseMerchatCell.h"
#import "PutInCell.h"
#import "SilverGoodsCell.h"
#import "GoldGoodsCell.h"
#import "DirectGoodsCell.h"
#import "SJYHCell.h"

@implementation BaseMerchatCell

+ (instancetype)createCell:(NSInteger)type WithData:(NSDictionary *)dataDic{
    if (type == 0) {
        PutInCell *cell = [PutInCell newInstance];
        cell.dataDic = dataDic;
        return cell;
    } else if (type == 1) {
        SilverGoodsCell *cell = [SilverGoodsCell newInstance];
        cell.dataDic = dataDic;
        return cell;
    } else if (type == 2) {
        GoldGoodsCell *cell = [GoldGoodsCell newInstance];
        cell.dataDic = dataDic;
        return cell;
    } else if (type == 3) {//直购
        DirectGoodsCell *cell = [DirectGoodsCell newInstance];
        cell.dataDic = dataDic;
        return cell;
    }
    else if (type == 4)//张贴栏
    {
        SJYHCell * cell = [SJYHCell newInstance];
        cell.dataDic = dataDic;
        return cell;
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

- (void)dealloc {
    [_lblTest release];
    [super dealloc];
}
@end
