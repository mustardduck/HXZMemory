//
//  RequestFailedView.h
//  miaozhuan
//
//  Created by 孙向前 on 15-1-23.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RRRequestFailedDelegate;

@interface RequestFailedView : UIView

+ (instancetype)shareInstance;

- (UIView *)createFailedHoverViewWithFrame:(CGRect)frame;

@property (nonatomic, assign) id<RRRequestFailedDelegate> delegate;

@end

@protocol RRRequestFailedDelegate <NSObject>

- (void)didClickRefreshBUtton;

@end