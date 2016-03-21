//
//  IndustryPicker.m
//  linphone
//
//  Created by zengbixing on 13-10-7.
//
//

#import "IndustryPicker.h"

@implementation IndustryPicker

@synthesize delegate = _delegate;
@synthesize locatePicker;
@synthesize fullBtn;
@synthesize cancelItem;
@synthesize okItem;
@synthesize titlelabel;
@synthesize srcArr;
@synthesize curText;
@synthesize index;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initwithtitles : (NSInteger) tags
{
    self = [super init];
    if (tags == 1)
    {
        self.titlelabel.text = @"性别";
    }
    else if (tags == 2)
    {
        self.titlelabel.text = @"收入区间";
    }
    else if (tags == 0)
    {
        self.titlelabel.text = @"";
    }
    else if (tags == 3)
    {
        self.titlelabel.text = @"请选择退款原因";
    }
    else if (tags == 4)
    {
        self.titlelabel.text = @"请选择退货原因";
    }
    return self;
}


- (id)initWithStyle:(id <IndustryPickerDelegate>)delegate pickerData:(NSArray*)arr{
    
    self = [[[[NSBundle mainBundle] loadNibNamed:@"IndustryPicker" owner:self options:nil] objectAtIndex:0] retain];
    
    if (self) {
        
        if ([[UIScreen mainScreen] bounds].size.height < 568) {
            
        }
        else
        {
            self.fullBtn.frame = CGRectMake(0, 0, 320, fullBtn.frame.size.height + 68);
        }
        
        self.srcArr = arr;
        
        [self.srcArr retain];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
            
            self.locatePicker.backgroundColor = [UIColor whiteColor];
        }
    }
    
    return self;
}

- (void) dealloc{
    
    [self.srcArr release];
    
    self.srcArr = nil;
    
    [super dealloc];
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [self.srcArr count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    return [self.srcArr objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        
        [self.delegate pickerDidChaneStatus:self];
    }
    
    self.curText = [self.srcArr objectAtIndex:row];
    
    self.index = row;
}

- (IBAction) touchUpInSideOnBtn:(id)sender{
    
    if (self.curText == nil&&[self.srcArr count] > 0) {
        
        self.curText = [self.srcArr objectAtIndex:0];
    }
    
    if (sender == okItem) {
        
        if (_delegate&&[_delegate respondsToSelector:@selector(pickerIndustryOk:)]) {
            
            [_delegate pickerIndustryOk:self];
        }
    }
    else if (sender == cancelItem||sender == self.fullBtn){
        
        if (_delegate&&[_delegate respondsToSelector:@selector(pickerIndustryCancel:)]) {
            
            [_delegate pickerIndustryCancel:self];
        }
    }
}

@end
