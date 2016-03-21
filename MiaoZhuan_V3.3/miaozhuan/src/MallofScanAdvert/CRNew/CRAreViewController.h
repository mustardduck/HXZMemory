//
//  CRAreViewController.h
//  miaozhuan
//
//  Created by abyss on 15/1/7.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRAreViewController;
@protocol CRAreViewControllerDelegate <NSObject>
@optional
- (void) AreControl:(CRAreViewController *)view select:(NSString *)city;
@end
@interface CRAreViewController : DotCViewController
@property (assign) id<CRAreViewControllerDelegate> delegate;
@end
