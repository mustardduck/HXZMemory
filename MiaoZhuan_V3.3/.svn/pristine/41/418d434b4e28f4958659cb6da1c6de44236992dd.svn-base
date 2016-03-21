//
//  LoveAccountViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-3.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "LoveAccountViewController.h"
#import "RRAttributedString.h"
#import "WebhtmlViewController.h"

@interface LoveAccountViewController ()

@property (retain, nonatomic) IBOutlet UILabel *lblOwnLoveAccount;
@property (retain, nonatomic) IBOutlet UILabel *lblCompanyAccount;
@property (retain, nonatomic) IBOutlet UIScrollView *scroller;

@end

@implementation LoveAccountViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigateTitle:@"爱心账户"];
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"说明"];
    if ([[UIScreen mainScreen] bounds].size.height < 568)
    {
        [_scroller setContentSize:CGSizeMake(320, 635)];
    }
    [self refreshPage];
}

#pragma mark - 事件
- (void)refreshPage{
    
    NSString *lovingIntegral = [[NSUserDefaults standardUserDefaults] valueForKey:@"LovingHeartIntegral"];
    if (!lovingIntegral.length) {
        lovingIntegral = @"0";
    }
    NSString *str = [NSString stringWithFormat:@"您贡献了爱心银元  %@", lovingIntegral];
    NSAttributedString *attributedString = [RRAttributedString setText:str
                                                                 color:RGBCOLOR(240, 5, 0)
                                                                 range:NSMakeRange(9, str.length - 9)];
    _lblOwnLoveAccount.attributedText = attributedString;
    NSString *company = [[NSUserDefaults standardUserDefaults] valueForKey:@"CompanyIntegral"];
    if (!company.length) {
        company = @"0";
    }
    _lblCompanyAccount.text = company;
}

//说明
- (void)onMoveFoward:(UIButton *)cattributedString{
    
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.navTitle = @"说明";
    model.ContentCode = @"9b281070c4a33adc7b0636ec935c49fe";
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_lblOwnLoveAccount release];
    [_lblCompanyAccount release];
    [_scroller release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLblOwnLoveAccount:nil];
    [self setLblCompanyAccount:nil];
    [super viewDidUnload];
}
@end
