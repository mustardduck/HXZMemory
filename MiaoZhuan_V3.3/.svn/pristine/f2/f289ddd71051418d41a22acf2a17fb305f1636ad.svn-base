//
//  BaseSilverCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BaseSilverCell.h"
#import "FansListCell.h"
#import "LookAdsCell.h"
#import "SysSendCell.h"
#import "ConsumptionCell.h"
#import "CirculateRecordsCell.h"

@implementation BaseSilverCell

+ (instancetype)createCell:(NSInteger)type WithData:(NSDictionary *)dataDic{
    if (type == 0) {
        FansListCell *cell = [FansListCell newInstance];
        cell.dataDic = dataDic;
        return cell;
    } else if (type == 1) {
        LookAdsCell *cell = [LookAdsCell newInstance];
        cell.dataDic = dataDic;
        return cell;
    } else if (type == 2) {
        SysSendCell *cell = [SysSendCell newInstance];
        cell.dataDic = dataDic;
        return cell;
    } else if (type == 3) {
        ConsumptionCell *cell = [ConsumptionCell newInstance];
        cell.dataDic = dataDic;
        return cell;
    } else if (type == 4){
        CirculateRecordsCell *cell = [CirculateRecordsCell newInstance];
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

@end
