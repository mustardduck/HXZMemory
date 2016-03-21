//
//  LookAdsCell.h
//  miaozhuan
//
//  Created by 孙向前 on 14-12-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "BaseSilverCell.h"

@interface LookAdsCell : BaseSilverCell

@property (retain, nonatomic) IBOutlet NetImageView *iconimgView;
@property (retain, nonatomic) IBOutlet UILabel *lblName;
@property (retain, nonatomic) IBOutlet UILabel *lblTime;
@property (retain, nonatomic) IBOutlet UILabel *lblNum;

@property (nonatomic, retain) NSDictionary *dataDic;
+ (instancetype)newInstance;

@end
