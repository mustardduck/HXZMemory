//
//  IWAlreadyPublishManagementViewController.m
//  miaozhuan
//
//  Created by luo on 15/4/23.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWAlreadyPublishManagementViewController.h"
#import "IWAlreadyPublishManagementTableViewCell.h"
#import "NSMutableArray+SWUtilityButtons.h"
#import "IWMainDetail.h"
#import "SellerDiscountDetail.h"
#import "IWCompanyIntroViewController.h"
#import "SharedData.h"
#import "API_PostBoard.h"
#import "IWRecruitDetailViewController.h"
#import "IWAttractBusinessDetailViewController.h"
#import "MZRefresh.h"
#import "IWPublishRecruitViewController.h"
#import "IWPublishAttractBusinessViewController.h"
#import "VIPPrivilegeViewController.h"
#import "IWSellerDiscountPublish.h"

#define kBuyVipAlertTag 112

/**
 *  是否是点击了操作按钮
 */
static BOOL isEdit = NO;


typedef NS_ENUM(NSInteger, IWAlreadyPublishManagementAlertViewType){
    
    /**  下架 */              kAlreadyPublishOffine  = 1,
    /**  删除 */              kAlreadyPublishDelete,
    /**  普通商家条数限制 */    kAlreadyPublishRefreshTypeNomalLimit,
    /**  VIP商家条数限制 */    kAlreadyPublishRefreshTypeVIPLimit,
    /**  今天剩余刷新条数大于条数限制时 */    kAlreadyPublishRefreshTypeOutBoundsLimit,
};

@interface IWAlreadyPublishManagementViewController () <UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate,UIAlertViewDelegate>
{
    int _pageIndex; //列表页
    int _pageSize;  //页面大小
    int _deleteIndex;   //删除cell值索引
    UIButton *_buttonRight;
    NSMutableArray *_alreadyRefreshItems;//已刷新
}


@property (nonatomic,strong) IBOutlet UITableView    * tableView;
@property (nonatomic,strong) NSMutableArray * data;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *verticalTableViewBottonVIew;

@property (retain, nonatomic) IBOutlet UIImageView *imageViewTip;
@property (retain, nonatomic) IBOutlet UILabel *lableTip;

@property (retain, nonatomic) IBOutlet UIButton *buttonRefresh;
@property (retain, nonatomic) IBOutlet UIButton *buttonOffline;



@end

