//
//  StartApealViewController.h
//  miaozhuan
//
//  Created by Santiago on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StartApealDelegate <NSObject>

- (void)refresh;
@end

@interface StartApealViewController : DotCViewController
@property (assign, nonatomic)int orderId;
@property (assign, nonatomic)id<StartApealDelegate>delegate;
@end


