//
//  IWCollectViewController.m
//  miaozhuan
//
//  Created by luo on 15/4/23.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWCollectViewController.h"
#import "NSMutableArray+SWUtilityButtons.h"
#import "IWCollectTableviewCell.h"
#import "SharedData.h"
#import "API_PostBoard.h"
#import "MZRefresh.h"
#import "IWRecruitDetailViewController.h"
#import "IWAttractBusinessDetailViewController.h"
#import "IWMainDetail.h"
#import "SellerDiscountDetail.h"
#import "IWCompanyIntroViewController.h"
#import "RequestFailed.h"



//管理类型
typedef NS_ENUM(NSInteger, IWCollectViewAlertViewType) {
    IWCollectViewAlertViewCancelCollection = 0, //取消收藏
    IWCollectViewAlertViewFilterCollection,     //过滤失效
};

@interface IWCollectViewController ()<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate,UIAlertViewDelegate,RequestFailedDelegate>
{
    int _pageIndex;
    int _pageSize;
    int _deleteIndex;
    RequestFailed * _requestFailed;
}

@property (retain, nonatomic) IBOutlet UIView             *viewHeader;
@property (retain, nonatomic) IBOutlet UIView             *viewLine;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraintLine;
@property (retain, nonatomic) IBOutlet UITableView        *tableView;
@property (nonatomic, retain) NSMutableArray     * dataRecruit;
@property (nonatomic, retain) NSMutableArray     * dataAttractBusiness;
@property (nonatomic, retain) NSMutableArray     * dataDiscount;

@property (nonatomic, retain) UIButton *buttonClick;
@property (retain, nonatomic) IBOutlet UIButton *buttonSellerDiscount;
@property (retain, nonatomic) IBOutlet UIButton *buttonRecurit;
@property (retain, nonatomic) IBOutlet UIButton *buttonAttract;

@property (retain, nonatomic) IBOutlet UIView *viewNoResult;
@property (retain, nonatomic) IBOutlet UILabel *lableNoResulTip;
@property (retain, nonatomic) IBOutlet UIButton *buttonFilter;


@end    

@implementation IWCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    InitNav(@"信息收藏");
    [self setupMoveBackButton];
    _pageIndex = 0;
    _pageSize = 30;
    _deleteIndex = -1;
    
    _dataRecruit = [[NSMutableArray alloc] init];
    _dataAttractBusiness = [[NSMutableArray alloc] init];
    _dataDiscount = [[NSMutableArray alloc] init];
    
    
    if(_postBoardType == 0)
        _postBoardType = kPostBoardDiscount;
    else if (_postBoardType == kPostBoardRecruit) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self buttonClick:self.buttonRecurit];
        });
        
    }else if (_postBoardType == kPostBoardAttractBusiness){
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self buttonClick:self.buttonAttract];
         });
    }else if (_postBoardType == kPostBoardDiscount){
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self buttonClick:self.buttonSellerDiscount];
         });
    }

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
    
    
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
    switch (_postBoardType) {
        case kPostBoardRecruit:
        {
            [[API_PostBoard getInstance] engine_outside_postBoard_colloctionListIndex:_pageIndex size:_pageSize type:kPostBoardRecruit];
        }
            break;
        case kPostBoardAttractBusiness:
        {
            [[API_PostBoard getInstance] engine_outside_postBoard_colloctionListIndex:_pageIndex size:_pageSize type:kPostBoardAttractBusiness];
        }
            break;
        case kPostBoardDiscount:
        {
            
            [[API_PostBoard getInstance] engine_outside_postBoard_colloctionListIndex:_pageIndex size:_pageSize type:kPostBoardDiscount];
        }
        default:
            break;
    }
}


