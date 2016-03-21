//
//  IWSearchViewController.m
//  miaozhuan
//
//  Created by luo on 15/4/24.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWSearchViewController.h"
#import "KxMenu.h"
#import "IWSearchTableViewCell.h"
#import "IWSearchResultViewController.h"
#import "SharedData.h"
#import "API_PostBoard.h"
#import "MZRefresh.h"

static NSString * kIWSearchWordRecordKey = @"IWSearchViewControllerSearchRecord";

@interface IWSearchViewController ()<KxMenuDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    int _pageIndex;
    int _pageSize;
}
/**
 *  搜索类型
 */
@property (nonatomic,assign ) IWSearchType   searchType;
@property (retain, nonatomic) NSMutableArray * arrayHotWord;
@property (retain, nonatomic) NSMutableArray * arrayReseachWord;

@property (retain, nonatomic) IBOutlet UIView         * viewNavigationTitle;
@property (retain, nonatomic) IBOutlet UITableView    * tableView;
@property (retain, nonatomic) IBOutlet UITextField    * textFieldSearch;
@property (retain, nonatomic) IBOutlet UIButton       * buttonSearch;


@end

@implementation IWSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
    
    _pageIndex = 0;
    _pageSize = 30;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
    
    self.arrayHotWord = [SharedData getInstance].hotSearchWords;
    [self loadHistoryData];
    [self.tableView reloadData];
    
    [[API_PostBoard getInstance] engine_outside_postBoard_hotwordSearch];
}

