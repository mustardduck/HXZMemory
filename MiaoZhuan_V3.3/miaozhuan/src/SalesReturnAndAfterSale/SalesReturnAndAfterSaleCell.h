//
//  SalesReturnAndAfterSaleCell.h
//  miaozhuan
//
//  Created by Santiago on 14-12-8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "RRLineView.h"
@interface SalesReturnAndAfterSaleCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *userPhoneNumber;
@property (retain, nonatomic) IBOutlet UILabel *orderTime;
@property (retain, nonatomic) IBOutlet RRLineView *littleGrayLine1;
@property (retain, nonatomic) IBOutlet NetImageView *productPic;
@property (retain, nonatomic) IBOutlet UILabel *productStatement;
@property (retain, nonatomic) IBOutlet UILabel *productStyle;
@property (retain, nonatomic) IBOutlet UILabel *littleX;
@property (retain, nonatomic) IBOutlet UILabel *numberOfProducts;
@property (retain, nonatomic) IBOutlet UILabel *singlePrice;



@property (retain, nonatomic) IBOutlet RRLineView *littleGrayLine2;


@property (retain, nonatomic) IBOutlet UILabel *price;
@property (retain, nonatomic) IBOutlet UILabel *labelAfterPrice;

@property (retain, nonatomic) IBOutlet UIView *bottomView1;
@property (retain, nonatomic) IBOutlet UIButton *rejectReturn;
@property (retain, nonatomic) IBOutlet UIButton *agreeReturn;
@property (retain, nonatomic) IBOutlet UILabel *timeLeftLabel;

@property (retain, nonatomic) IBOutlet UIView *bottomView2;

@property (retain, nonatomic) IBOutlet UIView *bottomView3;
@property (retain, nonatomic) IBOutlet UIButton *startArbitrament;
@property (retain, nonatomic) IBOutlet UIButton *confirmProduct;
@property (retain, nonatomic) IBOutlet UILabel *timeLeftLabel3;
@property (retain, nonatomic) IBOutlet UIView *withoutView123VIew;
@property (retain, nonatomic) IBOutlet RRLineView *UILineView;

@end
