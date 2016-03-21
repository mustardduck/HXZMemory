//
//  ConvertionCenterSetting.m
//  miaozhuan
//
//  Created by Santiago on 14-11-15.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ConvertionCenterSetting.h"
#import "SetConvertCenterViewController.h"
#import "OwnManagerListViewController.h"
@interface ConvertionCenterSetting ()

@end

@implementation ConvertionCenterSetting

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"兑换点管理"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)setConvertCenter:(id)sender {
    //设置兑换点
    PUSH_VIEWCONTROLLER(SetConvertCenterViewController);
}

- (IBAction)chackConvertManager:(id)sender {
    
    PUSH_VIEWCONTROLLER(OwnManagerListViewController);
}

@end
