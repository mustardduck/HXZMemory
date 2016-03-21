//
//  ZhaoPin_SupplementViewController.m
//  MZV32
//
//  Created by admin on 15/4/20.
//  Copyright (c) 2015年 Junnpy.Pro.Test. All rights reserved.
//

#import "IWRecruitSupplementViewController.h"
#import "IWTextInputViewController.h"
#import "IWCompanyTreatmentViewController.h"
#import "SharedData.h"
#import "UI_PickerView.h"

#define kBackToSureAlertViewTag 112

@interface IWRecruitSupplementViewController ()<UITextFieldDelegate,UI_PickViewDelegate,UIAlertViewDelegate>{
    BOOL _contentChanged;
    UI_PickerView *_dataPicker;
    id _currentDataPickerUI;
    NSMutableArray *_treatments;//公司待遇
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UITextField *tf_PhoneNumber;//招聘电话
@property (retain, nonatomic) IBOutlet UITextField *tf_Treatment;//福利待遇
@property (retain, nonatomic) IBOutlet UITextField *tf_CompanyNature;//公司性质
@property (retain, nonatomic) IBOutlet UITextField *tf_CompanyScale;//公司规模
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation IWRecruitSupplementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGBACOLOR(239, 239, 244, 1);
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    InitNav(@"招聘信息补充");    
    
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    self.constraint_height_line0.constant = 0.5f;
    self.constraint_height_line1.constant = 0.5f;
    self.constraint_height_line2.constant = 0.5f;
    self.constraint_height_line3.constant = 0.5f;
    self.constraint_height_line4.constant = 0.5f;
    
    _treatments = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
    
    [[API_PostBoard getInstance] engine_outside_postBoardManage_detail];
    
    UITapGestureRecognizer *resignFirstResponderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewResignFirstResponder)];
    resignFirstResponderTap.numberOfTapsRequired = 1;
    resignFirstResponderTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:resignFirstResponderTap];
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
        if(type == ut_postBoardManage_detail){
            for (int i = 0; i < [SharedData getInstance].postBoardNeedFull.needCompanyBenefits.count; i ++) {
                OperatorCodeInfo *oc = [[OperatorCodeInfo alloc] init];
                CompanyBenefitsInfo *cbi = [SharedData getInstance].postBoardNeedFull.needCompanyBenefits[i];
                oc.codeId = cbi.benefitsCode;
                oc.codeText = cbi.benefitsText;
                [_treatments addObject:oc];
            }
            [self updateContent];
        }else if (type == ut_operator_companyKind){
            [self chooseCompanyNature];
        }else if(type == ut_operator_companySize){
            [self chooseCompanyScale];
        }else if (type == ut_operator_companyBenefit){
            [self chooseWelfareAndTreatment];
        }else if(type == ut_postBoardManage_fillInfo){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        if(type == ut_postBoardManage_detail || type == ut_operator_companyKind || type == ut_operator_companySize || type == ut_operator_companyBenefit || type == ut_postBoardManage_fillInfo){
            [HUDUtil showErrorWithStatus:dict[@"msg"]];
        }
    }
}

#pragma mark -- 数据请求失败回调
-(void)handleUpdateFailureAction:(NSNotification *)noti{
    [HUDUtil showErrorWithStatus:@"数据加载失败"];
}

#pragma mark -- 更新界面内容
-(void)updateContent{
    self.tf_CompanyScale.text = [SharedData getInstance].postBoardNeedFull.needCompanySize;
    self.tf_CompanyNature.text = [SharedData getInstance].postBoardNeedFull.needCompanyKind;
    self.tf_PhoneNumber.text = [SharedData getInstance].postBoardNeedFull.needRecruitmentPhone;
    self.tf_Treatment.text =  [self textFromCompanyBenefitsList:[SharedData getInstance].postBoardNeedFull.needCompanyBenefits];
}

#pragma mark -- 输入框取消第一响应
-(void)textViewResignFirstResponder{
    [self.tf_PhoneNumber resignFirstResponder];
}

#pragma mark -- 检查输入完整
-(NSString *)checkInput{
    if(_tf_CompanyNature.text.length == 0 || _tf_CompanyScale.text.length == 0 || _tf_Treatment.text.length == 0){
        return @"请把招聘信息补充完整";
    }else if(self.tf_PhoneNumber.text.length < 5){
        return @"请填写正确的电话号码";
    }
    return nil;
}

//#pragma mark - 验证电话号码
//- (BOOL)isMobile:(NSString *)string {
//    NSString * regex = @"^[0-9]*$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isMatch = [pred evaluateWithObject:string];
//    if (!isMatch) {
//        return NO;
//    }
//    return YES;
//}

