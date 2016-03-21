//
//  IWSearchResultViewController.m
//  miaozhuan
//
//  Created by luo on 15/4/24.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWSearchResultViewController.h"
#import "IWSearchResultTableViewCell.h"
#import "SharedData.h"
#import "API_PostBoard.h"
#import "IWMainDetail.h"
#import "SellerDiscountDetail.h"
#import "IWCompanyIntroViewController.h"
#import "IWRecruitDetailViewController.h"
#import "IWAttractBusinessDetailViewController.h"
#import "MZRefresh.h"


@interface IWSearchResultViewController ()<UITableViewDelegate,UITableViewDataSource>{

    int _pageIndex;
    int _pageSize;
}

@property (retain, nonatomic) IBOutlet UIView *viewNoResult;
@property (retain, nonatomic) NSMutableArray *data;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) IBOutlet UIButton *buttonScrollContent;

@property (retain, nonatomic) IBOutlet UIView *tableViewHeader;
@property (retain, nonatomic) IBOutlet UILabel *lableSearchValue;
@property (retain, nonatomic) IBOutlet UILabel *lableSearchResultCount;



@end

@implementation IWSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pageIndex  = 0;
    _pageSize   = 30;
    
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:@"UpdateSuccessAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:@"UpdateFailureAction" object:nil];
//    
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    self.tableView.header.updatedTimeHidden = YES;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 1; i<=16; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Loadicon.bundle/Loadicon%d",i]];
        [refreshingImages addObject:image];
    }
    [self.tableView.gifHeader setImages:@[refreshingImages[0]] forState:MZRefreshHeaderStateIdle];
    [self.tableView.gifHeader setImages:@[refreshingImages[0]] forState:MZRefreshHeaderStatePulling];
    [self.tableView.gifHeader setImages:refreshingImages forState:MZRefreshHeaderStateRefreshing];
    
    [self.tableView.header beginRefreshing];
}

/**
 *  加载数据源
 */
-(void) refreshData{
    _pageIndex = 0;
    [self loadData];
}
-(void)loadMoreData{
    [self loadData];
}

-(void) loadData{
//    [HUDUtil showWithMaskType:HUDMaskTypeBlack];
    [[API_PostBoard getInstance] engine_outside_postBoard_searchIndex:_pageIndex size:_pageSize type:(PostBoardType)self.searchType keyword:_searchKeyword];
}

- (void)handleUpdateSuccessAction:(NSNotification *)note
{
//    [HUDUtil dismiss];
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    NSDictionary *dict = [note userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    
    if(type == ut_postBoard_search)
    {
        if(ret == 1)
        {
            _pageIndex++;
            [self reloadDataView];
        }else{
           [self reloadDataView];
        }
    }
}
-(void) reloadDataView{
        _data = [SharedData getInstance].postBoardSearchResults;
        if ([_data count] == 0) {
            _viewNoResult.hidden = NO;
            _tableView.hidden = YES;
            _buttonScrollContent.hidden = YES;
        }else{
            _viewNoResult.hidden = YES;
            _tableView.hidden = NO;
            _buttonScrollContent.hidden = NO;
            _lableSearchValue.text = [NSString stringWithFormat:@"当前搜索:%@",self.searchKeyword];
            _lableSearchResultCount.text =  [NSString stringWithFormat:@"%d个相关结果",[_data count]];
        }
        if ([_data count]>= _pageSize) {
            [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
            self.tableView.footer.textColor = MZRefreshFooterLabelTextColor;
        }
    
        [_tableView reloadData];
}



- (void)handleUpdateFailureAction:(NSNotification *)note
{
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    [HUDUtil showErrorWithStatus:@"搜索失败"];
}


-(void) setupUI{
    InitNav(@"搜索结果");
    [self setupMoveBackButton];
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([_data count] != 0) {
        return _tableViewHeader;
    }else{
        return nil;
    }
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid=@"IWSearchResultTableViewCell";
    
    IWSearchResultTableViewCell *cell = (IWSearchResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if(cell==nil){
        cell = (IWSearchResultTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"IWSearchResultTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    [cell setupContent:self.data[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    PostBoardSearchResultInfo *obj = _data[indexPath.row];
    
    switch (obj.resultType) {
        case kPostBoardRecruit:
        {
            IWMainDetail *vc = [[IWMainDetail alloc] init];
            
            IWRecruitDetailViewController *vc0 =[[IWRecruitDetailViewController alloc] initWithNibName:NSStringFromClass([IWRecruitDetailViewController class]) bundle:nil];
//            vc0.isDraft = NO;
            vc0.detailsId = obj.resultId;
            vc0.detailType = IWRecruitDetailType_Browse;
            IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
            vc1.postBoardType = kPostBoardRecruit;
            vc.navTitle = @"招聘信息详情";
            vc.viewControllers = @[vc0,vc1];
            vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case kPostBoardAttractBusiness:
        {
            IWMainDetail *vc = [[IWMainDetail alloc] init];
            
            IWAttractBusinessDetailViewController *vc0 =[[IWAttractBusinessDetailViewController alloc] initWithNibName:NSStringFromClass([IWAttractBusinessDetailViewController class]) bundle:nil];
            vc0.detailType = IWAttractBusinessDetailType_Browse;
            //            vc0.isDraft = NO;
            vc0.detailsId = obj.resultId;
            vc0.detailType = IWAttractBusinessDetailType_Browse;
            IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
            vc1.postBoardType = kPostBoardAttractBusiness;
            vc.navTitle = @"招商信息详情";
            vc.viewControllers = @[vc0,vc1];
            vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case kPostBoardDiscount:
        {
            IWMainDetail *vc = [[IWMainDetail alloc] init];
            
            SellerDiscountDetail *vc0 =[[SellerDiscountDetail alloc] initWithNibName:NSStringFromClass([SellerDiscountDetail class]) bundle:nil];
            vc0.isPreview = NO;
            vc0.discountId = obj.resultId;
            IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
            vc1.postBoardType = kPostBoardDiscount;
            vc.navTitle = @"商家优惠详情";
            vc.viewControllers = @[vc0,vc1];
            vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }   
}

//tableview 滚动
- (IBAction)buttonClick:(UIButton *)sender {
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
    [_viewNoResult release];
    [_tableView release];
    [_buttonScrollContent release];
    [_tableViewHeader release];
    [_lableSearchValue release];
    [_lableSearchResultCount release];
    [super dealloc];
}
@end
