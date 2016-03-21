//
//  ConsumptionCell.h
//  miaozhuan
//
//  Created by 孙向前 on 14-12-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "BaseSilverCell.h"

@interface ConsumptionCell : BaseSilverCell

@property (retain, nonatomic) IBOutlet NetImageView *headImageView;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblMethod;
@property (retain, nonatomic) IBOutlet UILabel *lblTime;
@property (retain, nonatomic) IBOutlet UILabel *lblNum;

@property (nonatomic, retain) NSDictionary *dataDic;
+ (instancetype)newInstance;

@end
