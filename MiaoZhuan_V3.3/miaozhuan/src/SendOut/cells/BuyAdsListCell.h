//
//  BuyAdsListCell.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyAdsListCell : UITableViewCell

@property (nonatomic, retain) NSDictionary *dataDic;

@property (retain, nonatomic) IBOutlet UILabel *lblAdsCount;
@property (retain, nonatomic) IBOutlet UILabel *lblCheap;
@property (retain, nonatomic) IBOutlet UILabel *lblPrice;
@property (retain, nonatomic) IBOutlet UIButton *btnClicked;

@end
