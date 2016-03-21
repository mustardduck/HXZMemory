//
//  ReleaseInfo_ZhaoPin_ViewController.m
//  MZV32
//
//  Created by admin on 15/4/16.
//  Copyright (c) 2015年 Junnpy.Pro.Test. All rights reserved.
//

#import "IWPublishRecruitViewController.h"
#import "IWTextInputViewController.h"
#import "UI_PickerView.h"
#import "IWRecruitDetailViewController.h"
#import "IWCompanyIntroViewController.h"
#import "IWMainDetail.h"
#import "SharedData.h"
#import "GetMoreGoldViewController.h"
#import "VIPPrivilegeViewController.h"

#define kActionSheetTag_BackWithSave 111
#define kAlertViewTag_SureToPublish 112
#define kAlertViewTag_GoldAmountNotEnough 113
#define kBuyVipAlertTag 114

@interface IWPublishRecruitViewController ()<UITextFieldDelegate,UI_PickViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>{
    UI_PickerView *_dataPicker;
    id _currentDataPickerUI;
    NSUInteger _recruitmentOnlineDayCount;
    RecruitmentInfo *_recruitmentInfo;
    RecruitmentInfo *_temp_recruitmentInfo;
    BOOL _needPopViewController;
    BOOL _needGetMoreGold;
    BOOL _saveFromOfflineAtFirst;
}

@property (weak, nonatomic) IBOutlet UIButton *button_Preview;
@property (weak, nonatomic) IBOutlet UIButton *button_Publish;
@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIButton *radioButton_SevenDay;
@property (retain, nonatomic) IBOutlet UIButton *radioButton_HalfOfMonth;
@property (retain, nonatomic) IBOutlet UIButton *radioButton_AMonth;
@property (retain, nonatomic) IBOutlet UIButton *button_SevenDay;
@property (retain, nonatomic) IBOutlet UIButton *button_HalfOfMonth;
@property (retain, nonatomic) IBOutlet UIButton *button_AMonth;
@property (retain, nonatomic) IBOutlet UITextField *tf_Title;
@property (retain, nonatomic) IBOutlet UITextField *tf_SalaryArea;
@property (retain, nonatomic) IBOutlet UITextField *tf_Experience;
@property (retain, nonatomic) IBOutlet UITextField *tf_PersonCount;
@property (retain, nonatomic) IBOutlet UITextField *tf_Sex;
@property (retain, nonatomic) IBOutlet UITextField *tf_WorkAbout;
@property (retain, nonatomic) IBOutlet UITextField *tf_Degree;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line1;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line2;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line3;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line4;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line5;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line6;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line7;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line8;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line0;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_Line9;


@end

@implementation IWPublishRecruitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGBACOLOR(248, 248, 248, 1);
    self.scrollView.backgroundColor = RGBACOLOR(239, 239, 244, 1);
    
    
    InitNav(@"发布招聘信息");
    
    [self setupMoveFowardButtonWithTitle:@"存入草稿"];
    
    [self updateButton];
    
    _recruitmentOnlineDayCount = 7;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
    
    if(_publishRecruitType == IWPublishRecruit_FromDraft || _publishRecruitType == IWPublishRecruit_FromOffline){
        if(self.detailsId){
           [[API_PostBoard getInstance] engine_outside_recruitmentManage_detailsId:self.detailsId];
        }
    }
    if([SharedData getInstance].operatorCompanySalaryCodeList.count == 0){
        [self getData_SalaryArea];
    }
    if([SharedData getInstance].operatorEducationCodeList.count == 0){
        [self getData_Education];
    }
    if([SharedData getInstance].operatorWorkingYearsCodeList.count == 0){
        [self getData_WorkYears];
    }
    if([SharedData getInstance].operatorRecruitmentCountCodeList.count == 0){
        [self getData_RecruitmentCount];
    }
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
#pragma mark -- 修改button样式
-(void)updateButton{
    
    _constraint_height_Line0.constant = 0.5f;
    _constraint_height_Line1.constant = _constraint_height_Line0.constant;
    _constraint_height_Line2.constant = _constraint_height_Line0.constant;
    _constraint_height_Line3.constant = _constraint_height_Line0.constant;
    _constraint_height_Line4.constant = _constraint_height_Line0.constant;
    _constraint_height_Line5.constant = _constraint_height_Line0.constant;
    _constraint_height_Line6.constant = _constraint_height_Line0.constant;
    _constraint_height_Line7.constant = _constraint_height_Line0.constant;
    _constraint_height_Line8.constant = _constraint_height_Line0.constant;
    _constraint_height_Line9.constant = _constraint_height_Line0.constant;
    
    UIImage *image = [UIImage imageNamed:@"ads_invate"];
    [self.button_Publish setBackgroundImage:image forState:UIControlStateNormal];
    image = [UIImage imageNamed:@"ads_buy"];
    [self.button_Preview setBackgroundImage:image forState:UIControlStateNormal];
    
    image = [UIImage imageNamed:@"ads_invatehover@2x.png"];
    [self.button_Publish setBackgroundImage:image forState:UIControlStateHighlighted];
    image = [UIImage imageNamed:@"ads_buyhover@2x.png"];
    [self.button_Preview setBackgroundImage:image forState:UIControlStateHighlighted];
    
    self.button_Preview.layer.cornerRadius = 5.f;
    self.button_Publish.layer.cornerRadius = 5.f;
    
    self.button_Preview.layer.masksToBounds = YES;
}

