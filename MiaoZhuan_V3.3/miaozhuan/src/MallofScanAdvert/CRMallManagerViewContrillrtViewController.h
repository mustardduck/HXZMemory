//
//  CRMallManagerViewContrillrtViewController.h
//  miaozhuan
//
//  Created by Abyss on 15-1-10.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRMallManagerViewContrillrtViewController : DotCViewController

#pragma mark - sliver request
@property (assign) CGFloat   minYinPoint;
@property (assign) CGFloat   maxYinPoint;
@property (assign) NSInteger searchType;
@property (assign) NSInteger CategoryId;
@property (retain) NSString* Province;
@property (retain) NSString* City;
@property (retain) NSString* District;
#pragma mark - gold request
@property (assign) CGFloat   minJinPoint;
@property (assign) CGFloat   maxJinPoint;
@property (assign) NSInteger OrderType;     //0、最新上架排序，1、销量排序，2、价格升序，3、价格降序
@property (assign) NSInteger ProductCatagoryId;
@property (assign) BOOL      IsVipRequired;

@end
