//
//  MyMarketMyOrderListController.h
//  miaozhuan
//
//  Created by momo on 14-12-26.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMarketMyOrderListController : DotCViewController
@property (retain, nonatomic) IBOutlet UIButton *allBtn;
@property (retain, nonatomic) IBOutlet UIButton *waitToPayBtn;
@property (retain, nonatomic) IBOutlet UIButton *waitToShipBtn;
@property (retain, nonatomic) IBOutlet UIButton *waitToReceiveBtn;
@property (retain, nonatomic) IBOutlet UIView *lineView;
@property (retain, nonatomic) IBOutlet UITableView *mainTableView;

//0-全部，1-待付款，2-待发货，3-待收货，4-退换/售后

@property (assign) int queryType;
@property (assign, nonatomic) BOOL isReturnMoney;

- (IBAction)touchUpInsideOn:(id)sender;

@end
