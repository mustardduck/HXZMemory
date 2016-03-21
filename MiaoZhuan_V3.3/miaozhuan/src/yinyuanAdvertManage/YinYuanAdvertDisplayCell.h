//
//  YinYuanAdvertDisplayCell.h
//  miaozhuan
//
//  Created by momo on 15/3/16.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "RRLineView.h"

@interface YinYuanAdvertDisplayCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
@property (retain, nonatomic) IBOutlet NetImageView *imgview;
@property (retain, nonatomic) IBOutlet UILabel *dateLbl;
@property (retain, nonatomic) IBOutlet UILabel *displayedCountLbl;
@property (retain, nonatomic) IBOutlet UILabel *reviewedCountLbl;
@property (retain, nonatomic) IBOutlet UIView *countView;
@property (retain, nonatomic) IBOutlet RRLineView *line;

- (void) displayView;

@end
