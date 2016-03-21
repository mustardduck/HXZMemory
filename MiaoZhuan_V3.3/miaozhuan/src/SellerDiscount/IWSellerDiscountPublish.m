//
//  SellerDiscountPublish.m
//  miaozhuan
//
//  Created by luo on 15/4/21.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWSellerDiscountPublish.h"
#import "PSTCollectionView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CollectionReusableView.h"
#import "AddPictureCell.h"
#import "RRAttributedString.h"
#import "PreviewViewController.h"
#import "EditImageViewController.h"
#import "UIView+expanded.h"
#import "DatePickerViewController.h"
#import "IWTextInputViewController.h"

#import "API_PostBoard.h"
#import "SharedData.h"
#import "HUDUtil.h"
#import "IWMainDetail.h"
#import "SellerDiscountDetail.h"
#import "IWCompanyIntroViewController.h"
#import "Model_PostBoard.h"
#import "GetMoreGoldViewController.h"


typedef NS_ENUM(NSInteger, IWSellerDiscountPublishAlertViewTag){
    
    /** not enough */ kIWSellerDiscountPublishAlertViewGoldNotEnough,
    /** enough     */ kIWSellerDiscountPublishAlertViewGoldEnough,
    
};


@interface IWSellerDiscountPublish ()<PSTCollectionViewDataSource, PSTCollectionViewDelegate, PSTCollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate,UIActionSheetDelegate, UIAlertViewDelegate,DatePickerDelegate>
{
    PSTCollectionView *_collectionview;
    BOOL _isBack;
    NSInteger _deleteIndex;
    NSInteger _currentItem;//选择的某个图片
    
    DatePickerViewController * _datePickerView;
    
    BOOL _isEarnGold;  //   是否点击赚取更多金币
    BOOL _isSaveDraftSuccess; //是否草稿发布成功
    BOOL _isEditDraftInfo;      //是否编辑过草稿
}


@property (retain,nonatomic) PreviewViewController *preview;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollViewMain;

@property (retain, nonatomic) IBOutlet UIView *viewTop;
@property (retain, nonatomic) IBOutlet UIView *viewBottom;
@property (retain, nonatomic) IBOutlet UILabel *lableInputTitle;
@property (retain, nonatomic) IBOutlet UILabel *lableInputContent;


//@property (nonatomic, retain) NSMutableArray *pickedUrls; //宣传图片
//@property (nonatomic, retain) NSMutableArray *pickedIds;


@property (retain, nonatomic) IBOutlet UIImageView *imageViewCertificate0;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewCertificate1;
@property (retain, nonatomic) UIButton * buttonCertificate;

@property (retain, nonatomic) IBOutlet UILabel *lableCertificate0;
@property (retain, nonatomic) IBOutlet UILabel *lableCertificate1;
@property (retain, nonatomic) IBOutlet UIButton *buttonCertificateUpload;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewLineCertificate;



@property (retain, nonatomic) IBOutlet UIImageView *imageViewTime0;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewTime1;
@property (retain, nonatomic) UIButton * buttonTime;

@property (retain, nonatomic) IBOutlet UILabel *lableTime0;
@property (retain, nonatomic) IBOutlet UIView *lableTime1;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewLineTime;

@property (retain, nonatomic)  DiscountInfo *discountDraft; //草稿箱



@property (retain, nonatomic) IBOutlet UIImageView *imageViewValid7;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewValid15;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewValid30;

@property (retain, nonatomic) IBOutlet UIButton *buttonValid7;
@property (retain, nonatomic) IBOutlet UIButton *buttonValid15;
@property (retain, nonatomic) IBOutlet UIButton *buttonValid30;
@property (retain, nonatomic) UIButton * buttonValid;

@property (retain, nonatomic) IBOutlet UIView *viewBotton0; //高度差距85
@property (retain, nonatomic) IBOutlet UIView *viewBotton1; //高度差距25
@property (retain, nonatomic) IBOutlet UIView *viewBotton2;

@property (retain, nonatomic) IBOutlet UIButton *startDateBtn;
@property (retain, nonatomic) IBOutlet UIButton *endDateBtn;


//datepicker

@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;


//inputContent
//@property (nonatomic, retain) NSString * inputTitle;        //优惠标题
//@property (nonatomic, retain) NSString * inputContent;      //优惠说明
//@property (nonatomic, retain) NSMutableArray * inputPublicUrls; //宣传图片
//@property (nonatomic, retain) PictureInfo * inputCertificate; //凭证


