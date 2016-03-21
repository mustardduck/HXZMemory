//
//  PrepareToGetCashViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PrepareToGetCashViewController.h"
#import "BankCardCell.h"
#import "ApplyToGetCashViewController.h"
#import "AddBankCardViewController.h"
#import "ApplytoGetCash2ViewController.h"
#import "RealNameAuthenticationViewController.h"
@interface PrepareToGetCashViewController () <UITableViewDataSource, UITableViewDelegate, AddBankCardRefreshDelegate> {

    BOOL _alreadyHaveBankCard;
}
@property (retain, nonatomic) IBOutlet UIView *tableHeadView;
@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (strong, nonatomic) NSMutableArray *bankList;
@property (retain, nonatomic) IBOutlet UIButton *applyToGetCashBtn;
@property (retain, nonatomic) IBOutlet UIView *UILineView1;
@property (retain, nonatomic) IBOutlet UIView *UILineView2;
@property (retain, nonatomic) IBOutlet UIView *UILineView3;



@end

@implementation PrepareToGetCashViewController
@synthesize tableHeadView = _tableHeadView;
@synthesize mainTable = _mainTable;
@synthesize bankList = _bankList;
@synthesize applyToGetCashBtn = _applyToGetCashBtn;
@synthesize dicDataSource = _dicDataSource;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"申请提现"];
    [_mainTable setTableHeaderView:_tableHeadView];
    [_mainTable registerNib:[UINib nibWithNibName:@"BankCardCell" bundle:nil] forCellReuseIdentifier:@"BankCardCell"];
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.UILineView1 setFrame:CGRectMake(0, 0, 320, 0.5)];
    [self.UILineView2 setFrame:CGRectMake(0, 49.5, 320, 0.5)];
    [self.UILineView3 setFrame:CGRectMake(0, 189.5, 320, 0.5)];
}

- (void)viewWillAppear:(BOOL)animated {

    ADAPI_GetBankCardList([self genDelegatorID:@selector(getBankList:)]);
    ADAPI_CashStatement([self genDelegatorID:@selector(getUrl:)]);
}


- (void)getBankList:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        self.bankList = [NSMutableArray arrayWithArray:wrapper.data];
        [_mainTable reloadData];
        if ([_bankList count] > 0) {
            
            _alreadyHaveBankCard = YES;
        }else {
        
            _alreadyHaveBankCard = NO;
        }
    }else {
        [HUDUtil showWithStatus:wrapper.operationMessage];
    }
    [_mainTable reloadData];
}

- (void)getUrl:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    DictionaryWrapper *item = wrapper.data;
    if (wrapper.operationSucceed) {
        
        float moneyLeft = [item getFloat:@"Balance"];
        moneyLeft = floor(moneyLeft*100)/100;
        
        BOOL cashed = [item getBool:@"Cashed"];
        
        if (moneyLeft < 10 || cashed) {
            
            self.applyToGetCashBtn.enabled = NO;
            [self.applyToGetCashBtn setBackgroundColor:RGBCOLOR(204, 204, 204)];
            [self.applyToGetCashBtn.titleLabel setTextColor:RGBCOLOR(255, 255, 255)];
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".haveGetCashPermission" int:0];
        }else {
        
            self.applyToGetCashBtn.enabled = YES;
            [self.applyToGetCashBtn setBackgroundColor:RGBCOLOR(240, 5, 0)];
            [self.applyToGetCashBtn.titleLabel setTextColor:RGBCOLOR(255, 255, 255)];
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".haveGetCashPermission" int:1];
        }
    }
    else if(wrapper.operationErrorCode || wrapper.operationPromptCode)
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (IBAction)applyToGetCash:(id)sender {
    
    int identifyStatus = [APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".IdentityStatus"];
    
    switch (identifyStatus) {
            //未认证
        case 0:{
            
            [AlertUtil showAlert:nil
                         message:@"尚未完成实名认证,暂时无法提现"
                         buttons:@[
                                   @"稍后再说",
                                   @{
                                       @"title":@"立即认证",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                
                PUSH_VIEWCONTROLLER(RealNameAuthenticationViewController);
            })}]];
            return;}
            //认证成功
        case 1:{
            
            if ([_bankList count] > 0) {
                
                ApplyToGetCashViewController *temp = WEAK_OBJECT(ApplyToGetCashViewController, init);
                temp.dataSource = _bankList;
                temp.dicDataSource = _dicDataSource;
                [self.navigationController pushViewController:temp animated:YES];
                
            }else {
                
                AddBankCardViewController *temp = WEAK_OBJECT(AddBankCardViewController, init);
                temp.delegate = self;
                temp.dataSource = _bankList;
                temp.dicDataSource = _dicDataSource;
                [self.navigationController pushViewController:temp animated:YES];
            }
            return;}
            //认证失败
        case 2:{
            
            
            [AlertUtil showAlert:nil
                         message:@"实名认证审核失败,暂时无法提现"
                         buttons:@[
                                   @"稍后再说",
                                   @{
                                       @"title":@"立即认证",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                
                PUSH_VIEWCONTROLLER(RealNameAuthenticationViewController);
            })}]];
            return;}
            //认证中
        case 3:{
            
            [AlertUtil showAlert:nil
                         message:@"实名认证审核中，暂时无法提现"
                         buttons:@[
                                   @"稍后再说",
                                   @{
                                       @"title":@"查看认证",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                
                PUSH_VIEWCONTROLLER(RealNameAuthenticationViewController);
            })}]];
            return;}
            
        default:
            return;
    }
}


