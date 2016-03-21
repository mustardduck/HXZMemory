//
//  SearchShopController.m
//  miaozhuan
//
//  Created by momo on 14-10-22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SearchShopController.h"
#import "NSDictionary+expanded.h"
#import "SearchShopCell.h"
#import "SearchShopResultController.h"

@interface SearchShopController ()<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UIView *searchBarView;
@property (retain, nonatomic) IBOutlet UITextField *searchField;

@end

@implementation SearchShopController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupMoveBackButton];
    
    [self initSearchBar];
    
    _hotSearchArr = STRONG_OBJECT(NSMutableArray, init);
    
    ADAPI_EnterpriseRecommend([self genDelegatorID:@selector(hotSearchRecommend:)], 2, 0, 20);
}

- (void) viewWillAppear:(BOOL)animated
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchShopRecord"];
    
    _searchDic = STRONG_OBJECT(NSMutableDictionary, initWithDictionary: dic);

    [self hiddenTableView];
    
}

- (void) hiddenTableView
{
    NSArray * arr = [_searchDic objectForKey:@"searchTextArr"];
    
    if(arr.count == 0)
    {
        _searchTableView.hidden = YES;
        
        CGRect rect = _hotSearchTableView.frame;
        
        rect.origin.y = 0;
        
        rect.size.height = H(self.view);
        
        _hotSearchTableView.frame = rect;
    }
    else
    {
        _searchTableView.hidden = NO;
        
        [_searchTableView reloadData];

        if(arr.count < 4)
        {
            _hotSearchTableView.top = 23 + 45 * arr.count - 1;
        }
        else
        {
            _hotSearchTableView.top = 203 - 1;
            
        }
        
        _hotSearchTableView.height = H(self.view) - H(_searchTableView);

    }
    
}

- (void) initSearchBar
{
    //导航条的搜索条
//    _searchBar = WEAK_OBJECT(UISearchBar, initWithFrame:CGRectMake(3,0,230,30));
//
//    _searchBar.delegate = self;
//    
//    [_searchBar setTintColor:[UIColor blackColor]];
//    
//    [_searchBar setPlaceholder:@"请输入商家名称"];
//    
//    _searchBar.showsCancelButton = YES;
//
//    self.navigationItem.titleView = _searchBar;
//    
//    [self addDoneToKeyboard:_searchBar];
    
    
    [self addDoneToKeyboard:_searchField];
    
    _searchBarView.layer.cornerRadius = 5.0;
    
    self.navigationItem.titleView = _searchBarView;
    
    [self setupMoveFowardButtonWithTitle:@"搜索"];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self onMoveFoward:nil];
    
    return YES;
}

