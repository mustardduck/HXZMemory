//
//  IndustryPicker.h
//  linphone
//
//  Created by zengbixing on 13-10-7.
//
//

#import <UIKit/UIKit.h>

@class IndustryPicker;

@protocol IndustryPickerDelegate <NSObject>

@optional

- (void)pickerDidChaneStatus:(IndustryPicker *)picker;

- (void)pickerIndustryOk:(IndustryPicker *)picker;

- (void)pickerIndustryCancel:(IndustryPicker *)picker;

@end

@interface IndustryPicker : UIView<UIPickerViewDelegate, UIPickerViewDataSource>{
    
    id <IndustryPickerDelegate> _delegate;
    
}

@property (assign, nonatomic) id <IndustryPickerDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIPickerView *locatePicker;
@property (retain, nonatomic) IBOutlet UIButton *fullBtn;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *cancelItem;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *okItem;
@property (nonatomic, retain) IBOutlet UILabel *titlelabel;
@property (copy, nonatomic) NSString *curText;
@property (assign) NSInteger index;


@property (retain, nonatomic) NSArray *srcArr;

-(id) initwithtitles : (NSInteger) tags;

- (id)initWithStyle:(id <IndustryPickerDelegate>)delegate pickerData:(NSArray*)arr;

- (IBAction) touchUpInSideOnBtn:(id)sender;

@end
