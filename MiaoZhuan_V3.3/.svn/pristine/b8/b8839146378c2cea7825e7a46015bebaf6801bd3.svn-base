//
//  PickerViewSelfDefined.h
//  miaozhuan
//
//  Created by Santiago on 14-11-5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantLocation.h"

typedef enum {
    
    ONELEVEL = 1,
    TWOLEVEL,
    THREELEVEL,
    ONELEVELSELFDEFINED,
    NORMALPICKERVIEWSTYLE
}PickerIdentify;

@class PickerViewSelfDefined;

@protocol PickerViewSelfDefineDelegate <NSObject>

@optional

- (void)pickerDidChangeContent:(PickerViewSelfDefined *)picker;
- (void)pickerClearContent:(PickerViewSelfDefined*)picker;
- (void)pushAnotherPicker:(NSString*)string;
- (void)refreshData:(PickerViewSelfDefined *)picker;
- (void)endOperating;
@end

@interface PickerViewSelfDefined : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (assign, nonatomic) id<PickerViewSelfDefineDelegate>delegate;
@property (retain, nonatomic) IBOutlet UIPickerView *locatePicker;
@property (strong, nonatomic) MerchantLocation *locate;
@property (strong, nonatomic) id userData;
@property (assign, nonatomic) PickerIdentify name;

- (id)initPickerWithDelegate:(id <PickerViewSelfDefineDelegate>)delegate name:(PickerIdentify)name userData:(id)userData array:(NSArray*)array;

- (void)showInView:(UIView*)view;
- (void)removePicker;
@end