@end

@implementation IWSellerDiscountPublish

MTA_viewDidAppear()
MTA_viewDidDisappear()

- (void)viewDidLoad {
    [super viewDidLoad];
 
//    self.inputPublicUrls = [[NSMutableArray alloc] init];
    _currentItem = -1;
    _deleteIndex = -1;
    _isEarnGold = NO;
    _isSaveDraftSuccess = NO;
    _isEditDraftInfo = NO;
    
    self.startDate = [NSDate date];
    [_startDateBtn setTitle:[UICommon usaulFormatTime:self.startDate formatStyle:@"yyyy-MM-dd"] forState:UIControlStateNormal];
    
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60 * 7;
    self.endDate = [ self.startDate dateByAddingTimeInterval: secondsPerDay];
    [_endDateBtn setTitle:[UICommon usaulFormatTime:self.endDate formatStyle:@"yyyy-MM-dd"] forState:UIControlStateNormal];
    
    
    InitNav(@"发布优惠信息");
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"存入草稿"];
    
    [self setupUI];


    if(self.discountDraft == nil){
        self.discountDraft = [[DiscountInfo alloc] init];
        [SharedData getInstance].discountDraft = self.discountDraft;
    }
    
    if(self.isDraft){
        [[API_PostBoard getInstance] engine_outside_discountManage_detailsId:self.draftID];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
}
- (void) onMoveBack:(UIButton*) sender{
    if (_discountDraft.discountTitle.length == 0 && _discountDraft.discountContent.length == 0 && [_discountDraft.discountPublicPics count] == 0 && _discountDraft.discountVoucherPic == nil) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        if (_isSaveDraftSuccess) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        if (_isEditDraftInfo) {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"是否保存到草稿箱" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle: @"保存草稿"otherButtonTitles:@"不保存", nil];
            sheet.tag = 10001;
            [sheet showInView:self.view];
            return;
        }
        [self.navigationController popViewControllerAnimated:YES];  
    }
}
- (void)handleUpdateSuccessAction:(NSNotification *)note
{
    
    NSDictionary *dict = [note userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    
    if(type == ut_discountManage_saveDraft)
    {
        if(ret == 1)
        {
            _isSaveDraftSuccess = YES;
            [HUDUtil showSuccessWithStatus:@"保存草稿成功"];
            
//            if (!_isEarnGold){
//                [self.navigationController popViewControllerAnimated:YES];
//            }
        }else{
            [HUDUtil showSuccessWithStatus:dict[@"msg"]];
        }
    }else if (type == ut_discountManage_publish){
        if(ret == 1)
        {
            DiscountManageInfo *obj = [SharedData getInstance].discountManageInfo;
            obj.discountTodayRestCount--;
            obj.discountCurrentGoldAmount = obj.discountCurrentGoldAmount - obj.discountPublishGoldCount;
            
            [HUDUtil showSuccessWithStatus:@"优惠信息发布成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [HUDUtil showSuccessWithStatus:dict[@"msg"]];
        }
    }else if (type == ut_discountManage_details){  //草稿跳转的详情
        if (ret == 1) {
            _discountDraft  = [SharedData getInstance].discountDetailInfo;
//            _inputTitle = _discountDraft.discountTitle;
            _lableInputTitle.text = _discountDraft.discountTitle;
//            _inputContent = _discountDraft.discountContent;
            _lableInputContent.text = _discountDraft.discountContent;
//            _inputPublicUrls = _discountDraft.discountPublicPics;
            [_collectionview reloadData];
            
            [self countHeight];
            
            //处理凭证
            if (_discountDraft.discountIsNeedVoucher) {
                if(H(self.viewBotton0) != 150){
                    self.viewBotton0.frameHeight = 150;
                    self.imageViewLineCertificate.frameY = 149;
                    self.viewBotton1.frameY = Y(self.viewBotton1) + 85;
                    self.viewBotton2.frameY = Y(self.viewBotton2) + 85;
                    
                    self.lableCertificate0.hidden = YES;
                    self.lableCertificate1.hidden = NO;
                    self.buttonCertificateUpload.hidden = NO;
                    self.imageViewCertificate0.image = [UIImage imageNamed:@"rank-02"];
                    self.imageViewCertificate1.image = [UIImage imageNamed:@"rank-03"];
                    
                }
                
//                self.inputCertificate = _discountDraft.discountVoucherPic;
                
                [_buttonCertificateUpload setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_discountDraft.discountVoucherPic.pictureURL]]] forState:UIControlStateNormal];
            }
            
            //处理优惠
            if (_discountDraft.discountHasDiscountDate){
                self.buttonTime = self.endDateBtn;
                self.imageViewTime0.image = [UIImage imageNamed:@"rank-02"];
                self.imageViewTime1.image = [UIImage imageNamed:@"rank-03"];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
                self.startDate = [dateFormatter dateFromString:[_discountDraft.discountDiscountStartDate stringByReplacingOccurrencesOfString:@"T" withString:@" "]];
                self.endDate = [dateFormatter dateFromString:[_discountDraft.discountDiscountEndDate stringByReplacingOccurrencesOfString:@"T" withString:@" "]];
                
                [self.startDateBtn  setTitle:[_discountDraft.discountDiscountStartDate substringToIndex:10] forState:UIControlStateNormal];
                [self.endDateBtn setTitle:[_discountDraft.discountDiscountEndDate substringToIndex:10] forState:UIControlStateNormal];
                self.lableTime0.hidden = YES;
                self.lableTime1.hidden = NO;
            }
            
            //处理有效期
            
            if(_discountDraft.discountOnlineDayCount ==7){
                _imageViewValid7.image = [UIImage imageNamed:@"rank-03"];
                 _imageViewValid15.image = [UIImage imageNamed:@"rank-02"];
                _imageViewValid30.image = [UIImage imageNamed:@"rank-02"];
                _buttonValid = _buttonValid7;
            }else if (_discountDraft.discountOnlineDayCount == 15){
                _imageViewValid7.image = [UIImage imageNamed:@"rank-02"];
                _imageViewValid15.image = [UIImage imageNamed:@"rank-03"];
                _imageViewValid30.image = [UIImage imageNamed:@"rank-02"];
                _buttonValid = _buttonValid15;
            }else if (_discountDraft.discountOnlineDayCount == 30){
                _imageViewValid7.image = [UIImage imageNamed:@"rank-02"];
                _imageViewValid15.image = [UIImage imageNamed:@"rank-02"];
                _imageViewValid30.image = [UIImage imageNamed:@"rank-03"];
                _buttonValid = _buttonValid30;
            
            }
            
        }
    }
}

