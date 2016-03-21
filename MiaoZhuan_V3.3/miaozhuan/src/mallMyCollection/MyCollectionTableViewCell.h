//
//  MyCollectionTableViewCell.h
//  miaozhuan
//
//  Created by apple on 14/12/19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *cellImages;
@property (retain, nonatomic) IBOutlet UILabel *cellTitle;
@property (retain, nonatomic) IBOutlet UILabel *cellNeedMoney;

@end
