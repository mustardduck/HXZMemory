//
//  IWPublishAttractBusinessViewController.m
//  miaozhuan
//
//  Created by admin on 15/4/29.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWPublishAttractBusinessViewController.h"
#import "PSTCollectionViewFlowLayout.h"
#import "PSTCollectionView.h"
#import "AddPictureCell.h"
#import "PreviewViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "EditImageViewController.h"
#import "IWTextInputViewController.h"
#import "IWAttractBusinessDetailViewController.h"
#import "IWMainDetail.h"
#import "IWCompanyIntroViewController.h"
#import "SharedData.h"
#import "UI_PickerView.h"
#import "UIImageView+WebCache.h"
#import "VIPPrivilegeViewController.h"

#define kActionSheetTag_BackWithSave 111
#define kAlertViewTag_SureToPublish 112
#define kAlertViewTag_GoldAmountNotEnough 113
#define kActionSheetViewTag_BrandLogo 114
#define kBuyVipAlertTag 115

@interface IWPublishAttractBusinessViewController ()<PSTCollectionViewDelegate,PSTCollectionViewDataSource,UIActionSheetDelegate,UITextFieldDelegate,UIAlertViewDelegate,UI_PickViewDelegate>{
    
    NSMutableArray *_ADPictureInfo;
    NSUInteger _currentADImageIndex;
    NSUInteger _deleteIndex;
    PictureInfo *_brandLogoPictureInfo;
    IWPublishAttactBusinessUploadImageType _uploadImageType;
    UIImage *_currentUploadImage;
    BOOL _needPopViewController;
    BOOL _needGetMoreGold;
    AttractBusinessInfo *_attractBusinessInfo;
    AttractBusinessInfo *_temp_attractBusinessInfo;
    NSUInteger _attractBusinessOnlineDayCount;
    UI_PickerView *_dataPicker;
    id _currentDataPickerUI;
    
    BOOL _saveFromOfflineAtFirst;
}

@property (retain, nonatomic) IBOutlet UIImageView *image_BrandLogo;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *button_Preview;
@property (retain, nonatomic) IBOutlet UIButton *button_Publish;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UITextField *tf_Title;
@property (retain, nonatomic) IBOutlet UITextField *tf_ProductBrand;
@property (retain, nonatomic) IBOutlet UITextField *tf_InvestMoney;
@property (retain, nonatomic) IBOutlet UITextField *tf_OfficialURL;
@property (retain, nonatomic) IBOutlet UITextField *tf_AttractBusinessRemark;

@property (retain, nonatomic) IBOutlet UIButton *radioButton_SevenDay;
@property (retain, nonatomic) IBOutlet UIButton *radioButton_HalfOfMonth;
@property (retain, nonatomic) IBOutlet UIButton *radioButton_AMonth;
@property (retain, nonatomic) IBOutlet UIButton *button_SevenDay;
@property (retain, nonatomic) IBOutlet UIButton *button_HalfOfMonth;
@property (retain, nonatomic) IBOutlet UIButton *button_AMonth;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_vertical_ADView_Bottom;
@property (retain, nonatomic) IBOutlet UIView *view_Radio;
@property (retain, nonatomic) IBOutlet UIView *view_AD;
@property (retain, nonatomic) IBOutlet UIView *view_Content;
@property (retain, nonatomic) PSTCollectionView *collectionview;
@property (retain, nonatomic) IBOutlet UIView *view_BrandLogo;
@property (retain, nonatomic) IBOutlet UIButton *button_AddLogo;

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

