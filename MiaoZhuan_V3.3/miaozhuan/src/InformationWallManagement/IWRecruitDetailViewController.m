//
//  RecruitDetailViewController.m
//  miaozhuan
//
//  Created by admin on 15/4/28.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWRecruitDetailViewController.h"
#import "IWPublishRecruitViewController.h"
#import "IWRecruitWelfareLabelView.h"
#import "RTLabel.h"
#import "VIPPrivilegeViewController.h"

#define kNoDataPlaceHolder @"未填写"
#define kBuyVipAlertTag 114

@interface IWRecruitDetailViewController ()<UIAlertViewDelegate>{
    float footviewHeight;
}

@property (retain, nonatomic) IBOutlet UIView *bottomView;
@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) IBOutlet UIButton *button_continue;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_ScrollView;


@property (retain, nonatomic) IBOutlet RTLabel *label_Title;
@property (retain, nonatomic) IBOutlet RTLabel *label_SubTitle;
@property (retain, nonatomic) IBOutlet UIView *view_Line;
@property (retain, nonatomic) IBOutlet RTLabel *label_Sarlay;
@property (retain, nonatomic) IBOutlet RTLabel *label_Intro;
@property (retain, nonatomic) IBOutlet RTLabel *label_Company;
@property (retain, nonatomic) IBOutlet RTLabel *label_Address;
@property (retain, nonatomic) IBOutlet UILabel *label_PhoneNumber;
@property (retain, nonatomic) IBOutlet IWRecruitWelfareLabelView *view_Welfare;
@property (retain, nonatomic) IBOutlet RTLabel *label_WorkAbout;
@property (retain, nonatomic) IBOutlet RTLabel *label_TempLabel;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_top_TItle;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_top_SubTitle;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_top_Line;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_top_Salary;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_top_Intro;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_top_Company;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_top_Address;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_top_Phone;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_top_Welfare;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_top_InWelfareView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_bottom_InWelfare;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_top_TempLabel;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_top_WorkAbout;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_bottom_WorkAbout;


@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Title;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_SubTitle;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Salary;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Intro;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Company;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Address;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Welfare;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_InWelfare;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_TempLabel;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_WorkAbout;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line1;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line2;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line3;


@end

