//
//  ZhiFuPwdEditController.h
//  miaozhuan
//
//  Created by momo on 15/6/1.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhiFuPwdEditController : DotCViewController

@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, retain) NSString * secCode;
@property (nonatomic, assign) BOOL isForgot;
@property (nonatomic, retain) NSString * ValidateCode;


@property (nonatomic, assign) int zhifuPwdFromType;//从哪里过来的
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSMutableDictionary *dataDic;
@property (nonatomic, copy) NSString *type;//类型
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, assign) BOOL isGold;
@property (nonatomic, assign) BOOL isTuiHuo;
@property (retain, nonatomic) NSString * orderNum;
@property (assign, nonatomic) int orderType;

//@property (nonatomic, assign) BOOL isJinBiNum;

@end
