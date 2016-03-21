//
//  DatePickerViewController.h
//  TouchShare
//
//  Created by zengbixing on 13-3-7.
//  Copyright (c) 2013年 zengbixing. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SVProgressHUD.h"

@protocol DatePickerDelegate <NSObject>

- (void) selectDateCallBack:(NSDate*)date;

- (void) cancelDateCallBack:(NSDate*)date;

@end

@interface DatePickerViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIBarButtonItem *cancelItem;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *okItem;
@property (nonatomic, retain) IBOutlet UIDatePicker *picker;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) IBOutlet UIView *subView;
@property (nonatomic, retain) IBOutlet UIButton *fullBtn;
@property (retain, nonatomic) IBOutlet UILabel *titleLable;

@property (assign) id<DatePickerDelegate> delegate;

- (IBAction) touchUpInSideOnBtn:(id)sender;

-(void) initwithtitles : (NSInteger) tags;

- (void) setMaxDate:(NSDate *)date;

-(BOOL) checkField :(NSDate *)astartDate endDate : (NSDate *)aendDate;  //开始时间不能大于结束时间

@end
