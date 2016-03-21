//
//  MyMarketMyOrderReturnProdController.h
//  miaozhuan
//
//  Created by momo on 14/12/30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMarketMyOrderReturnProdController : DotCViewController
@property (retain, nonatomic) IBOutlet UIButton *reasonBtn;
@property (retain, nonatomic) IBOutlet UITextField *totalPriceLbl;
@property (retain, nonatomic) IBOutlet UIButton *desBtn;

@property (retain, nonatomic) NSString * totalPrice;
@property (retain, nonatomic) NSString * orderId;
@property (retain, nonatomic) NSString * orderNo;
@property (assign, nonatomic) int orderType;

@property (assign, nonatomic) BOOL isReturnMoney;

- (IBAction)touchUpInsideOn:(id)sender;

@end
