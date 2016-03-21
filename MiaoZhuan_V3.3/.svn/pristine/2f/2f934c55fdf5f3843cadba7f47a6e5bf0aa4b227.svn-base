//
//  IWMainDetail.m
//  miaozhuan
//
//  Created by luocena on 4/28/15.
//  Copyright (c) 2015 zdit. All rights reserved.
//

#import "IWMainDetail.h"
#import "KxMenu.h"
#import "SCNavTabBarController.h"
#import "IWComplaintViewController.h"
#import "IWAttractBusinessDetailViewController.h"
#import "IWRecruitDetailViewController.h"
#import "IWCompanyIntroViewController.h"
#import "SellerDiscountDetail.h"
#import "Share_Method.h"
#import "RequestFailed.h"


@interface IWMainDetail ()<KxMenuDelegate,RequestFailedDelegate>
{
    RequestFailed *_requestFailed;
}

@property (nonatomic,strong) SCNavTabBarController *navTabBarController;

@end

@implementation IWMainDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    InitNav(self.navTitle);
    [self setupMoveBackButton];
    
    if (self.isDraft ) {
    }else if (self.isForceOffline){
    }else{
        [self setupMoveFowardButtonWithImage:@"more" In:@"morehover"];
    }
    
    
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
    

     self.navTabBarController = [[SCNavTabBarController alloc] init];
    self.navTabBarController .publishManagementType = _publishManagementType;
    self.navTabBarController .forceOfflineId = _forceOfflineId;
    self.navTabBarController .subViewControllers = self.viewControllers;
    self.navTabBarController .navTabBarColor = [UIColor whiteColor];
    self.navTabBarController .titles = self.viewControllersTitle;
    [self.navTabBarController  addParentController:self];

}
- (void)handleUpdateSuccessAction:(NSNotification *)note
{
    [_requestFailed.view removeFromSuperview];
    NSDictionary *dict = [note userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    if (type == ut_postBoard_addCollection) {
        if (ret == 1) {
            [HUDUtil showSuccessWithStatus:@"已收藏"];
        }else{
            if([dict[@"code"] intValue] == 60005){
                [HUDUtil showErrorWithStatus:@"该信息已经收藏过了"];

            }else{
                [HUDUtil showErrorWithStatus:dict[@"msg"]];

            }
        }
    }else if (type == ut_postBoard_reportInfo){
        if (ret == 1) {
            [HUDUtil showSuccessWithStatus:@"举报成功"];
        }else{
            [HUDUtil showErrorWithStatus:dict[@"msg"]];
        }
    }else{
    
    }
}

- (void)handleUpdateFailureAction:(NSNotification *)note
{
   
    NSDictionary *dict = [note userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    if (type == ut_postBoard_addCollection) {
        [HUDUtil showErrorWithStatus:@"收藏失败"];
    }else if (type == ut_postBoard_reportInfo){
        [HUDUtil showErrorWithStatus:@"举报失败"];
    }else if (type ==  ut_postBoard_DiscountDetails || type == ut_discountManage_details || type == ut_postBoard_attractBusinessDetails || type == ut_postBoard_recruitmentDetails){
        _requestFailed= [RequestFailed getInstance];
        _requestFailed.delegate = self;
        [_requestFailed.view addSubview:_requestFailed.viewNoNet];
        [self.view addSubview:_requestFailed.view];
        [self.view bringSubviewToFront:_requestFailed.viewNoNet];
    }
}

/**
 *  网络加载失败刷新
 */
-(void)didClickedRefresh{
    
    if ([self.viewControllers[0] isKindOfClass:[SellerDiscountDetail class]]) {
        SellerDiscountDetail *vc = self.viewControllers[0];
        [vc loadData];
    }
    //招商详情
    else if([self.viewControllers[0] isKindOfClass:[IWAttractBusinessDetailViewController class]]){
        IWRecruitDetailViewController *vc = self.viewControllers[0];
        [vc loadData];
    }//招聘详情
    else if ([self.viewControllers[0] isKindOfClass:[IWRecruitDetailViewController class]]){
        IWAttractBusinessDetailViewController *vc = self.viewControllers[0];
        [vc loadData];
    }
    IWCompanyIntroViewController *iwCompanyIntroViewController = self.viewControllers[1];
    [iwCompanyIntroViewController loadData];
   
}


-(void) onMoveBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)onMoveFoward:(UIButton *)sender
{
    if(![KxMenu isOpen])
    {
        NSArray *menuItems = nil;
        
        if ([self.viewControllers[0] isKindOfClass:[SellerDiscountDetail class]]) {
            PostBoardDiscount *obj = [SharedData getInstance].postBoardDiscountDetail;
            
            if([obj.enterpriseInfo.enterpriseId integerValue]  == [[SharedData getInstance].personalInfo.userEnterpriseId integerValue])
            {
                  menuItems = @[
                                [KxMenuItem menuItem:@"分享"
                                               image:[UIImage imageNamed:@"iwshare0"]
                                           highlight:[UIImage imageNamed:@"iwshare1"]
                                              target:self
                                              action:@selector(pushMenuItem:)]
                                ];
                
            }else{
                menuItems = @[
                              
                              [KxMenuItem menuItem:@"收藏"
                                             image:[UIImage imageNamed:@"iwcollection0"]
                                         highlight:[UIImage imageNamed:@"iwcollection1"]
                                            target:self
                                            action:@selector(pushMenuItem:)],
                              
                              [KxMenuItem menuItem:@"分享"
                                             image:[UIImage imageNamed:@"iwshare0"]
                                         highlight:[UIImage imageNamed:@"iwshare1"]
                                            target:self
                                            action:@selector(pushMenuItem:)],
                              
                              [KxMenuItem menuItem:@"举报"
                                             image:[UIImage imageNamed:@"iwreport0"]
                                         highlight:[UIImage imageNamed:@"iwreport1"]
                                            target:self
                                            action:@selector(pushMenuItem:)]
                              ];

            }
            
            //招聘详情
        }else if ([self.viewControllers[0] isKindOfClass:[IWRecruitDetailViewController class]]){
            PostBoardRecruitment *obj = [SharedData getInstance].postBoardRecruitmentDetail;
            if([obj.enterpriseInfo.enterpriseId integerValue]  == [[SharedData getInstance].personalInfo.userEnterpriseId integerValue])
            {
                menuItems = @[
                              [KxMenuItem menuItem:@"分享"
                                             image:[UIImage imageNamed:@"iwshare0"]
                                         highlight:[UIImage imageNamed:@"iwshare1"]
                                            target:self
                                            action:@selector(pushMenuItem:)]
                              ];
                
            }else{
                menuItems = @[
                              
                              [KxMenuItem menuItem:@"收藏"
                                             image:[UIImage imageNamed:@"iwcollection0"]
                                         highlight:[UIImage imageNamed:@"iwcollection1"]
                                            target:self
                                            action:@selector(pushMenuItem:)],
                              
                              [KxMenuItem menuItem:@"分享"
                                             image:[UIImage imageNamed:@"iwshare0"]
                                         highlight:[UIImage imageNamed:@"iwshare1"]
                                            target:self
                                            action:@selector(pushMenuItem:)],
                              
                              [KxMenuItem menuItem:@"举报"
                                             image:[UIImage imageNamed:@"iwreport0"]
                                         highlight:[UIImage imageNamed:@"iwreport1"]
                                            target:self
                                            action:@selector(pushMenuItem:)]
                              ];
            }

            //招商详情
        }else if([self.viewControllers[0] isKindOfClass:[IWAttractBusinessDetailViewController class]]){
            PostBoardAttractBusiness *obj = [SharedData getInstance].postBoardAttractBusinessDetail;
            if([obj.enterpriseInfo.enterpriseId integerValue]  == [[SharedData getInstance].personalInfo.userEnterpriseId integerValue])
            {
                menuItems = @[
                              [KxMenuItem menuItem:@"分享"
                                             image:[UIImage imageNamed:@"iwshare0"]
                                         highlight:[UIImage imageNamed:@"iwshare1"]
                                            target:self
                                            action:@selector(pushMenuItem:)]
                              ];
                
            }else{
                menuItems = @[
                              
                              [KxMenuItem menuItem:@"收藏"
                                             image:[UIImage imageNamed:@"iwcollection0"]
                                         highlight:[UIImage imageNamed:@"iwcollection1"]
                                            target:self
                                            action:@selector(pushMenuItem:)],
                              
                              [KxMenuItem menuItem:@"分享"
                                             image:[UIImage imageNamed:@"iwshare0"]
                                         highlight:[UIImage imageNamed:@"iwshare1"]
                                            target:self
                                            action:@selector(pushMenuItem:)],
                              
                              [KxMenuItem menuItem:@"举报"
                                             image:[UIImage imageNamed:@"iwreport0"]
                                         highlight:[UIImage imageNamed:@"iwreport1"]
                                            target:self
                                            action:@selector(pushMenuItem:)]
                              ];
            }
        }else{
        }

        CGRect rect = sender.frame;
        rect.origin.y = self.navigationController.navigationBar.frame.size.height;
        [KxMenu showMenuInView:self.navigationController.view
                      fromRect:CGRectMake(self.view.frame.size.width - 80, 8, 70, 40)     //rect
                     menuItems:menuItems
                     itemWidth:100.f];
        [KxMenu sharedMenu].delegate = self;
        
    }
    else
    {
        [KxMenu dismissMenu];
    }
}

-(void)pushMenuItem:(id)sender
{
    
}
- (void)which_tag_clicked:(int)tag{

    if([_requestFailed.view.superview isEqual:self.view]){
        [HUDUtil showErrorWithStatus:@"网络不给力，请检查后重试"];
        return;
    }
    if(tag == 2){ //举报
        IWComplaintViewController *iwcvc = [[IWComplaintViewController alloc] init];
        iwcvc.complaint = ^(NSString * code,NSString *reason){
            
            //优惠详情
            if ([self.viewControllers[0] isKindOfClass:[SellerDiscountDetail class]]) {
                PostBoardDiscount *obj = [SharedData getInstance].postBoardDiscountDetail;
                NSString * shareId = obj.discountInfo.discountId;
                if (shareId.length == 0) {
                    [HUDUtil showErrorWithStatus:@"举报的ID为空"]; return;
                }
                [[API_PostBoard getInstance] engine_outside_postBoard_reportId:shareId type:kPostBoardDiscount reasonCode:code reason:reason];
                //招聘详情
            }else if ([self.viewControllers[0] isKindOfClass:[IWRecruitDetailViewController class]]){
                PostBoardRecruitment *obj = [SharedData getInstance].postBoardRecruitmentDetail;
                NSString * shareId = obj.recruitmentInfo.recruitmentId;
                if (shareId.length == 0) {
                    [HUDUtil showErrorWithStatus:@"举报的ID为空"]; return;
                }
                [[API_PostBoard getInstance] engine_outside_postBoard_reportId:shareId type:kPostBoardRecruit reasonCode:code reason:reason];
                //招商详情
            }else if([self.viewControllers[0] isKindOfClass:[IWAttractBusinessDetailViewController class]]){
                PostBoardAttractBusiness*obj = [SharedData getInstance].postBoardAttractBusinessDetail;
                NSString * shareId = obj.attractBusinessInfo.attractBusinessId;
                if (shareId.length == 0) {
                   [HUDUtil showErrorWithStatus:@"举报的ID为空"]; return;
                }
                [[API_PostBoard getInstance] engine_outside_postBoard_reportId:shareId type:kPostBoardDiscount reasonCode:code reason:reason];
            }else{
            }
        };
        [self.navigationController pushViewController:iwcvc animated:YES];
    }else if (tag == 1){ //分享
        

        //优惠详情
        if ([self.viewControllers[0] isKindOfClass:[SellerDiscountDetail class]]) {
            PostBoardDiscount *obj = [SharedData getInstance].postBoardDiscountDetail;
             NSString * shareId = obj.discountInfo.discountId;
            if (shareId.length == 0) {
                NSLog(@"分享id为空"); return;
            }
            [[Share_Method shareInstance] getShareDataWithShareData:@{@"postboard_id":shareId, @"Key":@"bf72a0384cdc42b4a1c14dd0011d9ff2"}];
        //招聘详情
        }else if ([self.viewControllers[0] isKindOfClass:[IWRecruitDetailViewController class]]){
            PostBoardRecruitment *obj = [SharedData getInstance].postBoardRecruitmentDetail;
            NSString * shareId = obj.recruitmentInfo.recruitmentId;
            if (shareId.length == 0) {
                NSLog(@"分享id为空"); return;
            }
            [[Share_Method shareInstance] getShareDataWithShareData:@{@"postboard_id":shareId, @"Key":@"f82ad072c94c418d8ef447cfaeb0d02e"}];
        //招商详情
        }else if([self.viewControllers[0] isKindOfClass:[IWAttractBusinessDetailViewController class]]){
            PostBoardAttractBusiness *obj = [SharedData getInstance].postBoardAttractBusinessDetail;
            NSString * shareId = obj.attractBusinessInfo.attractBusinessId;
            if (shareId.length == 0) {
                NSLog(@"分享id为空"); return;
            }
            [[Share_Method shareInstance] getShareDataWithShareData:@{@"postboard_id":shareId, @"Key":@"562434ee823343ea985b85ef7b4aa34f"}];

        }else{
        }
        
    }else if (tag == 0){ //收藏
        //优惠详情
        NSString * discountId = nil;
        PostBoardType postbordType;
        if ([self.viewControllers[0] isKindOfClass:[SellerDiscountDetail class]]) {
            
            PostBoardDiscount *obj = [SharedData getInstance].postBoardDiscountDetail;
            
            //分享
            if([obj.enterpriseInfo.enterpriseId integerValue]  == [[SharedData getInstance].personalInfo.userEnterpriseId integerValue])
            {
                NSString * shareId = obj.discountInfo.discountId;
                if (shareId.length == 0) {
                    NSLog(@"分享id为空"); return;
                }
                [[Share_Method shareInstance] getShareDataWithShareData:@{@"postboard_id":shareId, @"Key":@"bf72a0384cdc42b4a1c14dd0011d9ff2"}];
            }else{ //收藏
            
                discountId = obj.discountInfo.discountId;
                postbordType = kPostBoardDiscount;
//                [HUDUtil showWithMaskType:HUDMaskTypeBlack];
                [[API_PostBoard getInstance] engine_outside_postBoard_addCollectionId:discountId type:postbordType];
            }
            //招聘详情
        }else if ([self.viewControllers[0] isKindOfClass:[IWRecruitDetailViewController class]]){
            
            PostBoardRecruitment *obj = [SharedData getInstance].postBoardRecruitmentDetail;
            
            if([obj.enterpriseInfo.enterpriseId integerValue]  == [[SharedData getInstance].personalInfo.userEnterpriseId integerValue])
            {
                NSString * shareId = obj.recruitmentInfo.recruitmentId;
                if (shareId.length == 0) {
                    NSLog(@"分享id为空"); return;
                }

                [[Share_Method shareInstance] getShareDataWithShareData:@{@"postboard_id":shareId, @"Key":@"f82ad072c94c418d8ef447cfaeb0d02e"}];
            
            }else{
                discountId = obj.recruitmentInfo.recruitmentId;
                postbordType = kPostBoardRecruit;
//                [HUDUtil showWithMaskType:HUDMaskTypeBlack];
                [[API_PostBoard getInstance] engine_outside_postBoard_addCollectionId:discountId type:postbordType];
            }
            
            //招商详情
        }else if([self.viewControllers[0] isKindOfClass:[IWAttractBusinessDetailViewController class]]){
            PostBoardAttractBusiness *obj = [SharedData getInstance].postBoardAttractBusinessDetail;
            
            if([obj.enterpriseInfo.enterpriseId integerValue]  == [[SharedData getInstance].personalInfo.userEnterpriseId integerValue])
            {
                NSString * shareId = obj.attractBusinessInfo.attractBusinessId;
                if (shareId.length == 0) {
                    NSLog(@"分享id为空"); return;
                }
                [[Share_Method shareInstance] getShareDataWithShareData:@{@"postboard_id":shareId, @"Key":@"562434ee823343ea985b85ef7b4aa34f"}];
            }else{
                discountId = obj.attractBusinessInfo.attractBusinessId;
                postbordType = kPostBoardAttractBusiness;
//                [HUDUtil showWithMaskType:HUDMaskTypeBlack];
                [[API_PostBoard getInstance] engine_outside_postBoard_addCollectionId:discountId type:postbordType];
            }
        }else{
            
        }
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

@end