-(void) handleUpdateFailureAction:(NSNotification *) note{
    
    NSDictionary *dict = [note userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    if(type == ut_discountManage_saveDraft)
    {
        [HUDUtil showErrorWithStatus:@"保存失败，请重试"];
    } else if (type == ut_discountManage_publish){
        [HUDUtil showErrorWithStatus:@"保存失败，请重试"];
    }
    
}
-(void) onMoveFoward:(UIButton *) sender{
    [self saveDraftValue];
    
    if (_discountDraft.discountTitle.length == 0 && _discountDraft.discountContent.length == 0 &&  [_discountDraft.discountPublicPics count] == 0 && _discountDraft.discountVoucherPic.pictureURL.length == 0) {
        [HUDUtil showErrorWithStatus:@"暂无可保存的内容"]; return;
    }
    
    if (_discountDraft.discountIsNeedVoucher && _discountDraft.discountVoucherPic.pictureURL.length == 0) {
        [HUDUtil showErrorWithStatus:@"请上传凭证"];
        return;
    }
    
    NSMutableArray *public = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_discountDraft.discountPublicPics count]; i++) {
        PictureInfo *obj = _discountDraft.discountPublicPics[i];
        [public addObject:obj.pictureId];
    }
    
    if (!_isEarnGold) {
        [HUDUtil showWithStatus:@"正在保存"];
    }
    NSString *publishId = _discountDraft.discountId.length > 0 ? _discountDraft.discountId :@"0";
    if (self.isContinuePublish) {
        publishId = @"";
    }
    [[API_PostBoard getInstance] engine_outside_discountManage_saveDraft:publishId
                                                                   title:_discountDraft.discountTitle.length > 0 ? _discountDraft.discountTitle:@""
                                                                 content:_discountDraft.discountContent.length > 0 ? _discountDraft.discountContent:@""
                                                                  images:public
                                                           isNeedVoucher:_discountDraft.discountIsNeedVoucher
                                                               voucherId:_discountDraft.discountVoucherPic.pictureId.length > 0 ? _discountDraft.discountVoucherPic.pictureId:@""
                                                             hasDiscount:_discountDraft.discountHasDiscountDate
                                                           discountStart:_discountDraft.discountDiscountStartDate
                                                             discountEnd:_discountDraft.discountDiscountEndDate
                                                             onlineCount:_discountDraft.discountOnlineDayCount];
}




