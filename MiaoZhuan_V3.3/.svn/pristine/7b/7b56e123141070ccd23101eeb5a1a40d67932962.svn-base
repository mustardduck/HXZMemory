//
//  ContactorListViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-2.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ContactorListViewController.h"
#import "ContactorCell.h"
#import "BaserHoverView.h"

@interface ContactorListViewController ()

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *dataArray;
@end

@implementation ContactorListViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setNavigateTitle:@"选择历史帐号"];
   
    [self setExtraCellLineHidden:_tableView];
    [_tableView.panGestureRecognizer setDelaysTouchesBegan:YES];
    
    if(!_isGold)
    {
        ADAPI_CustomerIntegral_GetGiftedUserList([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGetGiftedUserList:)], _keyWord);
    }
    else
    {
        ADAPI_CustomerGoldGetGiftedUserList([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGoldGetGiftedUserList:)], _keyWord);

    }
}

- (void)handleGoldGetGiftedUserList:(DelegatorArguments *)arguments{
    
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        if ([dic.data count]) {
            _tableView.hidden = NO;
            self.dataArray = dic.data;
            [self.tableView reloadData];
        } else {
            [self createHoverViewWhenNoData];
        }
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (void)handleGetGiftedUserList:(DelegatorArguments *)arguments{
    
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        if ([dic.data count]) {
            _tableView.hidden = NO;
            self.dataArray = dic.data;
            [self.tableView reloadData];
        } else {
            [self createHoverViewWhenNoData];
        }
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

//无数据hoverview
- (void)createHoverViewWhenNoData{
    BaserHoverView *hover = STRONG_OBJECT(BaserHoverView, initWithTitle:@"" message:@"暂无历史流通的账号");
    hover.imgView.image = [UIImage imageNamed:@"nomanager.png"];
    hover.frame = self.view.bounds;
    [self.view addSubview:hover];
    [hover release];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    ContactorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ContactorCell" owner:self options:nil] firstObject];
    }
    cell.dataDic = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //先进行判断，再调用块传递实参
    [self.navigationController popViewControllerAnimated:YES];
    if (self.value)
    {
        self.value ([_dataArray[indexPath.row] wrapper]);
    }
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
