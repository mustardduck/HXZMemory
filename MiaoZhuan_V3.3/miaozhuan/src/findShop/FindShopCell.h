//
//  FindShopCell.h
//  miaozhuan
//
//  Created by momo on 14-10-22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NetImageView;

@interface FindShopCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
@property (retain, nonatomic) IBOutlet UILabel *distanceLbl;
@property (retain, nonatomic) IBOutlet UIImageView *vipIcon;
@property (retain, nonatomic) IBOutlet UIImageView *yinyuanIcon;
@property (retain, nonatomic) IBOutlet UIImageView *jinbiIcon;
@property (retain, nonatomic) IBOutlet UIImageView *zhigouIcon;
@property (retain, nonatomic) IBOutlet NetImageView *imgView;

@end
