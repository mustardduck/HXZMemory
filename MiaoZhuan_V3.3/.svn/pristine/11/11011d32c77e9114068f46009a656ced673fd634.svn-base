//
//  ApealingViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ApealingViewController.h"

@interface ApealingViewController ()

@end

@implementation ApealingViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"协商退货"];
}

- (IBAction)offiiceNumber:(id)sender {
    
    if([CTSIMSupportGetSIMStatus() isEqualToString:kCTSIMSupportSIMStatusNotInserted]){
        
        [HUDUtil showErrorWithStatus:@"请先插入SIM卡"];
    }else{
        
        [[UICommon shareInstance]makeCall:@"4004193588"];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
