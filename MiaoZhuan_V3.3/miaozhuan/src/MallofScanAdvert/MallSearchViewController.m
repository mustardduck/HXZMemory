//
//  MallSearchViewController.m
//  miaozhuan
//
//  Created by abyss on 14/12/19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MallSearchViewController.h"
#import "MallSearchListViewController.h"
#import "HistorySearchCell.h"
#import "GoodsResultListViewController.h"

@interface MallSearchViewController ()
{
    BOOL _pageCount;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, assign) int type;

@end

@implementation MallSearchViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _pageCount ++;
    [MTA trackPageViewBegin:NSStringFromClass([self class])];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_pageCount > 0)
    {
        [MTA trackPageViewEnd:NSStringFromClass([self class])];
        _pageCount --;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = WEAK_OBJECT(UIView, init);
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, 100, 100);
    self.navigationItem.titleView = view;
    [self setupMoveFowardButtonWithTitle:@"搜索"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSearch:) name:@"MallSearch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleType:) name:@"MallType" object:nil];
    
    NSArray *history = [[NSUserDefaults standardUserDefaults] valueForKey:@"historyMallSearchKey"];
    self.dataArray = [NSMutableArray arrayWithArray:history];
    if (!_dataArray.count) {
        self.dataArray = [NSMutableArray arrayWithArray:@[@[],@[]]];
    }
 
    [self setExtraCellLineHidden:_tableView];
    
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

- (void)hiddenKeyboard{
    [self.view endEditing:YES];
}

- (void)handleType:(NSNotification *)noti{
    self.type = [noti.object intValue];
    [self.tableView reloadData];
}

- (void)handleSearch:(NSNotification *)noti{
    if ([noti.object[1] length]) {
        
        self.type = [noti.object[0] intValue];
        
        NSMutableArray *goods = [NSMutableArray arrayWithArray:self.dataArray[0]];
        NSMutableArray *shops = [NSMutableArray arrayWithArray:self.dataArray[1]];
        if (self.type) {
            if (![shops containsObject:noti.object[1]]) {
                [shops insertObject:noti.object[1] atIndex:0];
            }
            if (shops.count > 4) {
                [shops removeLastObject];
            }

        } else {
            if (![goods containsObject:noti.object[1]]) {
                [goods insertObject:noti.object[1] atIndex:0];
            }
            if (goods.count > 4) {
                [goods removeLastObject];
            }

        }
        self.dataArray = [NSMutableArray arrayWithArray:@[goods, shops]];
        [[NSUserDefaults standardUserDefaults] setValue:@[goods, shops] forKey:@"historyMallSearchKey"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.tableView reloadData];
    }
    //搜索
    MallSearchListViewController *list = WEAK_OBJECT(MallSearchListViewController, init);
    list.keyWord = noti.object[1];
    list.type = [noti.object[0] intValue];
    [UI_MANAGER.mainNavigationController pushViewController:list animated:YES];

}

#pragma mark - UITableViewDelegate/UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray[_type] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier;
    identifier = [NSString stringWithFormat:@"%d", (int)indexPath.row];
    HistorySearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HistorySearchCell" owner:self options:nil] firstObject];
    }
    cell.btnDelete.tag = indexPath.row;
    [cell.btnDelete addTarget:self action:@selector(deleteHistory:) forControlEvents:UIControlEventTouchUpInside];
//    NSArray *temp = [[_dataArray reverseObjectEnumerator] allObjects];
    cell.lblTitle.text = _dataArray[_type][indexPath.row];
    
    
    if (indexPath.row + 1 == [_dataArray[_type] count]) {
        cell.line.top = 44;
//        cell.line.left = 0;
    } else {
        cell.line.top = 44.5;
        cell.line.left = 15;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //搜索
    MallSearchListViewController *list = WEAK_OBJECT(MallSearchListViewController, init);
    list.keyWord = _dataArray[_type][indexPath.row];
    list.type = self.type;
    [UI_MANAGER.mainNavigationController pushViewController:list animated:YES];

}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)deleteHistory:(UIButton *)button{
    NSInteger row = button.tag;
    //删除数据
    NSMutableArray *array = [NSMutableArray arrayWithArray:_dataArray[_type]];
    [array removeObjectAtIndex:row];
    [_dataArray replaceObjectAtIndex:_type withObject:array];
    [[NSUserDefaults standardUserDefaults] setValue:_dataArray forKey:@"historyMallSearch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //删除行
    [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [_tableView reloadData];
}

#pragma  mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{

    [_tableView release];
    [super dealloc];
}

@end