#pragma mark -- 更新UI内容
-(void)updateUIContent{
    self.tf_Title.text = [SharedData getInstance].recruitmentDetailInfo.recruitmentTitle;
    self.tf_SalaryArea.text = [SharedData getInstance].recruitmentDetailInfo.recruitmentSalary;
    self.tf_Degree.text = [SharedData getInstance].recruitmentDetailInfo.recruitmentEducation;
    self.tf_Experience.text = [SharedData getInstance].recruitmentDetailInfo.recruitmentWorkingYears;
    self.tf_PersonCount.text = [SharedData getInstance].recruitmentDetailInfo.recruitmentRecruitmentCount;
    switch ([SharedData getInstance].recruitmentDetailInfo.recruitmentGender) {
        case kUserAll:
            self.tf_Sex.text = @"不限";
            break;
        case kUserMan:
            self.tf_Sex.text = @"男";
            break;
        case kUserWoman:
            self.tf_Sex.text = @"女";
            
        default:
            break;
    }
    self.tf_WorkAbout.text = [SharedData getInstance].recruitmentDetailInfo.recruitmentResponsibility;
    if(_recruitmentInfo.recruitmentOnlineDayCount == 30){
        [self radioButtonClicked:_button_AMonth];
    }else if (_recruitmentInfo.recruitmentOnlineDayCount == 15){
        [self radioButtonClicked:_button_HalfOfMonth];
    }else{
        [self radioButtonClicked:_button_SevenDay];
    }
}

