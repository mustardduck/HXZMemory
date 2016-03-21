//
//  ManagerOwnManagersViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 15-4-22.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "ManagerOwnManagersViewController.h"
#import "MJRefreshController.h"
#import "ManagerListCell.h"

@interface ManagerOwnManagersViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    MJRefreshController *_MJRefreshCon;
}

@property (retain, nonatomic) IBOutlet UITextField *txtAccount;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *hoverView;

@end

@implementation ManagerOwnManagersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigateTitle:@"我的店小二"];
    [self setupMoveBackButton];
    
    [self loadTableView];
    
    [self addDoneToKeyboard:_txtAccount];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadTableView
{
    NSString * refreshName = @"SilverAdvert/GetExchangeManagers/";
    
    __block typeof(self) weakself = self;
    
    _MJRefreshCon = nil;
    
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
                _tableView.hidden = NO;
                _hoverView.hidden = YES;
                
                UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(_tableView.left, _tableView.top, SCREENWIDTH, _MJRefreshCon.refreshCount * 80));
                view.backgroundColor = [UIColor whiteColor];
                [weakself.view insertSubview:view belowSubview:_tableView];
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
//删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        __block typeof(self) weakself = self;
        [AlertUtil showAlert:@"确认删除" message:@"一旦删除，则不可以恢复" buttons:@[
                                                                      
                                                                      @"取消"
                                                                      ,@{
                                                                          @"title":@"确定",
                                                                          @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                                                          ({
            DictionaryWrapper *dic = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
            
            int managerId = [[dic wrapper] getInt:@"Id"];
            
            ADAPI_DeleteConvertManager([GLOBAL_DELEGATOR_MANAGER addDelegator:weakself selector:@selector(handleDeleteManager:)], managerId);
        })
                                                                          }
                                                                      ]];
        
    }
}

#pragma mark - uitextfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

#pragma mark - actions

// delete manager request call back
- (void)handleDeleteManager:(DelegatorArguments *)arguments {
    
    DictionaryWrapper *ret = arguments.ret;
    if (ret.operationSucceed) {
        [self refreshTableView];
    } else {
        [HUDUtil showErrorWithStatus:ret.operationMessage];
        return;
    }
}

// add manager click
- (IBAction)addManagerClicked:(id)sender {
    
    if (!_txtAccount.text.length) {
        [HUDUtil showErrorWithStatus:@"请输入店小二账号"];return;
    }
    [self.view endEditing:YES];
    
    ADAPI_SilverAdvert_AddExchangeManager([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleAddManager:)], @{@"Account":_txtAccount.text});
}

// add manager request call back
- (void)handleAddManager:(DelegatorArguments *)arguments {
    
    DictionaryWrapper *ret = arguments.ret;
    if (ret.operationSucceed) {
        [self refreshTableView];
        [HUDUtil showSuccessWithStatus:@"添加成功"];
    } else {
        [HUDUtil showErrorWithStatus:ret.operationMessage];
        return;
    }
}

// hidden keyboard
- (void)hiddenKeyboard{
    
    [self.view endEditing:YES];
}

#pragma mark - scrollview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_txtAccount release];
    [_tableView release];
    [_hoverView release];
    [super dealloc];
}
@end
