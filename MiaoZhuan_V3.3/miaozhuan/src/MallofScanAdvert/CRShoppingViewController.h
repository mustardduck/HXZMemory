//
//  CRShoppingViewController.h
//  miaozhuan
//
//  Created by abyss on 14/12/19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRShoppingViewController : DotCViewController
@property (retain) UITableView* tableView;
@property (retain) MJRefreshController* MJRefreshCon;
@property (retain, readonly) NSArray* viewArray;

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

@property (retain, nonatomic) IBOutlet UIButton *selectBt;
@property (retain, nonatomic) IBOutlet CommonTextField *textF1;
@property (retain, nonatomic) IBOutlet CommonTextField *textF2;

@property (assign)            NSInteger startPage;
- (void)select:(id)sender;
@end
