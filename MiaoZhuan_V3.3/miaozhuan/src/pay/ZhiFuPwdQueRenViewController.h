//
//  ZhiFuPwdQueRenViewController.h
//  miaozhuan
//
//  Created by apple on 15/6/1.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZhiFuPwdQueRenViewController : DotCViewController

//银元金币流通信息
@property (nonatomic, retain) NSMutableDictionary *dataDic;//对方信息
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isGold;


@property (nonatomic, copy) NSString *type;//类型

//确认收货
@property (nonatomic, copy) NSString *OrderId;
@property (nonatomic, assign) BOOL isTuiHuo;
@property (retain, nonatomic) NSString * orderNum;
@property (assign, nonatomic) int orderType;


//易货商城
@property (assign, nonatomic) int ptype;
//@property (nonatomic, assign) BOOL isJinBiNum;
@property (nonatomic, retain)NSArray *goodsInfo;

@end
