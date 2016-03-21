//
//  RealNameAuthenticationViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RealNameAuthenticationViewController.h"
#import "Redbutton.h"
#import "NetImageView.h"
#import "CRInfoNotify.h"
#import "PreviewViewController.h"
#import "EditImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "RRLineView.h"

@interface RealNameAuthenticationViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    DictionaryWrapper * result;
    
    UIImage *_holdImage;
    
    NSString * positiveImageStatus;
    
    NSString * contraryImageStatus;
    
    int tag;
    
    NSString * FrontPicId;
    
    NSString * BackPicId;
    
    CRInfoNotify *infoName;
    
    CRInfoNotify *infoNum;
    
    CRInfoNotify *infopositive;
    
    CRInfoNotify * infocontrary;
}
@property (retain, nonatomic) IBOutlet UITextField *tureNameText;
@property (retain, nonatomic) IBOutlet UITextField *numberOfIDText;
@property (retain, nonatomic) IBOutlet NetImageView *positiveImage;
@property (retain, nonatomic) IBOutlet NetImageView *contraryImage;
@property (retain, nonatomic) IBOutlet UIView *btnVIew;
@property (retain, nonatomic) IBOutlet Redbutton *okBtn;
@property (retain, nonatomic) IBOutlet UILabel *otherViewNameLable;
@property (retain, nonatomic) IBOutlet UILabel *otherViewNumLable;
@property (retain, nonatomic) IBOutlet UIImageView *otherViewImage;
@property (retain, nonatomic) IBOutlet UILabel *otherViewContent;
@property (retain, nonatomic) IBOutlet UIView *otherView;
@property (retain, nonatomic) IBOutlet UIView *showView;

@property (retain, nonatomic) IBOutlet UIButton *positiveBtn;
@property (retain, nonatomic) IBOutlet UIButton *contraryBtn;
- (IBAction)upLoadImageTouch:(id)sender;

- (IBAction)okBtnTouch:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *errorView;
@property (retain, nonatomic) IBOutlet UILabel *errorLable;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollerVw;
@property (retain, nonatomic) IBOutlet UIView *viewOne;
@property (retain, nonatomic) IBOutlet UIView *viewTwo;
@property (retain, nonatomic) IBOutlet RRLineView *errlrLine;
@property (retain, nonatomic) IBOutlet UIView *errorLine;
@end

@implementation RealNameAuthenticationViewController

//定义宏（限制输入内容）
#define kAlphaNum   @"Xx0123456789"

