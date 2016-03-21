//
//  WatingShippingTableViewCell.h
//  miaozhuan
//
//  Created by apple on 14/12/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "RRLineView.h"
@interface WatingShippingTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet RRLineView *cellTopLine;
@property (retain, nonatomic) IBOutlet RRLineView *cellLastTwoLine;
@property (retain, nonatomic) IBOutlet UILabel *cellUserName;
@property (retain, nonatomic) IBOutlet UILabel *cellEndTime;
@property (retain, nonatomic) IBOutlet NetImageView *cellGoodsImage;
@property (retain, nonatomic) IBOutlet UILabel *cellGoodsName;
@property (retain, nonatomic) IBOutlet UILabel *cellGoodsNumPrice;
@property (retain, nonatomic) IBOutlet UILabel *cellNeedmoney;
@property (retain, nonatomic) IBOutlet UIButton *cellChanggeAddressBtn;
@property (retain, nonatomic) IBOutlet UIButton *cellShipping;
//@property (retain , nonatomic) NSIndexPath *cellIndex;
@property (retain, nonatomic) IBOutlet UIView *cellTopView;
@property (retain, nonatomic) IBOutlet UIView *cellResultView;
@property (retain, nonatomic) IBOutlet UIButton *cellArgeeTuihuoBtn;
@property (retain, nonatomic) IBOutlet UILabel *cellArgeeTuiHuoLable;
@property (retain, nonatomic) IBOutlet UILabel *cellChchangeAddressLable;
@property (retain, nonatomic) IBOutlet UILabel *cellShippingLable;
@property (retain, nonatomic) IBOutlet UILabel *cellShengTime;
@property (retain, nonatomic) IBOutlet RRLineView *cellLineTwo;


@end