- (IBAction)addBankCard:(id)sender {
    
    AddBankCardViewController *temp = WEAK_OBJECT(AddBankCardViewController, init);
    temp.delegate = self;
    temp.dataSource = _bankList;
    temp.dicDataSource = _dicDataSource;
    [self.navigationController pushViewController:temp animated:YES];
}

#pragma mark - AddBankListDelegate
- (void)refreshBankList {
    
    ADAPI_GetBankCardList([self genDelegatorID:@selector(getBankList:)]);
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_bankList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BankCardCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"BankCardCell" forIndexPath:indexPath];

    if ([[_bankList[indexPath.row]wrapper] getString:@"BankIconUrl"]) {
        
        [cell.icon requestPicture:[[_bankList[indexPath.row] wrapper] getString:@"BankIconUrl"]];
    }
    
    cell.bankName.text = [[_bankList[indexPath.row] wrapper] getString:@"BankName"];
    cell.tailNumber.text = [NSString stringWithFormat:@"%@",[[_bankList[indexPath.row] wrapper] getString:@"AccountNumberEnd"]];
    
    if ([[_bankList[indexPath.row] wrapper] getInt:@"CardType"] == 0) {
        
        cell.typeName.text = @"储蓄卡";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == [_bankList count] - 1) {
        
        [cell.UIBottomLineView setFrame:CGRectMake(0, 80.5, 320, 0.5)];
    }else {
    
        [cell.UIBottomLineView setFrame:CGRectMake(15, 80, 320, 0.5)];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 81;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        ADAPI_RemoveBankCard([self genDelegatorID:@selector(delBankCard:)],[[_bankList[indexPath.row] wrapper] getInt:@"BankId"]);
        [self.bankList removeObjectAtIndex:indexPath.row];  //删除数组里的数据
        [_mainTable deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];  //删除对应数据的cell
    }
}

- (void)delBankCard:(DelegatorArguments*)arguments {
    
    DictionaryWrapper* wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        [HUDUtil showSuccessWithStatus:@"删除成功!"];
        //删除缓存
        [APP_DELEGATE.userConfig set:@"ChoosedGetCashBankCardData" value:nil];
        [_mainTable reloadData];
    }else {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_dicDataSource release];
    [_bankList release];
    [_tableHeadView release];
    [_mainTable release];
    [_applyToGetCashBtn release];
    [_UILineView1 release];
    [_UILineView2 release];
    [_UILineView3 release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableHeadView:nil];
    [self setMainTable:nil];
    [super viewDidUnload];
}
@end