@implementation IWPublishAttractBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    InitNav(@"发布招商信息");
    
    [self setupMoveFowardButtonWithTitle:@"存入草稿"];
    
    self.view.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    
    self.scrollView.contentSize = CGSizeMake(0, self.contentView.height);
    
    _ADPictureInfo = [[NSMutableArray alloc] init];
    _brandLogoPictureInfo = [[PictureInfo alloc] init];
    _attractBusinessOnlineDayCount = 7;
    
    _uploadImageType = IWPublishAttactBusinessUploadImageType_AD;
    
    [self updateButton];
    [self setupImagePicker];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
    
    if(_publishAttractBuinessType == IWPublishAttractBusinessType_FromDraft || _publishAttractBuinessType == IWPublishAttractBusinessType_FromOffline){
        if(self.detailsId){
            [[API_PostBoard getInstance] engine_outside_postBoard_attractBusinessDetailsID:self.detailsId];
        }
    }
    
    if([SharedData getInstance].operatorInvestAmountCodeList.count == 0){
        [[API_PostBoard getInstance] engine_outside_operator_investAmount];
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

#pragma mark -- custom evnets
#pragma mark -- 数据请求成功回调
-(void)handleUpdateSuccessAction:(NSNotification *)noti{
    NSDictionary *dict = [noti userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    
    if(ret == 1){
        if(type == ut_attractBusinessManage_saveDraft){
            if(nil == _attractBusinessInfo){
                _attractBusinessInfo = [[AttractBusinessInfo alloc] init];
            }
            _attractBusinessInfo.attractBusinessId = [SharedData getInstance].attractBusinessDraft.attractBusinessId;
            _attractBusinessInfo.attractBusinessTitle = _temp_attractBusinessInfo.attractBusinessTitle;
            _attractBusinessInfo.attractBusinessBrand = _temp_attractBusinessInfo.attractBusinessBrand;
            _attractBusinessInfo.attractBusinessOfficialLink = _temp_attractBusinessInfo.attractBusinessOfficialLink;
            _attractBusinessInfo.attractBusinessInvestAmount = _temp_attractBusinessInfo.attractBusinessInvestAmount;
            _attractBusinessInfo.attractBusinessInvestAmountCode = _temp_attractBusinessInfo.attractBusinessInvestAmountCode;
            _attractBusinessInfo.attractBusinessDescription = _temp_attractBusinessInfo.attractBusinessDescription;
            _attractBusinessInfo.attractBusinessLogoPic = _temp_attractBusinessInfo.attractBusinessLogoPic;
            _attractBusinessInfo.attractBusinessPublicPics = _temp_attractBusinessInfo.attractBusinessPublicPics;
            _attractBusinessInfo.attractBusinessOnlineDayCount = _temp_attractBusinessInfo.attractBusinessOnlineDayCount;
            _attractBusinessInfo.attractBusinessStatus = _temp_attractBusinessInfo.attractBusinessStatus;
            _attractBusinessInfo.attractBusinessOfflineTime = _temp_attractBusinessInfo.attractBusinessOfflineTime;
            _attractBusinessInfo.attractBusinessPublishTime = _temp_attractBusinessInfo.attractBusinessPublishTime;
            _attractBusinessInfo.attractBusinessRefreshTime = _temp_attractBusinessInfo.attractBusinessRefreshTime;
            _attractBusinessInfo.attractBusinessAuditInfo = _temp_attractBusinessInfo.attractBusinessAuditInfo;
            
            _temp_attractBusinessInfo = nil;
            _publishAttractBuinessType = IWPublishAttractBusinessType_FromDraft;
            [HUDUtil showSuccessWithStatus:@"保存成功"];
            if(_needPopViewController){
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }else if(type == ut_attractBusinessManage_publish){
            [HUDUtil showSuccessWithStatus:@"发布成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else if(type == ut_postBoard_attractBusinessDetails){
            _attractBusinessInfo = [SharedData getInstance].postBoardAttractBusinessDetail.attractBusinessInfo;
            if(_attractBusinessInfo.attractBusinessOnlineDayCount != 15 && _attractBusinessInfo.attractBusinessOnlineDayCount != 30){
                _attractBusinessInfo.attractBusinessOnlineDayCount = 7;
            }
            if(_publishAttractBuinessType == IWPublishAttractBusinessType_FromOffline){
                _attractBusinessInfo.attractBusinessId = @"";
                _saveFromOfflineAtFirst = YES;
            }
            [self updateContentUI];
        }
    }else{
        if(type == ut_attractBusinessManage_saveDraft || type == ut_operator_investAmount || type == ut_attractBusinessManage_publish || type == ut_attractBusinessManage_details){
            [HUDUtil showErrorWithStatus:dict[@"msg"]];
        };
    }
}

#pragma mark -- 数据请求失败回调
-(void)handleUpdateFailureAction:(NSNotification *)noti{
    [HUDUtil showErrorWithStatus:@"数据加载失败"];
}

#pragma mark -- 更新内容视图
-(void)updateContentUI{
    self.tf_Title.text = _attractBusinessInfo.attractBusinessTitle;
    self.tf_ProductBrand.text = _attractBusinessInfo.attractBusinessBrand;
    self.tf_OfficialURL.text = _attractBusinessInfo.attractBusinessOfficialLink;
    self.tf_InvestMoney.text = _attractBusinessInfo.attractBusinessInvestAmount;
    self.tf_AttractBusinessRemark.text = _attractBusinessInfo.attractBusinessDescription;
    if(_attractBusinessInfo.attractBusinessPublicPics){
        _ADPictureInfo = [[NSMutableArray alloc] initWithArray:_attractBusinessInfo.attractBusinessPublicPics];
    }
    if(_attractBusinessInfo.attractBusinessLogoPic){
        _brandLogoPictureInfo = [[PictureInfo alloc] init];
        _brandLogoPictureInfo.pictureId = _attractBusinessInfo.attractBusinessLogoPic.pictureId;
        _brandLogoPictureInfo.pictureURL = _attractBusinessInfo.attractBusinessLogoPic.pictureURL;
        if(_brandLogoPictureInfo.pictureURL.length > 0){
            [_view_BrandLogo sendSubviewToBack:_button_AddLogo];
            [_image_BrandLogo setImageWithURL:[NSURL URLWithString:_brandLogoPictureInfo.pictureURL] placeholderImage:nil];
        }
    }
    
    [self updateScrollView];
    [_collectionview reloadData];
    if(_attractBusinessInfo.attractBusinessOnlineDayCount == 30){
        [self radioButtonClicked:_button_AMonth];
    }else if (_attractBusinessInfo.attractBusinessOnlineDayCount == 15){
        [self radioButtonClicked:_button_HalfOfMonth];
    }else{
        [self radioButtonClicked:_button_SevenDay];
    }
}

#pragma mark -- 检查是否更改内容
- (BOOL)checkChanged{
    if(_saveFromOfflineAtFirst){
        _saveFromOfflineAtFirst = NO;
        return YES;
    }
    BOOL flag = NO;
    
    
    if(nil == _attractBusinessInfo){
        if(_tf_Title.text.length != 0 ||
           _tf_ProductBrand.text.length != 0 ||
           _tf_OfficialURL.text.length != 0 ||
           _tf_InvestMoney.text.length != 0 ||
           _tf_AttractBusinessRemark.text.length != 0 ||
           _ADPictureInfo.count > 0 ||
           _brandLogoPictureInfo.pictureURL.length > 0 ||
           _attractBusinessOnlineDayCount != 7){
            flag = YES;
        }
    }else{
        if(![_attractBusinessInfo.attractBusinessTitle isEqualToString:_tf_Title.text]){
            if(_tf_Title.text.length > 0){
                flag = YES;
            }
        }
        if(![_attractBusinessInfo.attractBusinessBrand isEqualToString:_tf_ProductBrand.text]){
            if(_tf_ProductBrand.text.length > 0){
                flag = YES;
            }
        }
        if(![_attractBusinessInfo.attractBusinessOfficialLink isEqualToString:_tf_OfficialURL.text]){
            if(_tf_OfficialURL.text.length > 0){
                flag = YES;
            }
        }
        if(![_attractBusinessInfo.attractBusinessInvestAmount isEqualToString:_tf_InvestMoney.text]){
            if(_tf_InvestMoney.text.length > 0){
                flag = YES;
            }
        }
        if(![_attractBusinessInfo.attractBusinessDescription isEqualToString:_tf_AttractBusinessRemark.text]){
            if(_tf_AttractBusinessRemark.text.length > 0){
                flag = YES;
            }
        }
        if(_attractBusinessInfo.attractBusinessOnlineDayCount != _attractBusinessOnlineDayCount){
            flag = YES;
        }
        if(_attractBusinessInfo.attractBusinessPublicPics.count != _ADPictureInfo.count){
            flag = YES;
            goto finish;
        }else{
            for (int i = 0; i < _attractBusinessInfo.attractBusinessPublicPics.count; i ++) {
                PictureInfo *pi1 = _attractBusinessInfo.attractBusinessPublicPics[i];
                PictureInfo *pi2 = _ADPictureInfo[i];
                if(![pi1.pictureURL isEqualToString:pi2.pictureURL]){
                    flag = YES;
                    goto finish;
                }
            }
        }
        if(![_attractBusinessInfo.attractBusinessLogoPic.pictureURL isEqualToString:_brandLogoPictureInfo.pictureURL]){
            flag = YES;
        }
    }
    
finish:
    return flag;
}

#pragma mark -- 检查输入完整
-(NSString *)checkInput{
    if(_tf_Title.text.length == 0){
        return @"招商标题未填写";
    }else if(_tf_ProductBrand.text.length == 0){
        return @"招商品牌未填写";
    }else if(_tf_OfficialURL.text.length == 0){
        return @"官网链接未填写";
    }else if(_tf_InvestMoney.text.length == 0){
        return @"投资金额未选择";
    }else if(_tf_AttractBusinessRemark.text.length == 0){
        return @"招商说明未填写";
    }else if(_brandLogoPictureInfo.pictureURL.length == 0){
        return @"品牌LOGO未上传";
    }else if(_ADPictureInfo.count == 0){
        return @"宣传图片未上传";
    }
    return nil;
}

#pragma mark -- 初始化图片选择器
-(void)setupImagePicker{
    PSTCollectionViewFlowLayout *layout = [[PSTCollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 20.f;
    layout.minimumLineSpacing = 20.f;
    UIEdgeInsets insets = {.top = 0,.left = 20,.bottom = 20,.right = 20};
    layout.sectionInset = insets;
    
    _collectionview = [[PSTCollectionView alloc] initWithFrame:CGRectMake(0, 60, SCREENWIDTH, 120.f) collectionViewLayout:layout];
    _collectionview.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.scrollEnabled = NO;
    [_collectionview registerNib:[UINib nibWithNibName:@"AddPictureCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AddPictureCell"];
    
    [self.view_AD addSubview:_collectionview];
    
}

#pragma mark -- 返回
- (void)onMoveBack:(UIButton *)sender{
    
    BOOL contentChanged = [self checkChanged];
    
    if(contentChanged){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"是否保存到草稿箱" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存草稿" otherButtonTitles:@"不保存", nil];
        sheet.tag = kActionSheetTag_BackWithSave;
        [sheet showInView:self.view];
    }else{
        
        [UI_MANAGER.mainNavigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark -- 存入草稿
- (void)onMoveFoward:(UIButton*) sender{
    if([self checkChanged]){
        
        [self reloadAttractBusinessInfo];
        
        NSMutableArray *picIds = [[NSMutableArray alloc] init];
        for (int i = 0; i < _ADPictureInfo.count; i ++) {
            PictureInfo *pi = _ADPictureInfo[i];
            [picIds addObject:pi.pictureId];
        }
        
        [HUDUtil showWithStatus:@"正在保存..."];
        
        if(nil == [SharedData getInstance].attractBusinessDraft){
            [SharedData getInstance].attractBusinessDraft = [[AttractBusinessInfo alloc] init];
        }
        
        [[API_PostBoard getInstance] engine_outside_attractBusinessManage_saveDraft:_temp_attractBusinessInfo.attractBusinessId
                                                                              title:_temp_attractBusinessInfo.attractBusinessTitle
                                                                              brand:_temp_attractBusinessInfo.attractBusinessBrand
                                                                               link:_temp_attractBusinessInfo.attractBusinessOfficialLink
                                                                         investCode:_temp_attractBusinessInfo.attractBusinessInvestAmountCode
                                                                        description:_temp_attractBusinessInfo.attractBusinessDescription
                                                                               logo:_temp_attractBusinessInfo.attractBusinessLogoPic.pictureId
                                                                       publicImages:picIds
                                                                        onlineCount:_temp_attractBusinessInfo.attractBusinessOnlineDayCount];
    }else{
        [HUDUtil showErrorWithStatus:@"暂无可保存的内容"];
    }
}

#pragma mark -- 发布信息前检查
-(BOOL)checkBeforePublish{
    BOOL flag = NO;
    
    if([[SharedData getInstance] attractBusinessManageInfo].businessTodayRestCount < 1){
        if([SharedData getInstance].personalInfo.userIsEnterpriseVip){
            [HUDUtil showErrorWithStatus:[NSString stringWithFormat:@"今天已经发布了%d条",[[SharedData getInstance] attractBusinessManageInfo].businessVipPublishCount]];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发布限制" message:[NSString stringWithFormat:@"已发布%d条信息，是否获取更多条数",[[SharedData getInstance] attractBusinessManageInfo].businessNormalPublishCount] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"去购买", nil];
            alert.tag = kBuyVipAlertTag;
            [alert show];
        }
    }else{
        flag = YES;
    }
    
    
    return flag;
}

#pragma mark -- 发布招商信息
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
            
            if([SharedData getInstance].attractBusinessManageInfo.businessCurrentGoldAmount < [SharedData getInstance].attractBusinessManageInfo.businessPublishGoldCount){
                msg = [NSString stringWithFormat:@"发布广告所需金币：%d金币\n当前金币余额：%d金币",[SharedData getInstance].attractBusinessManageInfo.businessPublishGoldCount,(int)[SharedData getInstance].attractBusinessManageInfo.businessCurrentGoldAmount];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"金币不足" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存并去赚金币", nil];
                alert.tag = kAlertViewTag_GoldAmountNotEnough;
                [alert show];
            }else{
                [self reloadAttractBusinessInfo];
                
                NSMutableArray *picIds = [[NSMutableArray alloc] init];
                for (int i = 0; i < _ADPictureInfo.count; i ++) {
                    PictureInfo *pi = _ADPictureInfo[i];
                    [picIds addObject:pi.pictureId];
                }
                
                [HUDUtil showWithStatus:@"正在发布..."];
                
                [[API_PostBoard getInstance] engine_outside_attractBusinessManage_publish:_temp_attractBusinessInfo.attractBusinessId
                                                                                      title:_temp_attractBusinessInfo.attractBusinessTitle
                                                                                      brand:_temp_attractBusinessInfo.attractBusinessBrand
                                                                                       link:_temp_attractBusinessInfo.attractBusinessOfficialLink
                                                                                 investCode:_temp_attractBusinessInfo.attractBusinessInvestAmountCode
                                                                                description:_temp_attractBusinessInfo.attractBusinessDescription
                                                                                       logo:_temp_attractBusinessInfo.attractBusinessLogoPic.pictureId
                                                                               publicImages:picIds
                                                                                onlineCount:_temp_attractBusinessInfo.attractBusinessOnlineDayCount];
            }
        }
    }

}

#pragma mark -- 预览招商信息
- (IBAction)preview:(id)sender {
    
    IWMainDetail *detailVC = [[IWMainDetail alloc] init];
    detailVC.isDraft = YES;
    IWAttractBusinessDetailViewController *iwabdvc = [[IWAttractBusinessDetailViewController alloc] init];
    [self reloadAttractBusinessInfo];
    iwabdvc.detailType = IWAttractBusinessDetailType_PreView;
    iwabdvc.attractBusinessInfo = _temp_attractBusinessInfo;
    
    IWCompanyIntroViewController *iwcivc = [[IWCompanyIntroViewController alloc] init];
    detailVC.navTitle = @"招商信息标题";
    iwcivc.isDraft = YES;
    iwcivc.postBoardType = kPostBoardAttractBusiness;
    detailVC.viewControllers = @[iwabdvc,iwcivc];
    detailVC.viewControllersTitle = @[@"详情展示",@"企业简介"];
    
    [self.navigationController pushViewController:detailVC animated:YES];
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

#pragma mark -- 装载当前的招商信息
-(void)reloadAttractBusinessInfo{
    _temp_attractBusinessInfo = [[AttractBusinessInfo alloc] init];
    if(_publishAttractBuinessType == IWPublishAttractBusinessType_FromDraft){
        _temp_attractBusinessInfo.attractBusinessId = _attractBusinessInfo.attractBusinessId;
    }else{
        _temp_attractBusinessInfo.attractBusinessId = @"";
    }
    _temp_attractBusinessInfo.attractBusinessTitle = self.tf_Title.text.length > 0 ? self.tf_Title.text : @"";
    _temp_attractBusinessInfo.attractBusinessBrand = self.tf_ProductBrand.text.length > 0 ? self.tf_ProductBrand.text : @"";
    _temp_attractBusinessInfo.attractBusinessOfficialLink = self.tf_OfficialURL.text.length > 0 ? self.tf_OfficialURL.text : @"";
    OperatorCodeInfo *codeInfo = [self codeInfoFromCodeList:[SharedData getInstance].operatorInvestAmountCodeList WithCodeText:_tf_InvestMoney.text];
    _temp_attractBusinessInfo.attractBusinessInvestAmountCode = (codeInfo ? codeInfo.codeId : @"");
    _temp_attractBusinessInfo.attractBusinessInvestAmount = (codeInfo ? codeInfo.codeText : @"");
    _temp_attractBusinessInfo.attractBusinessDescription = self.tf_AttractBusinessRemark.text.length > 0 ? self.tf_AttractBusinessRemark.text : @"";
    _temp_attractBusinessInfo.attractBusinessOnlineDayCount = _attractBusinessOnlineDayCount;
    _temp_attractBusinessInfo.attractBusinessLogoPic = _brandLogoPictureInfo;
    if(_temp_attractBusinessInfo.attractBusinessLogoPic.pictureId.length <= 0){
        _temp_attractBusinessInfo.attractBusinessLogoPic.pictureId = @"";
        _temp_attractBusinessInfo.attractBusinessLogoPic.pictureURL = @"";
    }
    
    _temp_attractBusinessInfo.attractBusinessPublicPics = [[NSMutableArray alloc] initWithArray:_ADPictureInfo];
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

#pragma mark -- 添加品牌logo
- (IBAction)addBrandLogo:(id)sender {
    
    
    UIActionSheet *sheet = nil;
    if(_brandLogoPictureInfo.pictureURL.length > 0){
        sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"预览" otherButtonTitles:@"相机拍摄", @"从相册中选择", @"删除", nil];
        [sheet showInView:self.view];
    }else{
        sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机拍摄" otherButtonTitles:@"从相册中选择", nil];
    }
    _uploadImageType = IWPublishAttactBusinessUploadImageType_BrandLogo;
    sheet.tag = kActionSheetViewTag_BrandLogo;
    [sheet showInView:self.view];
}

#pragma mark -- 选择投资资金
-(void)chooseInverMoney{
    [_dataPicker remove];
    _dataPicker = nil;
    _dataPicker = [[UI_PickerView alloc] initPickviewWithArray:[self dataPickerArrayFromCodeList:[SharedData getInstance].operatorInvestAmountCodeList] isHaveNavControler:NO];
    _currentDataPickerUI = _tf_InvestMoney;
    [_dataPicker setDelegate:self];
    [_dataPicker show];
}

#pragma mark -- 更新scrollview内容
- (void)updateScrollView {
    self.view_AD.translatesAutoresizingMaskIntoConstraints = YES;//允许在自动布局下改变frame
    self.view_Radio.translatesAutoresizingMaskIntoConstraints = YES;
    
    NSInteger count = _ADPictureInfo.count + 1;
    NSInteger row = (count % 3) ? (count / 3 + 1) : count / 3;
    float height = row * (115 + 20);
    
    _collectionview.height = height;
    
    //计算高度
    _view_AD.height = _collectionview.bottom;
    _view_Radio.top = _view_AD.bottom;
    
    
    CGRect frame = self.view_AD.frame;
    CGRect frame1 = self.view_Radio.frame;
    
    [self.view_AD removeFromSuperview];
    [self.view_AD setFrame:frame];
    self.view_AD.top = self.view_BrandLogo.bottom + self.view_Content.top;
    [self.scrollView addSubview:self.view_AD];
    
    [self.view_Radio removeFromSuperview];
    [self.view_Radio setFrame:frame1];
    self.view_Radio.top = self.view_AD.bottom;
    [self.scrollView addSubview:self.view_Radio];
    
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH, _view_Radio.bottom + self.view_Content.top);
}

#pragma mark -- 添加宣传图片
- (void)clickImage:(UIButton *)button{
    [self.view endEditing:YES];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机拍摄" otherButtonTitles:@"从相册中选择", nil];
    _currentADImageIndex = _ADPictureInfo.count;
    [sheet showInView:self.view];
}

- (void)passImage:(UIImage *)image
{
    _currentUploadImage = image;
    ADAPI_Picture_Upload([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleUploadPic:)], UIImagePNGRepresentation(image));
}

//上传图片
- (void)handleUploadPic:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed) {
        NSLog(@"%@",dic.data);
        NSString *url = [dic.data getString:@"PictureUrl"];
        NSString *pid = [dic.data getString:@"PictureId"];
        if (!url) {
            return;
        }
        PictureInfo *pi = [[PictureInfo alloc] init];
        pi.pictureId = pid;
        pi.pictureURL = url;
        
        if(_uploadImageType == IWPublishAttactBusinessUploadImageType_BrandLogo){
            [self.image_BrandLogo setImage:_currentUploadImage];
            _brandLogoPictureInfo = pi;
            _uploadImageType = IWPublishAttactBusinessUploadImageType_AD;
            [_view_BrandLogo sendSubviewToBack:_button_AddLogo];
        }else{
            if(_ADPictureInfo.count > _currentADImageIndex){
                [_ADPictureInfo replaceObjectAtIndex:_currentADImageIndex withObject:pi];
            }else{
                [_ADPictureInfo addObject:pi];
            }
            
            [self updateScrollView];
            
            [_collectionview reloadData];
        }
        
        
    } else {
        NSLog(@"%@",dic.operationMessage);
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        
    }
    _currentUploadImage = nil;
}

#pragma mark -- 单选选择（信息有效期）
- (IBAction)radioButtonClicked:(id)sender {
    UIImage *normalImage = [UIImage imageNamed:@"radioButton_off.png"];
    UIImage *highlightedImage = [UIImage imageNamed:@"radioButton_on.png"];
    
    [_radioButton_SevenDay setImage:normalImage forState:UIControlStateNormal];
    [_radioButton_HalfOfMonth setImage:normalImage forState:UIControlStateNormal];
    [_radioButton_AMonth setImage:normalImage forState:UIControlStateNormal];
    
    if([sender isEqual:_button_SevenDay]){
        _attractBusinessOnlineDayCount = 7;
        [_radioButton_SevenDay setImage:highlightedImage forState:UIControlStateNormal];
    }else if ([sender isEqual:_button_HalfOfMonth]){
        _attractBusinessOnlineDayCount = 15;
        [_radioButton_HalfOfMonth setImage:highlightedImage forState:UIControlStateNormal];
    }else if ([sender isEqual:_button_AMonth]){
        _attractBusinessOnlineDayCount = 30;
        [_radioButton_AMonth setImage:highlightedImage forState:UIControlStateNormal];
    }
}

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
    image = [UIImage imageNamed:@"addLogo"];
    [self.button_AddLogo setBackgroundImage:image forState:UIControlStateNormal];
    
    image = [UIImage imageNamed:@"ads_invatehover"];
    [self.button_Publish setBackgroundImage:image forState:UIControlStateHighlighted];
    image = [UIImage imageNamed:@"ads_buyhover"];
    [self.button_Preview setBackgroundImage:image forState:UIControlStateHighlighted];
    image = [UIImage imageNamed:@"addLogohover"];
    [self.button_AddLogo setBackgroundImage:image forState:UIControlStateHighlighted];    
    
    self.button_Preview.layer.cornerRadius = 5.f;
    self.button_Publish.layer.cornerRadius = 5.f;
    
    self.button_Preview.layer.masksToBounds = YES;
}

#pragma mark - collectionview delegate / datasource
- (NSInteger)collectionView:(PSTCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _ADPictureInfo.count >= 5 ? 5 : _ADPictureInfo.count + 1;
}

- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddPictureCell" forIndexPath:indexPath];
    if (indexPath.row == _ADPictureInfo.count && _ADPictureInfo.count != 5) {
        cell.imageView.hidden = YES;
        cell.btnAdd.hidden = NO;
        [cell.btnAdd addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        cell.btnAdd.hidden = YES;
        cell.imageView.hidden = NO;
        [cell.imageView setRoundCorner:0.f withBorderColor:AppColorLightGray204];
        [cell.imageView requestWithRecommandSize:((PictureInfo *)_ADPictureInfo[indexPath.row]).pictureURL];
    }
    return cell;
}

- (CGSize)collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 120);
}

- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"预览" otherButtonTitles:@"相机拍摄", @"从相册中选择", @"删除", nil];
    sheet.tag = indexPath.row + 1000;
    _currentADImageIndex = indexPath.row;
    [sheet showInView:self.view];
    
}

