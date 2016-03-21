//
//  QTMoneyTableViewCell.h
//  miaozhuan
//
//  Created by apple on 15/6/30.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMyGoldCell.h"

@interface QTMoneyTableViewCell : BaseMyGoldCell
@property (retain, nonatomic) IBOutlet UILabel *titlecell;
@property (retain, nonatomic) IBOutlet UILabel *numcell;
@property (retain, nonatomic) IBOutlet UILabel *timecell;
@property (retain, nonatomic) IBOutlet UILabel *contentcell;
@property (nonatomic, retain) NSDictionary *dataDic;
+ (instancetype)newInstance;
@end
