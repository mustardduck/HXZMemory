//
//  IWAttractBusinessViewController.m
//  miaozhuan
//
//  Created by admin on 15/4/30.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWAttractBusinessDetailViewController.h"
#import "IWPublishAttractBusinessViewController.h"
#import "UIImageView+WebCache.h"
#import "ScrollerViewWithTime.h"
#import "PreviewViewController.h"
#import "VIPPrivilegeViewController.h"
#import "UI_CycleScrollView.h"

#define kNoDataPlaceHolder @"未填写"
#define kBuyVipAlertTag 114

@interface IWAttractBusinessDetailViewController ()<UIScrollViewDelegate,UIAlertViewDelegate,UI_CycleScrollViewDelegate>{
    UI_CycleScrollView *_cycleView;
}

@property (retain, nonatomic) IBOutlet UIImageView *imageView_NoADImage;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *label_Title;
@property (retain, nonatomic) IBOutlet UILabel *label_SubTitle;
@property (retain, nonatomic) IBOutlet UILabel *label_Type;
@property (retain, nonatomic) IBOutlet UILabel *label_ProductName;
@property (retain, nonatomic) IBOutlet UILabel *label_InvestMoney;
@property (retain, nonatomic) IBOutlet UILabel *label_OfficialURL;
@property (retain, nonatomic) IBOutlet UILabel *label_CompanyName;
@property (retain, nonatomic) IBOutlet UILabel *label_Phone;
@property (retain, nonatomic) IBOutlet UILabel *label_Address;
@property (retain, nonatomic) IBOutlet UIView *view_Bottom;
@property (retain, nonatomic) IBOutlet UILabel *label_Remark;
@property (retain, nonatomic) IBOutlet UIView *view_Content;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraints_vertical_Bottom_ScrollView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraints_vertical_Bottom_BottomView;
@property (retain, nonatomic) IBOutlet UIButton *button_ContinuePublish;
@property (retain, nonatomic) IBOutlet UIImageView *image_BrandLogo;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView_TopBanner;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_top_Title;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line2;
@end

@implementation IWAttractBusinessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _constraint_height_Line.constant = 0.5f;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
    
    [self loadData];
    
    [self updateUI];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UpdateFailureAction object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- custom events