@implementation IWRecruitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //初始化UI样式
    [self updateUI];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
    
    [self loadData];
    
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UpdateFailureAction object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
        if(type == ut_postBoardManage_enterpriseInfo){
            _enterpriseNewInfo = [SharedData getInstance].enterpriseInfo;
            [self updateContent];
        }else if(type == ut_postBoard_recruitmentDetails){
            _recruitmentInfo = [[SharedData getInstance] postBoardRecruitmentDetail].recruitmentInfo;
            _enterpriseNewInfo = [[SharedData getInstance] postBoardRecruitmentDetail].enterpriseInfo;
            [self updateContent];
        }else if(type == ut_recruitmentManage_details){
            _recruitmentInfo = [SharedData getInstance].recruitmentDetailInfo;
            [self updateContent];
        }
        
    }else{
        if(type == ut_postBoardManage_detail || type == ut_postBoardManage_enterpriseInfo || type == ut_recruitmentManage_details || type == ut_postBoardManage_detail){
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
    if(_detailType == IWRecruitDetailType_PreView){
        [self hideBottomView:YES];
        if(![SharedData getInstance].enterpriseInfo){
            [[API_PostBoard getInstance] engine_outside_postBoardManage_enterpriseInfo];
        }else{
            _enterpriseNewInfo = [SharedData getInstance].enterpriseInfo;
            [self updateContent];
        }
        
    }else if (_detailType == IWRecruitDetailType_Browse){
        [self hideBottomView:YES];
        if(self.detailsId){
            [[API_PostBoard getInstance] engine_outside_postBoard_recruitmentDetailsId:self.detailsId];
        }
        
    }else if (_detailType == IWRecruitDetailType_Offline){
        [self hideBottomView:NO];
        if(self.detailsId){
            [[API_PostBoard getInstance] engine_outside_postBoard_recruitmentDetailsId:self.detailsId];
        }
    }else if (_detailType == IWRecruitDetailType_ForceOffline){
        [self hideBottomView:YES];
        if(self.detailsId){
            
            [[API_PostBoard getInstance] engine_outside_recruitmentManage_detailsId:self.detailsId];
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
    
    if([[SharedData getInstance] recruitmentManageInfo].recruitmentTodayRestCount < 1){
        if([SharedData getInstance].personalInfo.userIsEnterpriseVip){
            [HUDUtil showErrorWithStatus:[NSString stringWithFormat:@"今天已经发布了%d条",[[SharedData getInstance] recruitmentManageInfo].recruitmentVipPublishCount]];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发布限制" message:[NSString stringWithFormat:@"已发布%d条信息，是否购买VIP获取特权",[[SharedData getInstance] recruitmentManageInfo].recruitmentNormalPublishCount] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"去购买", nil];
            alert.tag = kBuyVipAlertTag;
            [alert show];
        }
    }else{
        flag = YES;
    }
    
    return flag;
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

#pragma mark -- 继续发布
- (IBAction)continuePublish:(id)sender {
    if([self checkBeforeEnterPublish]){
        IWPublishRecruitViewController *iwprvc = [[IWPublishRecruitViewController alloc] init];
        iwprvc.publishRecruitType = IWPublishRecruit_FromOffline;
        iwprvc.detailsId = _detailsId;
        [self.navigationController pushViewController:iwprvc animated:YES];
    }    
}

#pragma mark -- 隐藏底部视图
-(void)hideBottomView:(BOOL)hide{
    if(hide){
        self.constraint_vertical_ScrollView.constant = 0;
        self.constraints_vertical_Bottom_BottomView.constant = -self.bottomView.height;
    }else{
        self.constraint_vertical_ScrollView.constant = self.bottomView.height;
        self.constraints_vertical_Bottom_BottomView.constant = 0;
    }
    self.bottomView.hidden = hide;
    
}

#pragma mark -- 更新内容
-(void)updateContent{
    
    //招聘标题
    if(_recruitmentInfo.recruitmentTitle.length > 0) {
        self.label_Title.text = [NSString stringWithFormat:@"<font size=16 color=#222222>%@</font>",_recruitmentInfo.recruitmentTitle];
    }else{
        self.label_Title.text = [NSString stringWithFormat:@"<font size=16 color=#cccccc>%@</font>",kNoDataPlaceHolder];
    }
    _constraint_height_Title.constant = _label_Title.optimumSize.height;
    _constraint_vertical_top_TItle.constant = 20.f;
    
    //刷新时间、发布时间
    NSString *refreshDate = @"";
    if(_detailType == IWRecruitDetailType_PreView){
        refreshDate = @"今天";
    }else{
        refreshDate = [self dateStringFromString:_recruitmentInfo.recruitmentPublishTime];
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
    NSString *publishDate = _recruitmentInfo.recruitmentPublishTime.length > 0 ? [self dateStringFromString:_recruitmentInfo.recruitmentPublishTime] : [UICommon usaulFormatTime:[NSDate date] formatStyle:@"yyyy-MM-dd"];
    self.label_SubTitle.text = [NSString stringWithFormat:@"<font size=11 color=#999999>刷新时间：%@         发布时间：%@</font>",refreshDate,[publishDate componentsSeparatedByString:@" "][0]];
    _constraint_height_SubTitle.constant = _label_SubTitle.optimumSize.height;
    _constraint_vertical_top_SubTitle.constant = 10.f;
    
    //分割线
    _constraint_vertical_top_Line.constant = 20.f;
    _constraint_height_Line.constant = 0.5f;

    //招聘工资
    if(_recruitmentInfo.recruitmentSalary.length > 0) {
        if([_recruitmentInfo.recruitmentSalary isEqualToString:@"面议"]){
            self.label_Sarlay.text = [NSString stringWithFormat:@"<font size=14 color=#FA091C>%@</font>",_recruitmentInfo.recruitmentSalary];
        }else{
            self.label_Sarlay.text = [NSString stringWithFormat:@"<font size=14 color=#FA091C>%@元/每月</font>",_recruitmentInfo.recruitmentSalary];
        }
    }else{
        self.label_Sarlay.text = [NSString stringWithFormat:@"<font size=14 color=#cccccc>%@</font>",kNoDataPlaceHolder];
    }
    _constraint_height_Salary.constant = _label_Sarlay.optimumSize.height;
    _constraint_vertical_top_Salary.constant = 20.f;
    
    //招聘简介
    self.label_Intro.text = [self appendSpecialString];
    _constraint_height_Intro.constant = _label_Intro.optimumSize.height;
    _constraint_vertical_top_Intro.constant = 15.f;
    
    //公司名称
    self.label_Company.text = [NSString stringWithFormat:@"<font size=14 color=#222222>%@</font>",_enterpriseNewInfo.enterpriseName];
    _constraint_height_Company.constant = _label_Intro.optimumSize.height;
    _constraint_vertical_top_Company.constant = 16.f;
    
    //公司地址
    self.label_Address.text = [NSString stringWithFormat:@"<font size=14 color=#222222>%@</font>",_enterpriseNewInfo.enterpriseAddress];
    _constraint_height_Address.constant = _label_Address.optimumSize.height;
    _constraint_vertical_top_Address.constant = 16.f;

    //招聘电话
    self.label_PhoneNumber.text = _enterpriseNewInfo.enterpriseRecruitmentPhone;
    _constraint_vertical_top_Phone.constant = 16.f;
    
    
    _constraint_height_Line2.constant = _constraint_height_Line.constant;
    _constraint_height_Line3.constant = _constraint_height_Line.constant;
    
    //公司福利
    _view_Welfare.maxWidth = SCREENWIDTH - 30.f;
    float welfareHeight = [_view_Welfare updateItems:_enterpriseNewInfo.enterpriseCompanyBenefits];
    _constraint_height_InWelfare.constant = welfareHeight;
    _constraint_height_Welfare.constant = welfareHeight + 30.f;
    _constraint_vertical_bottom_InWelfare.constant = 15.f;
    _constraint_vertical_top_InWelfareView.constant = 15.f;
    _constraint_vertical_top_Welfare.constant = 20.f;    
    
    _constraint_vertical_top_TempLabel.constant = 20.f;
    _label_TempLabel.text = [NSString stringWithFormat:@"<font size=14 color=#999999>岗位要求\n</font>"];
    _constraint_height_TempLabel.constant = _label_TempLabel.optimumSize.height;
    
    //岗位要求
    if(_recruitmentInfo.recruitmentResponsibility.length > 0) {
        self.label_WorkAbout.text = [NSString stringWithFormat:@"<font size=14 color=#222222>%@</font>",_recruitmentInfo.recruitmentResponsibility];
    }else{
        self.label_WorkAbout.text = [NSString stringWithFormat:@"<font size=14 color=#cccccc>%@</font>",kNoDataPlaceHolder];
    }
    _constraint_height_WorkAbout.constant = _label_WorkAbout.optimumSize.height;
    _constraint_vertical_top_WorkAbout.constant = 13.f;
    
    _constraint_height_Line1.constant = _constraint_height_Line.constant;
    
    _constraint_vertical_bottom_WorkAbout.constant = 0.f;


}

#pragma mark -- 打电话
- (IBAction)callSomeOne:(id)sender {
    NSURL *urlone = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_enterpriseNewInfo.enterpriseRecruitmentPhone]];
    UIWebView    *phoneCallWebView = [[UIWebView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] addSubview:phoneCallWebView];
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:urlone]];
}

#pragma mark -- 拼接特殊字符串
-(NSString *)appendSpecialString{
    
    NSString *sex = @"";
    if (_recruitmentInfo.recruitmentGender == kUserMan){
        sex = @"<font size=14 color=#222222>男</font>";
    }else if (_recruitmentInfo.recruitmentGender == kUserWoman){
        sex = @"<font size=14 color=#222222>女</font>";
    }else{
        sex = @"<font size=14 color=#222222>性别不限</font>";
    }
    NSString *recruitmentCount = @"";
    if(_recruitmentInfo.recruitmentRecruitmentCount.length > 0){
        recruitmentCount = [NSString stringWithFormat:@"<font size=14 color=#222222>%@</font>",_recruitmentInfo.recruitmentRecruitmentCount];
    }else{
        recruitmentCount = @"<font size=14 color=#cccccc>未填写</font>";
    }
    NSString *education = @"";
    if(_recruitmentInfo.recruitmentEducation.length > 0){
        education = [NSString stringWithFormat:@"<font size=14 color=#222222>%@</font>",_recruitmentInfo.recruitmentEducation];
    }else{
        education = @"<font size=14 color=#cccccc>未填写</font>";
    }
    NSString *workYears = @"";
    if(_recruitmentInfo.recruitmentWorkingYears.length > 0){
        workYears = [NSString stringWithFormat:@"<font size=14 color=#222222>%@</font>",_recruitmentInfo.recruitmentWorkingYears];
    }else{
        workYears = @"<font size=14 color=#cccccc>未填写</font>";
    }
    
    return [NSString stringWithFormat:@"%@ <font size=14 color=#cccccc>|</font> %@ <font size=14 color=#cccccc>|</font> %@ <font size=14 color=#cccccc>|</font> %@",
            recruitmentCount,
            education,
            workYears,
             sex];
}

#pragma mark -- 更新按钮样式
-(void)updateUI{
    self.button_continue.layer.cornerRadius = 5.f;
    self.button_continue.layer.masksToBounds = YES;
    
    [self.button_continue setBackgroundImage:[[UIImage imageNamed:@"ads_invate"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.button_continue setBackgroundImage:[[UIImage imageNamed:@"ads_invatehover"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
}

#pragma mark -- 处理时间特殊字符串
-(NSString *)dateStringFromString:(NSString *)string{
    return [string componentsSeparatedByString:@"T"][0];
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