- (void) onMoveFoward:(UIButton *)sender
{
    _searchField.text = [_searchField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(_searchField.text.length == 0)
    {
        [_searchField becomeFirstResponder];
        
        return;
    }
    
    [_searchField resignFirstResponder];
    
    [_searchDic setObjects:_searchField.text forKey:@"searchTextArr"];
    
    [[NSUserDefaults standardUserDefaults] setObject:_searchDic forKey:@"searchShopRecord"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    SearchShopResultController * view = WEAK_OBJECT(SearchShopResultController, init);
    
    view.keyword = _searchField.text;
    
    [self.navigationController pushViewController:view animated:YES];

}

- (void) hiddenKeyboard
{
    [_searchField resignFirstResponder];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self hiddenKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(searchBar.text.length == 0)
    {
        return;
    }
    
    [_searchDic setObjects:searchBar.text forKey:@"searchTextArr"];
    
    [[NSUserDefaults standardUserDefaults] setObject:_searchDic forKey:@"searchShopRecord"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    SearchShopResultController * view = WEAK_OBJECT(SearchShopResultController, init);
    
    view.keyword = _searchBar.text;
    
    [self.navigationController pushViewController:view animated:YES];
    
}

- (void)dealloc {
        
    [_searchTableView release];
    [_hotSearchTableView release];
    
    [_searchDic release];
    _searchDic = nil;
    
    [_hotSearchArr release];
    _hotSearchArr = nil;
    
    [_searchBarView release];
    [_searchField release];
    [super dealloc];
}

- (void)hotSearchRecommend:(DelegatorArguments*)arguments
{
    [arguments logError];
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        _hotSearchTableView.hidden = NO;
        
        [_hotSearchArr removeAllObjects];
        
        [_hotSearchArr addObjectsFromArray:[wrapper.data getArray:@"PageData"]];
        
        [_hotSearchTableView reloadData];
        
    }
    else
    {
        _hotSearchTableView.hidden = YES;
        
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

#pragma mark UITableViewDelegate and UITableViewDatasource methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 23.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _searchTableView)
    {
        NSArray * arr = [_searchDic objectForKey:@"searchTextArr"];
        
        return arr.count;
    }
    return _hotSearchArr.count;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if(tableView == _searchTableView)
//    {
//        return @"搜索记录";
//    }
//    
//    return @"热门搜索";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 160, 23));
    
    customView.backgroundColor = AppColor(247);
    
    UILabel * headerLabel = WEAK_OBJECT(UILabel, initWithFrame:CGRectZero);
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = AppColor(153);
    headerLabel.font = Font(12);
    headerLabel.frame = CGRectMake(15, 0, 140, 23);
    
    NSString * titleName = @"";
    
    if(tableView == _searchTableView)
    {
        titleName = @"搜索记录";
    }
    else
    {
        titleName = @"热门搜索";
    }
    
    headerLabel.text = titleName;
    
    [customView addSubview:headerLabel];
    
    return customView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = (int)[indexPath row];
    
    static NSString *identifier = @"SearchShopCell";
        
    SearchShopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchShopCell" owner:self options:nil] firstObject];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if(tableView == _searchTableView)
    {
        NSArray * recordStrArr = [[[_searchDic objectForKey:@"searchTextArr"] reverseObjectEnumerator] allObjects];

        cell.titleLbl.text = recordStrArr[index];
        
        cell.deleteIcon.hidden = NO;
        
        [cell.selectBtn addTarget:self action:@selector(onDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectBtn.tag = index;
    }
    else if (tableView == _hotSearchTableView)
    {
        cell.deleteIcon.hidden = YES;
        
        NSDictionary * dic = _hotSearchArr[index];
        
        cell.titleLbl.text = [dic.wrapper getString:@"Name"];
    }
    
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(15 , H(cell.contentView) - 0.5, 320, 0.5));
    view.backgroundColor = AppColor(204);
    [cell.contentView addSubview:view];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchShopCell *cell = (SearchShopCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchShopCell *cell = (SearchShopCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchShopCell * cell = (SearchShopCell *) [tableView cellForRowAtIndexPath:indexPath];
    
    SearchShopResultController * view = WEAK_OBJECT(SearchShopResultController, init);
    
    view.keyword = cell.titleLbl.text;
    
    [self.navigationController pushViewController:view animated:YES];
}

- (void) onDeleteBtn:(id)sender
{
    NSString * aKey = @"searchTextArr";
    
    UIButton * btn = (UIButton *) sender;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[_searchDic objectForKey:aKey]];
    
    [array removeObjectAtIndex: (array.count - btn.tag - 1)];
    
    [(NSMutableDictionary*)_searchDic setObject:array forKey:aKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:_searchDic forKey:@"searchShopRecord"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [_searchTableView reloadData];
    
    NSArray * arr = [_searchDic objectForKey:@"searchTextArr"];
    
    if(arr.count < 4)
    {
        _hotSearchTableView.top = 23 + 45 * arr.count - 1;
    }
    
    _hotSearchTableView.height = H(self.view) - H(_searchTableView);
}

@end