#pragma mark - uiacrionshee delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    _deleteIndex = -1;
    if (actionSheet.tag >= 1000) {
        if (buttonIndex == 0) {
            
            NSMutableArray *items = [[NSMutableArray alloc] init];
            for (int i = 0; i < _ADPictureInfo.count; i ++) {
                PictureInfo *pi = _ADPictureInfo[i];
                [items addObject:@{@"PictureUrl":pi.pictureURL}];
            }
            //预览
            PreviewViewController *preview = [[PreviewViewController alloc] init];
            preview.dataArray = items;
            preview.currentPage = actionSheet.tag - 1000;
            [self presentViewController:preview animated:NO completion:^{
                //                preview.pageControl.hidden = YES;
            }];
        } else if (buttonIndex == 1) {
            [UICommon showCamera:self view:self allowsEditing:NO];
        } else if (buttonIndex == 2) {
            [UICommon showImagePicker:self view:self];
        } else if (buttonIndex == 3){
            
            //删除
            _deleteIndex = actionSheet.tag - 1000;
            [_ADPictureInfo removeObjectAtIndex:(long)_deleteIndex];
            
            [self updateScrollView];
            [_collectionview reloadData];
        }
        
    } else if (actionSheet.tag == kActionSheetTag_BackWithSave) {
        if (buttonIndex == 0) {
            _needPopViewController = YES;
            [self onMoveFoward:nil];
            
        } else if (buttonIndex == 1){
            [UI_MANAGER.mainNavigationController popViewControllerAnimated:YES];
        }
        
    } else {
        if (buttonIndex == 0) {
            if(_brandLogoPictureInfo.pictureURL.length > 0 && actionSheet.tag == kActionSheetViewTag_BrandLogo){
                    PreviewViewController *preview = [[PreviewViewController alloc] init];
                    preview.dataArray = @[@{@"PictureUrl":_brandLogoPictureInfo.pictureURL}];
                    preview.currentPage = 0;
                    [self presentViewController:preview animated:NO completion:^{
                        //                preview.pageControl.hidden = YES;
                    }];
            }else{
                
                [UICommon showCamera:self view:self allowsEditing:YES];
            }
        } else if (buttonIndex == 1) {
            if(_brandLogoPictureInfo.pictureURL.length > 0 && actionSheet.tag == kActionSheetViewTag_BrandLogo){
                [UICommon showCamera:self view:self allowsEditing:YES];
            }else{
                [UICommon showImagePicker:self view:self];
            }
            
        }else if (buttonIndex == 2) {
            if(_brandLogoPictureInfo.pictureURL.length > 0 && actionSheet.tag == kActionSheetViewTag_BrandLogo){
                
                [UICommon showImagePicker:self view:self];
            }else if(actionSheet.tag == kActionSheetViewTag_BrandLogo){
                _uploadImageType = IWPublishAttactBusinessUploadImageType_AD;
            }
        }else if (buttonIndex == 3){
            if(_brandLogoPictureInfo.pictureURL.length > 0 && actionSheet.tag == kActionSheetViewTag_BrandLogo){
                _brandLogoPictureInfo.pictureURL = @"";
                _brandLogoPictureInfo.pictureId = @"";
                [_view_BrandLogo bringSubviewToFront:_button_AddLogo];
                [self.image_BrandLogo setImage:[UIImage imageNamed:@"addLogo.png"]];
            }
            
            
        }else if(buttonIndex == 4 && actionSheet.tag == kActionSheetViewTag_BrandLogo){
            _uploadImageType = IWPublishAttactBusinessUploadImageType_AD;
        }
    }
}