#pragma mark -- 数据请求成功回调
-(void)handleUpdateSuccessAction:(NSNotification *)noti{
    NSDictionary *dict = [noti userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    
    if(ret == 1){
        if(type == ut_postBoard_attractBusinessDetails){
            _attractBusinessInfo = [SharedData getInstance].postBoardAttractBusinessDetail.attractBusinessInfo;
            _enterpriseNewInfo = [SharedData getInstance].postBoardAttractBusinessDetail.enterpriseInfo;
            [self updateUIContent];
        }else if (type == ut_postBoardManage_enterpriseInfo){
            _enterpriseNewInfo = [SharedData getInstance].enterpriseInfo;
            [self updateUIContent];
        }else if(type == ut_attractBusinessManage_details){
            _attractBusinessInfo = [SharedData getInstance].attractBusinessDetalInfo;
            [self updateUIContent];
        }
    }else{
        if(type == ut_postBoard_attractBusinessDetails || type == ut_postBoardManage_enterpriseInfo){
            [HUDUtil showErrorWithStatus:dict[@"msg"]];
        }
    }
}

#pragma mark -- 数据请求失败回调
-(void)handleUpdateFailureAction:(NSNotification *)noti{
    [HUDUtil showErrorWithStatus:@"网络不给力，请检查后重试"];
}

#pragma mark -- 加载数据
-(void)loadData{
    if(_detailType == IWAttractBusinessDetailType_PreView){
        [self hideBottomView:YES];
        if(![SharedData getInstance].enterpriseInfo){
            [[API_PostBoard getInstance] engine_outside_postBoardManage_enterpriseInfo];
        }else{
            _enterpriseNewInfo = [SharedData getInstance].enterpriseInfo;
            [self updateUIContent];
        }
        
    }else if (_detailType == IWAttractBusinessDetailType_Browse){
        [self hideBottomView:YES];
        if(self.detailsId){
            
            [[API_PostBoard getInstance] engine_outside_postBoard_attractBusinessDetailsID:self.detailsId];
        }
    }else if (_detailType == IWAttractBusinessDetailType_Offline){
        [self hideBottomView:NO];
        if(self.detailsId){
            
            [[API_PostBoard getInstance] engine_outside_postBoard_attractBusinessDetailsID:self.detailsId];
        }
    }else if (_detailType == IWAttractBusinessDetailType_ForceOffline){
        [self hideBottomView:YES];
        if(self.detailsId){
            
            [[API_PostBoard getInstance] engine_outside_attractBusinessManage_detailsId:self.detailsId];
        }
        _enterpriseNewInfo = [SharedData getInstance].enterpriseInfo;
        if(_enterpriseNewInfo == nil){
            [[API_PostBoard getInstance] engine_outside_postBoardManage_enterpriseInfo];
        }
    }
}

#pragma mark -- 进入编辑前检查
-(BOOL)checkBeforeEnterPublish{
    BOOL flag = NO;
    
    if([[SharedData getInstance] attractBusinessManageInfo].businessTodayRestCount < 1){
        if([SharedData getInstance].personalInfo.userIsEnterpriseVip){
            [HUDUtil showErrorWithStatus:[NSString stringWithFormat:@"今天已经发布了%d条",[[SharedData getInstance] attractBusinessManageInfo].businessVipPublishCount]];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发布限制" message:[NSString stringWithFormat:@"已发布%d条信息，是否购买VIP获取特权",[[SharedData getInstance] attractBusinessManageInfo].businessNormalPublishCount] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"去购买", nil];
            alert.tag = kBuyVipAlertTag;
            [alert show];
        }
    }else{
        flag = YES;
    }
    
    return flag;
}


#pragma mark -- 继续发布
- (IBAction)continuePublish:(id)sender {
    if([self checkBeforeEnterPublish]){
        IWPublishAttractBusinessViewController *iwpabvc = [[IWPublishAttractBusinessViewController alloc] init];
        iwpabvc.detailsId = _detailsId;
        iwpabvc.publishAttractBuinessType = IWPublishAttractBusinessType_FromOffline;
        [self.navigationController pushViewController:iwpabvc animated:YES];
    }
}

#pragma mark -- 打电话
- (IBAction)call:(id)sender {
    NSURL *urlone = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.label_Phone.text]];
    UIWebView    *phoneCallWebView = [[UIWebView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] addSubview:phoneCallWebView];
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:urlone]];
}

