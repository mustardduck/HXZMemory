//
//  ApplytoGetCash3ViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ApplytoGetCash3ViewController.h"

@interface ApplytoGetCash3ViewController ()
@property (retain, nonatomic) IBOutlet UIImageView *icon;
@property (retain, nonatomic) IBOutlet UILabel *orderNumberLabel;
@end

@implementation ApplytoGetCash3ViewController
@synthesize orderNumberLabel = _orderNumberLabel;
@synthesize icon = _icon;
@synthesize orderNumber = _orderNumber;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏后退按钮
    [self setupMoveBackButtonWithTitle:@""];
    [self setTitle:@"提现详情"];
    [self setupMoveFowardButtonWithTitle:@"完成"];
    [self.icon setImage:[UIImage imageNamed:@"applyToGetCash.png"]];
    self.orderNumberLabel.text = _orderNumber;
}

- (void)onMoveBack:(UIButton *)sender {

}

- (IBAction) onMoveFoward:(UIButton*) sender {
    
    int x = [APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".IFHAVEONLYONEBANKCARD"];
    if (x == 1) {
        
        UINavigationController* navigationController = self.navigationController;
        [navigationController popViewControllerAnimated:FALSE];
        [navigationController popViewControllerAnimated:FALSE];
        [navigationController popViewControllerAnimated:FALSE];
        [navigationController popViewControllerAnimated:FALSE];
    }else {
    
        UINavigationController* navigationController = self.navigationController;
        [navigationController popViewControllerAnimated:FALSE];
        [navigationController popViewControllerAnimated:FALSE];
        [navigationController popViewControllerAnimated:FALSE];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_orderNumber release];
    [_orderNumberLabel release];
    [_icon release];
    [super dealloc];
}
@end