#pragma mark - uiimagepicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@",info);
    UIImage *temp = [[info wrapper] get:UIImagePickerControllerEditedImage];
    if (!temp) {
        temp = [[info wrapper] get:UIImagePickerControllerOriginalImage];
    }
    
    NSURL *assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    __block typeof(self) weakself = self;
    [library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
        UIImage *preview = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
        
        EditImageType editImageType = EditImageTypeAdertPic;
        if(_uploadImageType == IWPublishAttactBusinessUploadImageType_BrandLogo){
            editImageType = EditImageType800;
        }
        
        EditImageViewController *imageEditor = [[EditImageViewController alloc ] initWithNibName:@"EditImageViewController" bundle:nil ImgType:editImageType];
        imageEditor.rotateEnabled = NO;
        imageEditor.doneCallback = ^(UIImage *editedImage, BOOL canceled){
            if(!canceled) {
                [weakself passImage:editedImage];
            }
            [picker setNavigationBarHidden:NO animated:NO];
            [weakself dismissViewControllerAnimated:YES completion:nil];
        };
        
        imageEditor.sourceImage = temp;
        imageEditor.previewImage = preview;
        [imageEditor reset:NO];
        
        
        [picker pushViewController:imageEditor animated:YES];
        [picker setNavigationBarHidden:YES animated:NO];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Failed to get asset from library");
    }];
}

