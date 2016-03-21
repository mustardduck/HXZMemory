//
//  DatePickerViewController.m
//  TouchShare
//
//  Created by zengbixing on 13-3-7.
//  Copyright (c) 2013年 zengbixing. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

@synthesize cancelItem;
@synthesize okItem;
@synthesize picker;
@synthesize subView;
@synthesize delegate;
@synthesize fullBtn;
@synthesize toolBar;
@synthesize titleLable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) initwithtitles : (NSInteger) tags
{
    if (tags == 1)
    {
        self.titleLable.text = @"生日";
    }
    else if (tags == 2)
    {
        self.titleLable.text = @"开始时间";
    }
    else if (tags == 3)
    {
        self.titleLable.text = @"结束时间";
    }
    else if (tags == 0)
    {
        self.titleLable.text = @"";
    }

}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.picker.backgroundColor = [UIColor whiteColor];
    }
}



- (void) setMaxDate:(NSDate *)date{
    if (self.picker) {
        [self.picker setMaximumDate:date];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc{
    
    self.delegate = nil;
    self.cancelItem = nil;
    self.okItem = nil;
    self.picker = nil;
    self.toolBar = nil;
    self.subView = nil;
    self.fullBtn = nil;
    self.titleLable = nil;
    [super dealloc];
}

- (IBAction) touchUpInSideOnBtn:(id)sender{
    
    if (sender == okItem) {
        
        if (delegate&&[delegate respondsToSelector:@selector(selectDateCallBack:)]) {
            
            [delegate selectDateCallBack:self.picker.date];
        }
    }
    else if (sender == cancelItem||sender == self.fullBtn){
        
        if (delegate&&[delegate respondsToSelector:@selector(cancelDateCallBack:)]) {
            
            [delegate cancelDateCallBack:self.picker.date];
        }
    }
}

-(BOOL) checkField :(NSDate *)astartDate endDate : (NSDate *)aendDate
{
    if ( astartDate && aendDate) {
            
    NSTimeInterval aa = [aendDate timeIntervalSinceDate:astartDate];
            
    if (aa < 0) {
                
        [HUDUtil showErrorWithStatus:@"结束时间不能早于开始时间"];
        
                return YES;
        }
    }
    return NO;
}



- (void)viewDidUnload {
    [self setTitleLable:nil];
    [super viewDidUnload];
}
@end
