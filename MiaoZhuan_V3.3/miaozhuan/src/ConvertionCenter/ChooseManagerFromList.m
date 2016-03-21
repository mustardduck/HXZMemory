//
//  ChooseManagerFromList.m
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//
//
#import "ChooseManagerFromList.h"
#import "ChooseManagerFromListCell.h"
#import "UIView+expanded.h"

@interface ChooseManagerFromList () <UITabBarDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (strong, nonatomic) NSArray *dataSourceList;
@property (strong, nonatomic) NSMutableArray *choosedListArray;
@property (retain, nonatomic) IBOutlet UIView *nodataView;
@property (strong, nonatomic) MJRefreshController *mjCon;
@property (strong, nonatomic) NSMutableArray *choosedArrayPhones;
@end

@implementation ChooseManagerFromList
@synthesize mainTable = _mainTable;
@synthesize dataSourceList = _dataSourceList;
@synthesize choosedListArray = _choosedListArray;//当前页面已选择的数据(idString)
@synthesize nodataView = _nodataView;
@synthesize mjCon = _mjCon;
@synthesize chooedArray = _chooedArray;//前一个页面已经选择的managers
@synthesize choosedArrayPhones = _choosedArrayPhones;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"选择管理员"];
    [_mainTable registerNib:[UINib nibWithNibName:@"ChooseManagerFromListCell" bundle:nil] forCellReuseIdentifier:@"ChooseManagerFromListCell"];
    [self setupMoveFowardButtonWithTitle:@"保存"];
    self.dataSourceList = WEAK_OBJECT(NSArray, init);
    self.choosedListArray = WEAK_OBJECT(NSMutableArray, init);
    self.choosedArrayPhones = WEAK_OBJECT(NSMutableArray, init);
    
    [self setUpRefreshItem];
    
    for (NSDictionary *dic in _chooedArray) {
        DictionaryWrapper *wrapper = dic.wrapper;
        NSString *itemPhone = [wrapper getString:@"Phone"];
        if (itemPhone && ![itemPhone isEqualToString:@""]) {
            
            [self.choosedArrayPhones addObject:itemPhone];
        }
    }
}

- (void)setUpRefreshItem {

    NSString *refreshName = @"api/SilverAdvert/GetHistoryExchangeManager";
    
    __block ChooseManagerFromList *weakSelf = self;
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
            
            weakSelf.dataSourceList = [item getArray:@"PageData"];
            
            if ([_dataSourceList count] == 0) {

                _nodataView.hidden = NO;
                _mainTable.hidden = YES;
            }else {
            
                _nodataView.hidden = YES;
                _mainTable.hidden = NO;
            }
            [_mainTable reloadData];
        }else {
        
            _nodataView.hidden = NO;
            _mainTable.hidden = YES;
        }
    };
    [_mjCon setOnRequestDone:block];
    [_mjCon setPageSize:10];
    [_mjCon refreshWithLoading];
}

- (void)onMoveFoward:(UIButton *)sender {

    NSMutableArray *array = WEAK_OBJECT(NSMutableArray, init);
    for (NSDictionary *dic in _mjCon.refreshData) {
        
        NSString *string = [dic.wrapper getString:@"Id"];
        if ([_choosedListArray containsObject:string]) {
            
            WDictionaryWrapper *wrapper = [WDictionaryWrapper wrapperFromDictionary:dic];
            [wrapper set:@"IsValid" int:1];
            [array addObject:wrapper.dictionary];
        }
    }
    
    if ([array count] == 0) {
        
        [HUDUtil showErrorWithStatus:@"暂无可保存内容"];
        return;
    }

    [self.delegate getManagersIdsList:array];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _mjCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ChooseManagerFromListCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"ChooseManagerFromListCell" forIndexPath:indexPath];
    NSLog(@"%@", [_mjCon dataAtIndex:(int)indexPath.row]);
    NSLog(@"%@", [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"Phone"]);
    
    
    
    
    if ([_choosedArrayPhones containsObject:[[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"Phone"]]||[[[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"Phone"] isEqualToString:[APP_DELEGATE.persistConfig getString:USER_INFO_NAME]]) {
        
        cell.choosedImage.hidden = NO;
        cell.checkImage.hidden = YES;
        
        [cell.contentView setBackgroundColor:RGBCOLOR(239, 239, 244)];
    }else {
    
        cell.choosedImage.hidden = YES;
        cell.checkImage.hidden = NO;
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    
    if (![_choosedListArray containsObject:[[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"Id"]]) {
        
        [cell.checkImage setImage:[UIImage imageNamed:@"address_single_box.png"]];
    }else {
        
        [cell.checkImage setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
    }
    cell.name.text = [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"Name"];
    cell.phoneNumber.text = [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"Phone"];
    
    [cell.headImage roundCornerBorder];
    [cell.headImage requestPicture:[[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"PictureUrl"]];
    cell.headImage.layer.cornerRadius = 11.0f;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![_choosedArrayPhones containsObject:[[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"Phone"]]) {
        
        if ([_choosedListArray containsObject:[[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"Id"]]) {
           
            [self.choosedListArray removeObject:[[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"Id"]];
        }else {
            
            [self.choosedListArray addObject:[[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"Id"]];
        }
    }
    
    [_mainTable reloadData];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseManagerFromListCell *cell = (ChooseManagerFromListCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseManagerFromListCell *cell = (ChooseManagerFromListCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *temp = WEAK_OBJECT(UIView, init);
    return temp;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    self.delegate = nil;
    [_mjCon release];
    [_choosedArrayPhones release];
    [_mainTable release];
    [_dataSourceList release];
    [_choosedListArray release];
    [_nodataView release];
    [super dealloc];
}
@end
