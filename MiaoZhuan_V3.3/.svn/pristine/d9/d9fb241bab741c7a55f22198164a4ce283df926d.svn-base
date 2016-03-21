//
//  AddManagerViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-15.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AddManagerViewController.h"
#import "AddManagerTableViewCell.h"
#import "ChooseManagerFromList.h"
@interface AddManagerViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, GetManagerIdsList> {

    int _countOfManager;
}

@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (retain, nonatomic) IBOutlet UIView *tableHead;
@property (retain, nonatomic) IBOutlet UIView *tableFoot;
@property (strong, nonatomic) NSMutableArray *managers;
@property (retain, nonatomic) IBOutlet UIButton *saveButton;
@property (retain, nonatomic) IBOutlet UIView *topview;
@property (retain, nonatomic) IBOutlet UILabel *selfAccountLabel;
@end

@implementation AddManagerViewController
@synthesize managers = _managers;
@synthesize mainTable = _mainTable;
@synthesize tableFoot = _tableFoot;
@synthesize tableHead = _tableHead;
@synthesize managersAlreadyAdd = _managersAlreadyAdd;
@synthesize saveButton = _saveButton;
@synthesize selfAccountLabel = _selfAccountLabel;

- (void) onBackgroundClicked:(UIButton *)sender {
    
    [self becomeFirstResponder];
}

- (IBAction)buttonViewCilcked:(id)sender {
    
    [self becomeFirstResponder];
}

- (BOOL) canBecomeFirstResponder {
    
    return TRUE;
}

