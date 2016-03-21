//
//  MoneyFromPacketViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-10-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MoneyFromPacketViewController.h"
#import "MoneyFromPacketCell.h"
@interface MoneyFromPacketViewController ()<UITableViewDataSource, UITableViewDelegate> {

    IBOutlet UITableView *_mainTable;
    IBOutlet UIView *_sectionHead;
    IBOutlet UILabel *_sectionHeadLabel;
}

@end

@implementation MoneyFromPacketViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [_mainTable registerNib:[UINib nibWithNibName:@"MoneyFromPacketCell" bundle:nil] forCellReuseIdentifier:@"MoneyFromPacketCell"];
}

#pragma mark -UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return _sectionHead;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {


    return 28;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 58;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    MoneyFromPacketCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"MoneyFromPacketCell" forIndexPath:indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_mainTable release];
    [_sectionHead release];
    [_sectionHeadLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [_mainTable release];
    _mainTable = nil;
    [_sectionHead release];
    _sectionHead = nil;
    [_sectionHeadLabel release];
    _sectionHeadLabel = nil;
    [super viewDidUnload];
}
@end
