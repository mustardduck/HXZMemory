//
//  PSTCommonTableViewCell.h
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTCollectionView.h"
#import "NetImageView.h"

@interface PSTCommonTableViewCell : PSTCollectionViewCell
@property (retain, nonatomic) NetImageView *img;
@property (retain, nonatomic) UILabel *label;
@end
