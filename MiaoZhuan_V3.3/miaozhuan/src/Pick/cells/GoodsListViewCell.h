//
//  GoodsListViewCell.h
//  miaozhuan
//
//  Created by 孙向前 on 14-10-28.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "BaseMerchatCell.h"
#import "RRLineView.h"

@interface GoodsListViewCell : BaseMerchatCell

+ (instancetype)newInstance;

@property (nonatomic, retain) NSDictionary *dataDic;

@property (retain, nonatomic) IBOutlet NetImageView *imgIcon;
@property (retain, nonatomic) IBOutlet UILabel *lblName;
@property (retain, nonatomic) IBOutlet UILabel *lblNeedPay;
@property (retain, nonatomic) IBOutlet UILabel *lblWorth;
@property (retain, nonatomic) IBOutlet UIView *priceview;
@property (retain, nonatomic) IBOutlet RRLineView *lineview;

@end
