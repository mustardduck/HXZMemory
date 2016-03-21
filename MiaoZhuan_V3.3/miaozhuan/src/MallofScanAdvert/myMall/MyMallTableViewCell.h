//
//  MyMallTableViewCell.h
//  miaozhuan
//
//  Created by apple on 14/12/20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRLineView.h"

@interface MyMallTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *cellImages;
@property (retain, nonatomic) IBOutlet UILabel *cellTitle;
@property (retain, nonatomic) IBOutlet UILabel *cellContent;
@property (retain, nonatomic) IBOutlet RRLineView *cellLine;
@property (retain, nonatomic) IBOutlet UIImageView *cellJiantou;

@end