-(void) GetIdentityVerifyInfo
{
    ADAPI_adv3_GetIdentityVerifyInfo([self genDelegatorID:@selector(HandleNotification:)]);
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    [arguments logError];
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if ([arguments isEqualToOperation:ADOP_adv3_GetIdentityVerifyInfo])
    {
        if (wrapper.operationSucceed)
        {
            result = wrapper.data;
            
            [result retain];
            
            [self setType:result];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_Customer_VerifyIdentity])
    {
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".IdentityStatus" string:@"3"];
            
            _otherViewContent.text = @"实名认证审核中，请耐心等待";
            _otherViewNameLable.text = _tureNameText.text;
            
            NSString *str = [_numberOfIDText.text stringByReplacingCharactersInRange:NSMakeRange(1, 16) withString:@"****************"];
            
            _otherViewNumLable.text = str;
            
            _otherViewImage.image = [UIImage imageNamed:@"watingrealNameAction.png"];
            
            [self.view addSubview:_otherView];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

-(void) setLoseName : (NSString *) title
{
    infoName = WEAK_OBJECT(CRInfoNotify, init);
    infoName.rootPoint = CGPointMake(315, 27);
    infoName.info = title;
    infoName.alpha = 0.9;
    infoName.color = AppColor(85);
    [self.view addSubview:infoName];
}

-(void) setLoseNun : (NSString *) title
{
    infoNum = WEAK_OBJECT(CRInfoNotify, init);
    infoNum.rootPoint = CGPointMake(315, 76);
    infoNum.info = title;
    infoNum.alpha = 0.9;
    infoNum.color = AppColor(85);
    [self.view addSubview:infoNum];
}

-(void) setLoseposite : (NSString *) title
{
    infopositive = WEAK_OBJECT(CRInfoNotify, init);
    infopositive.rootPoint = CGPointMake(158, 162);
    infopositive.info = title;
    infopositive.alpha = 0.9;
    infopositive.color = AppColor(85);
    [self.view addSubview:infopositive];
}

-(void) setLosecontrary : (NSString *) title
{
    infocontrary = WEAK_OBJECT(CRInfoNotify, init);
    infocontrary.rootPoint = CGPointMake(298, 162);
    infocontrary.info = title;
    infocontrary.alpha = 0.9;
    infocontrary.color = AppColor(85);
    [self.view addSubview:infocontrary];
}

-(void) setType : (DictionaryWrapper *) dic
{
    int Status = [dic getInt:@"Status"];
    
    [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".IdentityStatus" string:[NSString stringWithFormat:@"%d",Status]];
    
    _showView.hidden = YES;
    
    if (Status == 0)
    {
        //未
    }
    else if (Status == 1)
    {
        //成功
        [self.view addSubview:_otherView];
        
        _otherViewContent.text = @"您已成功通过实名认证";
        _otherViewNameLable.text = [dic getString:@"TrueName"];
        _otherViewNumLable.text = [dic getString:@"IdentityNo"];
        _otherViewImage.image = [UIImage imageNamed:@"realNameAction.png"];
    }
    else if (Status == 2)
    {
        //失败原因
        DictionaryWrapper *AuditMessages = [dic getDictionaryWrapper:@"AuditMessages"];
        
        //退款原因
        _errorLable.text = [AuditMessages getString:@"OtherErrmsg"];
        
//        _errorLable.text = @"商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货商";
        
        CGSize size = [UICommon getSizeFromString:_errorLable.text
                                         withSize:CGSizeMake(290, MAXFLOAT)
                                         withFont:13];
        _errorLable.height = size.height;
        
        _errorView.frame = CGRectMake(0, 0, 320, _errorLable.frame.size.height + 30);
        
        _errorLine.frame = CGRectMake(0, _errorLable.frame.size.height + 30, 320, 0.5);
        
        _viewOne.frame = CGRectMake(0, _errorView.origin.y + _errorView.frame.size.height + 10, 320, 100);
        
        _viewTwo.frame = CGRectMake(0, _viewOne.origin.y + _viewOne.frame.size.height +10, 320, 205);
        
        _btnVIew.frame = CGRectMake(0, _viewTwo.origin.y + _viewTwo.frame.size.height +10, 320, 60);
        
        _scrollerVw.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height- 64);
        
        [_scrollerVw setContentSize:CGSizeMake(320, _btnVIew.origin.y + _btnVIew.frame.size.height)];
        
        if (_scrollerVw.contentSize.height < [[UIScreen mainScreen] bounds].size.height- 64)
        {
            _btnVIew.frame = CGRectMake(0, _scrollerVw.frame.size.height- 60, 320, 60);
        }
        
        //失败
        _tureNameText.text = [dic getString:@"TrueName"];

        _numberOfIDText.text = [dic getString:@"IdentityNo"];

        positiveImageStatus = [dic getString:@"FrontPicUrl"];

        contraryImageStatus = [dic getString:@"BackPicUrl"];

        FrontPicId = [dic getString:@"FrontPicId"];

        BackPicId = [dic getString:@"BackPicId"];

        [_positiveImage requestCustom:[dic getString:@"FrontPicUrl"] width:_positiveImage.width height:_positiveImage.height];

        [_contraryImage requestCustom:[dic getString:@"BackPicUrl"] width:_contraryImage.width height:_contraryImage.height];
        
        [_contraryBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        [_contraryBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        
        [_positiveBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        [_positiveBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        
        
//        //单个错误提示
//        [_contraryBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        
//        [_contraryBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
//        
//        [_positiveBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        
//        [_positiveBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
//
//        //失败
//        _tureNameText.text = [dic getString:@"TrueName"];
//        
//        _numberOfIDText.text = [dic getString:@"IdentityNo"];
//        
//        positiveImageStatus = [dic getString:@"FrontPicUrl"];
//        
//        contraryImageStatus = [dic getString:@"BackPicUrl"];
//        
//        FrontPicId = [dic getString:@"FrontPicId"];
//        
//        BackPicId = [dic getString:@"BackPicId"];
//        
//        [_positiveImage requestCustom:[dic getString:@"FrontPicUrl"] width:_positiveImage.width height:_positiveImage.height];
//        
//        [_contraryImage requestCustom:[dic getString:@"BackPicUrl"] width:_contraryImage.width height:_contraryImage.height];
//        
//        //失败原因
//        DictionaryWrapper *AuditMessages = [dic getDictionaryWrapper:@"AuditMessages"];
//        
//        if ([AuditMessages getString:@"FrontPicErrMsg"] != nil)
//        {
//            [self setLoseposite:[AuditMessages getString:@"FrontPicErrMsg"] ];
//            
//            _positiveImage.layer.borderWidth = 0.5;
//            _positiveImage.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];
//        }
//        if ([AuditMessages getString:@"BackPicErrMsg"] != nil)
//        {
//            [self setLosecontrary:[AuditMessages getString:@"BackPicErrMsg"]];
//
//            _contraryImage.layer.borderWidth = 0.5;
//            _contraryImage.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];
//        }
//        if ([AuditMessages getString:@"NameErrMsg"] != nil)
//        {
//            [self setLoseName:[AuditMessages getString:@"NameErrMsg"]];
//
//            _tureNameText.textColor = RGBCOLOR(240, 5, 0);
//        }
//        if ([AuditMessages getString:@"IdentityNoErrMsg"]!= nil)
//        {
//            [self setLoseNun:[AuditMessages getString:@"IdentityNoErrMsg"]];
//            
//            _numberOfIDText.textColor = RGBCOLOR(240, 5, 0);
//        }
    }
    else
    {
        //认证中
        [self.view addSubview:_otherView];
        
        _otherViewContent.text = @"实名认证审核中，请耐心等待";
        _otherViewNameLable.text = [dic getString:@"TrueName"];
        _otherViewNumLable.text = [dic getString:@"IdentityNo"];
        _otherViewImage.image = [UIImage imageNamed:@"watingrealNameAction"];
    }
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"实名认证");
    
    [self addDoneToKeyboard:_tureNameText];
    
    [self addDoneToKeyboard:_numberOfIDText];
    
    _scrollerVw.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height- 64);
    
    _btnVIew.frame = CGRectMake(0, _scrollerVw.size.height- 60, 320, 60);
    
    if ([[UIScreen mainScreen] bounds].size.height > 480)
    {
        [_scrollerVw setContentSize:CGSizeMake(320, 455)];
    }
    else
    {
        [_scrollerVw setContentSize:CGSizeMake(320, 400)];
    }
    
    [self GetIdentityVerifyInfo];
}

-(void)hiddenKeyboard
{
    [_tureNameText resignFirstResponder];
    [_numberOfIDText resignFirstResponder];
}

#pragma mark UIButton

- (IBAction)okBtnTouch:(id)sender
{
    if ([_tureNameText.text isEqualToString:@""])
    {
        [HUDUtil showErrorWithStatus:@"请输入真实姓名"];
        return;
    }
    if (_tureNameText.text.length > 10)
    {
        [HUDUtil showErrorWithStatus:@"姓名最多不超过10个字"];
        return;
    }
    if ([_numberOfIDText.text isEqualToString:@""])
    {
        [HUDUtil showErrorWithStatus:@"请输入身份证号"];
        return;
    }
    if ([_numberOfIDText.text isEqualToString:@""] || ![self validateIdentityCard:_numberOfIDText.text])
    {
        [HUDUtil showErrorWithStatus:@"请输入正确的身份证号"];
        return;
    }
    if (positiveImageStatus == nil)
    {
        [HUDUtil showErrorWithStatus:@"请上传身份证正面照片"];
        return;
    }
    if (contraryImageStatus == nil)
    {
        [HUDUtil showErrorWithStatus:@"请上传身份证反面照片"];
        return;
    }
    else
    {
        if ([result getInt:@"Status"] ==2)
        {
            DictionaryWrapper *AuditMessages = [result getDictionaryWrapper:@"AuditMessages"];
            
            //认证失败
            if ([[result getString:@"TrueName"] isEqualToString:_tureNameText.text])
            {
                if ([AuditMessages getString:@"NameErrMsg"] != nil)
                {
                    [HUDUtil showErrorWithStatus:@"请修改真实姓名"];
                    return;
                }
            }
            if ([[result getString:@"IdentityNo"] isEqualToString:_numberOfIDText.text])
            {
                if ([AuditMessages getString:@"IdentityNoErrMsg"] != nil)
                {
                    [HUDUtil showErrorWithStatus:@"请修改身份证号码"];
                    return;
                }
            }
            if ([[result getString:@"FrontPicUrl"] isEqualToString:positiveImageStatus])
            {
                 if ([AuditMessages getString:@"FrontPicErrMsg"] != nil)
                {
                    //身份证正面错误
                    [HUDUtil showErrorWithStatus:@"请修改身份证正面照片"];
                    return;
                }
            }
            if ([[result getString:@"BackPicUrl"] isEqualToString:contraryImageStatus])
            {
                 if ([AuditMessages getString:@"BackPicErrMsg"] != nil)
                {
                //身份证正面错误
                
                    [HUDUtil showErrorWithStatus:@"请修改身份证反面照片"];
                    return;
                }
            }
            
            ADAPI_adv3_Customer_VerifyIdentity([self genDelegatorID:@selector(HandleNotification:)], _tureNameText.text, _numberOfIDText.text, FrontPicId, BackPicId);
        }
        else
        {
            ADAPI_adv3_Customer_VerifyIdentity([self genDelegatorID:@selector(HandleNotification:)], _tureNameText.text, _numberOfIDText.text, FrontPicId, BackPicId);
        }
    }
}

-(void) setActionSheet
{
    UIActionSheet *actionSheet = [[[UIActionSheet alloc]
                                   initWithTitle:nil
                                   delegate:self
                                   cancelButtonTitle:@"取消"
                                   destructiveButtonTitle:nil
                                   otherButtonTitles:@"相机拍摄", @"从相册选择",nil]autorelease];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}

-(void) setActionSheetTwo
{
    UIActionSheet *actionSheet = [[[UIActionSheet alloc]
                                   initWithTitle:nil
                                   delegate:self
                                   cancelButtonTitle:@"取消"
                                   destructiveButtonTitle:nil
                                   otherButtonTitles:@"预览", @"相机拍摄",@"从相册选择",nil]autorelease];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}

- (IBAction)upLoadImageTouch:(id)sender
{
     [self hiddenKeyboard];
    if (sender == _contraryBtn)
    {
        infocontrary.hidden = YES;
        
        _contraryImage.layer.borderWidth = 0;
        
        
        tag = 2;
        
        if (contraryImageStatus == nil)
        {
            //反
            [self setActionSheet];
        }
        else
        {
            //反
            [self setActionSheetTwo];
        }
    }
    else if (sender == _positiveBtn)
    {
        infopositive.hidden = YES;
        
        _positiveImage.layer.borderWidth = 0;
        
        tag = 1;
        
        if (positiveImageStatus == nil)
        {
            //正
            [self setActionSheet];
        }
        else
        {
            //正
            [self setActionSheetTwo];
        }
       
    }
}

#pragma mark - 相机

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (tag == 1)
    {
        if (positiveImageStatus == nil)
        {
            if (buttonIndex == 0)
            {
                [UICommon showCamera:self view:self allowsEditing:YES];
            }
            else if (buttonIndex == 1)
            {
                [UICommon showImagePicker:self view:self];
            }
        }
        else
        {
            if (buttonIndex == 0)
            {
                //预览
                PreviewViewController *preview = WEAK_OBJECT(PreviewViewController, init);
                
                if (contraryImageStatus == nil)
                {
                    preview.dataArray = @[@{@"PictureUrl":positiveImageStatus}];
                }
                else
                {
                    preview.dataArray = @[@{@"PictureUrl":positiveImageStatus},@{@"PictureUrl":contraryImageStatus}];
                }
                preview.currentPage = 0;
                
                [self presentModalViewController:preview animated:NO];
            }
            else if (buttonIndex == 1)
            {
                [UICommon showCamera:self view:self allowsEditing:YES];
            }
            else if (buttonIndex == 2)
            {
                [UICommon showImagePicker:self view:self];
            }
        }
    }
    else
    {
        if (contraryImageStatus == nil)
        {
            if (buttonIndex == 0)
            {
                [UICommon showCamera:self view:self allowsEditing:YES];
            }
            else if (buttonIndex == 1)
            {
                [UICommon showImagePicker:self view:self];
            }
        }
        else
        {
            if (buttonIndex == 0)
            {
                PreviewViewController *preview = WEAK_OBJECT(PreviewViewController, init);
                //预览
                if (positiveImageStatus == nil)
                {
                    preview.dataArray = @[@{@"PictureUrl":positiveImageStatus}];
                                    }
                else
                {
                    preview.dataArray = @[@{@"PictureUrl":contraryImageStatus},@{@"PictureUrl":positiveImageStatus}];
                }
                
                preview.currentPage = 1;
                
                [self presentModalViewController:preview animated:NO];

            }
            else if (buttonIndex == 1)
            {
                [UICommon showCamera:self view:self allowsEditing:YES];
            }
            else if (buttonIndex == 2)
            {
                [UICommon showImagePicker:self view:self];
            }
        }
    }
}

#pragma mark - uiimagepicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    UIImage *image =  [info objectForKey:UIImagePickerControllerOriginalImage];
    NSURL *assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    ALAssetsLibrary *library = [[[ALAssetsLibrary alloc] init] autorelease];
    [library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
        UIImage *preview = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
        
        EditImageViewController *imageEditor = WEAK_OBJECT(EditImageViewController,
                                                           initWithNibName:@"EditImageViewController"
                                                           bundle:nil
                                                           ImgType:EditImageTypeIdCard);
        imageEditor.rotateEnabled = NO;
        imageEditor.doneCallback = ^(UIImage *editedImage, BOOL canceled){
            if(!canceled) {
                [self passImage:editedImage];
            }
            [picker setNavigationBarHidden:NO animated:NO];
            [self dismissModalViewControllerAnimated:YES];
        };
        
        imageEditor.sourceImage = image;
        imageEditor.previewImage = preview;
        [imageEditor reset:NO];
        
        [picker pushViewController:imageEditor animated:YES];
        [picker setNavigationBarHidden:YES animated:NO];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Failed to get asset from library");
    }];
}