#pragma mark -- 保存
- (void)onMoveFoward:(UIButton*) sender{
    NSString *msg = [self checkInput];
    if(msg){
        [HUDUtil showErrorWithStatus:msg];
    }else{
        if([self checkChanged]){
            
            [[API_PostBoard getInstance] engine_outside_postBoardManage_fillInfoSize:[self selectedCompanyScale].codeId
                                                                                kind:[self selectedCompanyNature].codeId
                                                                            denefits:[self codeFromCodeList:_treatments]
                                                                               phone:self.tf_PhoneNumber.text];
        }
    }
}

#pragma mark -- 检查是否更改内容
- (BOOL)checkChanged{
    BOOL flag = NO;
    
    if(![self.tf_CompanyNature.text isEqualToString:[SharedData getInstance].postBoardNeedFull.needCompanyKind] ||
       ![self.tf_CompanyScale.text isEqualToString:[SharedData getInstance].postBoardNeedFull.needCompanySize] ||
       ![self.tf_PhoneNumber.text isEqualToString:[SharedData getInstance].postBoardNeedFull.needRecruitmentPhone] ||
       ![[self textFromCompanyBenefitsList:[SharedData getInstance].postBoardNeedFull.needCompanyBenefits] isEqualToString:[self textFromCodeList:_treatments]]){
        flag = YES;
    }
    
    return flag;
}


