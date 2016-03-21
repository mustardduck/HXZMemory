//
//  IWManagementViewController.m
//  miaozhuan
//
//  Created by admin on 15/4/21.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWManagementViewController.h"
#import "IWPublishRecruitViewController.h"
#import "IWRecruitSupplementViewController.h"
#import "IWAlreadyPublishManagementViewController.h"
#import "IWCollectViewController.h"
#import "IWSellerDiscountPublish.h"
#import "IWSearchViewController.h"
#import "IWManagementTableViewCellForStyleValue1.h"
#import "IWManagementTableViewCellForStyleValue2.h"
#import "IWPublishAttractBusinessViewController.h"
#import "SharedData.h"
#import "VIPPrivilegeViewController.h"
#import "WebhtmlViewController.h"
#import "CRHtmlManager.h"

#define kRecruitmentIsInfoCompletedAlertTag 111
#define kBuyVipAlertTag 112

@interface IWManagementViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,RequestFailedDelegate>{
    NSMutableDictionary *managementInfos;
    UINib *nib_IWManagementTableViewCellForStyleValue1;
    UINib *nib_IWManagementTableViewCellForStyleValue2;
}


@property (strong, nonatomic) UITableView *tableView;

@end

@implementation IWManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.type == IWManagementType_ZhaoPin){
        managementInfos = [[NSMutableDictionary alloc]
                           initWithDictionary:@{
                                                @"title":@"招聘信息管理",
                                                @"items":@[
                                                        @[
                                                            @{@"title":@"发布招聘信息",@"action":@"gotoReleaseInfo_ZhaoPin",@"subTitle":@"今天还可以发布1条",@"IWManagementCellType":@(IWManagementCellType_Title_SubTitle_Vertical_DisclosureIndicator),@"IWManagementCellAligningType":@(IWManagementCellAligningType_OnlyOne),@"valueKey":@"todayRestCount"}
                                                            ],
                                                        @[
                                                            @{@"title":@"草稿箱",@"IWManagementCellType":@(IWManagementCellType_OnlyTitle_DisclosureIndicator),@"action":@"gotoManageRecruitDraft",@"IWManagementCellAligningType":@(IWManagementCellAligningType_OnlyOne)}
                                                            ],
                                                        @[
                                                            @{@"title":@"已发布的招聘信息",@"IWManagementCellType":@(IWManagementCellType_OnlyTitle_DisclosureIndicator),@"action":@"gotoManageAlreadyPublishRecruit",@"IWManagementCellAligningType":@(IWManagementCellAligningType_Top)},
                                                            @{@"title":@"下架的招聘信息",@"subTitle":@"11",@"IWManagementCellType":@(IWManagementCellType_Title_SubTitleHighlight_Horizontal_DisclosureIndicator),@"action":@"gotoManageAlreadyOfflineRecruit",@"IWManagementCellAligningType":@(IWManagementCellAligningType_Middle),@"valueKey":@"offlineCount"},
                                                            @{@"title":@"被强制下架的招聘信息",@"subTitle":@"22",@"IWManagementCellType":@(IWManagementCellType_Title_SubTitleHighlight_Horizontal_DisclosureIndicator),@"action":@"gotoManageAlreadyForceOfflineRecruit",@"IWManagementCellAligningType":@(IWManagementCellAligningType_Bottom),@"valueKey":@"forceOfflineCount"}
                                                            ],
                                                        @[
                                                            @{@"title":@"招聘信息补充",@"action":@"goto_ZhaoPin_Supplement",@"IWManagementCellAligningType":@(IWManagementCellType_OnlyTitle_DisclosureIndicator),@"IWManagementCellAligningType":@(IWManagementCellAligningType_OnlyOne)},
                                                            ],
                                                        ]
                                                }];
        
    }else if(self.type == IWManagementType_ZhaoShang){
        managementInfos = [[NSMutableDictionary alloc]
                           initWithDictionary:@{
                                                @"title":@"招商信息管理",
                                                @"items":@[
                                                        @[
                                                            @{@"title":@"发布招商信息",@"action":@"gotoReleaseInfo_ZhaoShang",@"subTitle":@"今天还可以发布1条",@"IWManagementCellType":@(IWManagementCellType_Title_SubTitle_Vertical_DisclosureIndicator),@"IWManagementCellAligningType":@(IWManagementCellAligningType_OnlyOne),@"valueKey":@"todayRestCount"}
                                                            ],
                                                        @[
                                                            @{@"title":@"草稿箱",@"action":@"gotoReleaseInfo_ZhaoShangDraft",@"IWManagementCellType":@(IWManagementCellType_OnlyTitle_DisclosureIndicator),@"IWManagementCellAligningType":@(IWManagementCellAligningType_OnlyOne)}
                                                            ],
                                                        @[
                                                            @{@"title":@"已发布的招商信息",@"action":@"gotoReleaseInfo_ZhaoShangPublish",@"IWManagementCellType":@(IWManagementCellType_OnlyTitle_DisclosureIndicator),@"IWManagementCellAligningType":@(IWManagementCellAligningType_Top)},
                                                            @{@"title":@"下架的招商信息",@"action":@"gotoReleaseInfo_ZhaoShangOffline",@"subTitle":@"99",@"IWManagementCellType":@(IWManagementCellType_Title_SubTitleHighlight_Horizontal_DisclosureIndicator),@"IWManagementCellAligningType":@(IWManagementCellAligningType_Middle),@"valueKey":@"offlineCount"},
                                                            @{@"title":@"被强制下架的招商信息",@"action":@"gotoReleaseInfo_ZhaoShangForceOffline",@"subTitle":@"8",@"IWManagementCellType":@(IWManagementCellType_Title_SubTitleHighlight_Horizontal_DisclosureIndicator),@"IWManagementCellAligningType":@(IWManagementCellAligningType_Bottom),@"valueKey":@"forceOfflineCount"}
                                                            ],
                                                        ]
                                                }];
    }else if (self.type == IWManagementType_ShangJiaYouHui){
        managementInfos = [[NSMutableDictionary alloc]
                           initWithDictionary:@{
                                                @"title":@"商家优惠管理",
                                                @"items":@[
                                                        @[
                                                            @{@"title":@"发布优惠信息",@"action":@"gotoReleaseInfo_ShangJiaYouHui",@"subTitle":@"今天还可以发布1条",@"IWManagementCellType":@(IWManagementCellType_Title_SubTitle_Vertical_DisclosureIndicator),@"IWManagementCellAligningType":@(IWManagementCellAligningType_OnlyOne),@"valueKey":@"todayRestCount"}
                                                            ],
                                                        @[
                                                            @{@"title":@"草稿箱",@"action":@"gotoReleaseInfo_ShangJiaDraft",@"IWManagementCellType":@(IWManagementCellType_OnlyTitle_DisclosureIndicator),@"IWManagementCellAligningType":@(IWManagementCellAligningType_OnlyOne)}
                                                            ],
                                                        @[
                                                            @{@"title":@"已发布的优惠信息",@"action":@"gotoReleaseInfo_ShangJiaAlreadyPusblich",@"IWManagementCellType":@(IWManagementCellType_OnlyTitle_DisclosureIndicator),@"IWManagementCellAligningType":@(IWManagementCellAligningType_Top)},
                                                            @{@"title":@"下架的优惠信息",@"action":@"gotoReleaseInfo_ShangJiaOffline",@"detailValue":@"89",@"IWManagementCellType":@(IWManagementCellType_Title_SubTitleHighlight_Horizontal_DisclosureIndicator),@"IWManagementCellAligningType":@(IWManagementCellAligningType_Middle),@"valueKey":@"offlineCount"},
                                                            @{@"title":@"被强制下架的优惠信息",@"action":@"gotoReleaseInfo_ShangJiaForceOffline",@"detailValue":@"90",@"IWManagementCellType":@(IWManagementCellType_Title_SubTitleHighlight_Horizontal_DisclosureIndicator),@"IWManagementCellAligningType":@(IWManagementCellAligningType_Bottom),@"valueKey":@"forceOfflineCount"}
                                                            ],
                                                        ]
                                                }];
    }
    
    self.view.backgroundColor = RGBACOLOR(239, 239, 244, 1);
    
    InitNav(managementInfos[@"title"]);
    
    [self setupMoveFowardButtonWithTitle:@"说明"];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView setDelegate:self];
    //    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    
    self.tableView.delaysContentTouches = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UpdateFailureAction object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self loadData];
}