- (void)passImage:(UIImage *)image
{
    image = [image compressedImage];
    NSLog(@"%@",NSStringFromCGSize(image.size));
    
    ADAPI_Picture_Upload([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleUploadPic:)], UIImagePNGRepresentation(image));
}

//上传图片
- (void)handleUploadPic:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_Picture_Upload])
    {
        DictionaryWrapper* dic = arguments.ret;
        
        if (dic.operationSucceed)
        {
            NSLog(@"%@",dic.data);
            
            NSString *url = [dic.data getString:@"PictureUrl"];
            
            if (!url)
            {
                return;
            }
            if (tag == 1)
            {
                [_positiveBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                
                [_positiveBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
                
                [_positiveImage requestCustom:url width:_positiveImage.width height:_positiveImage.height];
                
                positiveImageStatus = url;
                [positiveImageStatus retain];
                
                _positiveImage.layer.borderWidth = 0.5;
                
                _positiveImage.frame = CGRectMake(30.5, 44.5, 119, 79);
                
                _positiveImage.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
                
                FrontPicId = [dic.data getString:@"PictureId"];
                [FrontPicId retain];
            }
            else
            {
                [_contraryBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                
                [_contraryBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
                
                [_contraryImage requestCustom:url width:_contraryImage.width height:_contraryImage.height];
                
                _contraryImage.layer.borderWidth = 0.5;
                
                _contraryImage.frame = CGRectMake(170.5, 44.5, 119, 79);
                
                _contraryImage.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];

                
                contraryImageStatus = url;
                [contraryImageStatus retain];
                
                BackPicId = [dic.data getString:@"PictureId"];
                [BackPicId retain];
            }
        }
        else if (dic.operationPromptCode || dic.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:dic.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}


#pragma mark TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _tureNameText)
    {
        infoName.hidden = YES;
        _tureNameText.textColor = RGBCOLOR(34, 34, 34);
        return;
    }
    if (textField == _numberOfIDText)
    {
        infoNum.hidden = YES;
        _numberOfIDText.textColor = RGBCOLOR(34, 34, 34);
        return;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (_tureNameText == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 10)
        { 
            textField.text = [toBeString substringToIndex:10];            return NO;
        }
    }
     if (_numberOfIDText == textField)
    {
        if ([toBeString length] > 18)
        {
            textField.text = [toBeString substringToIndex:18];
            return NO;
        }
    }
    return YES;
}


//身份证号
- (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0)
    {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
//    [positiveImageStatus release];
//    
//    [contraryImageStatus release];
//    
//    [FrontPicId release];
//    
//    [BackPicId release];
    
    [_holdImage release];
    
    [result release];
//    result = nil;
    
    [_numberOfIDText release];
    [_tureNameText release];
    [_positiveImage release];
    [_contraryImage release];
    [_btnVIew release];
    [_okBtn release];
    [_otherViewNameLable release];
    [_otherViewNumLable release];
    [_otherViewImage release];
    [_otherViewContent release];
    [_otherView release];
    [_showView release];
    [_positiveBtn release];
    [_contraryBtn release];
    [_scrollerVw release];
    [_errorView release];
    [_errorLable release];
    [_viewOne release];
    [_viewTwo release];
    [_errlrLine release];
    [_errorLine release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setNumberOfIDText:nil];
    [self setTureNameText:nil];
    [self setPositiveImage:nil];
    [self setContraryImage:nil];
    [self setBtnVIew:nil];
    [self setOkBtn:nil];
    [self setOtherViewNameLable:nil];
    [self setOtherViewNumLable:nil];
    [self setOtherViewImage:nil];
    [self setOtherViewContent:nil];
    [super viewDidUnload];
}

@end
