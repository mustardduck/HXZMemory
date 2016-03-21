//
//  AddBankCardViewController.h
//  miaozhuan
//
//  Created by Santiago on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddBankCardRefreshDelegate <NSObject>
- (void)refreshBankList;
@end
@interface AddBankCardViewController : DotCViewController
@property (nonatomic, assign) id<AddBankCardRefreshDelegate>delegate;
@property (strong, nonatomic)NSArray *dataSource;
@property (strong, nonatomic)NSDictionary *dicDataSource;
@end
