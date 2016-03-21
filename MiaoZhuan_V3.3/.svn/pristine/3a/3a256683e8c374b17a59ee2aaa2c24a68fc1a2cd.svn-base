//
//  OrderViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-3.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderByTimeCell.h"

@interface OrderViewController (){
    NSInteger _currentRow;
}

@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic ,retain) NSArray *tableArray;

@end

float cellHeight = 45;

@implementation OrderViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    _currentRow = 0;
    [super viewDidLoad];
    [self.tableview registerNib:[UINib nibWithNibName:@"OrderByTimeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OrderByTimeCell"];
}

- (void)setDataArray:(NSArray *)dataArray{
    self.tableArray = dataArray;
    [self.tableview reloadData];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"OrderByTimeCell";
    OrderByTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = (indexPath.row == _currentRow) ? UITableViewCellSeparatorStyleNone : UITableViewCellSelectionStyleGray;
    cell.data = _tableArray[indexPath.row];
    cell.btnOrderType.selected = (indexPath.row == _currentRow);
    if (_currentRow == indexPath.row) {
        cell.btnOrderType.titleEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 0);
    } else {
        cell.btnOrderType.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _currentRow = indexPath.row;
    [tableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"orderbytime" object:@[@(_currentRow),_tableArray[_currentRow]]];
}

#pragma mark - 内存管理

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableArray release];
    [_dataArray release];
    [_tableview release];
    [_hview release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setDataArray:nil];
    [self setTableview:nil];
    [super viewDidUnload];
}
@end
