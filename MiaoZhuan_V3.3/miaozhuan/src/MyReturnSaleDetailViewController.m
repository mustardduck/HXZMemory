//
//  MyReturnSaleDetailViewController.m
//  miaozhuan
//
//  Created by Santiago on 15-1-14.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "MyReturnSaleDetailViewController.h"
#import "BaseSalesReturnCell.h"

@interface MyReturnSaleDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *mainTable;

@end

@implementation MyReturnSaleDetailViewController
@synthesize mainTable = _mainTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"协商退货"];
    [self setupMoveBackButton];
}


#pragma mark -UITableViewDelegate
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return 10;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//
//
//}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_mainTable release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainTable:nil];
    [super viewDidUnload];
}
@end
