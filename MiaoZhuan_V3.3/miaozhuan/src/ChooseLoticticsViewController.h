//
//  ChooseLoticticsViewController.h
//  miaozhuan
//
//  Created by Santiago on 15-1-4.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseLoticsDelegate <NSObject>

- (void)refresh;
@end
@interface ChooseLoticticsViewController : DotCViewController
@property (assign, nonatomic)int orderId;
@property (assign, nonatomic)id<ChooseLoticsDelegate>delagate;
@end
