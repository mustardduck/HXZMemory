//
//  PlaceTableViewCell.h
//  miaozhuan
//
//  Created by abyss on 14/12/30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceTableViewCell : UITableViewCell
@property (retain, nonatomic) NSString* place;
@property (retain, nonatomic) IBOutlet UILabel *t1;
@property (retain, nonatomic) IBOutlet UILabel *t2;
@property (retain, nonatomic) IBOutlet UILabel *t3;

@property (assign, nonatomic) double l1;
@property (assign, nonatomic) double l2;
@property (assign, nonatomic) int    lt;

@property (assign, nonatomic) NSString* phone;
@property (assign, nonatomic) CGFloat add;
@property (retain, nonatomic) UIView* addL;

@property (assign, nonatomic) BOOL isDisable;
@property (retain, nonatomic) IBOutlet UIButton *phoneBtns;

@end
