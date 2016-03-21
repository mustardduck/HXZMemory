//
//  BuyYiHuoEDuTableViewCell.h
//  miaozhuan
//
//  Created by apple on 15/6/3.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRNormalButton.h"

@interface BuyYiHuoEDuTableViewCell : UITableViewCell
@property (nonatomic, retain) NSDictionary *dataDic;

@property (retain, nonatomic) IBOutlet UILabel *titleLableCell;
@property (retain, nonatomic) IBOutlet RRNormalButton *buyBtnCell;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineCell;

@end
