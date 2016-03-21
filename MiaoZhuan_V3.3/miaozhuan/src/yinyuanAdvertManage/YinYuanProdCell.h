//
//  YinYuanProdCell.h
//  miaozhuan
//
//  Created by momo on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"

@interface YinYuanProdCell : UITableViewCell
@property (retain, nonatomic) IBOutlet NetImageView *imgView;
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
@property (retain, nonatomic) IBOutlet UILabel *desLbl;
@property (retain, nonatomic) IBOutlet UILabel *yinyuanLbl;

@end
