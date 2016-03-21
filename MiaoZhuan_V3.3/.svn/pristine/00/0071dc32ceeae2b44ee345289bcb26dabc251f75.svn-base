//
//  RRDatePickerView.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-21.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RRDatePickerView.h"

@interface RRDatePickerView()

@property (retain, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation RRDatePickerView

- (instancetype)initWithTitle:(NSString *)title{
    
    self = [[[[NSBundle mainBundle] loadNibNamed:@"RRDatePickerView" owner:self options:nil] firstObject] retain];
    if (self) {
        self.titleItem.title = title.length ? title : @"";
    }
    return self;
}

- (void) setMaxDate:(NSDate *)date{
    
    if (self.datePicker) {
        [self.datePicker setMaximumDate:date];
    }
}

- (void) setMinDate:(NSDate *)date{
    
    if (self.datePicker) {
        [self.datePicker setMinimumDate:date];
    }
}

- (BOOL)checkField:(NSDate *)startDate endDate:(NSDate *)endDate{
    
    if ( startDate && endDate) {
        if ([endDate earlierDate:startDate]) {
            [HUDUtil showErrorWithStatus:@"结束时间不能早于开始时间!"];
            return YES;
        }
    }
    return NO;
}

- (IBAction)dateChanged:(UIDatePicker *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(getDateFromDatePickerWithDate:)]) {
        
        NSDateFormatter *formatter = WEAK_OBJECT(NSDateFormatter, init);
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
        
        NSString *datestr = [formatter stringFromDate:sender.date];
        
        [_delegate getDateFromDatePickerWithDate:datestr];
    }
    
}

//取消
- (IBAction)cancelButtonClicked:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickCancelDatePickerWithDate:)]) {
        [_delegate clickCancelDatePickerWithDate:_datePicker.date];
    }
}
//确定
- (IBAction)confirmButtonClicked:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickSelectDatePickerWithDate:)]) {
        [_delegate clickSelectDatePickerWithDate:_datePicker.date];
    }
}


- (void)dealloc {
    _delegate = nil;
    [_titleItem release];
    [_datePicker release];
    [super dealloc];
}
@end
