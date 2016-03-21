//
//  OwnManagerListViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 15-4-21.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "OwnManagerListViewController.h"
#import "ManagerListCell.h"
#import "MJRefreshController.h"
#import "ManagerOwnManagersViewController.h"

@interface OwnManagerListViewController ()<UITableViewDataSource, UITableViewDelegate>{
    MJRefreshController *_MJRefreshCon;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *hoverView;

@end

@implementation OwnManagerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMoveBackButton];
    [self setNavigateTitle:@"我的店小二"];
    [self setupMoveFowardButtonWithTitle:@"添加"];
  
    [self loadTableView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshTableView];
}

- (void)loadTableView
{
    NSString * refreshName = @"SilverAdvert/GetExchangeManagers/";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_tableView name:refreshName];
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
     {
         return
         @{@"service":[NSString stringWithFormat:@"api/%@",refreshName],
           @"parameters":@{
                   @"PageIndex":@(pageIndex),
                   @"PageSize":@(pageSize)}
           }.wrapper;
     }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            NSLog(@"%@",netData);
            if (controller.refreshCount == 0)
            {
                _hoverView.hidden = NO;
                _tableView.hidden = YES;
            } else {
                _hoverView.hidden = YES;
                _tableView.hidden = NO;
            }
        };
        
        [_MJRefreshCon setOnRequestDone:block];
        [_MJRefreshCon setPageSize:30];
        [_MJRefreshCon retain];
    }
    
    [self refreshTableView];
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}


#pragma mark - UITableViewDelegate/UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _MJRefreshCon.refreshCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    ManagerListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ManagerListCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    DictionaryWrapper *data = [[_MJRefreshCon dataAtIndex:(int)indexPath.row] wrapper];
    NSString *name = [data getString:@"Name"];
    if ([name isKindOfClass:[NSNull class]] || !name.length) {
        cell.lblName.hidden = YES;
        cell.lblPhone.top = 27.f;
    } else {
        cell.lblName.hidden = NO;
        cell.lblPhone.top = 43.f;
    }
    
    cell.dataDic = data;
    return cell;
}

#pragma mark - actions

//move forward to add own's manager
- (void)onMoveFoward:(UIButton *)sender{
    PUSH_VIEWCONTROLLER(ManagerOwnManagersViewController);
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
    [_tableView release];
    [_hoverView release];
    [super dealloc];
}
@end
