//
//  HistoryLocationsViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "HistoryLocationsViewController.h"
#import "AreaListCell.h"

@interface HistoryLocationsViewController (){
    BOOL _isSelected;
}

@property (retain, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, retain) NSMutableArray *selectedArray;

@end

@implementation HistoryLocationsViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setNavigateTitle:@"历史定位地址"];
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    self.selectedArray = [NSMutableArray arrayWithCapacity:0];
    self.dataArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"Locations"]];
    
    _tableview.panGestureRecognizer.delaysTouchesBegan = YES;
//    [self setExtraCellLineHidden:_tableview];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    AreaListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AreaListCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lblArea.font = Font(17);
        cell.imgArrow.hidden = YES;
        cell.btnSelected.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.lblArea.text = [[_dataArray[indexPath.row] wrapper] getString:@"DetailAddress"];
    cell.btnSelected.selected = _isSelected;
    cell.btnSelected.tag = indexPath.row;
    [cell.btnSelected addTarget:self action:@selector(selectClicked:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - 事件
//勾选
- (void)selectClicked:(UIButton *)button{
    _isSelected = !button.selected;
    if (_isSelected) {
        [_selectedArray addObject:_dataArray[button.tag]];
    } else {
        [_selectedArray removeObjectAtIndex:button.tag];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
//保存
- (void)onMoveFoward:(UIButton *)sender{
    //保存
    if (!_selectedArray.count) {
        [HUDUtil showErrorWithStatus:@"暂无可保存的内容"];return;
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IsChanged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    for (NSString *str in _selectedArray) {
        if (![_dataArray containsObject:str]) {
            [_dataArray addObject:str];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:_dataArray forKey:@"CurrentLocations"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UI_MANAGER.mainNavigationController popViewControllerAnimated:YES];
}
//-(void)setExtraCellLineHidden: (UITableView *)tableView
//{
//    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
//    view.backgroundColor = [UIColor clearColor];
//    [tableView setTableFooterView:view];
//}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_tableview release];
    [super dealloc];
}
@end
