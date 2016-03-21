//
//  ConvertionForAManager.m
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ConvertionForAManager.h"
#import "ConvertionForAManagerCell.h"
#import "AppUtils.h"

@interface ConvertionForAManager ()<UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (strong, nonatomic) NSMutableArray *dataSourceArray;
@property (strong, nonatomic) MJRefreshController *mjCon;
@end

@implementation ConvertionForAManager
@synthesize managerId = _managerId;
@synthesize mainTable = _mainTable;
@synthesize dataSourceArray = _dataSourceArray;
@synthesize mjCon = _mjCon;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"管理兑换点"];
    [_mainTable registerNib:[UINib nibWithNibName:@"ConvertionForAManagerCell" bundle:nil] forCellReuseIdentifier:@"ConvertionForAManagerCell"];
    self.dataSourceArray = WEAK_OBJECT(NSMutableArray, init);
    [self setUpRefreshItem];
}

- (IBAction)onMoveBack:(UIButton *)sender {

    [self.delegate refreshList];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpRefreshItem {

    NSString *refreshname = @"api/SilverAdvert/GetExchangeAddressByManager";
    __block ConvertionForAManager *weakSelf = self;
    self.mjCon = [MJRefreshController controllerFrom:_mainTable name:refreshname];

    [self.mjCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK {
    
        return @{
                 @"service":refreshName,
                 @"parameters":@{
                         @"PageIndex":@(pageIndex),
                         @"PageSize":@(pageSize),
                         @"ExchangeManagerId":@(_managerId)
                         }
                 }.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE {
    
        if (netData.operationSucceed) {
            DictionaryWrapper *item = netData.data;
            weakSelf.dataSourceArray = [NSMutableArray arrayWithArray:[item getArray:@"PageData"]];
            [_mainTable reloadData];
        }else {
        
        }
    };
    [_mjCon setOnRequestDone:block];
    [_mjCon setPageSize:10];
    [_mjCon refreshWithLoading];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _mjCon.refreshCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *string = [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"DetailedAddress"];
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(255, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    
    if(size.height > 25)
    {
        size.height = 34;
    }
    else
        size.height = 15;
    
//    int cell_height = 193+size.height-21;
    int cell_height = 194+size.height-15;
    
    return cell_height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *temp = WEAK_OBJECT(UIView, init);
    return temp;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ConvertionForAManagerCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"ConvertionForAManagerCell" forIndexPath:indexPath];
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.companyNameLabel.text = [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"Name"];
    cell.phoneNumberLabel.text = [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"ContactNumber"];
    cell.convertLocationLabel.text = [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"DetailedAddress"];

    NSArray *array = [[[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"ExchangeTime"] componentsSeparatedByString:@"#"];
    NSMutableString *string = WEAK_OBJECT(NSMutableString, init);
    
    for (int i = 0; i<[array count]; i++) {
        
        [string appendString:array[i]];
    }
    
    cell.convertTimeLabel.text = [NSString stringWithFormat:@"兑换时间:%@",string];
    
    NSMutableString *temp = WEAK_OBJECT(NSMutableString, init);
    
    for (NSDictionary *dic in [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getArray:@"ExchangeManagers"]) {
        
        [temp appendString:[NSString stringWithFormat:@"%@ ",[[dic wrapper]getString:@"Phone"]]];
    }
    
    cell.convertManagersLabel.text = temp;
    cell.cancelPermissionOfManagement.tag = [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper]getInt:@"Id"];
    [cell.cancelPermissionOfManagement addTarget:self action:@selector(cancleManagement:) forControlEvents:UIControlEventTouchUpInside];
    
    //根据内容设置布局
    CGSize size = [cell.convertLocationLabel.text sizeWithFont:cell.convertLocationLabel.font constrainedToSize:CGSizeMake(255, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    if(size.height > 25)
    {
        size.height = 34;
    }
    else
        size.height = 15;
    
    int cell_height = 194+size.height-15;
    
    [cell.contentView addSubview:[AppUtils LineView:cell_height]];
    
    [cell.convertLocationLabel setFrame:CGRectMake(cell.convertLocationLabel.origin.x, cell.convertLocationLabel.origin.y, cell.convertLocationLabel.size.width, size.height)];
    [cell.convertTimeLabel setOrigin:CGPointMake(15, 7+size.height+cell.convertLocationLabel.frame.origin.y)];
    [cell.cancelPermissionOfManagement setOrigin:CGPointMake(cell.cancelPermissionOfManagement.origin.x, 16+cell.convertTimeLabel.frame.origin.y+cell.convertTimeLabel.frame.size.height)];
    
    return cell;
}

- (void)cancleManagement:(UIButton*)sender {
    
    NSString *managerName = nil;
    
    for (NSDictionary *dic in _mjCon.refreshData) {
        
        if ([dic.wrapper getInt:@"Id"] == sender.tag) {
            
            managerName = [dic.wrapper getString:@"Name"];
        }
    }
    
    [AlertUtil showAlert:[NSString stringWithFormat:@"确定取消管理员%@",managerName]
                 message:@"一旦取消,则不可恢复"
                 buttons:@[
                           @"取消",
                           @{
                               @"title":@"确定",
                               @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                                                ADAPI_CanclePermissionOfManager([self genDelegatorID:@selector(requestCancleDone:)], _managerId, (int)sender.tag);
                                            })
                               }]];
}

- (void)requestCancleDone:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
    
        [_mjCon refreshWithLoading];
        [_mjCon refreshData];
        [HUDUtil showSuccessWithStatus:@"操作成功!"];
    }else {
        [HUDUtil showErrorWithStatus:@"操作失败!"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    self.delegate = nil;
    [_mjCon release];
    [_dataSourceArray release];
    [_mainTable release];
    [super dealloc];
}
@end