#pragma mark -- 更新按钮样式
-(void)updateUI{
    
    self.button_ContinuePublish.layer.cornerRadius = 5.f;
    self.button_ContinuePublish.layer.masksToBounds = YES;
    
    [self.button_ContinuePublish setBackgroundImage:[[UIImage imageNamed:@"ads_invate"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.button_ContinuePublish setBackgroundImage:[[UIImage imageNamed:@"ads_invatehover"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
    
    self.scrollView.canCancelContentTouches = NO;
    self.scrollView.delaysContentTouches = NO;
    
    self.image_BrandLogo.layer.masksToBounds = YES;
    self.image_BrandLogo.clipsToBounds = YES;
    self.image_BrandLogo.layer.cornerRadius = 10.0;
    self.image_BrandLogo.layer.borderWidth = 0.5;
    self.image_BrandLogo.layer.borderColor = RGBCOLOR(197, 197, 197).CGColor;
    
    _constraint_height_Line.constant = 0.5f;
    _constraint_height_Line2.constant = _constraint_height_Line.constant;
}

#pragma mark - banner
- (void)createBannerViewWithImages:(NSArray *)images{
    
    _imageView_NoADImage.hidden = (images.count > 0);
    if (!images.count) {
        return;
    }
    if (_cycleView == nil) {
        _cycleView = [[UI_CycleScrollView alloc] initWithFrame:self.scrollView_TopBanner.frame];
        _cycleView.backgroundColor = [UIColor clearColor];
        _cycleView.delegate = self;
        [self.scrollView_TopBanner addSubview:_cycleView];
        
        [_cycleView setPictureUrls:[NSMutableArray arrayWithArray:images]];
    }
    
//    CGSize tempsize = {150,217};
//    if (!_recommandBanner) {
//    }
//    
//    
//    _recommandBanner = [ScrollerViewWithTime controllerFromView:_scrollView_TopBanner pictureSize:tempsize];
//    [_recommandBanner setWidthSelf:160.f];
//    [_recommandBanner addImageItems:images];
//    __block typeof(self) weakself = self;
//    _recommandBanner.TapActionBlock = ^(NSInteger pageIndex){
//    };
}

-(void)CycleImageTap:(int)page {
    
    PreviewViewController *model = [[PreviewViewController alloc] init];
    model.currentPage = page;
    NSMutableArray *pics = [NSMutableArray array];
    for (int i = 0; i < _attractBusinessInfo.attractBusinessPublicPics.count; i ++) {
        PictureInfo *pi = _attractBusinessInfo.attractBusinessPublicPics[i];
        [pics addObject:@{@"PictureUrl":pi.pictureURL}];
    }
    model.dataArray = pics;
    [self presentViewController:model animated:NO completion:nil];

}


#pragma mark -- 处理时间特殊字符串
-(NSString *)dateStringFromString:(NSString *)string{
    return [string componentsSeparatedByString:@"T"][0];
}

#pragma mark -- 是否是某天
-(BOOL)isSomeDay:(NSDate *)date DateString:(NSString *)dateString{
    BOOL flag = NO;
    NSString *someDay = [UICommon usaulFormatTime:date formatStyle:@"yyyy-MM-dd"];
    if([someDay isEqualToString:dateString]){
        flag = YES;
    }
    
    return flag;
}

#pragma mark -- 更新展示内容
-(void)updateUIContent{
    
    _constraint_vertical_top_Title.constant = 10.f;
    if(_attractBusinessInfo.attractBusinessTitle.length > 0){
        self.label_Title.text = _attractBusinessInfo.attractBusinessTitle;
        self.label_Title.textColor = RGBACOLOR(34, 34, 34, 1);
    }else{
        self.label_Title.text = kNoDataPlaceHolder;
        self.label_Title.textColor = RGBACOLOR(204, 204, 204, 1);
    }
    
    NSString *refreshDate = @"";
    if(_detailType == IWAttractBusinessDetailType_PreView){
        refreshDate = @"今天";
    }else{
        refreshDate = [self dateStringFromString:_attractBusinessInfo.attractBusinessRefreshTime];
        BOOL today = [self isSomeDay:[NSDate date] DateString:refreshDate];
        if(!today){
            BOOL yesterday = [self isSomeDay:[NSDate dateWithTimeIntervalSinceNow:-(24*60*60)] DateString:refreshDate];
            if(yesterday){
                refreshDate = @"昨天";
            }
        }else{
            refreshDate = @"今天";
        }
    }
    NSString *publishDate = _attractBusinessInfo.attractBusinessPublishTime.length > 0 ? [self dateStringFromString:_attractBusinessInfo.attractBusinessPublishTime] : [UICommon usaulFormatTime:[NSDate date] formatStyle:@"yyyy-MM-dd"];
    self.label_SubTitle.text = [NSString stringWithFormat:@"刷新时间：%@        发布时间：%@",refreshDate,[publishDate componentsSeparatedByString:@" "][0]];
    
    if(_attractBusinessInfo.attractBusinessBrand.length > 0){
        self.label_ProductName.text = _attractBusinessInfo.attractBusinessBrand;
        self.label_ProductName.textColor = RGBACOLOR(34, 34, 34, 1);
    }else{
        self.label_ProductName.text = kNoDataPlaceHolder;
        self.label_ProductName.textColor = RGBACOLOR(204, 204, 204, 1);
    }
    
    if(_enterpriseNewInfo.enterpriseIndustry.length > 0){
        self.label_Type.text = _enterpriseNewInfo.enterpriseIndustry;
        self.label_Type.textColor = RGBACOLOR(34, 34, 34, 1);
    }else{
        self.label_Type.text = kNoDataPlaceHolder;
        self.label_Type.textColor = RGBACOLOR(204, 204, 204, 1);
    }
    
    if(_attractBusinessInfo.attractBusinessInvestAmount.length > 0){
        self.label_InvestMoney.text = _attractBusinessInfo.attractBusinessInvestAmount;
        self.label_InvestMoney.textColor = RGBACOLOR(34, 34, 34, 1);
    }else{
        self.label_InvestMoney.text = kNoDataPlaceHolder;
        self.label_InvestMoney.textColor = RGBACOLOR(204, 204, 204, 1);
    }
    
    if(_enterpriseNewInfo.enterpriseContactPhone.length > 0){
        self.label_Phone.text = _enterpriseNewInfo.enterpriseContactPhone;
        self.label_Phone.textColor = RGBACOLOR(34, 34, 34, 1);
    }else{
        self.label_Phone.text = kNoDataPlaceHolder;
        self.label_Phone.textColor = RGBACOLOR(204, 204, 204, 1);
    }
    
    if(_enterpriseNewInfo.enterpriseName.length > 0){
        self.label_CompanyName.text = _enterpriseNewInfo.enterpriseName;
        self.label_CompanyName.textColor = RGBACOLOR(34, 34, 34, 1);
    }else{
        self.label_CompanyName.text = kNoDataPlaceHolder;
        self.label_CompanyName.textColor = RGBACOLOR(204, 204, 204, 1);
    }
    
    if(_enterpriseNewInfo.enterpriseAddress.length > 0){
        self.label_Address.text = _enterpriseNewInfo.enterpriseAddress;
        self.label_Address.textColor = RGBACOLOR(34, 34, 34, 1);
    }else{
        self.label_Address.text = @"正在获取";
        self.label_Address.textColor = RGBACOLOR(204, 204, 204, 1);
    }
    
    if(_attractBusinessInfo.attractBusinessOfficialLink.length > 0){
        self.label_OfficialURL.text = _attractBusinessInfo.attractBusinessOfficialLink;
        self.label_OfficialURL.textColor = RGBACOLOR(34, 34, 34, 1);
    }else{
        self.label_OfficialURL.text = kNoDataPlaceHolder;
        self.label_OfficialURL.textColor = RGBACOLOR(204, 204, 204, 1);
    }
    
    if(_attractBusinessInfo.attractBusinessDescription.length > 0){
        self.label_Remark.text = _attractBusinessInfo.attractBusinessDescription;
        self.label_Remark.textColor = RGBACOLOR(34, 34, 34, 1);
    }else{
        self.label_Remark.text = kNoDataPlaceHolder;
        self.label_Remark.textColor = RGBACOLOR(204, 204, 204, 1);
    }
    if(_attractBusinessInfo.attractBusinessLogoPic.pictureURL.length > 0){
        [_image_BrandLogo setImageWithURL:[NSURL URLWithString:_attractBusinessInfo.attractBusinessLogoPic.pictureURL] placeholderImage:[UIImage imageNamed:@"A8_商家LOGO默认"]];
    }
    NSMutableArray *adImages = [NSMutableArray array];
    for (int i = 0; i < _attractBusinessInfo.attractBusinessPublicPics.count; i ++) {
        PictureInfo *pi = _attractBusinessInfo.attractBusinessPublicPics[i];
        [adImages addObject:pi.pictureURL];
    }
    [self createBannerViewWithImages:adImages];
}

#pragma mark -- 隐藏底部视图
-(void)hideBottomView:(BOOL)hide{
    if(hide){
        self.constraints_vertical_Bottom_ScrollView.constant = 0;
        self.constraints_vertical_Bottom_BottomView.constant = -self.view_Bottom.height;
    }else{
        self.constraints_vertical_Bottom_ScrollView.constant = self.view_Bottom.height;
        self.constraints_vertical_Bottom_BottomView.constant = 0;
    }
    self.view_Bottom.hidden = hide;
    
}

#pragma mark uialertview delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == kBuyVipAlertTag){
        if(buttonIndex == 1){
            //购买VIP页面
            VIPPrivilegeViewController *vipvc = [[VIPPrivilegeViewController alloc] init];
            [CRHttpAddedManager mz_pushViewController:vipvc];
        }
    }
}

@end
