//
//  BaseMyGoldCell.m
//  miaozhuan
//
//  Created by momo on 14-12-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BaseMyGoldCell.h"
#import "MyGoldAdvertCell.h"
#import "MyGoldSystemSendCell.h"
#import "MyGoldConsumptionCell.h"
#import "MyGoldMarketCell.h"
#import "MyGoldCirculateRecordsCell.h"
#import "YiHuoMaTableViewCell.h"
#import "QTMoneyTableViewCell.h"

@implementation BaseMyGoldCell

//0.发广告消耗的，1.兑换商品消耗的，2.竞价广告消耗的，3.系统赠送的，4.易货商城的货款 5.流通记录 6.其他收入 10.(易货码：兑换获得的） 11.(易货码：易货消耗的） 12.(易货码：易货商城货款） 13.其他收入

+ (instancetype)createCell:(NSInteger)type WithData:(NSDictionary *)dataDic
{
    NSLog(@"----%d",type);
    if (type == 0 || type == 7 || type == 8 || type == 9) {
        MyGoldAdvertCell *cell = [MyGoldAdvertCell newInstance];
        cell.type = type;//type要在datadic的前面
        cell.dataDic = dataDic;
        return cell;
    }
    else if (type == 1 || type == YHXH_YHM )
    {
        MyGoldConsumptionCell *cell = [MyGoldConsumptionCell newInstance];
        cell.type = type;//type要在datadic的前面
        cell.dataDic = dataDic;
        return cell;
    }
    else if (type == 2 || type == 3 || type == 6 || type == GetBuyAdvertGold) {
        MyGoldSystemSendCell *cell = [MyGoldSystemSendCell newInstance];
        cell.dataDic = dataDic;
        return cell;
    }
    else if ( type == DHHD_YHM)
    {
        YiHuoMaTableViewCell *cell = [YiHuoMaTableViewCell newInstance];
        cell.dataDic = dataDic;
        return cell;
    }
    else if (type == QT_MONEY)
    {
        QTMoneyTableViewCell * cell = [QTMoneyTableViewCell newInstance];
        cell.dataDic = dataDic;
        return cell;
    }
    else if (type == QT_YHM )
    {
        MyGoldSystemSendCell *cell = [MyGoldSystemSendCell newInstance];
        cell.isYHM = YES;
        cell.dataDic = dataDic;
        return cell;
    }
    else if (type == 4 || type == YHHK_YHM) {
        MyGoldMarketCell *cell = [MyGoldMarketCell newInstance];
        cell.type = type;//type要在datadic的前面
        cell.dataDic = dataDic;
        return cell;
    }
    else if (type == 5) {
        MyGoldCirculateRecordsCell *cell = [MyGoldCirculateRecordsCell newInstance];
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