@implementation IWAlreadyPublishManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _alreadyRefreshItems = [[NSMutableArray alloc] init];
    
    _pageIndex = 0;
    _pageSize = 30;
    _deleteIndex = -1;
    isEdit = NO;
    _tableView.tableFooterView = [[UIView alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
    
    switch (_type) {
        case AlreadyPublishManagementSellerDiscountDraft:
            InitNav(@"草稿箱");
            break;
            
        case AlreadyPublishManagementSellerDiscountAlreadyPublish:{
            InitNav(@"已发布的优惠信息");
            
            [self setupMoveFowardButtonWithTitle:@"操作"];
        } break;
            
        case AlreadyPublishManagementSellerDiscountOffline:
            InitNav(@"下架的优惠信息"); break;
            
        case AlreadyPublishManagementSellerDiscountForceOffline:
            InitNav(@"被强制下架的优惠信息");break;
            
        case AlreadyPublishManagementRecruitDraft:
            InitNav(@"草稿箱"); break;
            
        case AlreadyPublishManagementRecruitAlreadyPublish:{
            InitNav(@"已发布的招聘信息");
            [self setupMoveFowardButtonWithTitle:@"操作"];
        }break;
            
        case AlreadyPublishManagementRecruitOffline:
            InitNav(@"下架的招聘信息");break;
            
        case AlreadyPublishManagementRecruitForceOffline:
            InitNav(@"被强制下架的招聘信息");break;
            
        case AlreadyPublishManagementAttractBusinessDraft:
            InitNav(@"草稿箱");break;
            
        case AlreadyPublishManagementAttractBusinessAlreadyPublish:{
            InitNav(@"已发布的招商信息");
            [self setupMoveFowardButtonWithTitle:@"操作"];
        }
            break;
            
        case AlreadyPublishManagementAttractBusinessOffline:
            InitNav(@"下架的招商信息");break;
            
        case AlreadyPublishManagementAttractBusinessForceOffline:
            InitNav(@"被强制下架的招商信息");break;
            
        default:
            break;
    }
    
    [self setupMoveBackButton];
    [self setupUI];
    
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    self.tableView.header.updatedTimeHidden = YES;
    
     if([UICommon getSystemVersion] < 7.0f){
        [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 1; i<=16; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Loadicon.bundle/Loadicon%d",i]];
        [refreshingImages addObject:image];
    }
    
    [self.tableView.gifHeader setImages:@[refreshingImages[0]] forState:MZRefreshHeaderStateIdle];
    [self.tableView.gifHeader setImages:@[refreshingImages[0]] forState:MZRefreshHeaderStatePulling];
    [self.tableView.gifHeader setImages:refreshingImages forState:MZRefreshHeaderStateRefreshing];
   
}

-(void) refreshData{
    _pageIndex = 0;
    [self loadData];
    
}
-(void)loadMoreData{
    [self loadData];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView.header beginRefreshing];
}

#pragma mark -- 重置数据源编辑的选中状态
-(void)resetDataSelectedStatus{
    for (int i = 0; i < _data.count; i ++) {
        
        DiscountListInfo * obj = _data[i];
        obj.listIsSelected = NO;
    }
    [_tableView reloadData];
}

/**
 *  加载数据
 */
-(void) loadData{
    
    switch (_type) {
        case AlreadyPublishManagementSellerDiscountDraft:
        {
            [[API_PostBoard getInstance] engine_outside_discountManage_listType:kPostBoardUncommit index:_pageIndex size:_pageSize];
        }
            break;
        case AlreadyPublishManagementSellerDiscountAlreadyPublish:{
            [[API_PostBoard getInstance] engine_outside_discountManage_listType:kPostBoardPlayOn index:_pageIndex size:_pageSize];
        }
            break;
        case AlreadyPublishManagementSellerDiscountOffline:{
            [[API_PostBoard getInstance] engine_outside_discountManage_listType:kPostBoardPlayOff index:_pageIndex size:_pageSize];
        }break;
        case AlreadyPublishManagementSellerDiscountForceOffline:{
            [[API_PostBoard getInstance] engine_outside_discountManage_listType:kPostBoardOffine index:_pageIndex size:_pageSize];
        }
            break;
        case AlreadyPublishManagementRecruitDraft:
        {
            [[API_PostBoard getInstance] engine_outside_recruitmentManage_listStatus:kPostBoardUncommit index:_pageIndex size:_pageSize];
        }
            break;
        case AlreadyPublishManagementRecruitAlreadyPublish:{
            [[API_PostBoard getInstance] engine_outside_recruitmentManage_listStatus:kPostBoardPlayOn index:_pageIndex size:_pageSize];
        }break;
            
        case AlreadyPublishManagementRecruitOffline:{
            [[API_PostBoard getInstance] engine_outside_recruitmentManage_listStatus:kPostBoardPlayOff index:_pageIndex size:_pageSize];
        } break;
            
        case AlreadyPublishManagementRecruitForceOffline:{
            [[API_PostBoard getInstance] engine_outside_recruitmentManage_listStatus:kPostBoardOffine index:_pageIndex size:_pageSize];
            
        }break;
            
        case AlreadyPublishManagementAttractBusinessDraft:{
            [[API_PostBoard getInstance] engine_outside_attractBusinessManage_listStatus:kPostBoardUncommit index:_pageIndex size:_pageSize];
        } break;
            
        case AlreadyPublishManagementAttractBusinessAlreadyPublish:{
            [[API_PostBoard getInstance] engine_outside_attractBusinessManage_listStatus:kPostBoardPlayOn index:_pageIndex size:_pageSize];
        } break;
            
        case AlreadyPublishManagementAttractBusinessOffline:{
            [[API_PostBoard getInstance] engine_outside_attractBusinessManage_listStatus:kPostBoardPlayOff index:_pageIndex size:_pageSize];
        } break;
            
        case AlreadyPublishManagementAttractBusinessForceOffline:{
            [[API_PostBoard getInstance] engine_outside_attractBusinessManage_listStatus:kPostBoardOffine index:_pageIndex size:_pageSize];
        } break;
        default:
            break;
    }
    
}

- (void)handleUpdateSuccessAction:(NSNotification *)note
{
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    
    
    NSDictionary *dict = [note userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    
    if(type == ut_discountManage_list || type == ut_recruitmentManage_list || type == ut_attractBusinessManage_list)
    {
        if(ret == 1)
        {
            _pageIndex = _pageIndex + 1;
            
            switch (type) {
                case ut_discountManage_list:
                    _data = [SharedData getInstance].discountList;
                    break;
                case ut_recruitmentManage_list:
                    _data = [SharedData getInstance].recruitmentList;
                    break;
                case ut_attractBusinessManage_list:
                    _data = [SharedData getInstance].attractBusinessList;
                    break;
                default:
                    break;
            }
            
            
            if ([_data count] == 0) {
                
                switch (_type) {
                    case AlreadyPublishManagementSellerDiscountDraft:
                        _lableTip.text = @"暂时没有草稿信息";
                        break;
                        
                    case AlreadyPublishManagementSellerDiscountAlreadyPublish:
                        _lableTip.text = @"没有发布任何商家优惠";
                        break;
                        
                    case AlreadyPublishManagementSellerDiscountOffline:
                        _lableTip.text = @"没有任何已下架的优惠";
                        break;
                        
                    case AlreadyPublishManagementSellerDiscountForceOffline:
                        _lableTip.text = @"没有任何被强制下架的优惠";
                        break;
                        
                    case AlreadyPublishManagementRecruitDraft:
                        _lableTip.text = @"暂时没有草稿信息";break;
                        
                    case AlreadyPublishManagementRecruitAlreadyPublish:{
                        _lableTip.text = @"没有发布任何招聘信息";
                    }break;
                        
                    case AlreadyPublishManagementRecruitOffline:
                        _lableTip.text = @"没有任何已下架的招聘信息";
                        break;
                        
                    case AlreadyPublishManagementRecruitForceOffline:
                        _lableTip.text = @"没有任何被强制下架的招聘信息";
                        break;
                        
                    case AlreadyPublishManagementAttractBusinessDraft:
                        _lableTip.text = @"暂时没有草稿信息";
                        break;
                        
                    case AlreadyPublishManagementAttractBusinessAlreadyPublish:{
                        _lableTip.text = @"没有发布任何招商信息";
                    }
                        break;
                        
                    case AlreadyPublishManagementAttractBusinessOffline:
                        _lableTip.text = @"没有任何已下架的招商信息";
                        break;
                        
                    case AlreadyPublishManagementAttractBusinessForceOffline:
                        _lableTip.text = @"没有任何被强制下架的招商信息";
                        break;
                        
                    default:
                        break;
                }

                self.navigationItem.rightBarButtonItems = nil;
                
                _imageViewTip.hidden = NO;
                _lableTip.hidden = NO;
                _tableView.hidden = YES;
                
            }else{
                _tableView.hidden = NO;
                _imageViewTip.hidden = YES;
                _lableTip.hidden = YES;
            }
            if ([_data count] >= _pageSize) {
                [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
                self.tableView.footer.textColor = MZRefreshFooterLabelTextColor;
            }
            
            [self.tableView reloadData];
            
        }else{
            [HUDUtil showSuccessWithStatus:dict[@"msg"]];
        }
    }else if (type == ut_discountManage_delete || type == ut_recruitmentManage_delete || type == ut_attractBusinessManage_delete){
        if(ret == 1)
        {
            [HUDUtil showSuccessWithStatus:@"删除信息成功"];
            [_data removeObjectAtIndex:_deleteIndex];
            [_tableView reloadData];
        }else{
            [HUDUtil showSuccessWithStatus:dict[@"msg"]];
        }
    }else if (type == ut_discountManage_refresh || type == ut_recruitmentManage_refresh || type ==ut_attractBusinessManage_refresh){
        if(ret == 1)
        {
            [HUDUtil showSuccessWithStatus:@"刷新成功"];
            [_buttonRight setTitle:@"操作" forState:UIControlStateNormal];
            isEdit = NO;
            _verticalTableViewBottonVIew.constant = -60;
            [self refreshData];
            
        }else{
//            6011: 已刷新5条信息，是否购买VIP获取特权
//            6012: 今天还剩下X次刷新机会，请重新选择！
//            61011: 今天已经刷新了20条
//            6021: 已刷新5条信息，是否购买VIP获取特权
//            6022: 今天还剩下X次刷新机会，请重新选择！
//            61021: 今天已经刷新了20条
//            6031: 已刷新5条信息，是否购买VIP获取特权
//            6032: 今天还剩下X次刷新机会，请重新选择！
//            61031: 今天已经刷新了20条
            
            switch ([dict[@"code"] integerValue]) {
                case 6011:
                case 6021:
                case 6031:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"刷新限制" message:dict[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"去购买", nil];
                    alert.tag = kAlreadyPublishRefreshTypeNomalLimit;
                    [alert show];
                }
                    return;
                case 6012:
                case 6022:
                case 6032:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"超出限制" message:dict[@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    alert.tag = kAlreadyPublishRefreshTypeOutBoundsLimit;
                    [alert show];
                }
                    return;
                case 61011:
                case 61021:
                case 61031:
                {
                    [HUDUtil showErrorWithStatus:dict[@"msg"]];
                }
                    return;
                    
                default:
                    break;
                
            }
        }
    }else if (type == ut_discountManage_offline || type == ut_recruitmentManage_offline || type == ut_attractBusinessManage_offline){
        if(ret == 1)
        {
            [HUDUtil showSuccessWithStatus:@"下架成功"];
            isEdit = NO;
            _verticalTableViewBottonVIew.constant = -60;
            [_buttonRight setTitle:@"操作" forState:UIControlStateNormal];
            
            [self refreshData];
        }else{
            [HUDUtil showSuccessWithStatus:dict[@"msg"]];
        }
    }
}

-(void) handleUpdateFailureAction:(NSNotification *) note{
    
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    
    NSDictionary *dict = [note userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    if(type == ut_discountManage_saveDraft)
    {
        [HUDUtil showErrorWithStatus:@"保存草稿失败"];
    }
    
}


-(void) setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _verticalTableViewBottonVIew.constant = -60;
}

-(void) onMoveFoward:(UIButton *)sender
{
    _buttonRight = sender;
    
    isEdit = !isEdit;
    
    if (!isEdit) {
        [sender setTitle:@"操作" forState:UIControlStateNormal];
        _verticalTableViewBottonVIew.constant = -60;
        [self resetDataSelectedStatus];
    }else{
        [sender setTitle:@"取消" forState:UIControlStateNormal];
        _verticalTableViewBottonVIew.constant = 0;
    }
    
    [self.tableView reloadData];
    
}
- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"删除"];
    return rightUtilityButtons;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.data count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid=@"IWAlreadyPublishManagementTableViewCell";
    IWAlreadyPublishManagementTableViewCell *cell = (IWAlreadyPublishManagementTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if(cell==nil){
        cell = (IWAlreadyPublishManagementTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"IWAlreadyPublishManagementTableViewCell" owner:self options:nil] objectAtIndex:0];
        
        switch (self.type) {
            case AlreadyPublishManagementSellerDiscountAlreadyPublish:
            case AlreadyPublishManagementAttractBusinessAlreadyPublish:
            case AlreadyPublishManagementRecruitAlreadyPublish:
            {
            }
                break;
            default:
                cell.rightUtilityButtons = [self rightButtons];
                cell.delegate = self;
                break;
        }
    }
    cell.tag = indexPath.row;
    DiscountListInfo * obj = _data[indexPath.row];
    if(_type != AlreadyPublishManagementAttractBusinessDraft && _type != AlreadyPublishManagementRecruitDraft && _type != AlreadyPublishManagementSellerDiscountDraft){
        cell.label_AlreadyRefresh.hidden = !obj.listIsRefreshed;
    }else{
        cell.label_AlreadyRefresh.hidden = YES;
    }
    
    
    switch (_type) {
        case AlreadyPublishManagementSellerDiscountDraft:
        case AlreadyPublishManagementSellerDiscountAlreadyPublish:
        case AlreadyPublishManagementSellerDiscountOffline:
        case AlreadyPublishManagementSellerDiscountForceOffline:
        {
            DiscountListInfo * obj = _data[indexPath.row];
            cell.lableTitle.text = obj.listTitle.length > 0 ? obj.listTitle : @"未填写优惠标题";
            cell.lableContent.text = obj.listTimeDesc;
            
            [cell updateContent:isEdit seleted:obj.listIsSelected];
            __weak __block IWAlreadyPublishManagementViewController *wself = self;
            cell.choiceItem = ^(BOOL seleted){
                obj.listIsSelected = seleted;
                
                if ([[wself choseSelectedItem] count]) {
                    wself.buttonOffline.enabled = YES;
                    wself.buttonRefresh.enabled = YES;
                }else{
                    wself.buttonOffline.enabled = NO;
                    wself.buttonRefresh.enabled = NO;
                }
            };
        }
            break;
        case AlreadyPublishManagementRecruitDraft:
        case AlreadyPublishManagementRecruitAlreadyPublish:
        case AlreadyPublishManagementRecruitOffline:
        case AlreadyPublishManagementRecruitForceOffline:{
            
            RecruitmentListInfo *obj = _data[indexPath.row];
            cell.lableTitle.text = obj.listTitle.length > 0 ? obj.listTitle : @"未填写招聘标题";
            cell.lableContent.text = obj.listTimeDesc;
            [cell updateContent:isEdit seleted:obj.listIsSelected];
            __weak __block IWAlreadyPublishManagementViewController *wself = self;
            cell.choiceItem = ^(BOOL seleted){
                obj.listIsSelected = seleted;
                
                if ([[wself choseSelectedItem] count]) {
                    wself.buttonOffline.enabled = YES;
                    wself.buttonRefresh.enabled = YES;
                }else{
                    wself.buttonOffline.enabled = NO;
                    wself.buttonRefresh.enabled = NO;
                }
            };
        }
            break;
        case AlreadyPublishManagementAttractBusinessDraft:
        case AlreadyPublishManagementAttractBusinessAlreadyPublish:
        case AlreadyPublishManagementAttractBusinessOffline:
        case AlreadyPublishManagementAttractBusinessForceOffline:{
            
            AttractBusinessListInfo *obj = _data[indexPath.row];
            cell.lableTitle.text = obj.listTitle.length > 0 ? obj.listTitle : @"未填写招商标题";
            cell.lableContent.text = obj.listTimeDesc;
            [cell updateContent:isEdit seleted:obj.listIsSelected];
            __weak __block IWAlreadyPublishManagementViewController *wself = self;
            cell.choiceItem = ^(BOOL seleted){
                obj.listIsSelected = seleted;
                
                if ([[wself choseSelectedItem] count]) {
                    wself.buttonOffline.enabled = YES;
                    wself.buttonRefresh.enabled = YES;
                }else{
                    wself.buttonOffline.enabled = NO;
                    wself.buttonRefresh.enabled = NO;
                }
            };
        }
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark -- VIP最多发布条数
-(NSUInteger)vipPublishCountWithType:(AlreadyPublishManagementType)type{
    switch (self.type) {
        case AlreadyPublishManagementAttractBusinessDraft:
        case AlreadyPublishManagementAttractBusinessAlreadyPublish:
        case AlreadyPublishManagementAttractBusinessOffline:
        case AlreadyPublishManagementAttractBusinessForceOffline:
            return [[SharedData getInstance] attractBusinessManageInfo].businessVipPublishCount;
        case AlreadyPublishManagementRecruitDraft:
        case AlreadyPublishManagementRecruitAlreadyPublish:
        case AlreadyPublishManagementRecruitOffline:
        case AlreadyPublishManagementRecruitForceOffline:
            return [[SharedData getInstance] recruitmentManageInfo].recruitmentVipPublishCount;
        case AlreadyPublishManagementSellerDiscountDraft:
        case AlreadyPublishManagementSellerDiscountAlreadyPublish:
        case AlreadyPublishManagementSellerDiscountOffline:
        case AlreadyPublishManagementSellerDiscountForceOffline:
            return [[SharedData getInstance] discountManageInfo].discountVipPublishCount;
        default:
            return 0;
            break;
    }
}

#pragma mark -- 普通商家最多发布条数
-(NSUInteger)normalPublishCountWithType:(AlreadyPublishManagementType)type{
    switch (type) {
        case AlreadyPublishManagementAttractBusinessDraft:
        case AlreadyPublishManagementAttractBusinessAlreadyPublish:
        case AlreadyPublishManagementAttractBusinessOffline:
        case AlreadyPublishManagementAttractBusinessForceOffline:
            return [[SharedData getInstance] attractBusinessManageInfo].businessNormalPublishCount;
        case AlreadyPublishManagementRecruitDraft:
        case AlreadyPublishManagementRecruitAlreadyPublish:
        case AlreadyPublishManagementRecruitOffline:
        case AlreadyPublishManagementRecruitForceOffline:
            return [[SharedData getInstance] recruitmentManageInfo].recruitmentNormalPublishCount;
        case AlreadyPublishManagementSellerDiscountDraft:
        case AlreadyPublishManagementSellerDiscountAlreadyPublish:
        case AlreadyPublishManagementSellerDiscountOffline:
        case AlreadyPublishManagementSellerDiscountForceOffline:
            return [[SharedData getInstance] discountManageInfo].discountNormalPublishCount;
        default:
            return 0;
            break;
    }
}

#pragma mark -- 今日剩余发布条数
-(NSUInteger)todayRestCountWithType:(AlreadyPublishManagementType)type{
    switch (type) {
        case AlreadyPublishManagementAttractBusinessDraft:
        case AlreadyPublishManagementAttractBusinessAlreadyPublish:
        case AlreadyPublishManagementAttractBusinessOffline:
        case AlreadyPublishManagementAttractBusinessForceOffline:
            return [[SharedData getInstance] attractBusinessManageInfo].businessTodayRestCount;
        case AlreadyPublishManagementRecruitDraft:
        case AlreadyPublishManagementRecruitAlreadyPublish:
        case AlreadyPublishManagementRecruitOffline:
        case AlreadyPublishManagementRecruitForceOffline:
            return [[SharedData getInstance] recruitmentManageInfo].recruitmentTodayRestCount;
        case AlreadyPublishManagementSellerDiscountDraft:
        case AlreadyPublishManagementSellerDiscountAlreadyPublish:
        case AlreadyPublishManagementSellerDiscountOffline:
        case AlreadyPublishManagementSellerDiscountForceOffline:
            return [[SharedData getInstance] discountManageInfo].discountTodayRestCount;
        default:
            return 0;
            break;
    }
}

#pragma mark -- 进入编辑前检查
-(BOOL)checkBeforeEnterPublish{
    BOOL flag = NO;
    
    if(_type == AlreadyPublishManagementSellerDiscountDraft || _type == AlreadyPublishManagementRecruitDraft || _type == AlreadyPublishManagementAttractBusinessDraft){
        if([self todayRestCountWithType:_type] < 1){
            if([SharedData getInstance].personalInfo.userIsEnterpriseVip){
                [HUDUtil showErrorWithStatus:[NSString stringWithFormat:@"今天已经发布了%d条",[self vipPublishCountWithType:_type]]];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发布限制" message:[NSString stringWithFormat:@"已发布%d条信息，是否购买VIP获取特权",[self normalPublishCountWithType:_type]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"去购买", nil];
                alert.tag = kBuyVipAlertTag;
                [alert show];
            }
        }else{
            flag = YES;
        }
    }else{
        flag = YES;
    }
    
    return flag;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(isEdit){
        IWAlreadyPublishManagementTableViewCell *cell = (IWAlreadyPublishManagementTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        switch (_type) {
            case AlreadyPublishManagementSellerDiscountAlreadyPublish:
            {
                DiscountListInfo * obj = _data[indexPath.row];
                obj.listIsSelected = !obj.listIsSelected;
                if (obj.listIsSelected) {
                    [cell.buttonSelect setBackgroundImage:[UIImage imageNamed:@"ads_consult_004"] forState:UIControlStateNormal];
                }else{
                    [cell.buttonSelect setBackgroundImage:[UIImage imageNamed:@"ads_consult_005"] forState:UIControlStateNormal];
                }
            }
                break;
            case AlreadyPublishManagementRecruitAlreadyPublish:{
                RecruitmentListInfo * obj = _data[indexPath.row];
                obj.listIsSelected = !obj.listIsSelected;
                if (obj.listIsSelected) {
                    [cell.buttonSelect setBackgroundImage:[UIImage imageNamed:@"ads_consult_004"] forState:UIControlStateNormal];
                }else{
                    [cell.buttonSelect setBackgroundImage:[UIImage imageNamed:@"ads_consult_005"] forState:UIControlStateNormal];
                }
                
            }break;
            case AlreadyPublishManagementAttractBusinessAlreadyPublish:{
                AttractBusinessListInfo * obj = _data[indexPath.row];
                obj.listIsSelected = !obj.listIsSelected;
                if (obj.listIsSelected) {
                    [cell.buttonSelect setBackgroundImage:[UIImage imageNamed:@"ads_consult_004"] forState:UIControlStateNormal];
                }else{
                    [cell.buttonSelect setBackgroundImage:[UIImage imageNamed:@"ads_consult_005"] forState:UIControlStateNormal];
                }
                
            }
                break;
                
            default:
                break;
        }
        
        if ([[self choseSelectedItem] count]) {
            self.buttonOffline.enabled = YES;
            self.buttonRefresh.enabled = YES;
        }else{
            self.buttonOffline.enabled = NO;
            self.buttonRefresh.enabled = NO;
        }
        
        return;
    }
    
    if(![self checkBeforeEnterPublish]){
        return;
    }
    
    IWMainDetail *vc = [[IWMainDetail alloc] init];
    UIViewController *vc0;
     IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
    
    switch (self.type) {
        case AlreadyPublishManagementAttractBusinessDraft:
        {
            AttractBusinessListInfo *obj = _data[indexPath.row];
            IWPublishAttractBusinessViewController *iwpabvc = [[IWPublishAttractBusinessViewController alloc] init];
            iwpabvc.publishAttractBuinessType = IWPublishAttractBusinessType_FromDraft;
            iwpabvc.detailsId = obj.listId;
            vc1.postBoardType = kPostBoardAttractBusiness;
            [self.navigationController pushViewController:iwpabvc animated:YES];
        }
            return;
        case AlreadyPublishManagementAttractBusinessAlreadyPublish:
        {
            {
                vc.navTitle = @"招商信息";
                IWAttractBusinessDetailViewController *vctemp =[[IWAttractBusinessDetailViewController alloc] initWithNibName:NSStringFromClass([IWAttractBusinessDetailViewController class]) bundle:nil];
                if(_type == AlreadyPublishManagementAttractBusinessAlreadyPublish){
                    vctemp.detailType = IWAttractBusinessDetailType_Browse;
                }else if (_type == AlreadyPublishManagementAttractBusinessOffline){
                    vctemp.detailType = IWAttractBusinessDetailType_Offline;
                }
                vc1.postBoardType = kPostBoardAttractBusiness;
                AttractBusinessListInfo *obj = _data[indexPath.row];
                vctemp.detailsId = obj.listId;
                vc0 = vctemp;
            }
            break;
        }
        case AlreadyPublishManagementAttractBusinessOffline:
        {
            vc.navTitle = @"招商信息";
            IWAttractBusinessDetailViewController *vctemp =[[IWAttractBusinessDetailViewController alloc] initWithNibName:NSStringFromClass([IWAttractBusinessDetailViewController class]) bundle:nil];
            if(_type == AlreadyPublishManagementAttractBusinessAlreadyPublish){
                vctemp.detailType = IWAttractBusinessDetailType_Browse;
            }else if (_type == AlreadyPublishManagementAttractBusinessOffline){
                vctemp.detailType = IWAttractBusinessDetailType_Offline;
            }
            vc.isDraft = YES;
            vc1.postBoardType = kPostBoardAttractBusiness;
            AttractBusinessListInfo *obj = _data[indexPath.row];
            vctemp.detailsId = obj.listId;
            vc0 = vctemp;
        }
            break;
        case AlreadyPublishManagementAttractBusinessForceOffline:
        {
            vc.isForceOffline = YES;
            vc.isDraft = YES;
            vc.navTitle = @"招商信息";
            
            IWAttractBusinessDetailViewController *vctemp =[[IWAttractBusinessDetailViewController alloc] initWithNibName:NSStringFromClass([IWAttractBusinessDetailViewController class]) bundle:nil];
            vctemp.detailType = IWAttractBusinessDetailType_ForceOffline;
            AttractBusinessListInfo *obj = _data[indexPath.row];
            vctemp.detailsId = obj.listId;
            vc0 = vctemp;
            
            vc1.postBoardType = kPostBoardAttractBusiness;
            vc1.isDraft = YES;
            vc.forceOfflineId = obj.listId;
            vc.publishManagementType = AlreadyPublishManagementAttractBusinessForceOffline;
        }
            break;
        case AlreadyPublishManagementRecruitDraft:{
            RecruitmentListInfo *obj = _data[indexPath.row];
            IWPublishRecruitViewController *iwprvc = [[IWPublishRecruitViewController alloc] init];
            iwprvc.publishRecruitType = IWPublishRecruit_FromDraft;
            iwprvc.detailsId = obj.listId;
            
            [self.navigationController pushViewController:iwprvc animated:YES];
        }
            return;
        case AlreadyPublishManagementRecruitAlreadyPublish:
        {
            vc.navTitle = @"招聘信息";
            vc.isDraft = NO;
            RecruitmentListInfo *obj = _data[indexPath.row];
            IWRecruitDetailViewController *vctmp = [[IWRecruitDetailViewController alloc] initWithNibName:NSStringFromClass([IWRecruitDetailViewController class]) bundle:nil];
            if(_type == AlreadyPublishManagementRecruitOffline){
                vctmp.detailType = IWRecruitDetailType_Offline;
            }else if (_type == AlreadyPublishManagementRecruitAlreadyPublish){
                vctmp.detailType = IWRecruitDetailType_Browse;
            }
            
            vc1.postBoardType = kPostBoardRecruit;
            vctmp.detailsId = obj.listId;
            vc0 = vctmp;

        }
            break;
        case AlreadyPublishManagementRecruitOffline:
        {
            vc.navTitle = @"招聘信息";
            vc.isDraft = YES;
            RecruitmentListInfo *obj = _data[indexPath.row];
            IWRecruitDetailViewController *vctmp = [[IWRecruitDetailViewController alloc] initWithNibName:NSStringFromClass([IWRecruitDetailViewController class]) bundle:nil];
            if(_type == AlreadyPublishManagementRecruitOffline){
                vctmp.detailType = IWRecruitDetailType_Offline;
            }else if (_type == AlreadyPublishManagementRecruitAlreadyPublish){
                vctmp.detailType = IWRecruitDetailType_Browse;
            }
            
            vc1.postBoardType = kPostBoardRecruit;
            vctmp.detailsId = obj.listId;
            vc0 = vctmp;
            
        }
            break;
         case AlreadyPublishManagementRecruitForceOffline:
        {
            
            vc.isForceOffline = YES;
            vc.isDraft = YES;
            vc.navTitle = @"招聘信息";
            vc1.postBoardType = kPostBoardRecruit;
            vc1.isDraft = YES;
            RecruitmentListInfo *obj = _data[indexPath.row];
            IWRecruitDetailViewController *vctmp = [[IWRecruitDetailViewController alloc] initWithNibName:NSStringFromClass([IWRecruitDetailViewController class]) bundle:nil];
            vctmp.detailType = IWRecruitDetailType_ForceOffline;
            vctmp.detailsId = obj.listId;
            vc0 = vctmp;
            vc.forceOfflineId = obj.listId;
            vc.publishManagementType = AlreadyPublishManagementRecruitForceOffline;
        }
            break;
            
        case AlreadyPublishManagementSellerDiscountDraft:
        {
            IWSellerDiscountPublish *vc = [[IWSellerDiscountPublish alloc] initWithNibName:NSStringFromClass([IWSellerDiscountPublish class]) bundle:nil];
            DiscountListInfo *obj = _data[indexPath.row];
            vc.draftID = obj.listId;
            vc.isDraft = YES;
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        case AlreadyPublishManagementSellerDiscountAlreadyPublish:
        {
            vc.navTitle = @"优惠信息";
//             vc.isDraft = YES;
            SellerDiscountDetail *vctemp =[[SellerDiscountDetail alloc] initWithNibName:NSStringFromClass([SellerDiscountDetail class]) bundle:nil];
            AttractBusinessListInfo *obj = _data[indexPath.row];
            vctemp.discountId = obj.listId;
            vc1.postBoardType = kPostBoardDiscount;
            vc0 = vctemp;
            
        }break;
        case AlreadyPublishManagementSellerDiscountOffline:
        {
            vc.navTitle = @"优惠信息";
            vc.isDraft = YES;
            SellerDiscountDetail *vctemp =[[SellerDiscountDetail alloc] initWithNibName:NSStringFromClass([SellerDiscountDetail class]) bundle:nil];
            AttractBusinessListInfo *obj = _data[indexPath.row];
            vctemp.discountId = obj.listId;
            vctemp.isOffline = YES;
            vc1.postBoardType = kPostBoardDiscount;
            vc1.isDraft = YES;
            vc0 = vctemp;
           
        }
            break;
        case AlreadyPublishManagementSellerDiscountForceOffline:
        {
            vc.isForceOffline = YES;
            vc.navTitle = @"优惠信息";
            SellerDiscountDetail *vctemp =[[SellerDiscountDetail alloc] initWithNibName:NSStringFromClass([SellerDiscountDetail class]) bundle:nil];
            AttractBusinessListInfo *obj = _data[indexPath.row];
            vctemp.isForceOffLine = YES;
            vctemp.discountId = obj.listId;
            vc0 = vctemp;
            vc1.postBoardType = kPostBoardDiscount;
            vc1.isDraft = YES;
            vc.forceOfflineId = obj.listId;
            vc.publishManagementType = AlreadyPublishManagementSellerDiscountForceOffline;
        }
        
            break;
        default:
            break;
    }
    vc.viewControllers = @[vc0,vc1];
    vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            _deleteIndex = cell.tag;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认删除" message:@"一旦删除,则不可恢复" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alertView.tag = kAlreadyPublishDelete;
            [alertView show];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            
        }
        default:
            break;
    }
}

//删除内容
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //下架UIAlertView
    if (alertView.tag == kAlreadyPublishOffine) {
        if(buttonIndex == 0){ //取消
        }else if (buttonIndex == 1){ //确定
            switch (_type) {
                case AlreadyPublishManagementSellerDiscountAlreadyPublish:
                {
                    NSMutableArray *data = [self choseSelectedItem];
                    if ([data count] == 0) {
                        [HUDUtil showErrorWithStatus:@"请选择将要下架的商家优惠信息"];
                        return;
                    }
//                    [HUDUtil showWithStatus:@"下架中..."];
                    [[API_PostBoard getInstance] engine_outside_discountManage_offlineIds:data];
                }
                    break;
                    
                case AlreadyPublishManagementRecruitAlreadyPublish:
                {
                    NSMutableArray *data = [self choseSelectedItem];
                    if ([data count] == 0) {
                        [HUDUtil showErrorWithStatus:@"请选择将要下架的招聘信息"];
                        return;
                    }
//                    [HUDUtil showWithStatus:@"下架中..."];
                    [[API_PostBoard getInstance] engine_outside_recruitmentManage_offlineIds:data];
                }
                    break;
                    
                case AlreadyPublishManagementAttractBusinessAlreadyPublish:
                {
                    NSMutableArray *data = [self choseSelectedItem];
                    if ([data count] == 0) {
                        [HUDUtil showErrorWithStatus:@"请选择将要下架的招商信息"];
                        return;
                    }
//                    [HUDUtil showWithStatus:@"下架中..."];
                    [[API_PostBoard getInstance] engine_outside_attractBusinessManage_offlineId:data];
                }
                    break;
                    
                default:
                    break;
            }
        }
        //删除UIAlertView
    }else if (alertView.tag == kAlreadyPublishDelete){
        if(buttonIndex == 0){ //取消
        }else if (buttonIndex == 1){ //确定
            
            switch (_type) {
                case AlreadyPublishManagementSellerDiscountDraft:
                case AlreadyPublishManagementSellerDiscountAlreadyPublish:
                case AlreadyPublishManagementSellerDiscountOffline:
                case AlreadyPublishManagementSellerDiscountForceOffline:
                {
                    DiscountListInfo *obj = _data[_deleteIndex];
                    
                    
                    [[API_PostBoard getInstance] engine_outside_discountManage_deleteId:obj.listId];
                }
                    break;
                case AlreadyPublishManagementAttractBusinessDraft:
                case AlreadyPublishManagementAttractBusinessAlreadyPublish:
                case AlreadyPublishManagementAttractBusinessOffline:
                case AlreadyPublishManagementAttractBusinessForceOffline:
                {
                    AttractBusinessListInfo * obj = _data[_deleteIndex];
                    
                    
                    [[API_PostBoard getInstance] engine_outside_attractBusinessManage_deleteIds:obj.listId];
                }
                    break;
                case AlreadyPublishManagementRecruitDraft:
                case AlreadyPublishManagementRecruitAlreadyPublish:
                case AlreadyPublishManagementRecruitOffline:
                case AlreadyPublishManagementRecruitForceOffline:
                {
                    RecruitmentListInfo *obj = _data[_deleteIndex];
                    [[API_PostBoard getInstance] engine_outside_recruitmentManage_deleteId:obj.listId];
                }
                default:
                    break;
            }
            
            
        }
    }else if(alertView.tag == kAlreadyPublishRefreshTypeNomalLimit){
        if(buttonIndex == 0){ //取消
        }else if (buttonIndex == 1){ //确定
            //购买VIP页面
            PUSH_VIEWCONTROLLER(VIPPrivilegeViewController);
        }
    }
    else if(alertView.tag == kBuyVipAlertTag){
        if(buttonIndex == 1){
            //购买VIP页面
            VIPPrivilegeViewController *vipvc = [[VIPPrivilegeViewController alloc] init];
            [CRHttpAddedManager mz_pushViewController:vipvc];
        }
    }
}

#pragma mark -- 刷新前检查
-(BOOL)checkBeforeRefresh{
    BOOL flag = NO;
    
    
    
    return flag;
}

- (IBAction)buttonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 0: //刷新
        {
            switch (_type) {
                case AlreadyPublishManagementSellerDiscountAlreadyPublish:
                {
                    NSMutableArray *data = [self choseSelectedItem];
                    if ([data count] == 0) {
                        [HUDUtil showErrorWithStatus:@"请选择将要刷新的商家优惠信息"];
                        return;
                    }
//                    [HUDUtil showWithStatus:@"刷新中..."];
                    [_alreadyRefreshItems removeAllObjects];
                    [_alreadyRefreshItems addObjectsFromArray:data];
                    [[API_PostBoard getInstance] engine_outside_discountManage_refreshIds:data];
                }
                    break;
                    
                case AlreadyPublishManagementRecruitAlreadyPublish:
                {
                    NSMutableArray *data = [self choseSelectedItem];
                    if ([data count] == 0) {
                        [HUDUtil showErrorWithStatus:@"请选择将要刷新的招聘信息"];
                        return;
                    }
//                    [HUDUtil showWithStatus:@"刷新中..."];
                    
                    [_alreadyRefreshItems removeAllObjects];
                    [_alreadyRefreshItems addObjectsFromArray:data];
                    [[API_PostBoard getInstance] engine_outside_recruitmentManage_refreshId:data];
                }
                    break;
                    
                case AlreadyPublishManagementAttractBusinessAlreadyPublish:
                {
                    NSMutableArray *data = [self choseSelectedItem];
                    if ([data count] == 0) {
                        [HUDUtil showErrorWithStatus:@"请选择将要刷新的招商信息"];
                        return;
                    }
//                    [HUDUtil showWithStatus:@"刷新中..."];
                    
                    [_alreadyRefreshItems removeAllObjects];
                    [_alreadyRefreshItems addObjectsFromArray:data];
                    [[API_PostBoard getInstance] engine_outside_attractBusinessManage_refreshId:data];
                }
                    break;
                    
                    
                default:
                    break;
            }
            
            
        }
            break;
        case 1: //下架
        {
            switch (_type) {
                case AlreadyPublishManagementAttractBusinessAlreadyPublish:
                {
                    UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"下架信息" message:@"确定要下架选中的招商信息吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    view.tag = kAlreadyPublishOffine;
                    [view show];
                }
                    break;
                case AlreadyPublishManagementSellerDiscountAlreadyPublish:
                {
                    UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"下架信息" message:@"确定要下架选中的优惠信息吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    view.tag = kAlreadyPublishOffine;
                    [view show];
                }
                    break;
                case AlreadyPublishManagementRecruitAlreadyPublish:
                {
                    UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"下架信息" message:@"确定要下架选中的招聘信息吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    view.tag = kAlreadyPublishOffine;
                    [view show];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}




/**
 *  判断已选择的数据
 */
-(NSMutableArray *) choseSelectedItem
{
    NSMutableArray * ids = [[NSMutableArray alloc] init];
    switch (_type) {
        case AlreadyPublishManagementSellerDiscountAlreadyPublish:
        case AlreadyPublishManagementAttractBusinessAlreadyPublish:
        case AlreadyPublishManagementRecruitAlreadyPublish:
        {
            for (DiscountListInfo *obj in _data) {
                if (obj.listIsSelected) {
                    [ids addObject:obj.listId];
                }
            }
        }
            break;
            
        default:
            break;
    }
    return ids;
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
    [_alreadyRefreshItems release];
    [_verticalTableViewBottonVIew release];
    [_imageViewTip release];
    [_lableTip release];
    [_buttonRefresh release];
    [_buttonOffline release];
    [super dealloc];
}
@end