- (void)handleUpdateSuccessAction:(NSNotification *)note
{
    [_tableView.header endRefreshing];
    [_tableView.footer endRefreshing];
    
    NSDictionary *dict = [note userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    if(type == ut_postBoard_colloctionList)
    {
        if (ret == 1) {
            [self handleUpdateData:YES];
        }else{
            [HUDUtil showErrorWithStatus:dict[@"msg"]];
        }
    }else if (type == ut_postBoard_cancelCollection){
        if (ret == 1) {
            switch (_postBoardType) {
                case kPostBoardRecruit:
                {
                    [_dataRecruit removeObjectAtIndex:_deleteIndex];
                }
                    break;
                case kPostBoardAttractBusiness:
                {
                    [_dataAttractBusiness removeObjectAtIndex:_deleteIndex];
                }
                    break;
                case kPostBoardDiscount:
                {
                    [_dataDiscount removeObjectAtIndex:_deleteIndex];
                }
                    break;
                    
                default:
                    break;
            }
            
            [self handleUpdateData:NO];
            
        }else{
            [HUDUtil showErrorWithStatus:dict[@"msg"]];
        }
    }else if (type == ut_postBoard_filterCollection)
    {
        if (ret == 1) {
            [HUDUtil showSuccessWithStatus:@"过滤成功"];
              [self handleUpdateData:NO];
        }else{
            [HUDUtil showErrorWithStatus:dict[@"msg"]];
        }
    }
}
-(void) handleUpdateFailureAction:(NSNotification *) note{
    
    [_tableView.header endRefreshing];
    [_tableView.footer endRefreshing];
    
    NSDictionary *dict = [note userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    if(type == ut_postBoard_colloctionList)
    {
        _requestFailed= [RequestFailed getInstance];
        _requestFailed.delegate = self;
        [_requestFailed.view addSubview:_requestFailed.viewNoNet];
        [self.view addSubview:_requestFailed.view];
        [self.view bringSubviewToFront:_requestFailed.viewNoNet];
        
        [HUDUtil showErrorWithStatus:@"收藏列表加载失败"];
    }
}
-(void)didClickedRefresh{
    [_requestFailed.view  removeFromSuperview];
    _pageIndex = 0;
    [self.tableView.header beginRefreshing];
}

/**
 *  显示加载的数据
 */
-(void) handleUpdateData:(BOOL) isNetWorkData
{
    switch (_postBoardType) {
        case kPostBoardAttractBusiness:
        {
            if (isNetWorkData) {
                [_dataAttractBusiness removeAllObjects];
                [_dataAttractBusiness addObjectsFromArray:[SharedData getInstance].postBoardCollectionLists];
            }
            if ([_dataAttractBusiness count] >= _pageSize) {
                [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
                self.tableView.footer.textColor = MZRefreshFooterLabelTextColor;
            }
            
            if ([_dataAttractBusiness count] == 0) {
                _tableView.hidden = YES;
                _viewNoResult.hidden = NO;
                _lableNoResulTip.text = @"您没有收藏任何招商信息";
                _buttonFilter.hidden = YES;
            }else{
                _tableView.hidden = NO;
                _viewNoResult.hidden = YES;
                [_tableView reloadData];
                _buttonFilter.hidden = NO;
            }
        }
            break;
        case kPostBoardRecruit:
        {
            if (isNetWorkData) {
                [_dataRecruit removeAllObjects];
                [_dataRecruit addObjectsFromArray:[SharedData getInstance].postBoardCollectionLists];
            }
            if ([_dataRecruit count] >= _pageSize) {
                [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
                self.tableView.footer.textColor = MZRefreshFooterLabelTextColor;
            }
            if ([_dataRecruit count] == 0) {
                _tableView.hidden = YES;
                _viewNoResult.hidden = NO;
                _lableNoResulTip.text = @"您没有收藏任何招聘信息";
                _buttonFilter.hidden = YES;
            }else{
                _tableView.hidden = NO;
                _viewNoResult.hidden = YES;
                [_tableView reloadData];
                _buttonFilter.hidden = NO;
            }
        }
            break;
        case kPostBoardDiscount:
        {
            if (isNetWorkData) {
                [_dataDiscount removeAllObjects];
                [_dataDiscount addObjectsFromArray:[SharedData getInstance].postBoardCollectionLists];
            }
            if ([_dataDiscount count] >= _pageSize) {
                [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
                self.tableView.footer.textColor = MZRefreshFooterLabelTextColor;
            }
            
            if ([_dataDiscount count] == 0) {
                _tableView.hidden = YES;
                _viewNoResult.hidden = NO;
                _lableNoResulTip.text = @"您没有收藏任何优惠信息";
                _buttonFilter.hidden = YES;
            }else{
                _tableView.hidden = NO;
                _viewNoResult.hidden = YES;
                [_tableView reloadData];
                _buttonFilter.hidden = NO;
            }
        }
            break;
            
        default:
            break;
    }
}

/**
 *  切换信息源
 *
 *  @param sender sender
 */
- (IBAction)buttonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
        {
            _postBoardType = kPostBoardDiscount;
        }
            break;
        case 1:
        {
            _postBoardType = kPostBoardRecruit;
        }
            break;
        case 2:
        {
            _postBoardType = kPostBoardAttractBusiness;
        }
            break;
            
        default:
            break;
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        self.constraintLine.constant = sender.frame.origin.x;
        [self.viewHeader layoutIfNeeded];
        
        switch (_postBoardType) {
            case kPostBoardRecruit:
            {
                if ([_dataRecruit count] == 0) {
                    [_tableView.header beginRefreshing];
                }else{
                    [self handleUpdateData:NO];
                }
                
            }
                break;
            case kPostBoardAttractBusiness:
            {
                if ([_dataAttractBusiness count] == 0) {
                    [_tableView.header beginRefreshing];
                }else{
                    [self handleUpdateData:NO];
                }
                
                
            }
                break;
            case kPostBoardDiscount:
            {
                if ([_dataDiscount count] == 0) {
                    [_tableView.header beginRefreshing];
                }else{
                    [self handleUpdateData:NO];
                }
            }
                break;
                
            default:
                break;
        }
        
    }];

    
    if (sender.tag == 0 && (self.buttonClick == nil)) {
        self.buttonClick = sender; return;
    }else if ( (self.buttonClick == nil ) && sender.tag != 0){
        [self.buttonSellerDiscount setTitleColor:RGBCOLORFLOAT(34) forState:UIControlStateNormal];
        self.buttonSellerDiscount.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    if (sender == self.buttonClick) return;
    
    
    [self.buttonClick setTitleColor:RGBCOLORFLOAT(34) forState:UIControlStateNormal];
    self.buttonClick.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.buttonClick = sender;
    
    [self.buttonClick setTitleColor:RGBCOLOR(240, 34, 34) forState:UIControlStateNormal];
    self.buttonClick.titleLabel.font = [UIFont systemFontOfSize:16];
    

    [self.viewHeader layoutIfNeeded];
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"取消"];
    return rightUtilityButtons;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = 0;
    switch (_postBoardType) {
        case kPostBoardRecruit:
        {
            count = [_dataRecruit count];
        }
            break;
        case kPostBoardAttractBusiness:
        {
            count = [_dataAttractBusiness count];
        }
            break;
        case kPostBoardDiscount:
        {
            count = [_dataDiscount count];
        }
        default:
            break;
    }
    
    return count;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 110.f;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid=@"IWCollectTableviewCell";
    
    IWCollectTableviewCell *cell = (IWCollectTableviewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if(cell==nil){
        cell = (IWCollectTableviewCell *)[[[NSBundle mainBundle] loadNibNamed:@"IWCollectTableviewCell" owner:self options:nil] objectAtIndex:0];
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
    }
    cell.tag = indexPath.row;
    
    switch (_postBoardType) {
        case kPostBoardRecruit:
        {
            [cell updateContent:_dataRecruit[indexPath.row]];
        }
            break;
        case kPostBoardAttractBusiness:
        {
             [cell updateContent:_dataAttractBusiness[indexPath.row]];
        }
            break;
        case kPostBoardDiscount:
        {
            [cell updateContent:_dataDiscount[indexPath.row]];
        }
        default:
            break;
    }

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    switch (_postBoardType) {
        case kPostBoardRecruit:
        {
            CollectionInfo * obj = _dataRecruit[indexPath.row];
            IWMainDetail *vc = [[IWMainDetail alloc] init];
            vc.navTitle = @"招聘信息";
            IWRecruitDetailViewController *vc0 = [[IWRecruitDetailViewController alloc] initWithNibName:NSStringFromClass([IWRecruitDetailViewController class]) bundle:nil];
            vc0.detailsId = obj.collectionId;
            vc0.detailType = IWRecruitDetailType_Browse;
            IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
            vc1.postBoardType = kPostBoardRecruit;
            vc.viewControllers = @[vc0,vc1];
            vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case kPostBoardAttractBusiness:
        {
            CollectionInfo * obj = _dataAttractBusiness[indexPath.row];
            IWMainDetail *vc = [[IWMainDetail alloc] init];
            vc.navTitle = @"招商信息";
            IWAttractBusinessDetailViewController *vc0 = [[IWAttractBusinessDetailViewController alloc] initWithNibName:NSStringFromClass([IWAttractBusinessDetailViewController class]) bundle:nil];
            vc0.detailsId = obj.collectionId;
            vc0.detailType = IWAttractBusinessDetailType_Browse;
            IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
            vc1.postBoardType =kPostBoardAttractBusiness;
            vc.viewControllers = @[vc0,vc1];
            vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case kPostBoardDiscount:
        {
            CollectionInfo * obj = _dataDiscount[indexPath.row];
            IWMainDetail *vc = [[IWMainDetail alloc] init];
            vc.navTitle = @"优惠信息";
            SellerDiscountDetail *vc0 = [[SellerDiscountDetail alloc] initWithNibName:NSStringFromClass([SellerDiscountDetail class]) bundle:nil];
            vc0.discountId = obj.collectionId;
            vc0.isPreview = NO;
            IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
            vc1.postBoardType = kPostBoardDiscount;
            vc.viewControllers = @[vc0,vc1];
            vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
            
            [self.navigationController pushViewController:vc animated:YES];

            
        }
        default:
            break;
    }
    
}
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:  //取消收藏
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"取消收藏" message:@"是否取消本条收藏信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = IWCollectViewAlertViewCancelCollection;
            [alert show];
            _deleteIndex = cell.tag;
            break;
        }
        default:
            break;
    }
}

#pragma mark 取消收藏信息
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if(buttonIndex == 0){
    
    }else if (buttonIndex == 1){
        //取消收藏
        if (alertView.tag == IWCollectViewAlertViewCancelCollection) {
        
            CollectionInfo * obj = nil;
            switch (_postBoardType) {
                case kPostBoardRecruit:
                    obj = _dataRecruit[_deleteIndex];
                    break;
                case kPostBoardAttractBusiness:
                    obj = _dataAttractBusiness[_deleteIndex];
                    break;
                case kPostBoardDiscount:
                    obj = _dataDiscount[_deleteIndex];
                    break;
                default:
                    break;
            }
            
            [[API_PostBoard getInstance] engine_outside_postBoard_cancelCollectionID:obj.collectionId type:_postBoardType];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)onMoveBack:(UIButton *) sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)buttonClickFilter:(UIButton *)sender {
    [[API_PostBoard getInstance] engine_outside_postBoard_filterCollectionType:_postBoardType];
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
    [_constraintLine release];
    [_viewHeader release];
    [_viewLine release];
    [_tableView release];
    [_buttonSellerDiscount release];
    [_viewNoResult release];
    [_lableNoResulTip release];
    [_buttonFilter release];
    [_buttonRecurit release];
    [_buttonAttract release];
    [super dealloc];
}
@end