- (void)handleUpdateSuccessAction:(NSNotification *)note
{
    
    NSDictionary *dict = [note userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    
    if(type == ut_postBoard_hotwordSearch)
    {
        if(ret == 1)
        {
            self.arrayHotWord = [SharedData getInstance].hotSearchWords;
            [self.tableView reloadData];
        }else{
            [HUDUtil showErrorWithStatus:@"热门词汇加载失败"];
        }
    }
}

- (void)handleUpdateFailureAction:(NSNotification *)note
{
    NSDictionary *dict = [note userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    
    if(type == ut_postBoard_hotwordSearch)
    {
        [HUDUtil showErrorWithStatus:@"热门词汇加载失败"];
    }
}


-(void) setupUI{
    self.navigationItem.titleView = self.viewNavigationTitle;
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"搜索"];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

-(void) onMoveBack:(UIButton *) sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) onMoveFoward:(UIButton *) sender{
    
    if([self.textFieldSearch.text isEqual:@"请输入搜索词"]){
        [HUDUtil showErrorWithStatus:@"请输入搜索词"];return;
    }
    
    if ([self.textFieldSearch.text length] == 0)return;
    if (self.arrayReseachWord == nil) {
        self.arrayReseachWord = [[NSMutableArray alloc] init];
    }
    NSString *searchText = self.textFieldSearch.text;
    
    if([self.arrayReseachWord count] >= 4){
        [self.arrayReseachWord removeLastObject];
    }
    
    [self.arrayReseachWord insertObject:searchText atIndex:0];
    [self.tableView reloadData];
    [self saveHistoryData];
    
    IWSearchResultViewController *vc = [[IWSearchResultViewController alloc] initWithNibName:NSStringFromClass([IWSearchResultViewController class]) bundle:nil];
    vc.searchType = self.searchType;
    vc.searchKeyword = searchText;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)buttonClickSearchType:(UIButton *)sender {
    
    if(![KxMenu isOpen])
    {
        NSArray *menuItems =
        @[
          
          [KxMenuItem menuItem:@"搜全部"
                         image:[UIImage imageNamed:@"iwsearchall0"]
                     highlight:[UIImage imageNamed:@"iwsearchall1"]
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"搜招聘"
                         image:[UIImage imageNamed:@"iwsearchrecruit0"]
                     highlight:[UIImage imageNamed:@"iwsearchrecruit1"]
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"搜招商"
                         image:[UIImage imageNamed:@"iwsearchattract0"]
                     highlight:[UIImage imageNamed:@"iwsearchattract1"]
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"搜优惠"
                         image:[UIImage imageNamed:@"iwsearchdiscount0"]
                     highlight:[UIImage imageNamed:@"iwsearchdiscount1"]
                        target:self
                        action:@selector(pushMenuItem:)],
          ];
        
        CGRect rect = CGRectMake(46, 8, 100, 40);
        
        [KxMenu showMenuInView:self.navigationController.view
                      fromRect:rect
                     menuItems:menuItems
                     itemWidth:100];
        [KxMenu sharedMenu].delegate = self;
    }
    else
    {
        [KxMenu dismissMenu];
    }
}
- (void)pushMenuItem:(id)sender{
    
}

- (void)which_tag_clicked:(int)tag{
    self.searchType = (IWSearchType) tag;
    switch (self.searchType) {
        case IWSearchAll:
            [self.buttonSearch setTitle:@"搜全部" forState:UIControlStateNormal];
            break;
        case IWSearchRecruit:
            [self.buttonSearch setTitle:@"搜招聘" forState:UIControlStateNormal];
            break;
        case IWSearchAttract:
            [self.buttonSearch setTitle:@"搜招商" forState:UIControlStateNormal];
            break;
        case IWSearchDiscount:
            [self.buttonSearch setTitle:@"搜优惠" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W(self.view), 23)];
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width, 23)];
    if (section == 0) {
        header.text = @"热门搜索";
        header.textColor = RGBCOLOR(250, 9, 28);
    }else{
        header.text = @"搜索记录";
        header.textColor = RGBCOLOR(153, 153, 153);
    }
    view.backgroundColor = RGBCOLOR(247, 247, 247);
    header.font = [UIFont systemFontOfSize:12];
    [view addSubview:header];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(float) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 23.0f;
}
-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return [self.arrayHotWord count];
    }else{
        return [self.arrayReseachWord count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid=@"IWSearchTableViewCell";
    
    IWSearchTableViewCell *cell = (IWSearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if(cell==nil){
        cell = (IWSearchTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"IWSearchTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    if (indexPath.section == 0) {
        [cell setupContent:NO title:self.arrayHotWord[indexPath.row]];
    }else{
        cell.tag = indexPath.row;
         [cell setupContent:YES title:self.arrayReseachWord[indexPath.row]];
        cell.deleteItem = ^(int tag){
            [self.arrayReseachWord removeObjectAtIndex:tag];
            [tableView reloadData];
            [self saveHistoryData];
        };
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        self.textFieldSearch.text = self.arrayHotWord[indexPath.row];
    }else{
        self.textFieldSearch.text = self.arrayReseachWord[indexPath.row];
    }
    
    IWSearchResultViewController *vc = [[IWSearchResultViewController alloc] initWithNibName:NSStringFromClass([IWSearchResultViewController class]) bundle:nil];
    vc.searchType = self.searchType;
    if (indexPath.section == 0) {
        vc.searchKeyword = self.arrayHotWord[indexPath.row];
    }else{
        vc.searchKeyword = self.arrayReseachWord[indexPath.row];
    }
    [self.navigationController pushViewController:vc animated:YES];
}


/**
 *  加载 保存历史纪录
 */
-(void) loadHistoryData
{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];

    if (self.arrayReseachWord == nil) {
        self.arrayReseachWord = [[NSMutableArray alloc] initWithArray:[userDefault objectForKey:kIWSearchWordRecordKey]];
    }
}
-(void) saveHistoryData
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.arrayReseachWord forKey:kIWSearchWordRecordKey];
    [userDefault synchronize];
}


/**
 *  输入框处理
 */

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@"请输入搜索词"]) {
        textField.textColor = RGBCOLOR(9, 9, 9);
        textField.text = @"";
    }
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
    [_viewNavigationTitle release];
    [_tableView release];
    [_textFieldSearch release];
    [_buttonSearch release];
    [super dealloc];
}
@end
