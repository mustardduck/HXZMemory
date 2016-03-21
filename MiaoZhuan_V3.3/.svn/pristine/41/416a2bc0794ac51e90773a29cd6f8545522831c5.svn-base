//
//  ProfileNameViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ProfileNameViewController.h"
#import "RRLineView.h"

@interface ProfileNameViewController ()<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *nameLable;
@property (retain, nonatomic) IBOutlet RRLineView *lineImage;

@end

@implementation ProfileNameViewController
@synthesize nameLable = _nameLable;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _nameLable.text = _name;
    
    [self addDoneToKeyboard:_nameLable];
    
    _lineImage.top = 49.5;
    
    [self setupMoveBackButtonWithTitle:@"取消"];
    
    [self setupMoveFowardButtonWithTitle:@"保存"];
}

-(void)hiddenKeyboard
{
    [_nameLable resignFirstResponder];
}

- (IBAction) onMoveBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onMoveFoward:(UIButton *)sender
{
    if (![_nameLable.text isEqualToString:_name])
    {
        //有一项改动
        [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"ChangeUsers"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".TrueName" string:_nameLable.text];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (_nameLable == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 15)
        {
            textField.text = [toBeString substringToIndex:15];
            return NO;
        }
    }
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_nameLable release];
    [_lineImage release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setNameLable:nil];
    [self setLineImage:nil];
    [super viewDidUnload];
}
@end