#pragma mark -- 返回
- (void)onMoveBack:(UIButton *)sender{
    [self.tf_PhoneNumber resignFirstResponder];
    
    BOOL inputFull = ([self checkInput] == nil ? YES : NO);
    BOOL contentChanged = [self checkChanged];
    
    if(inputFull && contentChanged){
        [self onMoveFoward:nil];
    }else if(!inputFull && contentChanged){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"招聘信息补充" message:@"招聘信息未补充完整，确认返回？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.tag = kBackToSureAlertViewTag;
        [alert show];
    }else{
       [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark -- 获取福利待遇所有文本
- (NSString *)textFromCompanyBenefitsList:(NSArray *)codeList{
    NSString *string = @"";
    for (int i = 0; i < codeList.count; i ++) {
        CompanyBenefitsInfo *cbi = codeList[i];
        if(i == 0){
            string = [NSString stringWithFormat:@"%@",cbi.benefitsText];
        }else{
            string = [NSString stringWithFormat:@"%@,%@",string,cbi.benefitsText];
        }
    }
    return string;
}

#pragma mark -- 获取字典所有文本
- (NSString *)textFromCodeList:(NSArray *)codeList{
    NSString *string = @"";
    for (int i = 0; i < codeList.count; i ++) {
        OperatorCodeInfo *oc = codeList[i];
        if(i == 0){
            string = [NSString stringWithFormat:@"%@",oc.codeText];
        }else{
            string = [NSString stringWithFormat:@"%@,%@",string,oc.codeText];
        }
    }
    return string;
}

#pragma mark -- 获取福利待遇所有Code
- (NSArray *)codeFromCodeList:(NSArray *)codeList{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < codeList.count; i++)
    {
        OperatorCodeInfo *oc = codeList[i];
        [items addObject:oc.codeId];
    }
    return items;
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

#pragma mark -- 获取字典对应ID
-(NSArray *)codeIdListFromCodeList:(NSArray *)codeList{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < codeList.count; i++)
    {
        OperatorCodeInfo *oc = codeList[i];
        [items addObject:oc.codeId];
    }
    return items;
}

#pragma mark -- 获取用户选中的公司性质
-(OperatorCodeInfo *)selectedCompanyNature{
    for (int i = 0; i < [SharedData getInstance].operatorCompanyKindCodeList.count; i ++) {
        OperatorCodeInfo *oc = [SharedData getInstance].operatorCompanyKindCodeList[i];
        if([oc.codeText isEqualToString:_tf_CompanyNature.text]){
            return oc;
        }
    }
    OperatorCodeInfo *oc = [[OperatorCodeInfo alloc] init];
    oc.codeId = [SharedData getInstance].postBoardNeedFull.needCompanyKindCode;
    return oc;
}

#pragma mark -- 选择公司性质
-(void)chooseCompanyNature{
    [self.tf_PhoneNumber resignFirstResponder];
    if([[SharedData getInstance].operatorCompanyKindCodeList count] != 0){
        [_dataPicker remove];
        _dataPicker = nil;
        _dataPicker = [[UI_PickerView alloc] initPickviewWithArray:[self dataPickerArrayFromCodeList:[SharedData getInstance].operatorCompanyKindCodeList] isHaveNavControler:NO];
        [_dataPicker setDelegate:self];
        _currentDataPickerUI = _tf_CompanyNature;
        [_dataPicker show];
    }else{
       [[API_PostBoard getInstance] engine_outside_operator_complayKind];
    }

}

#pragma mark -- 获取用户选中的公司规模
-(OperatorCodeInfo *)selectedCompanyScale{
    for (int i = 0; i < [SharedData getInstance].operatorCompanySizeCodeList.count; i ++) {
        OperatorCodeInfo *oc = [SharedData getInstance].operatorCompanySizeCodeList[i];
        if([oc.codeText isEqualToString:_tf_CompanyScale.text]){
            return oc;
        }
    }
    OperatorCodeInfo *oc = [[OperatorCodeInfo alloc] init];
    oc.codeId = [SharedData getInstance].postBoardNeedFull.needCompanySizeCode;
    return oc;
}

#pragma mark -- 选择公司规模
-(void)chooseCompanyScale{
    [self.tf_PhoneNumber resignFirstResponder];
    if([[SharedData getInstance].operatorCompanySizeCodeList count] != 0){
        [_dataPicker remove];
        _dataPicker = nil;
        _dataPicker = [[UI_PickerView alloc] initPickviewWithArray:[self dataPickerArrayFromCodeList:[SharedData getInstance].operatorCompanySizeCodeList] isHaveNavControler:NO];
        [_dataPicker setDelegate:self];
        _currentDataPickerUI = _tf_CompanyScale;
        [_dataPicker show];
    }else{
        [[API_PostBoard getInstance] engine_outside_operator_companySize];
    }
}

#pragma mark -- 选择公司福利待遇
-(void)chooseWelfareAndTreatment{
    [self.tf_PhoneNumber resignFirstResponder];
    if([[SharedData getInstance].operatorCompanyBenefitCodeList count] != 0){
        IWCompanyTreatmentViewController *iwctvc = [[IWCompanyTreatmentViewController alloc] init];
        NSArray *chooseItems = [self dataPickerArrayFromCodeList:[SharedData getInstance].operatorCompanyBenefitCodeList];
        iwctvc.chooseItems = [[NSMutableArray alloc] initWithArray:chooseItems];
        iwctvc.finished = ^(NSArray *items){
            [_treatments removeAllObjects];
            for (int i = 0; i < items.count; i ++) {
                NSIndexPath *indexPath = items[i];
                OperatorCodeInfo *oc = [SharedData getInstance].operatorCompanyBenefitCodeList[indexPath.row];
                [_treatments addObject:oc];
            }
            _tf_Treatment.text = [self textFromCodeList:_treatments];
        };
        
        iwctvc.selectedItems = [[NSMutableArray alloc] init];
        for (int i = 0; i < _treatments.count; i ++) {
            OperatorCodeInfo *oc = _treatments[i];
            if([iwctvc.chooseItems containsObject:oc.codeText]){
                [iwctvc.selectedItems addObject:[NSIndexPath indexPathForRow:[iwctvc.chooseItems indexOfObject:oc.codeText] inSection:0]];
            }
        }
        [self.navigationController pushViewController:iwctvc animated:YES];
    }else{
        [[API_PostBoard getInstance] engine_outside_operator_companyBenefit];
    }
    
}

#pragma mark -- uitextfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if([textField isEqual:_tf_CompanyScale]){
        [self chooseCompanyScale];
        return NO;
    }else if ([textField isEqual:_tf_CompanyNature]){
        [self chooseCompanyNature];
        return NO;
    }else if ([textField isEqual:_tf_Treatment]){
        [self chooseWelfareAndTreatment];
        return NO;
    }else if ([textField isEqual:_tf_PhoneNumber]){
        if(SCREENHEIGHT < 568.f){
            self.scrollView.contentOffset = CGPointMake(0, 60.f);
        }else{
            self.scrollView.contentOffset = CGPointMake(0, 50.f);
        }
        return YES;
    }
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

#pragma mark -- datapicker delegate
-(void)toobarDonBtnHaveClick:(UI_PickerView *)pickView resultString:(NSString *)resultString{
    if(_currentDataPickerUI == _tf_CompanyNature){
        [_tf_CompanyNature setText:resultString];
    }else if (_currentDataPickerUI == _tf_CompanyScale){
        [_tf_CompanyScale setText:resultString];
    }
}

#pragma mark -- uialertview delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == kBackToSureAlertViewTag){
        if(buttonIndex == 1){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