#pragma mark -- 数据请求成功回调
-(void)handleUpdateSuccessAction:(NSNotification *)noti{
    NSDictionary *dict = [noti userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    
    if(ret == 1){
        if(type == ut_recruitmentManage_publish){
            [HUDUtil showSuccessWithStatus:@"发布成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else if (type == ut_operator_companySalary){
        }else if (type == ut_operator_education){
        }else if (type == ut_operator_workingYears){
        }else if (type == ut_operator_recruitmentCount){
        }else if (type == ut_recruitmentManage_saveDraft){
            _recruitmentInfo = _temp_recruitmentInfo;
            _publishRecruitType = IWPublishRecruit_FromDraft;
            NSLog(@"%@",[SharedData getInstance].recruitmentDraft.recruitmentId);
            _recruitmentInfo.recruitmentId = [SharedData getInstance].recruitmentDraft.recruitmentId;
            _temp_recruitmentInfo = nil;
            [HUDUtil showSuccessWithStatus:@"保存成功"];
            if(_needPopViewController){
                [self.navigationController popViewControllerAnimated:YES];
            }else if (_needGetMoreGold){
                GetMoreGoldViewController *gmgvc = [[GetMoreGoldViewController alloc] init];
                [self.navigationController pushViewController:gmgvc animated:YES];
                _needGetMoreGold = NO;
            }
        }else if (type == ut_recruitmentManage_details){
            _recruitmentInfo = [SharedData getInstance].recruitmentDetailInfo;
            if(_recruitmentInfo.recruitmentOnlineDayCount != 15 && _recruitmentInfo.recruitmentOnlineDayCount != 30){
                _recruitmentInfo.recruitmentOnlineDayCount = 7;
            }
            if(_publishRecruitType == IWPublishRecruit_FromOffline){
                _recruitmentInfo.recruitmentId = @"";
                _saveFromOfflineAtFirst = YES;
            }
            [self updateUIContent];
        }
    }else{
        if(type == ut_recruitmentManage_publish || type == ut_operator_companySalary || type == ut_operator_education || type == ut_operator_workingYears ||type == ut_operator_recruitmentCount || type == ut_recruitmentManage_saveDraft || type == ut_recruitmentManage_details){
            [HUDUtil showErrorWithStatus:dict[@"msg"]];
        }
    }
}

#pragma mark -- 数据请求失败回调
-(void)handleUpdateFailureAction:(NSNotification *)noti{
    [HUDUtil showErrorWithStatus:@"数据加载失败"];
}

#pragma mark -- 发布信息前检查
-(BOOL)checkBeforePublish{
    BOOL flag = NO;
    
    if([[SharedData getInstance] recruitmentManageInfo].recruitmentTodayRestCount < 1){
        if([SharedData getInstance].personalInfo.userIsEnterpriseVip){
            [HUDUtil showErrorWithStatus:[NSString stringWithFormat:@"今天已经发布了%d条",[[SharedData getInstance] recruitmentManageInfo].recruitmentVipPublishCount]];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发布限制" message:[NSString stringWithFormat:@"已发布%d条信息，是否获取更多条数",[[SharedData getInstance] recruitmentManageInfo].recruitmentNormalPublishCount] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"去购买", nil];
            alert.tag = kBuyVipAlertTag;
            [alert show];
        }
    }else{
        flag = YES;
    }
    
    
    return flag;
}

#pragma mark -- 存入草稿
- (void)onMoveFoward:(UIButton*) sender{
    if([self checkChanged]){
        
        [HUDUtil showWithStatus:@"正在保存..."];
        
        if(nil == [SharedData getInstance].recruitmentDraft){
            [SharedData getInstance].recruitmentDraft = [[RecruitmentInfo alloc] init];
        }
        
        [self reloadCurrentRecruitmentInfo];
        [[API_PostBoard getInstance] engine_outside_recruitmentManage_saveDraft:_temp_recruitmentInfo.recruitmentId
                                                                          title:_temp_recruitmentInfo.recruitmentTitle
                                                                     salaryCode:_temp_recruitmentInfo.recruitmentSalaryCode
                                                                  educationCode:_temp_recruitmentInfo.recruitmentEducationCode
                                                                       yearCode:_temp_recruitmentInfo.recruitmentWorkingYearsCode
                                                                   recruitCount:_temp_recruitmentInfo.recruitmentRecruitmentCountCode
                                                                         gender:_temp_recruitmentInfo.recruitmentGender
                                                                 responsibility:_temp_recruitmentInfo.recruitmentResponsibility
                                                                    onlineCount:_temp_recruitmentInfo.recruitmentOnlineDayCount];
    }else{
        [HUDUtil showErrorWithStatus:@"暂无可保存的内容"];
    }
}

#pragma mark -- 发布招聘信息
- (IBAction)publish:(id)sender {
    if(![self checkBeforePublish]){
        return;
    }
    NSString *msg = [self checkInput];
    
    if(msg){
        [HUDUtil showErrorWithStatus:msg];
    }else{
        if(sender){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发布确认" message:@"是否确认消耗5金币发布本条信息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = kAlertViewTag_SureToPublish;
            [alert show];
        }else{
            
            if([SharedData getInstance].recruitmentManageInfo.recruitmentCurrentGoldAmount < [SharedData getInstance].recruitmentManageInfo.recruitmentPublishGoldCount){
                msg = [NSString stringWithFormat:@"发布广告所需金币：%d金币\n当前金币余额：%d金币",[SharedData getInstance].recruitmentManageInfo.recruitmentPublishGoldCount,(int)[SharedData getInstance].recruitmentManageInfo.recruitmentCurrentGoldAmount];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"金币不足" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存并去赚金币", nil];
                alert.tag = kAlertViewTag_GoldAmountNotEnough;
                [alert show];
            }else{
                [self reloadCurrentRecruitmentInfo];
                
                [HUDUtil showWithStatus:@"正在发布..."];
                
                [[API_PostBoard getInstance] engine_outside_recruitmentManage_publish:_temp_recruitmentInfo.recruitmentId
                                                                                title:_temp_recruitmentInfo.recruitmentTitle
                                                                           salaryCode:_temp_recruitmentInfo.recruitmentSalaryCode
                                                                        educationCode:_temp_recruitmentInfo.recruitmentEducationCode
                                                                             yearCode:_temp_recruitmentInfo.recruitmentWorkingYearsCode
                                                                         recruitCount:_temp_recruitmentInfo.recruitmentRecruitmentCountCode
                                                                               gender:_temp_recruitmentInfo.recruitmentGender
                                                                       responsibility:_temp_recruitmentInfo.recruitmentResponsibility
                                                                          onlineCount:_temp_recruitmentInfo.recruitmentOnlineDayCount];
            }
            
            
        }
    }
}

#pragma mark -- 预览招聘信息
- (IBAction)preview:(id)sender {
    
    IWMainDetail *detailVC = [[IWMainDetail alloc] init];
    detailVC.isDraft = YES;
    IWRecruitDetailViewController *iwrdvc = [[IWRecruitDetailViewController alloc] init];
    [self reloadCurrentRecruitmentInfo];
    iwrdvc.recruitmentInfo = _temp_recruitmentInfo;
    iwrdvc.detailType = IWRecruitDetailType_PreView;
    
    
    IWCompanyIntroViewController *sdep = [[IWCompanyIntroViewController alloc] init];
    detailVC.navTitle = @"招聘信息标题";
    sdep.isDraft = YES;
    sdep.postBoardType = kPostBoardRecruit;
    detailVC.viewControllers = @[iwrdvc,sdep];
    detailVC.viewControllersTitle = @[@"详情展示",@"企业简介"];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

#pragma mark -- 返回
- (void)onMoveBack:(UIButton *)sender{
    
    BOOL contentChanged = [self checkChanged];
    
    if(contentChanged){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"是否保存到草稿箱" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存草稿" otherButtonTitles:@"不保存", nil];
        sheet.tag = kActionSheetTag_BackWithSave;
        [sheet showInView:self.view];
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark -- 获取薪资范围数据
-(void)getData_SalaryArea{
    [[API_PostBoard getInstance] engine_outside_operator_companySalary];
}

#pragma mark -- 获取学历要求数据
-(void)getData_Education{
    [[API_PostBoard getInstance] engine_outside_operator_education];
}

#pragma mark -- 获取经验要求数据
-(void)getData_WorkYears{
    [[API_PostBoard getInstance] engine_outside_operator_workingYears];
}

#pragma mark -- 获取招聘人数数据
-(void)getData_RecruitmentCount{
    [[API_PostBoard getInstance] engine_outside_operator_recruitmentCount];
}

#pragma mark -- 装载当前招聘信息
-(void)reloadCurrentRecruitmentInfo{
    
    _temp_recruitmentInfo = [[RecruitmentInfo alloc] init];
    if(_publishRecruitType == IWPublishRecruit_FromDraft){
        _temp_recruitmentInfo.recruitmentId = _recruitmentInfo.recruitmentId;
    }else{
        _temp_recruitmentInfo.recruitmentId = @"";
    }
    
    _temp_recruitmentInfo.recruitmentTitle = self.tf_Title.text.length > 0 ? self.tf_Title.text : @"";
    OperatorCodeInfo *codeInfo = [self codeInfoFromCodeList:[SharedData getInstance].operatorCompanySalaryCodeList WithCodeText:_tf_SalaryArea.text];
    _temp_recruitmentInfo.recruitmentSalaryCode = (codeInfo ? codeInfo.codeId : @"");
    _temp_recruitmentInfo.recruitmentSalary = (codeInfo ? codeInfo.codeText : @"");
    codeInfo = [self codeInfoFromCodeList:[SharedData getInstance].operatorEducationCodeList WithCodeText:_tf_Degree.text];
    _temp_recruitmentInfo.recruitmentEducationCode = (codeInfo ? codeInfo.codeId : @"");
    _temp_recruitmentInfo.recruitmentEducation = (codeInfo ? codeInfo.codeText : @"");
    codeInfo = [self codeInfoFromCodeList:[SharedData getInstance].operatorWorkingYearsCodeList WithCodeText:_tf_Experience.text];
    _temp_recruitmentInfo.recruitmentWorkingYearsCode = (codeInfo ? codeInfo.codeId : @"");
    _temp_recruitmentInfo.recruitmentWorkingYears = (codeInfo ? codeInfo.codeText : @"");
    codeInfo = [self codeInfoFromCodeList:[SharedData getInstance].operatorRecruitmentCountCodeList WithCodeText:_tf_PersonCount.text];
    _temp_recruitmentInfo.recruitmentRecruitmentCountCode = (codeInfo ? codeInfo.codeId : @"");
    _temp_recruitmentInfo.recruitmentRecruitmentCount = (codeInfo ? codeInfo.codeText : @"");
    _temp_recruitmentInfo.recruitmentResponsibility = _tf_WorkAbout.text.length > 0 ? self.tf_WorkAbout.text : @"";
    _temp_recruitmentInfo.recruitmentGender = [self userGenderIDFromString:_tf_Sex.text];
    _temp_recruitmentInfo.recruitmentOnlineDayCount = _recruitmentOnlineDayCount;

}

#pragma mark -- 检查输入完整
-(NSString *)checkInput{
    if(_tf_Title.text.length == 0){
        return @"招聘标题未填写";
    }else if(_tf_SalaryArea.text.length == 0){
        return @"薪资范围未选择";
    }else if(_tf_Degree.text.length == 0){
        return @"学历要求未选择";
    }else if(_tf_Experience.text.length == 0){
        return @"经验要求未选择";
    }else if(_tf_PersonCount.text.length == 0){
        return @"招聘人数未选择";
    }else if(_tf_Sex.text.length == 0){
        return @"性别要求未选择";
    }else if(_tf_WorkAbout.text.length == 0){
        return @"职责与要求未填写";
    }
    return nil;
}

#pragma mark -- 检查是否更改内容
- (BOOL)checkChanged{
    if(_saveFromOfflineAtFirst){
        _saveFromOfflineAtFirst = NO;
        return YES;
    }
    BOOL flag = NO;
    
    if(nil == _recruitmentInfo){
        if(_tf_Title.text.length != 0 ||
           _tf_SalaryArea.text.length != 0 ||
           _tf_Degree.text.length != 0 ||
           _tf_Experience.text.length != 0 ||
           _tf_PersonCount.text.length != 0 ||
           _tf_Title.text.length != 0 ||
           _tf_WorkAbout.text.length != 0 ||
           _recruitmentOnlineDayCount != 7){
            flag = YES;
        }
    }else{
        if(![_recruitmentInfo.recruitmentTitle isEqualToString:_tf_Title.text]){
            if(_tf_Title.text.length > 0){
                flag = YES;
            }
        }
        if(![_recruitmentInfo.recruitmentSalary isEqualToString:_tf_SalaryArea.text]){
            if(_tf_SalaryArea.text.length > 0){
                flag = YES;
            }
        }
        if(![_recruitmentInfo.recruitmentEducation isEqualToString:_tf_Degree.text]){
            if(_tf_Degree.text.length > 0){
                flag = YES;
            }
        }
        if(![_recruitmentInfo.recruitmentWorkingYears isEqualToString:_tf_Experience.text]){
            if(_tf_Experience.text.length > 0){
                flag = YES;
            }
        }
        if(![_recruitmentInfo.recruitmentRecruitmentCount isEqualToString:_tf_PersonCount.text]){
            if(_tf_PersonCount.text.length > 0){
                flag = YES;
            }
        }
        if(_recruitmentInfo.recruitmentGender != [self userGenderIDFromString:_tf_Sex.text]){
            if(_tf_Sex.text.length > 0){
                flag = YES;
            }
        }if(![_recruitmentInfo.recruitmentResponsibility isEqualToString:_tf_WorkAbout.text]){
            if(_tf_WorkAbout.text.length > 0){
                flag = YES;
            }
        }
        if(_recruitmentInfo.recruitmentOnlineDayCount != _recruitmentOnlineDayCount){
            flag = YES;
        }
    }
    
    
    return flag;
}

#pragma mark -- 根据codeText获取指定字典中自定的OperatorCodeInfo
-(OperatorCodeInfo *)codeInfoFromCodeList:(NSArray *)codeList WithCodeText:(NSString *)codeText{
    for (int i = 0; i < codeList.count; i ++) {
        OperatorCodeInfo *oc = codeList[i];
        if([oc.codeText isEqualToString:codeText]){
            return oc;
        }
    }
    return nil;
}

#pragma mark -- 字符串转性别ID
-(UserGender)userGenderIDFromString:(NSString *)string{
    if ([string isEqualToString:@"男"]){
        return kUserMan;
    }else if ([string isEqualToString:@"女"]){
        return kUserWoman;
    }
    return kUserAll;
}

#pragma mark -- 从字典获取数据选择数据源
-(NSArray *)dataPickerArrayFromCodeList:(NSArray *)codeList{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < codeList.count; i++)
    {
        OperatorCodeInfo *oc = codeList[i];
        [items addObject:oc.codeText];
    }
    return items;
}

#pragma mark -- 信息有效期选择
- (IBAction)radioButtonClicked:(id)sender {
    UIImage *normalImage = [UIImage imageNamed:@"radioButton_off.png"];
    UIImage *highlightedImage = [UIImage imageNamed:@"radioButton_on.png"];
    
    [_radioButton_SevenDay setImage:normalImage forState:UIControlStateNormal];
    [_radioButton_HalfOfMonth setImage:normalImage forState:UIControlStateNormal];
    [_radioButton_AMonth setImage:normalImage forState:UIControlStateNormal];
    
    if([sender isEqual:_button_SevenDay]){
        [_radioButton_SevenDay setImage:highlightedImage forState:UIControlStateNormal];
        _recruitmentOnlineDayCount = 7;
    }else if ([sender isEqual:_button_HalfOfMonth]){
        [_radioButton_HalfOfMonth setImage:highlightedImage forState:UIControlStateNormal];
        _recruitmentOnlineDayCount = 15;
    }else if ([sender isEqual:_button_AMonth]){
        [_radioButton_AMonth setImage:highlightedImage forState:UIControlStateNormal];
        _recruitmentOnlineDayCount = 30;
    }
}

#pragma mark -- 薪资范围选择
-(void)chooseCompanySalary{
    [_dataPicker remove];
    _dataPicker = nil;
    _dataPicker = [[UI_PickerView alloc] initPickviewWithArray:[self dataPickerArrayFromCodeList:[SharedData getInstance].operatorCompanySalaryCodeList] isHaveNavControler:NO];
    [_dataPicker setDelegate:self];
    _currentDataPickerUI = _tf_SalaryArea;
    [_dataPicker show];
}

#pragma mark -- 学历要求选择
-(void)chooseEducation{
    [_dataPicker remove];
    _dataPicker = nil;
    _dataPicker = [[UI_PickerView alloc] initPickviewWithArray:[self dataPickerArrayFromCodeList:[SharedData getInstance].operatorEducationCodeList] isHaveNavControler:NO];
    [_dataPicker setDelegate:self];
    _currentDataPickerUI = _tf_Degree;
    [_dataPicker show];
}

#pragma mark -- 经验要求选择
-(void)chooseWorkingYears{
    [_dataPicker remove];
    _dataPicker = nil;
    _dataPicker = [[UI_PickerView alloc] initPickviewWithArray:[self dataPickerArrayFromCodeList:[SharedData getInstance].operatorWorkingYearsCodeList] isHaveNavControler:NO];
    [_dataPicker setDelegate:self];
    _currentDataPickerUI = _tf_Experience;
    [_dataPicker show];
}

#pragma mark -- 招聘人数选择
-(void)chooseRecruitmentCount{
    [_dataPicker remove];
    _dataPicker = nil;
    _dataPicker = [[UI_PickerView alloc] initPickviewWithArray:[self dataPickerArrayFromCodeList:[SharedData getInstance].operatorRecruitmentCountCodeList] isHaveNavControler:NO];
    [_dataPicker setDelegate:self];
    _currentDataPickerUI = _tf_PersonCount;
    [_dataPicker show];
}

#pragma mark -- 性别选择
-(void)chooseSex{
    [_dataPicker remove];
    _dataPicker = nil;
    _dataPicker = [[UI_PickerView alloc] initPickviewWithArray:@[@"不限",@"男",@"女"] isHaveNavControler:NO];
    [_dataPicker setDelegate:self];
    _currentDataPickerUI = _tf_Sex;
    [_dataPicker show];
}

#pragma mark -- uitextfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if([textField isEqual:_tf_Title]){
        IWTextInputViewController *iwtivc = [[IWTextInputViewController alloc] init];
        [iwtivc setInputFinished:^(NSString *text){
            _tf_Title.text = text;
        }];
        iwtivc.value = _tf_Title.text;
        iwtivc.inputType = IWTextInputTitle;
        [iwtivc setTextInputAlert:@{@"alert_title":@"招聘标题",@"alert_textMinLength":@10,@"alert_textLength":@40,@"alert_minLength":@10,@"alert_demo":@"例如：高薪诚聘大堂经理，双休+提成",@"alert_placeholder":@"请输入招聘标题"}];
        [self.navigationController pushViewController:iwtivc animated:YES];
        
    }else if ([textField isEqual:_tf_SalaryArea]){
        [self chooseCompanySalary];
    }else if ([textField isEqual:_tf_Experience]){
        [self chooseWorkingYears];
    }else if ([textField isEqual:_tf_Degree]){
        [self chooseEducation];
    }else if ([textField isEqual:_tf_PersonCount]){
        [self chooseRecruitmentCount];
    }else if ([textField isEqual:_tf_Sex]){
        [self chooseSex];
    }else if ([textField isEqual:_tf_WorkAbout]){
        IWTextInputViewController *iwtivc = [[IWTextInputViewController alloc] init];
        iwtivc.inputType = IWTextInputContent;
        [iwtivc setInputFinished:^(NSString *text){
            _tf_WorkAbout.text = text;
        }];
        iwtivc.value = _tf_WorkAbout.text;
        [iwtivc setTextInputAlert:@{@"alert_title":@"职责与要求",@"alert_textMinLength":@10,@"alert_textLength":@1000,@"alert_minLength":@10,@"alert_demo":@"岗位职责：\n1、本科以上学历，3年以上互联网产品策划、设计经验；善于分析用户需求，对网络用户体验有较多研究；\n2、具备一定的项目管理经验，习惯于用严谨科学的统筹方法来保证工作按计划进行；\n3、对国内外产品与技术发展有敏锐的观察力和极高的求知欲；\n岗位要求\n1、具有良好的沟通能力和团队合作能力，具有很高的执行力，善于沟通，耐心细致，心理承受力强；\n2、具有数据统计，互联网广告系统开发经验者更佳。",@"alert_placeholder":@"请输入内容简介"}];
        [self.navigationController pushViewController:iwtivc animated:YES];
    }
    
    return NO;
}

#pragma mark -- datapicker delegate

-(void)toobarDonBtnHaveClick:(UI_PickerView *)pickView resultString:(NSString *)resultString{
    if(_currentDataPickerUI == _tf_Sex){
        [_tf_Sex setText:resultString];
    }else if (_currentDataPickerUI == _tf_SalaryArea){
        _tf_SalaryArea.text = resultString;
    }else if (_currentDataPickerUI == _tf_PersonCount){
        _tf_PersonCount.text = resultString;
    }else if (_currentDataPickerUI == _tf_Experience){
        _tf_Experience.text = resultString;
    }else if (_currentDataPickerUI == _tf_Degree){
        _tf_Degree.text = resultString;
    }
}

#pragma mark -- uiactionsheetview delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag == kActionSheetTag_BackWithSave){
        if (buttonIndex == 0) {
            _needPopViewController = YES;
            [self onMoveFoward:nil];
        } else if (buttonIndex == 1){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark -- uialertview delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == kAlertViewTag_SureToPublish){
        if(buttonIndex == 1){
            [self publish:nil];
        }
    }else if (alertView.tag == kAlertViewTag_GoldAmountNotEnough){
        if(buttonIndex == 1){
            _needGetMoreGold = YES;
            [self onMoveFoward:nil];
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
