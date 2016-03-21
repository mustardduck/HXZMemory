//
//  CheckManagerViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-15.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CheckManagerViewController.h"
#import "CheckManagerTableViewCell.h"
@interface CheckManagerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (retain, nonatomic) IBOutlet UILabel *tableHeadView;
@end

@implementation CheckManagerViewController
@synthesize mainTable = _mainTable;
@synthesize tableHeadView = _tableHeadView;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"查看管理员"];
    [_mainTable setTableHeaderView:_tableHeadView];
    [_mainTable registerNib:[UINib nibWithNibName:@"CheckManagerTableViewCell" bundle:nil] forCellReuseIdentifier:@"CheckManagerTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 77;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *temp = WEAK_OBJECT(UIView, init);
    [temp setBackgroundColor:[UIColor clearColor]];
    return temp;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     CheckManagerTableViewCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"CheckManagerTableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
//选中变暗动画
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//滑动删除代理
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setEditing:NO animated:YES];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)dealloc {
    [_mainTable release];
    [_tableHeadView release];
    [super dealloc];
}
@end