- (void)setupUI{
    
    PSTCollectionViewFlowLayout *layout = [[PSTCollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 20.f;
    layout.minimumLineSpacing = 20.f;
    UIEdgeInsets insets = {.top = 0,.left = 20,.bottom = 20,.right = 20};
    layout.sectionInset = insets;
    
    _collectionview = [[PSTCollectionView alloc] initWithFrame:CGRectMake(0, _viewTop.bottom, SCREENWIDTH, 115) collectionViewLayout:layout];
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.scrollEnabled = NO;
    _collectionview.backgroundColor = [UIColor whiteColor];
    [_collectionview registerNib:[UINib nibWithNibName:@"AddPictureCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AddPictureCell"];
    
    [_scrollViewMain addSubview:_collectionview];
    
    //计算高度
    _viewBottom.top = _collectionview.bottom;
    _scrollViewMain.contentSize = CGSizeMake(SCREENWIDTH, YH(_viewTop) + H(_collectionview) + H(_viewBottom) + 10);
    
    _datePickerView = STRONG_OBJECT(DatePickerViewController, initWithNibName:@"DatePickerViewController" bundle:nil);
    
    CGFloat offset = [UICommon getIos4OffsetY];
    
    _datePickerView.view.frame = CGRectMake(0, 0, 320, 460 + offset);
    
    _datePickerView.delegate = self;
    
    NSLocale * loca = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    [_datePickerView.picker setLocale:loca ];
    
    _datePickerView.picker.timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    
    NSDate * today = [NSDate date];
    
    _datePickerView.picker.minimumDate = today;
    
    
    
}

- (void)countHeight{
    //计算高度
    NSInteger count = _discountDraft.discountPublicPics.count + 1;
    NSInteger row = (count % 3) ? (count / 3 + 1) : count / 3;
    float height = row * (115 + 20);
    
    _collectionview.height = height;
    
    //计算高度
    _viewBottom.top = _collectionview.bottom;
    
    _scrollViewMain.contentSize = CGSizeMake(SCREENWIDTH, YH(_viewTop) + height + 400);
}


#pragma mark - collectionview delegate / datasource
- (NSInteger)collectionView:(PSTCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _discountDraft.discountPublicPics.count >= 5 ? 5 : _discountDraft.discountPublicPics.count + 1;
}

- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AddPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddPictureCell" forIndexPath:indexPath];
    if (indexPath.row == _discountDraft.discountPublicPics.count && _discountDraft.discountPublicPics.count != 5) {
        cell.imageView.hidden = YES;
        cell.btnAdd.hidden = NO;
        [cell.btnAdd addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        cell.btnAdd.hidden = YES;
        cell.imageView.hidden = NO;
        [cell.imageView setRoundCorner:0.f withBorderColor:AppColorLightGray204];
        PictureInfo * obj = _discountDraft.discountPublicPics[indexPath.row];
        [cell.imageView requestWithRecommandSize:obj.pictureURL];
    }
    return cell;
}

- (CGSize)collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 115);
}

- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"预览" otherButtonTitles:@"相机拍摄", @"从相册中选择", @"删除", nil];
    sheet.tag = indexPath.row + 1000;
    [sheet showInView:self.view];
    
}


