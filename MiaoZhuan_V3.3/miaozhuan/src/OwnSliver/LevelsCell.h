//
//  LevelsCell.h
//  miaozhuan
//
//  Created by 孙向前 on 15-3-12.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRLineView.h"

@interface LevelsCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *lblRecFans;
@property (retain, nonatomic) IBOutlet UILabel *lblVerFans;
@property (retain, nonatomic) IBOutlet UILabel *lblTotalSilver;
@property (retain, nonatomic) IBOutlet UIView *hoverView;
@property (retain, nonatomic) IBOutlet UIButton *btnUnlock;

@property (nonatomic ,retain) DictionaryWrapper *dataDic;
@property (retain, nonatomic) IBOutlet RRLineView *lineView;

@end
