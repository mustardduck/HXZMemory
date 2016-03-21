//
//  FansDetailTableViewCell.h
//  miaozhuan
//
//  Created by apple on 14/11/25.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRLineView.h"
#import "NetImageView.h"
@interface FansDetailTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *verifyLable;
@property (retain, nonatomic) IBOutlet UILabel *nameLable;
@property (retain, nonatomic) IBOutlet UILabel *phoneLable;
@property (retain, nonatomic) IBOutlet UIView *checkView;
@property (retain, nonatomic) IBOutlet RRLineView *cellLine;
@property (retain, nonatomic) IBOutlet NetImageView *cellImages;
@property (retain, nonatomic) IBOutlet UIImageView *cellVipImage;
@property (retain, nonatomic) IBOutlet UILabel *cellHeGeLable;
@property (retain, nonatomic) IBOutlet UILabel *cellNoHeGeLable;
@property (retain, nonatomic) IBOutlet UIButton *remindBtn;


@end