#pragma mark - uiacrionshee delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    _deleteIndex = -1;
    _currentItem = -1;
    
    //返回时保存草稿
    if(actionSheet.tag == 10001){
        switch (buttonIndex) {
            case 0://保存草稿
            {
                [self onMoveFoward:nil];
            }
                break;
            case 1: //不保存
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
            case 2: //取消
            {
            }
                
            default:
                break;
        }
    }
    //上传凭证
    else if (actionSheet.tag == 10000) {
        _currentItem = 10000;
        if (buttonIndex == 0) {
            [UICommon showCamera:self view:self allowsEditing:NO];
        }else{
            [UICommon showImagePicker:self view:self];
        }
        
    }else if (actionSheet.tag >= 1000) {
        if (buttonIndex == 0) {
            //预览
            
            self.preview = [[PreviewViewController alloc]init];
            
            
            NSMutableArray *urls = [[NSMutableArray alloc] init];
            for (int i = 0; i < [_discountDraft.discountPublicPics count]; i++) {
                PictureInfo * obj = _discountDraft.discountPublicPics[i];
                [urls addObject:@{@"PictureUrl":obj.pictureURL}];
            }
            self.preview.dataArray = urls;
            self.preview.currentPage = actionSheet.tag - 1000;
            [self presentViewController:self.preview animated:NO completion:^{
                //                preview.pageControl.hidden = YES;
            }];
        } else if (buttonIndex == 1) {
            _currentItem = actionSheet.tag - 1000;
            [UICommon showCamera:self view:self allowsEditing:NO];
        } else if (buttonIndex == 2) {
            _currentItem = actionSheet.tag - 1000;
            [UICommon showImagePicker:self view:self];
        } else if (buttonIndex == 3){
            //删除
            _deleteIndex = actionSheet.tag - 1000;
            
            [_discountDraft.discountPublicPics removeObjectAtIndex:(long)_deleteIndex];
            
            [self countHeight];
            [_collectionview reloadData];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IsChanged"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    } else if (actionSheet.tag == 10) {
        if (buttonIndex == 0) {
            _isBack = YES;
            [self onMoveFoward:nil];
            
        } else if (buttonIndex == 1){
            [UI_MANAGER.mainNavigationController popViewControllerAnimated:YES];
        }
        if (buttonIndex != 2) {
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"IsChanged"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CurrentDirectAdId"];
        }
        
    } else {
        if (buttonIndex == 0) {
            [UICommon showCamera:self view:self allowsEditing:YES];
        } else if (buttonIndex == 1) {
            [UICommon showImagePicker:self view:self];
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
        
        EditImageViewController *imageEditor = [[EditImageViewController alloc]
                                                           initWithNibName:@"EditImageViewController"
                                                           bundle:nil
                                                           ImgType:EditImageType200];
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

//点击add图片
- (void)clickImage:(UIButton *)button{
    
    [self.view endEditing:YES];
    _currentItem = -1;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机拍摄" otherButtonTitles:@"从相册中选择", nil];
    [sheet showInView:self.view];
}

- (void)passImage:(UIImage *)image
{
    
    ADAPI_Picture_Upload([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleUploadPic:)], UIImagePNGRepresentation(image));
}

//上传图片
- (void)handleUploadPic:(DelegatorArguments *)arguments{
    _isEditDraftInfo = YES;
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IsChanged"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        NSString *url = [dic.data getString:@"PictureUrl"];
        NSString *pid = [dic.data getString:@"PictureId"];
        if (!url) {
            return;
        }
        if(_currentItem == 10000){ //凭证
            if (_discountDraft.discountVoucherPic == nil) {
                _discountDraft.discountVoucherPic = [[PictureInfo alloc] init];
            }
            _discountDraft.discountVoucherPic.pictureId = pid;
            _discountDraft.discountVoucherPic.pictureURL = url;
            
            [_buttonCertificateUpload setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_discountDraft.discountVoucherPic.pictureURL]]] forState:UIControlStateNormal];
        }else if (_currentItem == -1) {//添加
            if (_discountDraft.discountPublicPics == nil) {
                _discountDraft.discountPublicPics = [NSMutableArray array];
            }
            PictureInfo * obj = [[PictureInfo alloc] init];
            obj.pictureId = pid;
            obj.pictureURL = url;
            [_discountDraft.discountPublicPics addObject:obj];
            
            [self countHeight];
            [_collectionview reloadData];
        } else { //替换
            
            PictureInfo * obj = [[PictureInfo alloc] init];
            obj.pictureId = pid;
            obj.pictureURL = url;
            [_discountDraft.discountPublicPics replaceObjectAtIndex:_currentItem withObject:obj];
            
            [self countHeight];
            [_collectionview reloadData];
        }
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (IBAction)buttonClickCertificate:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0: //无需凭证
        {
            _discountDraft.discountIsNeedVoucher = NO;
            if(self.buttonCertificate == nil) {
                self.buttonCertificate = sender; return;
            }
            if(self.buttonCertificate == sender) return;
            self.buttonCertificate = sender;
            self.imageViewCertificate0.image = [UIImage imageNamed:@"rank-03"];
            self.imageViewCertificate1.image = [UIImage imageNamed:@"rank-02"];
            
            
            if(H(self.viewBotton0) != 75){
                self.viewBotton0.frameHeight = 75;
                self.imageViewLineCertificate.frameY = 74;
                self.viewBotton1.frameY = Y(self.viewBotton1) - 85;
                self.viewBotton2.frameY = Y(self.viewBotton2) - 85;
                
                self.lableCertificate0.hidden = NO;
                self.lableCertificate1.hidden = YES;
                self.buttonCertificateUpload.hidden = YES;
            }
        }
            break;
        case 1://需要凭证
        {
            _discountDraft.discountIsNeedVoucher = YES;
            if(self.buttonCertificate == sender) return;
            self.buttonCertificate = sender;
            self.imageViewCertificate0.image = [UIImage imageNamed:@"rank-02"];
            self.imageViewCertificate1.image = [UIImage imageNamed:@"rank-03"];
            if(H(self.viewBotton0) != 150){
                self.viewBotton0.frameHeight = 150;
                self.imageViewLineCertificate.frameY = 149;
                self.viewBotton1.frameY = Y(self.viewBotton1) + 85;
                self.viewBotton2.frameY = Y(self.viewBotton2) + 85;
                
                self.lableCertificate0.hidden = YES;
                self.lableCertificate1.hidden = NO;
                self.buttonCertificateUpload.hidden = NO;
                
            }
        }
            break;
        case 2://上传凭证
        {
            [self.view endEditing:YES];
            _currentItem = -1;
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机拍摄" otherButtonTitles:@"从相册中选择", nil];
            sheet.tag = 10000;
            [sheet showInView:self.view];
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)buttonClickTime:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
        {
            if(self.buttonTime == nil) {
                self.buttonTime = sender; return;
            }
            if(self.buttonTime == sender) return;
            self.buttonTime = sender;
            
            self.imageViewTime0.image = [UIImage imageNamed:@"rank-03"];
            self.imageViewTime1.image = [UIImage imageNamed:@"rank-02"];
            self.lableTime0.hidden = NO;
            self.lableTime1.hidden = YES;
            
        }
            break;
        case 1:
        {
            _discountDraft.discountHasDiscountDate = YES;
            if(self.buttonTime == sender) return;
            self.buttonTime = sender;
            
            self.imageViewTime0.image = [UIImage imageNamed:@"rank-02"];
            self.imageViewTime1.image = [UIImage imageNamed:@"rank-03"];
            self.lableTime0.hidden = YES;
            self.lableTime1.hidden = NO;
            
        }
            break;
            
        default:
            break;
    }
}



