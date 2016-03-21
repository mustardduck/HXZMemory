//
//  MyCollectionTableViewCell.h
//  miaozhuan
//
//  Created by apple on 14/12/19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"

@interface MyCollectionTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet NetImageView *cellImages;
@property (retain, nonatomic) IBOutlet UILabel *cellTitle;
@property (retain, nonatomic) IBOutlet UILabel *cellNeedMoney;
@property (retain, nonatomic) IBOutlet UILabel *cellneedLable;
@property (retain, nonatomic) IBOutlet UIImageView *cellTypeImage;

@end