#pragma mark -- custom events
-(void)loadData{
    if(_type == IWManagementType_ZhaoPin){//招聘数据
        [[API_PostBoard getInstance] engine_outside_recruitmentManage_index];
    }else if(_type == IWManagementType_ZhaoShang){//招商数据
        [[API_PostBoard getInstance] engine_outside_attractBusinessManage_index];
    }else if (_type == IWManagementType_ShangJiaYouHui){//优惠数据
        [[API_PostBoard getInstance] engine_outside_discountManage_index];
    }
}
#pragma mark -- 数据请求成功回调
-(void)handleUpdateSuccessAction:(NSNotification *)noti{
    NSDictionary *dict = [noti userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    
    if(ret == 1){
        if(type == ut_recruitmentManage_index || type == ut_discountManage_index || type == ut_attractBusinessManage_index){
            [_tableView reloadData];
        }
    }else{
        if(type == ut_recruitmentManage_index || type == ut_discountManage_index || type == ut_attractBusinessManage_index){
            [HUDUtil showErrorWithStatus:dict[@"msg"]];
        }
    }
}

#pragma mark -- 数据请求失败回调
-(void)handleUpdateFailureAction:(NSNotification *)noti{
    [HUDUtil showErrorWithStatus:@"数据加载失败"];
}

#pragma mark -- 说明
- (void)onMoveFoward:(UIButton*) sender{
//    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    WebhtmlViewController *vc = [[WebhtmlViewController alloc] initWithNibName:NSStringFromClass([WebhtmlViewController class]) bundle:nil];
    
    switch (_type) {
        case IWManagementType_ShangJiaYouHui:
            vc.navTitle = @"商家优惠信息说明";
            vc.ContentCode = CRHtmlManager_Code_SellerDiscount;
            break;
        case IWManagementType_ZhaoPin:
            vc.navTitle = @"招聘信息说明";
            vc.ContentCode = CRHtmlManager_Code_RecruitSupplement;
            break;
        case IWManagementType_ZhaoShang:
            vc.navTitle = @"招商信息说明";
            vc.ContentCode = CRHtmlManager_Code_AttractBusiness;
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 发布信息前检查
-(BOOL)checkBeforePublish{
    BOOL flag = NO;
    
    if(_type == IWManagementType_ZhaoPin){
        if(![[SharedData getInstance] recruitmentManageInfo].recruitmentIsInfoCompleted){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"补充信息" message:@"请先完成基本信息的补充" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = kRecruitmentIsInfoCompletedAlertTag;
            [alert show];
            
            return flag;
        }
    }
    
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
    
    
    return flag;
}

#pragma mark -- 下架个数
-(NSUInteger)offlineCountWithType:(IWManagementType)type{
    switch (type) {
        case IWManagementType_ZhaoPin:
            return [[SharedData getInstance] recruitmentManageInfo].recruitmentOfflineCount;
        case IWManagementType_ZhaoShang:
            return [[SharedData getInstance] attractBusinessManageInfo].businessOfflineCount;
            break;
        case IWManagementType_ShangJiaYouHui:
            return [[SharedData getInstance] discountManageInfo].discountOfflineCount;
        default:
            return 0;
    }
    
}

#pragma mark -- 强制下架个数
-(NSUInteger)ForceOfflineCountWithType:(IWManagementType)type{
    switch (_type) {
        case IWManagementType_ZhaoPin:
            return [[SharedData getInstance] recruitmentManageInfo].recruitmentForceOfflineCount;
        case IWManagementType_ZhaoShang:
            return [[SharedData getInstance] attractBusinessManageInfo].businessForceOfflineCount;
            break;
        case IWManagementType_ShangJiaYouHui:
            return [[SharedData getInstance] discountManageInfo].discountForceOfflineCount;
        default:
            return 0;
    }
}


#pragma mark -- 今日剩余发布条数
-(NSUInteger)todayRestCountWithType:(IWManagementType)type{
    switch (type) {
        case IWManagementType_ZhaoPin:
            return [[SharedData getInstance] recruitmentManageInfo].recruitmentTodayRestCount;
        case IWManagementType_ZhaoShang:
            return [[SharedData getInstance] attractBusinessManageInfo].businessTodayRestCount;
            break;
        case IWManagementType_ShangJiaYouHui:
            return [[SharedData getInstance] discountManageInfo].discountTodayRestCount;
        default:
            return 0;
    }
}

#pragma mark -- VIP商家最多发布条数
-(NSUInteger)vipPublishCountWithType:(IWManagementType)type{
    switch (type) {
        case IWManagementType_ZhaoPin:
            return [[SharedData getInstance] recruitmentManageInfo].recruitmentVipPublishCount;
        case IWManagementType_ZhaoShang:
            return [[SharedData getInstance] attractBusinessManageInfo].businessVipPublishCount;
            break;
        case IWManagementType_ShangJiaYouHui:
            return [[SharedData getInstance] discountManageInfo].discountVipPublishCount;
        default:
            return 0;
    }
}

#pragma mark -- 普通商家最多发布条数
-(NSUInteger)normalPublishCountWithType:(IWManagementType)type{
    switch (type) {
        case IWManagementType_ZhaoPin:
            return [[SharedData getInstance] recruitmentManageInfo].recruitmentNormalPublishCount;
        case IWManagementType_ZhaoShang:
            return [[SharedData getInstance] attractBusinessManageInfo].businessNormalPublishCount;
            break;
        case IWManagementType_ShangJiaYouHui:
            return [[SharedData getInstance] discountManageInfo].discountNormalPublishCount;
        default:
            return 0;
    }
}

#pragma mark -- 发布招聘信息
-(void)gotoReleaseInfo_ZhaoPin{
    if([self checkBeforePublish]){
        IWPublishRecruitViewController *rizpvc = [[IWPublishRecruitViewController alloc] init];
        [UI_MANAGER.mainNavigationController pushViewController:rizpvc animated:YES];
    }
}

#pragma mark -- 招聘信息补充
-(void)goto_ZhaoPin_Supplement{
    IWRecruitSupplementViewController *zp_svc = [[IWRecruitSupplementViewController alloc] init];
    [UI_MANAGER.mainNavigationController pushViewController:zp_svc animated:YES];
}

#pragma mark -- 已发布的招聘信息
-(void)gotoManageAlreadyPublishRecruit{
    IWAlreadyPublishManagementViewController *iwapmvc = [[IWAlreadyPublishManagementViewController alloc] init];
    iwapmvc.type = AlreadyPublishManagementRecruitAlreadyPublish;
    [self.navigationController pushViewController:iwapmvc animated:YES];
}

#pragma mark -- 招聘草稿箱
-(void)gotoManageRecruitDraft{
    IWAlreadyPublishManagementViewController *iwapmvc = [[IWAlreadyPublishManagementViewController alloc] init];
    iwapmvc.type = AlreadyPublishManagementRecruitDraft;
    [self.navigationController pushViewController:iwapmvc animated:YES];
}

#pragma mark -- 已下架的招聘信息
-(void)gotoManageAlreadyOfflineRecruit{
    IWAlreadyPublishManagementViewController *iwapmvc = [[IWAlreadyPublishManagementViewController alloc] init];
    iwapmvc.type = AlreadyPublishManagementRecruitOffline;
    [self.navigationController pushViewController:iwapmvc animated:YES];
}

#pragma mark -- 被强制下架的招聘信息
-(void)gotoManageAlreadyForceOfflineRecruit{
    IWAlreadyPublishManagementViewController *iwapmvc = [[IWAlreadyPublishManagementViewController alloc] init];
    iwapmvc.type = AlreadyPublishManagementRecruitForceOffline;
    [self.navigationController pushViewController:iwapmvc animated:YES];
}

#pragma mark -- 发布招商信息
-(void)gotoReleaseInfo_ZhaoShang{
    if([self checkBeforePublish]){
        IWPublishAttractBusinessViewController *iwpabvc = [[IWPublishAttractBusinessViewController alloc] init];
        [self.navigationController pushViewController:iwpabvc animated:YES];
    }
}

#pragma mark -- 招商草稿箱
-(void)gotoReleaseInfo_ZhaoShangDraft{
    
    IWAlreadyPublishManagementViewController *iwapmvc = [[IWAlreadyPublishManagementViewController alloc] init];
    iwapmvc.type = AlreadyPublishManagementAttractBusinessDraft;
    [self.navigationController pushViewController:iwapmvc animated:YES];
}
#pragma mark -- 招商已发布
-(void)gotoReleaseInfo_ZhaoShangPublish{
    IWAlreadyPublishManagementViewController *iwapmvc = [[IWAlreadyPublishManagementViewController alloc] init];
    iwapmvc.type = AlreadyPublishManagementAttractBusinessAlreadyPublish;
    [self.navigationController pushViewController:iwapmvc animated:YES];
}
#pragma mark -- 招商已下架
-(void) gotoReleaseInfo_ZhaoShangOffline{
    IWAlreadyPublishManagementViewController *iwapmvc = [[IWAlreadyPublishManagementViewController alloc] init];
    iwapmvc.type = AlreadyPublishManagementAttractBusinessOffline;
    [self.navigationController pushViewController:iwapmvc animated:YES];
}
#pragma mark -- 招商被强制下架
-(void) gotoReleaseInfo_ZhaoShangForceOffline{
    IWAlreadyPublishManagementViewController *iwapmvc = [[IWAlreadyPublishManagementViewController alloc] init];
    iwapmvc.type = AlreadyPublishManagementAttractBusinessForceOffline;
    [self.navigationController pushViewController:iwapmvc animated:YES];
}

/**
 *  发布商家优惠
 */
-(void)gotoReleaseInfo_ShangJiaYouHui
{
    if([self checkBeforePublish]){
        IWSellerDiscountPublish *tivc = [[IWSellerDiscountPublish alloc] initWithNibName:@"IWSellerDiscountPublish" bundle:nil];
        [self.navigationController pushViewController:tivc animated:YES];
    }
}
/**
 *  商家草稿
 */
-(void) gotoReleaseInfo_ShangJiaDraft
{
    IWAlreadyPublishManagementViewController *tivc = [[IWAlreadyPublishManagementViewController alloc] initWithNibName:NSStringFromClass([IWAlreadyPublishManagementViewController class]) bundle:nil];
    tivc.type = AlreadyPublishManagementSellerDiscountDraft;
    [self.navigationController pushViewController:tivc animated:YES];
}
/**
 *  商家已发布
 */
-(void) gotoReleaseInfo_ShangJiaAlreadyPusblich
{
    IWAlreadyPublishManagementViewController *tivc = [[IWAlreadyPublishManagementViewController alloc] initWithNibName:NSStringFromClass([IWAlreadyPublishManagementViewController class]) bundle:nil];
    tivc.type = AlreadyPublishManagementSellerDiscountAlreadyPublish;
    [self.navigationController pushViewController:tivc animated:YES];
}
/**
 *  商家优惠下架
 */
-(void) gotoReleaseInfo_ShangJiaOffline
{
    IWAlreadyPublishManagementViewController *tivc = [[IWAlreadyPublishManagementViewController alloc] initWithNibName:NSStringFromClass([IWAlreadyPublishManagementViewController class]) bundle:nil];
    tivc.type = AlreadyPublishManagementSellerDiscountOffline;
    [self.navigationController pushViewController:tivc animated:YES];
    //    IWSearchViewController *vc = [[IWSearchViewController alloc] initWithNibName:NSStringFromClass([IWSearchViewController class]) bundle:nil];
    //    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  商家优惠强制下架
 */
-(void) gotoReleaseInfo_ShangJiaForceOffline
{
    IWAlreadyPublishManagementViewController *tivc = [[IWAlreadyPublishManagementViewController alloc] initWithNibName:NSStringFromClass([IWAlreadyPublishManagementViewController class]) bundle:nil];
    tivc.type = AlreadyPublishManagementSellerDiscountForceOffline;
    [self.navigationController pushViewController:tivc animated:YES];
    
    //    IWCollectViewController *vc = [[IWCollectViewController alloc] initWithNibName:NSStringFromClass([IWCollectViewController class]) bundle:nil];
    //    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return [managementInfos[@"items"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return [managementInfos[@"items"][section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0)return kIWManagementTableViewCellForStyleValue1Height;
    
    return kIWManagementTableViewCellForStyleValue2Height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = managementInfos[@"items"][indexPath.section][indexPath.row][@"title"];
    NSString *valueKey = managementInfos[@"items"][indexPath.section][indexPath.row][@"valueKey"];
    NSString *subTitle = @"";
    if([valueKey isEqualToString:@"todayRestCount"]){
        subTitle = [NSString stringWithFormat:@"还可以发布%d条",[self todayRestCountWithType:_type]];
    }else if ([valueKey isEqualToString:@"offlineCount"]){
        subTitle = [NSString stringWithFormat:@"%d",[self offlineCountWithType:_type]];
    }else if ([valueKey isEqualToString:@"forceOfflineCount"]){
        subTitle = [NSString stringWithFormat:@"%d",[self ForceOfflineCountWithType:_type]];
    }
    IWManagementCellType type = [managementInfos[@"items"][indexPath.section][indexPath.row][@"IWManagementCellType"] integerValue];
    IWManagementCellAligningType aligningType = [managementInfos[@"items"][indexPath.section][indexPath.row][@"IWManagementCellAligningType"] integerValue];
    
    if(type == IWManagementCellType_Title_SubTitle_Vertical_DisclosureIndicator){
        static NSString *identy = @"IWManagementTableViewCellForStyleValue1_reuseIdentifier";
        if (!nib_IWManagementTableViewCellForStyleValue1) {
            nib_IWManagementTableViewCellForStyleValue1 = [UINib nibWithNibName:@"IWManagementTableViewCellForStyleValue1" bundle:nil];
            [tableView registerNib:nib_IWManagementTableViewCellForStyleValue1 forCellReuseIdentifier:identy];
        }
        IWManagementTableViewCellForStyleValue1 *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        cell.label_Title.text = title;
        cell.label_SubTitle.text = subTitle;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
    }else if (type == IWManagementCellType_OnlyTitle_DisclosureIndicator || type == IWManagementCellType_Title_SubTitleHighlight_Horizontal_DisclosureIndicator){
        
        static NSString *identy = @"IWManagementTableViewCellForStyleValue2_reuseIdentifier";
        if (!nib_IWManagementTableViewCellForStyleValue2) {
            nib_IWManagementTableViewCellForStyleValue2 = [UINib nibWithNibName:@"IWManagementTableViewCellForStyleValue2" bundle:nil];
            [tableView registerNib:nib_IWManagementTableViewCellForStyleValue2 forCellReuseIdentifier:identy];
        }
        IWManagementTableViewCellForStyleValue2 *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = title;
        cell.textLabel.textColor = RGBACOLOR(34, 34, 34, 1);
        cell.textLabel.font = [UIFont systemFontOfSize:16.f];
        if(subTitle.integerValue == 0){
            cell.label_SubTitle.hidden = YES;
        }else{
            if(subTitle.integerValue > 99){
                subTitle = @"···";
            }
            cell.label_SubTitle.hidden = NO;
        }
        cell.label_SubTitle.text = subTitle;
        
        [cell updateCellAligningType:aligningType];
        
        return cell;
    }
    
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//   
//    IWBrowseADViewController *iwbadvc = [[IWBrowseADViewController alloc] init];
//    [self.navigationController pushViewController:iwbadvc animated:YES];
//    
//    return;
    //获取绑定事件
    SEL selector = NSSelectorFromString(managementInfos[@"items"][indexPath.section][indexPath.row][@"action"]);
    //事件判断存在及触发
    if([self respondsToSelector:selector]){
        [self performSelector:selector withObject:nil];
    }
}

#pragma mark uialertview delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == kRecruitmentIsInfoCompletedAlertTag){
        if(buttonIndex == 1){
            //完善招聘信息
            [self goto_ZhaoPin_Supplement];
        }
    }else if(alertView.tag == kBuyVipAlertTag){
        if(buttonIndex == 1){
            //购买VIP页面
            VIPPrivilegeViewController *vipvc = [[VIPPrivilegeViewController alloc] init];
            [CRHttpAddedManager mz_pushViewController:vipvc];
        }
    }
}

@end
