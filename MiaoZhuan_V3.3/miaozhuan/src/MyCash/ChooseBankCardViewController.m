//
//  ChooseBankCardViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ChooseBankCardViewController.h"
#import "BankCardCell.h"
@interface ChooseBankCardViewController () <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (strong, nonatomic) NSIndexPath *theChoosedIndexPath;
@property (retain, nonatomic) IBOutlet UIView *tableHead;
@end

@implementation ChooseBankCardViewController
@synthesize mainTable = _mainTable;
@synthesize theChoosedIndexPath = _theChoosedIndexPath;
@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;
@synthesize tableHead = _tableHead;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"选择银行卡"];
    [_mainTable registerNib:[UINib nibWithNibName:@"BankCardCell" bundle:nil] forCellReuseIdentifier:@"BankCardCell"];
    [self.mainTable setTableHeaderView:_tableHead];
    ADAPI_GetBankCardList([self genDelegatorID:@selector(getBankList:)]);
}


- (void)getBankList:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        self.dataSource = [NSMutableArray arrayWithArray:wrapper.data];
        [_mainTable reloadData];
    }else {
        [HUDUtil showWithStatus:wrapper.operationMessage];
    }
    [_mainTable reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BankCardCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"BankCardCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.icon requestIcon:[[_dataSource[indexPath.row] wrapper] getString:@"BankIconUrl"]];
    cell.bankName.text = [[_dataSource[indexPath.row] wrapper]getString:@"BankName"];
    cell.tailNumber.text = [[_dataSource[indexPath.row] wrapper]getString:@"AccountNumberEnd"];
    
    if (_theChoosedIndexPath == indexPath) {

        cell.checkImageView.hidden = NO;
    }else {
    
        cell.checkImageView.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    self.theChoosedIndexPath = indexPath;
    
    WDictionaryWrapper *wdic = [WDictionaryWrapper wrapperFromDictionary:(NSDictionary*)_dataSource[indexPath.row]];
    
    [wdic set:@"BankIconUrl" string:@"http://www.google.com"];
    
    [self.delegate choosedBankCardData:wdic.dictionary];
    [_mainTable reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *temp = WEAK_OBJECT(UIView, init);
    [temp setBackgroundColor:[UIColor clearColor]];
    return temp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_dataSource release];
    [_theChoosedIndexPath release];
    [_mainTable release];
    [_tableHead release];
    [super dealloc];
}
- (void)viewDidUnload {
    self.delegate = nil;
    [self setDataSource:nil];
    [self setTheChoosedIndexPath:nil];
    [self setMainTable:nil];
    [self setTableHead:nil];
    [super viewDidUnload];
}
@end
