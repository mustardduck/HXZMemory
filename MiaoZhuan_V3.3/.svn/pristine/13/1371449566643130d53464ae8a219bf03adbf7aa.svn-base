//
//  LoginViewController.m
//  DotC
//
//  Created by xm01 on 14-10-21.
//  Copyright (c) 2014年 BIN. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterOneViewController.h"
#import "LogonViewController.h"
#import "UICommon.h"
#import "UIView+expanded.h"
#import "Redbutton.h"

@interface LoginViewController ()

@property (retain, nonatomic) IBOutlet UIImageView *backGroundImage;
@property (retain, nonatomic) IBOutlet Redbutton *registerBtn;
@property (retain, nonatomic) IBOutlet UIButton *loginBtn;

- (IBAction)touchUpInsideBtn:(id)sender;

@end

@implementation LoginViewController

@synthesize registerBtn = _registerBtn;
@synthesize loginBtn = _loginBtn;
@synthesize backGroundImage = _backGroundImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@",[DotCUIManager instance].mainNavigationController.viewControllers);
    
    [_registerBtn roundCorner];

    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 5.0;
    _loginBtn.layer.borderWidth = 1.0;
    _loginBtn.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];
    
    CGFloat offsetY = [UICommon getIos4OffsetY];
 
    if (offsetY > 0)
    {
        [_backGroundImage setFrame:CGRectMake(0, 0, 320, 568)];
        _backGroundImage.image = [UIImage imageNamed:@"login568"];
        
        [_registerBtn setFrame:CGRectMake(30, 483, 120, 40)];
        [_loginBtn setFrame:CGRectMake(170, 483, 120, 40)];
    }
    else
    {
        [_backGroundImage setFrame:CGRectMake(0, 0, 320, 480)];
        _backGroundImage.image = [UIImage imageNamed:@"login480"];
        
        [_registerBtn setFrame:CGRectMake(30, 405, 120, 40)];
        [_loginBtn setFrame:CGRectMake(170, 405, 120, 40)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [_registerBtn release];
    [_loginBtn release];
    [_backGroundImage release];
    [super dealloc];
}
- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _registerBtn)
    {
        PUSH_VIEWCONTROLLER(RegisterOneViewController);
    }
    else if (sender == _loginBtn)
    {
        PUSH_VIEWCONTROLLER(LogonViewController);
    }
}


@end
