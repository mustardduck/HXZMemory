//
//  RRDatePickerView.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-21.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RRDatePickerDelegate;

@interface RRDatePickerView : UIView

/**
 *初始化方法
 */
- (instancetype)initWithTitle:(NSString *)title;

@property (retain, nonatomic) IBOutlet UIBarButtonItem *titleItem;

@property (nonatomic, assign) id<RRDatePickerDelegate> delegate;

- (void) setMaxDate:(NSDate *)date;
- (void) setMinDate:(NSDate *)date;
- (BOOL)checkField:(NSDate *)startDate endDate:(NSDate *)endDate;
@end

@protocol RRDatePickerDelegate <NSObject>

- (void)getDateFromDatePickerWithDate:(NSString *)formatDate;

- (void)clickSelectDatePickerWithDate:(NSDate *)date;

- (void)clickCancelDatePickerWithDate:(NSDate *)date;

@end