#pragma mark -- uitextfield delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if([textField isEqual:_tf_AttractBusinessRemark]){
        IWTextInputViewController *iwtivc = [[IWTextInputViewController alloc] init];
        iwtivc.inputType = IWTextInputContent;
        [iwtivc setInputFinished:^(NSString *text){
            _tf_AttractBusinessRemark.text = text;
        }];
        iwtivc.value = _tf_AttractBusinessRemark.text;
        [iwtivc setTextInputAlert:@{@"alert_title":@"招商说明",@"alert_textMinLength":@10,@"alert_textLength":@1000,@"alert_minLength":@10,@"alert_demo":@"代理优势：\n6套出授权，团队培训，手把手教你怎么营销​‌‌，广告知名度高，三个月卖不出去，无条件退货！就是这么牛！\n咨询微信：18010128195\n当前微商状况：\n韩束洗礼微商，重磅打造良性微商生态圈。为强势领军品牌力创“快乐微商，无忧代理”，韩束经过无数次内测、演练、调整直到最终确定，全力改革，只是为了能够最大利益化保障微商无忧代理，力作不囤货、人走货清的形式，并连续重金布置、打造品牌的耐久开展动力，共享韩束至臻动能肌秘面膜的无穷商机，推翻微商年代。\n前景展望：\n韩束，踏浪而来，洗涤微商，正式开启微商新年代。",@"alert_placeholder":@"请输入内容简介"}];
        [self.navigationController pushViewController:iwtivc animated:YES];
    }else if ([textField isEqual:_tf_InvestMoney]){
        [self chooseInverMoney];
    }else if ([textField isEqual:_tf_OfficialURL]){
        IWTextInputViewController *iwtivc = [[IWTextInputViewController alloc] init];
        iwtivc.inputType = IWTextInputAttractWebSite;
        [iwtivc setInputFinished:^(NSString *text){
            _tf_OfficialURL.text = text;
        }];
        iwtivc.value = _tf_OfficialURL.text;
        [iwtivc setTextInputAlert:@{@"alert_title":@"官网链接",@"alert_textMinLength":@10,@"alert_textLength":@40,@"alert_minLength":@10,@"alert_demo":@"",@"alert_placeholder":@"请填写有关招商信息，更具体的网址链接！"}];
        [self.navigationController pushViewController:iwtivc animated:YES];
    }else if ([textField isEqual:_tf_ProductBrand]){
        IWTextInputViewController *iwtivc = [[IWTextInputViewController alloc] init];
        iwtivc.inputType = IWTextInputAttractBrand;
        [iwtivc setInputFinished:^(NSString *text){
            _tf_ProductBrand.text = text;
        }];
        iwtivc.value = _tf_ProductBrand.text;
        [iwtivc setTextInputAlert:@{@"alert_title":@"招商品牌",@"alert_textMinLength":@2,@"alert_textLength":@20,@"alert_minLength":@2,@"alert_demo":@"例如：本草相宜",@"alert_placeholder":@"请输入招商品牌"}];
        [self.navigationController pushViewController:iwtivc animated:YES];
    }else if ([textField isEqual:_tf_Title]){
        IWTextInputViewController *iwtivc = [[IWTextInputViewController alloc] init];
        iwtivc.inputType = IWTextInputTitle;
        [iwtivc setInputFinished:^(NSString *text){
            _tf_Title.text = text;
        }];
        iwtivc.value = _tf_Title.text;
        [iwtivc setTextInputAlert:@{@"alert_title":@"招商标题",@"alert_textMinLength":@10,@"alert_textLength":@40,@"alert_minLength":@10,@"alert_demo":@"例如：重庆小面加盟，小面培训，正宗重庆麻辣小面",@"alert_placeholder":@"请输入招商标题"}];
        [self.navigationController pushViewController:iwtivc animated:YES];
    }
    return NO;
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

#pragma mark -- datapicker delegate
-(void)toobarDonBtnHaveClick:(UI_PickerView *)pickView resultString:(NSString *)resultString{
    if(_currentDataPickerUI == _tf_InvestMoney){
        [_tf_InvestMoney setText:resultString];
    }
}


@end
