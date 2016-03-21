//
//  ZhiFuPwdYanZhengViewController.h
//  miaozhuan
//
//  Created by apple on 15/6/29.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhiFuPwdYanZhengViewController : DotCViewController


@property (nonatomic, assign) int zhifuPwdFromType;//从哪里过来的
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSMutableDictionary *dataDic;
@property (nonatomic, copy) NSString *type;//类型
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, assign) BOOL isGold;
@property (nonatomic, assign) BOOL isTuiHuo;
@property (retain, nonatomic) NSString * orderNum;
@property (assign, nonatomic) int orderType;

@end
