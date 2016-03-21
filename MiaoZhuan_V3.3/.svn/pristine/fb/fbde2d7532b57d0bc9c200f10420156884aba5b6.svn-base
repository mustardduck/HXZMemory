//
//  ManagerInConvertCenter.m
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ManagerInConvertCenter.h"
#import "ManagerInConvertCenterCell.h"
#import "ConvertionForAManager.h"
#import "UIView+expanded.h"

@interface ManagerInConvertCenter ()<UITableViewDataSource, UITableViewDelegate, UpdateAfterCancleManagerPermission>
@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (retain, nonatomic) IBOutlet UIView *tableHead;
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) MJRefreshController *mjCon;
@property (retain, nonatomic) IBOutlet UIView *nodataView;
@end

@implementation ManagerInConvertCenter
@synthesize mainTable = _mainTable;
@synthesize tableHead = _tableHead;
@synthesize dataSource = _dataSource;
@synthesize mjCon = _mjCon;
@synthesize nodataView = _nodataView;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"查看管理员"];
    [_mainTable setTableHeaderView:_tableHead];
    [_mainTable registerNib:[UINib nibWithNibName:@"ManagerInConvertCenterCell" bundle:nil] forCellReuseIdentifier:@"ManagerInConvertCenterCell"];
    [self setUpRefreshItem];
}

- (void)setUpRefreshItem {

    NSString *refreshName = @"api/SilverAdvert/GetExchangeManagers";
    
    __block ManagerInConvertCenter *weakSelf = self;
    
    self.mjCon = [MJRefreshController controllerFrom:_mainTable name:refreshName];
    
    [self.mjCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK {
    
        return @{
                 @"service":refreshName,
                 @"parameters":@{
                         @"PageIndex":@(pageIndex),
                         @"PageSize":@(pageSize)
                         }
                 }.wrapper;
    }];
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE {
    
        if (netData.operationSucceed) {
            
            DictionaryWrapper *item = netData.data;
            
            weakSelf.dataSource = [item getArray:@"PageData"];
            
            NSLog(@"%lu", (unsigned long)[_dataSource count]);
            if ([_dataSource count] == 0) {
                
                self.nodataView.hidden = NO;
            }else {
                
                self.nodataView.hidden = YES;
            }
        }else {
            self.nodataView.hidden = NO;
        }
        
        [_mainTable reloadData];
    };
    [_mjCon setOnRequestDone:block];
    [_mjCon setPageSize:30];
    [_mjCon refreshWithLoading];
}
#pragma mark - UpDateListAfterCancleManagerPermission
- (void)refreshList {

    [_mjCon refreshData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _mjCon.refreshCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ManagerInConvertCenterCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"ManagerInConvertCenterCell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSString *temp = [NSString stringWithFormat:@"%d",[[[_mjCon dataAtIndex:(int)indexPath.row] wrapper]getInt:@"ExchangeAddressCount"]];
    [cell setUpLayouts:temp];

    [cell.headImage roundCornerBorder];
    [cell.headImage requestPicture:[[[_mjCon dataAtIndex:(int)indexPath.row] wrapper]getString:@"PictureUrl"]];
    cell.headImage.layer.cornerRadius = 11.0f;
    cell.name.text = [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper]getString:@"Name"];
    cell.phoneNumber.text = [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"Phone"];
    [cell.buttomLineView setFrame:CGRectMake(0, 79.5, 320, 0.5)];
    
    if (indexPath.row == _mjCon.refreshCount - 1) {
        
        cell.buttomLineView.hidden = NO;
    }else {
    
        cell.buttomLineView.hidden = YES;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *temp = WEAK_OBJECT(UIView, init);
    [temp setBackgroundColor:RGBCOLOR(239, 239, 244)];
    return temp;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *temp = WEAK_OBJECT(UIView, init);
    [temp setBackgroundColor:RGBCOLOR(239, 239, 244)];
    return temp;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.001;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ConvertionForAManager *temp = WEAK_OBJECT(ConvertionForAManager, init);
    temp.managerId = [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getInt:@"Id"];
    temp.delegate = self;
    [self.navigationController pushViewController:temp animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [AlertUtil showAlert:@"确认删除"
                     message:@"一旦删除，则不可以恢复"
                     buttons:@[
                               @"取消",
                               @{
                                   @"title":@"确定",
                                   @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
            
            ADAPI_DeleteConvertManager ([self genDelegatorID:@selector(delManager:)], [[_dataSource[indexPath.row] wrapper]getInt:@"Id"]);
        })}]];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManagerInConvertCenterCell *cell = (ManagerInConvertCenterCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManagerInConvertCenterCell *cell = (ManagerInConvertCenterCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)delManager:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed) {
        
        [HUDUtil showSuccessWithStatus:@"删除成功"];
        [_mjCon refreshWithLoading];
    }else {
    
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_dataSource release];
    [_mainTable release];
    [_tableHead release];
    [_nodataView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainTable:nil];
    [self setTableHead:nil];
    [super viewDidUnload];
}
@end
