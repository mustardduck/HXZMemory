//
//  FansHelpRecordsViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 15-3-12.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "FansHelpRecordsViewController.h"
#import "MJRefreshController.h"
#import "FansLevel1Cell.h"

@interface FansHelpRecordsViewController ()

@property (retain, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, retain) MJRefreshController *MJRefreshCon;
@property (nonatomic, copy) NSString *curId;

@end

@implementation FansHelpRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigateTitle:@"粉丝明细"];
    [self setupMoveBackButton];
    
    [_MJRefreshCon release];
    _MJRefreshCon = nil;
    _MJRefreshCon = [[MJRefreshController controllerFrom:_tableview name:@"MemberCampaign/Level1Report"] retain];
    
    [self initTableView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)initTableView
{
    NSString * refreshName = @"MemberCampaign/Level1Report";
    __block __typeof(self)weakself = self;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"service":[NSString stringWithFormat:@"%@%@", @"api/", refreshName]}];
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        [dic setValue:@{@"PageIndex":@(pageIndex), @"PageSize":@(pageSize)} forKey:@"parameters"];
        return dic.wrapper;
    }];

    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
    {
        if(controller.refreshCount > 0)
        {
        }
        else
        {
            [weakself.tableview reloadData];
        }
    };
    
    [_MJRefreshCon setOnRequestDone:block];
    [_MJRefreshCon setPageSize:30];
    
    [self refreshTableView];

}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    FansLevel1Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FansLevel1Cell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.lineview.top = 119.5;
    
    cell.btnNotice.tag = indexPath.row + 1;
    [cell.btnNotice addTarget:self action:@selector(notice:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.dataDic = [_MJRefreshCon.refreshData[indexPath.row] wrapper];
    return cell;
}

#pragma mark - acions
//提醒用户手机认证
- (void)notice:(UIButton *)button{
    
    NSInteger tag = button.tag - 1;
    //获取粉丝手机号码
    NSString *customerId = [[_MJRefreshCon.refreshData[tag] wrapper] getString:@"CustomerId"];
    self.curId = customerId;
    //提醒粉丝
    if (!customerId.length || [customerId isKindOfClass:[NSNull class]]) {
        return;
    }
    //判断用户是不是在同一天点击
    NSDate *date = [[NSUserDefaults standardUserDefaults] valueForKey:customerId];
    NSDate *date1 = [self dateFormatWithDate:[NSDate date] formatString:@"yyyy-MM-dd"];
    if ([date isEqualToDate:date1]) {
        return;
    }
    ADAPI_MemberCampaign_RemindFansPhoneVerify([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleNotice:)], customerId);
}

- (void)handleNotice:(DelegatorArguments *)arguments{
    DictionaryWrapper *ret = arguments.ret;
    if (ret.operationSucceed) {
        
        [HUDUtil showSuccessWithStatus:@"已通过消息中心成功向好友发送提醒"];
        
        NSDate *date = [self dateFormatWithDate:[NSDate date] formatString:@"yyyy-MM-dd"];
        if (!date || !_curId.length) {
            return;
        }
        [[NSUserDefaults standardUserDefaults] setValue:date forKey:_curId];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [HUDUtil showErrorWithStatus:ret.operationMessage];
    }
}

- (NSDate *)dateFormatWithDate:(NSDate *)date formatString:(NSString *)formatStr {
    
    NSDateFormatter *formatter = WEAK_OBJECT(NSDateFormatter, init);
    formatter.dateFormat = formatStr;
    NSString *curDate = [formatter stringFromDate:date];
    
    return [formatter dateFromString:curDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_MJRefreshCon release];
    [_curId release];
    [_tableview release];
    [super dealloc];
}
@end