- (IBAction)buttonClickValid:(UIButton *)sender {
    _isEditDraftInfo = YES;
    switch (sender.tag) {
        case 0:
        {
            _discountDraft.discountOnlineDayCount = 7;
            if (self.buttonValid == nil){
                self.buttonValid = sender; return;
            }
            if (self.buttonValid == sender)
                return;
            self.buttonValid = sender;
            self.imageViewValid7.image = [UIImage imageNamed:@"rank-03"];
            self.imageViewValid15.image = [UIImage imageNamed:@"rank-02"];
            self.imageViewValid30.image = [UIImage imageNamed:@"rank-02"];
            
        }
            break;
        case 1:
        {
             _discountDraft.discountOnlineDayCount = 15;
            if (self.buttonValid == sender)
                return;
            self.buttonValid = sender;
            
            self.imageViewValid7.image = [UIImage imageNamed:@"rank-02"];
            self.imageViewValid15.image = [UIImage imageNamed:@"rank-03"];
            self.imageViewValid30.image = [UIImage imageNamed:@"rank-02"];
        }
            break;
        case 2:
        {
             _discountDraft.discountOnlineDayCount = 30;
            if (self.buttonValid == sender)
                return;
            self.buttonValid = sender;
            
            self.imageViewValid7.image = [UIImage imageNamed:@"rank-02"];
            self.imageViewValid15.image = [UIImage imageNamed:@"rank-02"];
            self.imageViewValid30.image = [UIImage imageNamed:@"rank-03"];
        }
            break;
            
        default:
            break;
    }
    
}
- (IBAction)buttonClickSelectDate:(UIButton *)sender {
    _isEditDraftInfo = YES;
    switch (sender.tag) {
        case 0:
        {
            _datePickerView.view.tag = 200;
            
            _datePickerView.titleLable.text = @"开始时间";
            
            [self.view addSubview:_datePickerView.view];
        }
            break;
        case 1:
        {
            _datePickerView.view.tag = 300;
            
            _datePickerView.titleLable.text = @"结束时间";
            
            [self.view addSubview:_datePickerView.view];
        }
            break;
        default:
            break;
    }
}

