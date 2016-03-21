//
//  MyMarketMyOrderDetailController.h
//  miaozhuan
//
//  Created by momo on 14/12/29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "UICopyLabel.h"

@interface MyMarketMyOrderDetailController : DotCViewController


@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (retain, nonatomic) IBOutlet UIImageView *topIcon;

@property (retain, nonatomic) IBOutlet UILabel *topTitle;
@property (retain, nonatomic) IBOutlet UIView *topOrderView;
@property (retain, nonatomic) IBOutlet UILabel *topOrderPriceLbl;
@property (retain, nonatomic) IBOutlet UILabel *topOrderNumber;
@property (retain, nonatomic) IBOutlet UILabel *topOrderDateLbl;


@property (retain, nonatomic) IBOutlet UILabel *topPayNumberLbl;

@property (retain, nonatomic) IBOutlet UILabel *topReasonLbl;
@property (retain, nonatomic) IBOutlet UIView *logisticsView;
@property (retain, nonatomic) IBOutlet UIButton *logisticsBtn;
@property (retain, nonatomic) IBOutlet UILabel *logisticsCompLbl;
@property (retain, nonatomic) IBOutlet UILabel *logisticsOrderNumberLbl;

@property (retain, nonatomic) IBOutlet UIView *bottomView;
@property (retain, nonatomic) IBOutlet UILabel *sentToLbl;
@property (retain, nonatomic) IBOutlet UILabel *sentAddressLbl;
@property (retain, nonatomic) IBOutlet UILabel *mobileLbl;
@property (retain, nonatomic) IBOutlet UILabel *compNameLbl;
@property (retain, nonatomic) IBOutlet UILabel *prodNameLbl;
@property (retain, nonatomic) IBOutlet UILabel *prodDetailLbl;
@property (retain, nonatomic) IBOutlet NetImageView *prodImgView;
@property (retain, nonatomic) IBOutlet UILabel *priceLbl;
@property (retain, nonatomic) IBOutlet UILabel *countLbl;
@property (retain, nonatomic) IBOutlet UILabel *totalPriceLbl;
@property (retain, nonatomic) IBOutlet UILabel *deliveryCostLbl;
@property (retain, nonatomic) IBOutlet UILabel *orderPrice;
@property (retain, nonatomic) IBOutlet UILabel *sellerTelLbl;
@property (retain, nonatomic) IBOutlet UIButton *sellTelBtn;
@property (retain, nonatomic) IBOutlet UIButton *returnProdBtn;
@property (retain, nonatomic) IBOutlet UIButton *appealBtn;

@property (retain, nonatomic) NSString * orderNum;
@property (assign, nonatomic) int productType;

@property (assign, nonatomic) int Type;

- (IBAction)touchUpInsideOn:(id)sender;

@end
