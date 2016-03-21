//
//  MySaleReturnCell.h
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
@interface MySaleReturnCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *companyName;
@property (retain, nonatomic) IBOutlet UILabel *statusString;
@property (retain, nonatomic) IBOutlet UILabel *timeLeftString;

@property (retain, nonatomic) IBOutlet NetImageView *productImage;
@property (retain, nonatomic) IBOutlet UILabel *productIntroduce;
@property (retain, nonatomic) IBOutlet UILabel *productCount;
@property (retain, nonatomic) IBOutlet UILabel *productPrice;

@property (retain, nonatomic) IBOutlet UILabel *orderNumber;

@property (retain, nonatomic) IBOutlet UILabel *orderPriceLeft;
@property (retain, nonatomic) IBOutlet UILabel *orderPriceRight;
@property (retain, nonatomic) IBOutlet UILabel *returnPriceLeft;
@property (retain, nonatomic) IBOutlet UILabel *returnPriceRight;

//确认退货View
@property (retain, nonatomic) IBOutlet UIView *view1;
@property (retain, nonatomic) IBOutlet UIButton *startReturnBtn;

//发起仲裁View
@property (retain, nonatomic) IBOutlet UIView *view2;
@property (retain, nonatomic) IBOutlet UIButton *startApealBtn;
@property (retain, nonatomic) IBOutlet UIButton *confirmreceiptBtn;

@property (retain, nonatomic) IBOutlet UIView *UILineView1;

@property (retain, nonatomic) IBOutlet UIView *UILineView2;

@property (retain, nonatomic) IBOutlet UIView *UILineView3;

@property (retain, nonatomic) IBOutlet UIView *UILineView4;
@property (retain, nonatomic) IBOutlet UIView *UILineView41;



@property (retain, nonatomic) IBOutlet UIView *UILineView5;
@property (retain, nonatomic) IBOutlet UIView *UILineView6;

@property (retain, nonatomic) IBOutlet UIView *UILineView7;
@property (retain, nonatomic) IBOutlet UIView *UILineView8;

@property (retain, nonatomic) IBOutlet UIView *UILineView9;
@end
