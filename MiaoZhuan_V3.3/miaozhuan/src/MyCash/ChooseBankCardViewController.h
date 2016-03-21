//
//  ChooseBankCardViewController.h
//  miaozhuan
//
//  Created by Santiago on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetChoosedBankCard <NSObject>
@optional
- (void)choosedBankCardData:(NSDictionary*)dic;
@end

@interface ChooseBankCardViewController : DotCViewController
@property (strong, nonatomic)NSArray *dataSource;
@property (nonatomic, assign)id<GetChoosedBankCard>delegate;
@end
