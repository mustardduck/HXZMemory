//
//  YinYuanADsDetailProductCell.h
//  miaozhuan
//
//  Created by momo on 14-12-23.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"


@interface YinYuanADsDetailProductCell : UITableViewCell
@property (retain, nonatomic) IBOutlet NetImageView *imgView;
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
@property (retain, nonatomic) IBOutlet UILabel *yinyuanNumLbl;
@property (retain, nonatomic) IBOutlet UILabel *priceLbl;

@end
