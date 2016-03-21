//
//  PeopleSettingViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PeopleSettingViewController.h"
#import "PeopleSetCell.h"
#import "CustomerQuestionsViewController.h"

@interface PeopleSettingViewController ()

@property (retain, nonatomic) IBOutlet UITableView *tableVIew;
@property (nonatomic, retain) NSArray *titles;
@property (nonatomic, retain) NSMutableArray *status;

@end

@implementation PeopleSettingViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self check];
}
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMoveBackButton];
    [self setNavigateTitle:@"设置接受广告人群"];
    
    self.status = [NSMutableArray arrayWithCapacity:4];
    
    _tableVIew.panGestureRecognizer.delaysTouchesBegan = YES;
    _tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    ADAPI_DirectAdvert_GetQuestionFields([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGetQuestionFields:)]);
}

#pragma mark - UITableViewDelegate/UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    PeopleSetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PeopleSetCell" owner:self options:nil] firstObject];
    }
    cell.lblTitle.text = [[_titles[indexPath.row] wrapper] getString:@"FieldName"];
    cell.lblStatus.text = _status[indexPath.row];
    
    if (indexPath.row + 1 == _titles.count) {
        cell.lineview.left = 0;
        cell.lineview.width = 320;
        cell.lineview.top = 49;
    } else {
        cell.lineview.top = 49.5;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomerQuestionsViewController *customQuestion = WEAK_OBJECT(CustomerQuestionsViewController, init);
    customQuestion.type = [[_titles[indexPath.row] wrapper] getInt:@"Field"];
    customQuestion.navTitle = [[_titles[indexPath.row] wrapper] getString:@"FieldName"];
    [UI_MANAGER.mainNavigationController pushViewController:customQuestion animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 网络请求回调
- (void)handleGetQuestionFields:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        if ([dic.data count]) {
            [_tableVIew setHidden:NO];
            self.titles = dic.data;
            [[NSUserDefaults standardUserDefaults] setValue:dic.data forKey:@"QuestionFields"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            _tableVIew.height = _titles.count * 50;
            
            [self check];
            
        }
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (void)check{
    [self.status removeAllObjects];
    for (NSDictionary *title in self.titles) {
        NSString *navTitle = [[title wrapper] getString:@"FieldName"];
        BOOL flag = [[NSUserDefaults standardUserDefaults] boolForKey:navTitle];
        [self.status addObject:flag ? @"已完成" : @"未完成"];
        [self.tableVIew reloadData];
    }
}


#pragma mark - 内存管理0
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_titles release];
    [_status release];
    [_tableVIew release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableVIew:nil];
    [super viewDidUnload];
}
@end
