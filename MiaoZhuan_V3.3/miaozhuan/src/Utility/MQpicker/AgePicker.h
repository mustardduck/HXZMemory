//
//  AgePicker.h
//  miaozhuan
//
//  Created by momo on 14-12-3.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AgePicker;

@protocol AgePickerDelegate <NSObject>

@optional

- (void)pickerAgeDidChaneStatus:(AgePicker *)picker;

- (void)pickerAgeOk:(AgePicker *)picker;

- (void)pickerAgeCancel:(AgePicker *)picker;

@end

@interface AgePicker : UIView<UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSMutableArray * _ageFirstArr;
    
    NSMutableArray * _ageSecondArr;
}

@property (assign, nonatomic) id <AgePickerDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIButton *fullBtn;
@property (retain, nonatomic) IBOutlet UIPickerView *agePicker;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *cancelItem;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *okItem;
@property (retain, nonatomic) NSString * firstText;
@property (retain, nonatomic) NSString * secondText;
@property (retain, nonatomic) NSString * curText;
@property (assign, nonatomic) BOOL isAll;

- (IBAction) touchUpInsideOnBtn:(id)sender;

- (id)initWithStyle:(id <AgePickerDelegate>)delegate;
- (void) displayAgeView;

@end
