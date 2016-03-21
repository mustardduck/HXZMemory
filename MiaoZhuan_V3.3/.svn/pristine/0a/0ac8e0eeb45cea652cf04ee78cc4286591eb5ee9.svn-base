//
//  SelectListVC.h
//  guanggaoban
//
//  Created by CQXianMai on 14-8-10.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreeningListType.h"

@protocol SelectRightInfoDelegate <NSObject>

@optional

- (void)checkRightInfoName:(NSString *)chooseStr ListType:(NSInteger)type andSearchType:(NSInteger)searchType andSelectDate:(NSString *)dateStr;

@end

@interface SelectListVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) NSString* selectTitle;
@property (retain, nonatomic) IBOutlet UITableView *chooseList;
@property (retain, nonatomic) NSArray *listArr;
@property (retain, nonatomic) NSString *titleNameStr;
@property (assign, nonatomic) id<SelectRightInfoDelegate> delegate;
// 0榜单名称   1榜单时间
@property (assign, nonatomic) CheckListType listType;
@end