- (void) selectDateCallBack:(NSDate*)date
{
    [_datePickerView.view removeFromSuperview];
    
    if (_datePickerView.view.tag == 200) {
        
        [_startDateBtn setTitle:[UICommon usaulFormatTime:date formatStyle:@"yyyy-MM-dd"] forState:UIControlStateNormal];
        
        self.startDate = date;
        
        _datePickerView.view.tag = 300;
        
        _datePickerView.titleLable.text = @"结束时间";
        
        [self.view addSubview:_datePickerView.view];
    }
    else{
        if([date compare:_startDate] != NSOrderedDescending){
            [HUDUtil showErrorWithStatus:@"优惠结束时间等于或小于开始时间"]; return;
        }
        self.endDate = date;
        [_endDateBtn setTitle:[UICommon usaulFormatTime:date formatStyle:@"yyyy-MM-dd"] forState:UIControlStateNormal];
    }
}

- (void) cancelDateCallBack:(NSDate*)date
{
    [_datePickerView.view removeFromSuperview];
}

/**
 *  优惠标题，优惠内容详情页面
 *
 *  @param sender 信息按钮，tag为0时为标题，2为内容
 */
- (IBAction)buttonClickDiscountTitle:(UIButton *)sender {
    IWTextInputViewController *tivc = [[IWTextInputViewController alloc] init];
    
    if(sender.tag == 0){
        tivc.inputType = IWTextInputTitle;
        tivc.textInputAlert = @{@"alert_title":@"优惠信息标题",@"alert_textMinLength":@10,@"alert_textLength":@40,@"alert_demo":@"例如：石桥铺韩式烤肉店，30元代返利"};
        tivc.value = _discountDraft.discountTitle;
        [tivc setInputFinished:^(NSString *text){
            _discountDraft.discountTitle = text;
            _isEditDraftInfo = YES;
            self.lableInputTitle.text = text;
        }];
    }
    else{
        tivc.inputType = IWTextInputContent;
        tivc.value = _discountDraft.discountContent;
        tivc.textInputAlert             = @{@"alert_title":@"优惠信息内容",@"alert_textMinLength":@10,@"alert_textLength":@1000,@"alert_demo":@"使用规则\n团购券使用时段：每周一10:00-22:00可用可累积使用，不兑换、不找零、不退现\n•不可抵扣店内的贩售的其他产品，例如蜜饯、红糖、茶叶、木棉甜品、猫西施杏仁豆腐等\n•不可与其他优惠同享\n•如需团购券发票，请在消费时向商户提出\n•客人在落座后如需参加此活动请告知服务员，并将桌上所有朋友的手机放置在密封袋中，贴上封条直至用餐结束\n•在用餐结束后请持未启封的密封袋在前台结账即可享用此代金券\n•工体店用餐后到前台免费兑换2小时的停车券"};
        
        [tivc setInputFinished:^(NSString *text){
            _discountDraft.discountContent  = text;
            _isEditDraftInfo = YES;
            self.lableInputContent.text = text;
        }];
    }
    
    [self.navigationController pushViewController:tivc animated:YES];
}

/**
 *  预览 发布
 *
 *  @param sender 预览 发布
 */