-(void)viewWillAppear:(BOOL)animated
{
    _mainTable.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 64 - 65);
    _topview.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 64 -65, 320, 65);
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [_tableFoot bringSubviewToFront:_saveButton];
    [_mainTable registerNib:[UINib nibWithNibName:@"AddManagerTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddManagerTableViewCell"];
    [_mainTable setTableHeaderView:_tableHead];
    [_mainTable setTableFooterView:_tableFoot];
    [self setupMoveBackButton];
    [self setTitle:@"添加兑换管理员"];
    self.selfAccountLabel.text = [APP_DELEGATE.persistConfig getString:USER_INFO_NAME];
    
    if ([SystemUtil aboveIOS7_0]) {
        _mainTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    
    self.managers = WEAK_OBJECT(NSMutableArray, init);
    
    NSMutableArray *resultArray = WEAK_OBJECT(NSMutableArray, init);
    
    for (NSDictionary *dic in _managersAlreadyAdd) {
        
        WDictionaryWrapper *wrapper = [WDictionaryWrapper wrapperFromDictionary:dic];
        [wrapper set:@"IsValid" int:1];
        
        if (![[wrapper getString:@"Phone"] isEqualToString:_selfAccountLabel.text]) {
            
            [resultArray addObject:wrapper.dictionary];
        }
    }
    
    [self.managers addObjectsFromArray:resultArray];
    _countOfManager = (int)[_managers count];
    
    [_mainTable reloadData];
    
    _saveButton.enabled = NO;
    [_saveButton setBackgroundColor: RGBCOLOR(204, 204, 204)];
    
    for (int i = 0; i < _countOfManager; i++) {
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        AddManagerTableViewCell *cell = (AddManagerTableViewCell*) [_mainTable cellForRowAtIndexPath:path];
        [self addDoneToKeyboard:cell.managerNumberField];
    }
}

- (void)hiddenKeyboard {
    
    for (int i = 0; i < _countOfManager; i++) {
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        AddManagerTableViewCell *cell = (AddManagerTableViewCell*) [_mainTable cellForRowAtIndexPath:path];
        [cell.managerNumberField resignFirstResponder];
    }
}

- (IBAction)chooseManegersFromList:(id)sender {
    
    [self toChooseManagerFromList];
}

- (IBAction)addMoreManager:(id)sender {
    
    _countOfManager++;
    [_mainTable reloadData];
    
    for (int i = 0; i < _countOfManager; i++) {
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        AddManagerTableViewCell *cell = (AddManagerTableViewCell*) [_mainTable cellForRowAtIndexPath:path];
        [self addDoneToKeyboard:cell.managerNumberField];
    }
    
    _saveButton.enabled = YES;
    [_saveButton setBackgroundColor:RGBCOLOR(240, 5, 0)];
}

//保存按钮
- (IBAction)saveManagerIds:(id)sender {
    
    NSArray *managersTemp = [_managers copy];
    //禁止输入重复数据
    NSMutableSet *managersDataSet = WEAK_OBJECT(NSMutableSet, init);
    for (NSDictionary *dic in managersTemp) {
        DictionaryWrapper *wrapper = dic.wrapper;
        if ([[wrapper getString:@"Phone"] isEqualToString:@""]||![wrapper getString:@"Phone"]) {
            [_managers removeObject:dic];
        }else {
            [managersDataSet addObject:[wrapper getString:@"Phone"]];
        }
        
        if ([[wrapper getString:@"Phone"] isEqualToString:_selfAccountLabel.text]) {
            
            [HUDUtil showErrorWithStatus:@"该管理员已存在，请重新添加"];
            return;
        }
    }
    
    if ([_managers count] != [managersDataSet count]) {
        
        [HUDUtil showErrorWithStatus:@"请勿添加相同的管理员"];
        return;
    }
    
    NSMutableArray *postArray = WEAK_OBJECT(NSMutableArray, init);
    
    for (NSDictionary *dic in _managers) {
        
        DictionaryWrapper *wrapper = dic.wrapper;
        [postArray addObject:[wrapper getString:@"Phone"]];
    }
    
    if ([postArray count] == 0) {
        
        [self.delegate getManagerIds:nil];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    ADAPI_VerifyConvertManagers([self genDelegatorID:@selector(verifyManagers:)], postArray);
}

- (void)verifyManagers:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        self.managers = [NSMutableArray arrayWithArray:wrapper.data];
        int countOfValidManagers = 0;
        for (NSDictionary *dic in _managers) {
            
            DictionaryWrapper *item = dic.wrapper;
        
//            测试新增需求：所有账号必须11为，否则视为错误。
//            2015/1/5
            countOfValidManagers = countOfValidManagers + [item getInt:@"IsValid"];
        }

        if (countOfValidManagers == [_managers count]) {
           
            [self.delegate getManagerIds:_managers];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
        
            [_mainTable reloadData];
            [HUDUtil showErrorWithStatus:@"管理员账号输入错误，请重新输入！"];
        }
    }else {
    
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - GetManagerIdsList
- (void)getManagersIdsList:(NSArray*)array {
    
    [self.managers addObjectsFromArray:array];
    _countOfManager = (int)[_managers count]+1;
    
    if ([array count] > 0) {
        
        _saveButton.enabled = YES;
        [_saveButton setBackgroundColor:RGBCOLOR(240, 5, 0)];
    }
    [_mainTable reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _countOfManager;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AddManagerTableViewCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"AddManagerTableViewCell" forIndexPath:indexPath];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.deleteBtn.tag = indexPath.row;
    
    [cell.deleteBtn addTarget:self action:@selector(delCell:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.checkFromList addTarget:self action:@selector(toChooseManagerFromList) forControlEvents:UIControlEventTouchUpInside];
    
    cell.managerNumberField.delegate = self;
    cell.managerNumberField.tag = indexPath.row;
        
    cell.deleteBtn.hidden = NO;
    cell.managerLabel.textColor = RGBCOLOR(34, 34, 34);
    cell.managerNumberField.textColor = RGBCOLOR(34, 34, 34);
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.checkFromList setBackgroundImage:[UIImage imageNamed:@"checkManagerList.png"] forState:UIControlStateNormal];
    cell.managerNumberField.enabled = YES;
    cell.managerNumberField.text = nil;
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row < [_managers count]) {
        
        DictionaryWrapper *wrapper = [_managers[indexPath.row] wrapper];
        cell.managerNumberField.text = [wrapper getString:@"Phone"];
        
        if ([wrapper getInt:@"IsValid"] == 0) {
            
            cell.managerNumberField.textColor = [UIColor redColor];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 60;
}

#pragma mark -UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    textField.textColor = [UIColor blackColor];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    if (![textField.text isEqualToString:@""]) {
        
        if ([_managers count] < textField.tag+1) {
            
            WDictionaryWrapper *dic = WEAK_OBJECT(WDictionaryWrapper, init);
            [dic set:@"Phone" string:textField.text];
            [dic set:@"IsValid" int:1];
            [self.managers addObject:dic.dictionary];
        }else {
            
            WDictionaryWrapper *dic = WEAK_OBJECT(WDictionaryWrapper, init);
            [dic set:@"Phone" string:textField.text];
            [dic set:@"IsValid" int:1];
            [self.managers replaceObjectAtIndex:textField.tag withObject:dic.dictionary];
        }
    }
    
    [_mainTable reloadData];
}

- (void)toChooseManagerFromList {

    ChooseManagerFromList *temp = WEAK_OBJECT(ChooseManagerFromList, init);
    temp.delegate = self;
    
    NSMutableArray *choosedIdsArray = WEAK_OBJECT(NSMutableArray, init);
    
    for (NSDictionary *dic in _managers) {
        DictionaryWrapper *wrapper = dic.wrapper;
        
        if ([wrapper getString:@"Id"]) {
            
            [choosedIdsArray addObject:[wrapper getString:@"Id"]];
        }
        
        if ([wrapper getString:@"BusinessCardId"]) {
            
            [choosedIdsArray addObject:[wrapper getString:@"BusinessCardId"]];
        }
    }
    
    temp.chooedArray = _managers;
    [self.navigationController pushViewController:temp animated:YES];
}

- (void)delCell:(UIButton*)sender {
    
    if (sender.tag < [_managers count]) {
        
        [self.managers removeObjectAtIndex:sender.tag];
        _saveButton.enabled = YES;
        [_saveButton setBackgroundColor:RGBCOLOR(240, 5, 0)];
    }
    _countOfManager--;
    [_mainTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    self.delegate = nil;
    [_managersAlreadyAdd release];
    [_managers release];
    [_mainTable release];
    [_tableHead release];
    [_tableFoot release];
    [_saveButton release];
    [_selfAccountLabel release];
    [_topview release];
    [super dealloc];
}
@end
