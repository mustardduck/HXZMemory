//
//  ShippingViewController.h
//  miaozhuan
//
//  Created by apple on 14/12/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShippingDelegate;
@interface ShippingViewController : DotCViewController

@property (retain, nonatomic) NSString * OrderNumber;

@property (retain, nonatomic) NSString * orderType;

@property (retain, nonatomic) NSString * EnterpriseId;

@property (retain, nonatomic) NSString * type;

@property (assign) id<ShippingDelegate> delegate;
@end

@protocol ShippingDelegate <NSObject>

- (void)stateShouldBeChange:(NSString *)state;

@end