- (IBAction)buttonClickPreviewOrPublish:(UIButton *)sender {
    
    if(sender.tag == 0){ //预览
        
        [self saveDraftValue];
        
//        if (_discountDraft.discountTitle.length == 0 && _discountDraft.discountContent.length == 0 &&  [_discountDraft.discountPublicPics count] == 0 && _discountDraft.discountVoucherPic.pictureURL.length == 0) {
//            [HUDUtil showErrorWithStatus:@"暂无可预览的内容"]; return;
//        }
        
        [SharedData getInstance].discountDraft = _discountDraft;
        IWMainDetail *vc = [[IWMainDetail alloc] init];
        vc.isDraft = YES;
        SellerDiscountDetail *vc0 =[[SellerDiscountDetail alloc] initWithNibName:NSStringFromClass([SellerDiscountDetail class]) bundle:nil];
        vc0.isPreview = YES;
        vc0.isOffline = NO;
        IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
        vc1.postBoardType = kPostBoardDiscount;
        vc1.isDraft = YES;
        vc.navTitle = @"优惠信息标题";
        vc.viewControllers = @[vc0,vc1];
        vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else{ //发布
        
        if ([self checkInputContentPublish]) {
        
            DiscountManageInfo *discountManageInfo = [SharedData getInstance].discountManageInfo;
            
            //金币不足
            if (discountManageInfo.discountCurrentGoldAmount < discountManageInfo.discountPublishGoldCount) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"发布广告所需金币数:%d金币\n 当前金币余额:%d金币",discountManageInfo.discountPublishGoldCount,(int)discountManageInfo.discountCurrentGoldAmount] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存并赚金币", nil];
                alert.tag = kIWSellerDiscountPublishAlertViewGoldNotEnough;
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发布确认" message:[NSString stringWithFormat:@"是否确认消耗%d金币发布本条信息?",discountManageInfo.discountPublishGoldCount] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
                alert.tag = kIWSellerDiscountPublishAlertViewGoldEnough;
                [alert show];
            }
        }
    }
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == kIWSellerDiscountPublishAlertViewGoldNotEnough) {
        if (buttonIndex == 0) { //取消
            
        }else{  //保存并赚取金币
            _isEarnGold = YES;
            [self onMoveFoward:nil];
            GetMoreGoldViewController *vc = [[GetMoreGoldViewController alloc] initWithNibName:@"GetMoreGoldViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }

    }else if(alertView.tag == kIWSellerDiscountPublishAlertViewGoldEnough){
        if (buttonIndex == 0) { //取消
        
        }else{  //发布
//            if([self checkInputContentPublish]){
                [self publishDiscount];
//            }
        }
    }
}

/**
 *  保存优惠信息数据
 */
-(void) saveDraftValue{
    if (_discountDraft.discountIsNeedVoucher && _discountDraft.discountVoucherPic.pictureURL.length == 0) {
        [HUDUtil showErrorWithStatus:@"请上传凭证"];
        return;
    }
    
    if (_discountDraft.discountHasDiscountDate) {
        if([self.endDate compare:self.startDate] != NSOrderedDescending){
            [HUDUtil showErrorWithStatus:@"优惠结束时间等于或小于开始时间"]; return;
        }
    }
    _discountDraft.discountDiscountStartDate = [UICommon usaulFormatTime:self.startDate formatStyle:@"yyyy-MM-dd HH:mm:ss"];
    _discountDraft.discountDiscountEndDate = [UICommon usaulFormatTime:self.endDate formatStyle:@"yyyy-MM-dd HH:mm:ss"];
    
    if (self.buttonValid.tag == 1) {
        _discountDraft.discountOnlineDayCount = 15;
    }else if (self.buttonValid.tag == 2){
        _discountDraft.discountOnlineDayCount = 30;
    }else{
        _discountDraft.discountOnlineDayCount = 7;
    }
}

/**
 *  检查发布项
 */
-(BOOL) checkInputContentPublish
{
    if (_discountDraft.discountTitle.length == 0) {
        [HUDUtil showErrorWithStatus:@"优惠标题未填写"]; return NO;
    }
    
    if (_discountDraft.discountContent.length == 0) {
        [HUDUtil showErrorWithStatus:@"优惠内容未填写"]; return NO;;
    }
    
    [self saveDraftValue];
    
    if ([_discountDraft.discountPublicPics count] == 0) {
        [HUDUtil showErrorWithStatus:@"宣传图片未上传"]; return NO;
    }
    
    if (_discountDraft.discountIsNeedVoucher && _discountDraft.discountVoucherPic.pictureURL.length == 0) {
        [HUDUtil showErrorWithStatus:@"凭证图片未上传"]; return NO;;
    }
    if([_endDate compare:_startDate] != NSOrderedDescending){
        [HUDUtil showErrorWithStatus:@"优惠结束时间等于或小于开始时间"]; return NO;
    }
    return YES;
}

-(void) publishDiscount{
    
    
    NSMutableArray *public = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_discountDraft.discountPublicPics count]; i++) {
        PictureInfo *obj = _discountDraft.discountPublicPics[i];
        [public addObject:obj.pictureId];
    }
    [HUDUtil showWithStatus:@"正在发布"];
    
    NSString *publishId = nil;
    if (self.isContinuePublish) {
        publishId = @"";
    }else{
        publishId = _discountDraft.discountId.length > 0 ?_discountDraft.discountId : @"";
    }
    [[API_PostBoard getInstance] engine_outside_discountManage_publish:publishId
                                                                 title:_discountDraft.discountTitle
                                                               content:_discountDraft.discountContent
                                                                images:public
                                                         isNeedVoucher:_discountDraft.discountIsNeedVoucher
                                                             voucherId:_discountDraft.discountVoucherPic.pictureId
                                                           hasDiscount:_discountDraft.discountHasDiscountDate
                                                         discountStart:_discountDraft.discountDiscountStartDate
                                                           discountEnd:_discountDraft.discountDiscountEndDate
                                                           onlineCount:_discountDraft.discountOnlineDayCount];
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
