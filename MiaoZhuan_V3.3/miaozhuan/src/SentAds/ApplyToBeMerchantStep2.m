//
//  ApplyToBeMerchantStep2.m
//  miaozhuan
//
//  Created by Santiago on 14-11-4.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ApplyToBeMerchantStep2.h"
#import "IndustryCategotiesViewController.h"
#import "PreviewViewController.h"
#import "ControlViewController.h"
#import "CRInfoNotify.h"
#import "NetImageView.h"
#import "EditImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "RRLineView.h"

@interface ApplyToBeMerchantStep2 ()<UITextViewDelegate, UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate, GetIndustryInformationForSpecialQualification> {

    int _imageChoose;
    BOOL _buttomTextFieldBeginEditing;
    BOOL _middleTextFieldBeginEditing;
}
@property (retain, nonatomic) IBOutlet RRLineView *zizhiBottomLine;

@property (retain, nonatomic) IBOutlet RRLineView *topReasonLine;
@property (retain, nonatomic) IBOutlet RRLineView *logoBottomLine;
//图片ID
@property (strong, nonatomic) NSString* merchantLogoPicId;
@property (strong, nonatomic) NSString* businessLicencePicId;
@property (strong, nonatomic) NSString* picID_1_1;
@property (strong, nonatomic) NSString* picID_1_2;
@property (strong, nonatomic) NSString* picID_2_1;
@property (strong, nonatomic) NSString* picID_3_1;
@property (strong, nonatomic) NSString* picID_3_2;
@property (strong, nonatomic) NSString* picID_3_3;

//图片URL
@property (strong, nonatomic) NSString* merchantLogoPicUrl;
@property (strong, nonatomic) NSString* businessLicencePicUrl;
@property (strong, nonatomic) NSString* picURL_1_1;
@property (strong, nonatomic) NSString* picURL_1_2;
@property (strong, nonatomic) NSString* picURL_2_1;
@property (strong, nonatomic) NSString* picURL_3_1;
@property (strong, nonatomic) NSString* picURL_3_2;
@property (strong, nonatomic) NSString* picURL_3_3;

@property (retain, nonatomic) IBOutlet UITextView *merchantIntroduce;
@property (retain, nonatomic) IBOutlet UILabel *introduceLabel;
@property (retain, nonatomic) IBOutlet UITextField *industryCategory;
@property (retain, nonatomic) IBOutlet NetImageView *merchantLogoImage;
@property (retain, nonatomic) IBOutlet UIButton *merchantLogoButton;
@property (retain, nonatomic) IBOutlet NetImageView *merchantQualificationImage;
@property (retain, nonatomic) IBOutlet UIButton *merchantQualificationButton;
@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollerView;
@property (retain, nonatomic) IBOutlet UITextField *merchantAdvantageTextField;
@property (retain, nonatomic) IBOutlet UITextField *serviceNumberTextField;
@property (retain, nonatomic) IBOutlet UITextField *businessLicenceTextField;

@property (strong, nonatomic) NSString* detailChoosedStr;
@property (strong, nonatomic) IndustryCategotiesViewController *industryCategoryPage;
@property (strong, nonatomic) NSArray *choosedIndustryDetailIds;

@property (strong, nonatomic) NSString* merchantIntroduceStr;
@property (strong, nonatomic) NSString* merchantAdvantageStr;
@property (strong, nonatomic) NSString* serviceNumberStr;
@property (strong, nonatomic) NSString* businessLicenceStr;

@property (strong, nonatomic) CRInfoNotify *introduceErrorBubble;
@property (strong, nonatomic) CRInfoNotify *advantageErrorBubble;
@property (strong, nonatomic) CRInfoNotify *logoErrorBubble;
@property (strong, nonatomic) CRInfoNotify *certificationErrorBubble;
@property (strong, nonatomic) CRInfoNotify *businessLicenceErrorBubble;

@property (strong, nonatomic) CRInfoNotify *extraErrorBubble1_1;
@property (strong, nonatomic) CRInfoNotify *extraErrorBubble1_2;

@property (retain, nonatomic) IBOutlet UIView *aboveView;
@property (retain, nonatomic) IBOutlet UIView *belowView;

@property (retain, nonatomic) IBOutlet UIView *UILineView;
@property (retain, nonatomic) IBOutlet UIView *UILineView2;

@property (strong, nonatomic) UIImage *imageUserChoosed;

@property (retain, nonatomic) IBOutlet UIView *extraView1;
@property (retain, nonatomic) IBOutlet UIView *extraView2;//特殊行业资质列表
@property (retain, nonatomic) IBOutlet UIView *extraView3;


//新增Frame========================================================================================

@property (retain, nonatomic) IBOutlet UIButton *extraView1_Button1;
@property (retain, nonatomic) IBOutlet UIButton *extraView1_Button2;

@property (retain, nonatomic) IBOutlet UIButton *extraView2_Button1;

@property (retain, nonatomic) IBOutlet UIButton *extraView3_Button1;
@property (retain, nonatomic) IBOutlet UIButton *extraView3_Button2;
@property (retain, nonatomic) IBOutlet UIButton *extraView3_Button3;


@property (retain, nonatomic) IBOutlet NetImageView *extraView1_Image1;
@property (retain, nonatomic) IBOutlet NetImageView *extraView1_Image2;

@property (retain, nonatomic) IBOutlet NetImageView *extraView2_Image1;

@property (retain, nonatomic) IBOutlet NetImageView *extraView3_Image1;
@property (retain, nonatomic) IBOutlet NetImageView *extraView3_Image2;
@property (retain, nonatomic) IBOutlet NetImageView *extraView3_Image3;
@property (retain, nonatomic) IBOutlet UIView *topReasonView;
@property (retain, nonatomic) IBOutlet UILabel *reasonLbl;
@property (retain, nonatomic) IBOutlet UIView *logoView;
@property (retain, nonatomic) IBOutlet UIView *logoReasonView;
@property (retain, nonatomic) IBOutlet UILabel *logoReasonLbl;
@property (retain, nonatomic) IBOutlet UIView *zizhiView;
@property (retain, nonatomic) IBOutlet UIView *zizhiReasonView;
@property (retain, nonatomic) IBOutlet UILabel *zizhiReasonLbl;
@property (retain, nonatomic) IBOutlet RRLineView *logoLine;
@property (retain, nonatomic) IBOutlet UILabel *shuiLbl;

@end

@implementation ApplyToBeMerchantStep2
@synthesize businessLicencePicUrl = _businessLicencePicUrl;
@synthesize businessLicencePicId = _businessLicencePicId;
@synthesize merchantLogoPicUrl = _merchantLogoPicUrl;
@synthesize merchantLogoPicId = _merchantLogoPicId;
@synthesize choosedIndustryDetailIds = _choosedIndustryDetailIds;
@synthesize detailChoosedStr = _detailChoosedStr;
@synthesize merchantIntroduce = _merchantIntroduce;
@synthesize introduceLabel = _introduceLabel;
@synthesize industryCategory = _industryCategory;
@synthesize merchantLogoImage = _merchantLogoImage;
@synthesize merchantLogoButton = _merchantLogoButton;
@synthesize merchantQualificationImage = _merchantQualificationImage;
@synthesize merchantQualificationButton = _merchantQualificationButton;
@synthesize mainScrollerView = _mainScrollerView;
@synthesize merchantAdvantageTextField = _merchantAdvantageTextField;
@synthesize serviceNumberTextField = _serviceNumberTextField;
@synthesize businessLicenceTextField = _businessLicenceTextField;
@synthesize industryCategoryPage = _industryCategoryPage;
@synthesize postData = _postData;
@synthesize merchantIntroduceStr = _merchantIntroduceStr;
@synthesize merchantAdvantageStr = _merchantAdvantageStr;
@synthesize serviceNumberStr = _serviceNumberStr;
@synthesize businessLicenceStr = _businessLicenceStr;
@synthesize oldData = _oldData;
@synthesize editStatement = _editStatement;
@synthesize introduceErrorBubble = _introduceErrorBubble;
@synthesize advantageErrorBubble = _advantageErrorBubble;
@synthesize logoErrorBubble = _logoErrorBubble;
@synthesize certificationErrorBubble = _certificationErrorBubble;
@synthesize businessLicenceErrorBubble = _businessLicenceErrorBubble;
@synthesize extraErrorBubble1_1 = _extraErrorBubble1_1;
@synthesize extraErrorBubble1_2 = _extraErrorBubble1_2;
@synthesize aboveView = _aboveView;
@synthesize belowView = _belowView;
@synthesize imageUserChoosed = _imageUserChoosed;
@synthesize UILineView2 = _UILineView2;
@synthesize extraView1 = _extraView1;
@synthesize extraView2 = _extraView2;
@synthesize extraView3 = _extraView3;
@synthesize extraView1_Image1 = _extraView1_Image1;
@synthesize extraView1_Image2 = _extraView1_Image2;
@synthesize extraView2_Image1 = _extraView2_Image1;
@synthesize extraView3_Image1 = _extraView3_Image1;
@synthesize extraView3_Image2 = _extraView3_Image2;
@synthesize extraView3_Image3 = _extraView3_Image3;
@synthesize extraView1_Button1 = _extraView1_Button1;
@synthesize extraView1_Button2 = _extraView1_Button2;
@synthesize extraView2_Button1 = _extraView2_Button1;
@synthesize extraView3_Button1 = _extraView3_Button1;
@synthesize extraView3_Button2 = _extraView3_Button2;
@synthesize extraView3_Button3 = _extraView3_Button3;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _logoBottomLine.top = 159.5;
    _zizhiBottomLine.top = 179.5;
    
    _imageChoose = -1;
    self.imageUserChoosed = WEAK_OBJECT(UIImage, init);
    [self setupMoveBackButton];
    [self setTitle:@"申请商家(2/2)"];
    [self setupMoveFowardButtonWithTitle:@"提交"];
    
    [self addDoneToKeyboard:_merchantIntroduce];
    [self addDoneToKeyboard:_merchantAdvantageTextField];
    [self addDoneToKeyboard:_serviceNumberTextField];
    [self addDoneToKeyboard:_businessLicenceTextField];
    [self.UILineView setFrame:CGRectMake(0, 300.5, 320, 0.5)];
    [_UILineView2 setFrame:CGRectMake(0, 0, 320, 0.5)];
    
    
    _merchantLogoImage.hidden = YES;
    _merchantQualificationImage.hidden = YES;
    
    self.merchantLogoImage.layer.borderWidth = 0.5;
    self.merchantLogoImage.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    self.merchantQualificationImage.layer.borderWidth = 0.5;
    self.merchantQualificationImage.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    if ([SystemUtil aboveIOS7_0]) {
        _mainScrollerView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    if (_editStatement == 1) {
        
        NSMutableArray *temIdsArray = WEAK_OBJECT(NSMutableArray, init);
        NSMutableString *temIdsNameStr = WEAK_OBJECT(NSMutableString, init);
        
        if ([_oldData getString:@"ParentIndustry"]) {
            
            [temIdsNameStr appendString:[_oldData getString:@"ParentIndustry"]];
        }
        
        for (NSDictionary *dic in [_oldData getArray:@"Industrys"]) {
            
            DictionaryWrapper *item = dic.wrapper;
            
            if ([item getInt:@"IndustryId"]) {
                [temIdsArray addObject:[NSString stringWithFormat:@"%d", [item getInt:@"IndustryId"]]];
            }
            if ([dic.wrapper getString:@"Name"]) {
                [temIdsNameStr appendString:[NSString stringWithFormat:@" %@",[dic.wrapper getString:@"Name"]]];
            }
        }
        
        self.industryCategory.text = temIdsNameStr;
        self.choosedIndustryDetailIds = temIdsArray;
        
        self.merchantIntroduce.text = [_oldData getString:@"Introduction"];
        self.merchantIntroduceStr = _merchantIntroduce.text;
        
        if ([_oldData getString:@"Introduction"]||![[_oldData getString:@"Introduction"] isEqualToString:@""]) {
            
            self.introduceLabel.hidden = YES;
        }
        
        self.merchantAdvantageTextField.text = [_oldData getString:@"Feature"];
        self.merchantAdvantageStr = _merchantAdvantageTextField.text;
        
        self.businessLicenceTextField.text = [_oldData getString:@"BusinessLicenseNo"];
        self.businessLicenceStr = _businessLicenceTextField.text;
        
        self.serviceNumberTextField.text = [_oldData getString:@"ServicePersonnelNumber"];
        self.serviceNumberStr = _serviceNumberTextField.text;
        
        self.merchantLogoPicId = [[_oldData getString:@"LogoPicId"] copy];
        self.merchantLogoPicUrl = [[_oldData getString:@"LogoUrl"] copy];
        
        if ((![_merchantLogoPicId isEqualToString:@""])&&(![_merchantLogoPicUrl isEqualToString:@""])) {
            
            _merchantLogoImage.hidden = NO;
            _merchantLogoButton.hidden = YES;
            
            if (_merchantLogoPicUrl && ![_merchantLogoPicUrl isEqualToString:@""]) {
                
                [self.merchantLogoImage requestPicture:_merchantLogoPicUrl];
            }
            
            UIButton *button = WEAK_OBJECT(UIButton, init);
            button.tag = 1;
            [button setFrame:_merchantLogoImage.frame];
            [button addTarget:self action:@selector(showActionSheet1:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundColor:[UIColor clearColor]];
            [_logoView addSubview:button];
        }
        
        self.businessLicencePicId = [[_oldData getString:@"BusinessLicensePicId"] copy];
        self.businessLicencePicUrl = [[_oldData getString:@"BusinessLicensePicUrl"] copy];
        
        if ((![_businessLicencePicId isEqualToString:@""])&&(![_businessLicencePicUrl isEqualToString:@""])) {
            
            _merchantQualificationImage.hidden = NO;
            _merchantQualificationButton.hidden = YES;
            
            if (_businessLicencePicUrl && ![_businessLicencePicUrl isEqualToString:@""]) {
                
                [self.merchantQualificationImage requestPicture:_businessLicencePicUrl];
            }
            
            UIButton *button = WEAK_OBJECT(UIButton, init);
            button.tag = 2;
            [button setFrame:_merchantQualificationImage.frame];
            [button addTarget:self action:@selector(showActionSheet1:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundColor:[UIColor clearColor]];
            [_zizhiView addSubview:button];
        }
        
        NSArray* extraDataArray = [_oldData getArray:@"OtherCert"];
        
        for (NSDictionary *dic in extraDataArray) {
            
            DictionaryWrapper *wrapper = [dic wrapper];
            
            //获取税务登记证信息
            if ([[wrapper getString:@"Name"] isEqualToString:@"税务登记证"]) {
                
                _picID_1_1 = [[wrapper getString:@"PictureId"] copy];
                _picURL_1_1 = [[wrapper getString:@"PictureUrl"] copy];
                _extraView1_Button1.hidden = YES;
                _extraView1_Image1.hidden = NO;
                [_extraView1_Image1 requestPicture:_picURL_1_1];
                
                UIButton *button = WEAK_OBJECT(UIButton, init);
                button.tag = 11;
                [button setFrame:_extraView1_Image1.frame];
                [button addTarget:self action:@selector(showActionSheet1:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundColor:[UIColor clearColor]];
                [_extraView1 addSubview:button];
            }
            
            //获取组织机构代码证信息
            if ([[wrapper getString:@"Name"] isEqualToString:@"组织机构代码证"]) {
                
                _picURL_1_2 = [[wrapper getString:@"PictureUrl"] copy];
                _picID_1_2 = [[wrapper getString:@"PictureId"] copy];
                _extraView1_Button2.hidden = YES;
                _extraView1_Image2.hidden = NO;
                [_extraView1_Image2 requestPicture:_picURL_1_2];
                
                UIButton *button = WEAK_OBJECT(UIButton, init);
                button.tag = 12;
                [button setFrame:_extraView1_Image2.frame];
                [button addTarget:self action:@selector(showActionSheet1:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundColor:[UIColor clearColor]];
                [_extraView1 addSubview:button];
            }
        }
        [self popBubble];
    }
    
    [self setUpExtraFrame];
}


#pragma mark - delegate GetIndustryInformationForSpecialQualification
- (void)reloadFrameForSpeciaQualification:(NSArray*) array {
    
//    响应数据：List<T>
//    
//    字段	数据类型	可空	备注
//    Code	string	否	行业资质代码
//    Name	string	否	行业资质名称
  @TODO("有些事，我都已忘记");
//    if (array.count != 0) {
//        
//        [_mainScrollerView setContentSize:CGSizeMake(320, _belowView.bottom + _extraView1.height + 10)];
//        
//        _extraView2.hidden = YES;
//        
//        [_extraView1 setOrigin:CGPointMake(0, _belowView.bottom)];
//        
//    }else {
//        
//        [_mainScrollerView setContentSize:CGSizeMake(320, _belowView.bottom + _extraView1.height + _extraView2.height + 10)];
//        
//        _extraView2.hidden = NO;
//
//        [_extraView1 setOrigin:CGPointMake(0, _belowView.bottom)];
//        [_extraView2 setOrigin:CGPointMake(0, _extraView1.bottom)];
//    }
}

//设置3.1增加的frame，确定行业类别时再次调用该函数，完成回调可以考虑是否传递参数
- (void)setUpExtraFrame {
    
    [_mainScrollerView setContentSize:CGSizeMake(320, _belowView.bottom + _extraView1.height+ 10)];
    
    [_mainScrollerView addSubviews:_extraView1,_extraView2,nil];
    
    _extraView2.hidden = YES;
    
    if(_shuiLbl.hidden)
    {
        [_extraView1 setOrigin:CGPointMake(0, _belowView.bottom - 23)];
        
        [_mainScrollerView bringSubviewToFront:_belowView];
    }
    else
    {
        [_extraView1 setOrigin:CGPointMake(0, _belowView.bottom)];
    }
    
}



//弹出气泡
- (void)popBubble {
   
    DictionaryWrapper *errors = [_oldData getDictionaryWrapper:@"AuditMessages"];
    
    NSString * text = [errors getString:@"OtherErrmsg"];
    
//    text = @"测试测试测试测试";

    if(text.length > 0)
    {
        _topReasonView.hidden = NO;
        
        _reasonLbl.text = text;
        
        CGSize textSize = [UICommon getSizeFromString:text
                                             withSize:CGSizeMake(_reasonLbl.width, MAXFLOAT)
                                             withFont:14];
        _reasonLbl.height = textSize.height < 30 ? 30 : textSize.height;
        
        _topReasonView.height = _reasonLbl.bottom + 15;
        
        _topReasonLine.top = _topReasonView.height - 0.5;
        
        
        _aboveView.top = _topReasonView.bottom + 10;
        
        _belowView.top = _aboveView.bottom + 10;
    }
    
    //介绍错误
    text = [errors getString:@"IntroductionErrmsg"];
//    text = @"测试测试测试测试";

    if (text) {
        
        self.introduceErrorBubble = WEAK_OBJECT(CRInfoNotify, initWith:text at:CGPointMake(298, 68));
        [self.aboveView addSubview:_introduceErrorBubble];
        self.merchantIntroduce.textColor = [UIColor redColor];
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTINTRODUCE" int:1];
    }
    
    //特色错误
    text = [errors getString:@"FeatureErrmsg"];
//    text = @"测试测试测试测试";

    if (text) {

        self.advantageErrorBubble = WEAK_OBJECT(CRInfoNotify, initWith:text at:CGPointMake(298, 218));
        [self.aboveView addSubview:_advantageErrorBubble];
        self.merchantAdvantageTextField.textColor = [UIColor redColor];
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTFEATURE" int:1];
    }
    
    //logo错误
    text = [errors getString:@"LogoErrmsg"];
//    text = @"测试测试测试测试";

    if (text) {
        
//        self.logoErrorBubble = WEAK_OBJECT(CRInfoNotify, initWith:[errors getString:@"LogoErrmsg"] at:CGPointMake(173, 59));
//        [self.belowView addSubview:_logoErrorBubble];
//    
//        self.merchantLogoImage.layer.borderWidth = 2;
//        self.merchantLogoImage.layer.borderColor = [[UIColor redColor] CGColor];
        
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTLOGO" int:1];
        
        _logoReasonView.hidden = NO;
        _logoLine.hidden = YES;
        _logoReasonLbl.text = text;
        _logoView.top = _logoReasonView.bottom - 17;
        
        [_belowView bringSubviewToFront:_logoReasonView];
    }
    
    //资质错误
    text = [errors getString:@"CertificationErrmsg"];
//    text = @"测试测试测试测试";

    if (text) {
        
//        self.certificationErrorBubble = WEAK_OBJECT(CRInfoNotify, initWith:[errors getString:@"CertificationErrmsg"] at:CGPointMake(173, 206));
//        [self.belowView addSubview:_certificationErrorBubble];
//        
//        self.merchantQualificationImage.layer.borderWidth = 2;
//        self.merchantQualificationImage.layer.borderColor = [[UIColor redColor] CGColor];
        
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTCERTIFICATION" int:1];
        _zizhiReasonLbl.text = text;
        _zizhiReasonView.hidden = NO;
        
        _zizhiReasonView.top = _logoView.bottom + 10;
        _zizhiView.top = _zizhiReasonView.bottom - 17;
        [_belowView bringSubviewToFront:_zizhiReasonView];
    }
    
    //营业执照注册号错误
    text = [errors getString:@"BusinessLicenseNoErrmsg"];

    if (text) {
        
//        self.businessLicenceErrorBubble = WEAK_OBJECT(CRInfoNotify, initWith:[errors getString:@"BusinessLicenseNoErrmsg"] at:CGPointMake(293, 336));
//        [self.belowView addSubview:_businessLicenceErrorBubble];
//        self.businessLicenceTextField.textColor = [UIColor redColor];
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTBUSINESSLICENCE" int:1];
    }
    
    //其他资质错误
    text = [errors getString:@"OtherCertErrmsg"];
//    text = @"测试测试测试测试";

    if (text) {
        
        _shuiLbl.hidden = NO;
        _shuiLbl.text = text;
    }
    
//    NSArray *otherErrorArray = [_oldData getArray:@"OtherCert"];
//    
//    for (NSDictionary *dic in otherErrorArray) {
//        DictionaryWrapper *wrapper = dic.wrapper;
//        
//        //税务登记证
//        if ([[wrapper getString:@"Name"] isEqualToString:@"税务登记证"]) {
//            
//            if ([wrapper getString:@"AuditMessage"].length && ![[wrapper getString:@"AuditMessage"] isKindOfClass:[NSNull class]]) {
//                
//                _extraErrorBubble1_1 = WEAK_OBJECT(CRInfoNotify, initWith:[wrapper getString:@"AuditMessage"] at:CGPointMake(100, 42));
//                [_extraView1 addSubview:_extraErrorBubble1_1];
//                _extraView1_Image1.layer.borderWidth = 2;
//                _extraView1_Image1.layer.borderColor = [[UIColor redColor] CGColor];
//                [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTEXTRAERROR1_1" int:1];
//            }
//        }
//        
//        //组织结构代码证
//        if ([[wrapper getString:@"Name"] isEqualToString:@"组织机构代码证"]) {
//            
//            if ([wrapper getString:@"AuditMessage"].length && ![[wrapper getString:@"AuditMessage"] isKindOfClass:[NSNull class]]) {
//                
//                _extraErrorBubble1_2 = WEAK_OBJECT(CRInfoNotify, initWith:[wrapper getString:@"AuditMessage"] at:CGPointMake(234, 42));
//                [_extraView1 addSubview:_extraErrorBubble1_2];
//                _extraView1_Image2.layer.borderWidth = 2;
//                _extraView1_Image2.layer.borderColor = [[UIColor redColor] CGColor];
//                [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTEXTRAERROR1_2" int:1];
//            }
//        }
//    }
    
    _belowView.height = _zizhiView.bottom;
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    int moreHeight;
    if ([[UIScreen mainScreen] bounds].size.height <= 480) {
        
        moreHeight = 70;
    }else {
        
        moreHeight = 0;
    }
    
    if (_buttomTextFieldBeginEditing) {
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.mainScrollerView setContentOffset:CGPointMake(0, height+300+moreHeight + 10)];
        }];
    }
    
    if (_middleTextFieldBeginEditing) {
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.mainScrollerView setContentOffset:CGPointMake(0, height/2+moreHeight + 10)];
        }];
    }
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    
    //获取键盘的高度
    if (_buttomTextFieldBeginEditing) {
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.mainScrollerView setContentOffset:CGPointMake(0, 310)];
        }];
    }
    if (_middleTextFieldBeginEditing) {
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.mainScrollerView setContentOffset:CGPointMake(0, 10)];
        }];
    }
}

- (void)hiddenKeyboard {

    [_merchantIntroduce resignFirstResponder];
    [_merchantAdvantageTextField resignFirstResponder];
    [_serviceNumberTextField resignFirstResponder];
    [_businessLicenceTextField resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    if (_industryCategoryPage.parentStr&&_industryCategoryPage.detailChoosedStr) {
        
        //返回配置本页面数据
        self.industryCategory.text = [NSString stringWithFormat:@"%@, %@",_industryCategoryPage.parentStr,_industryCategoryPage.detailChoosedStr];
    }else {
        
    }
}

//提交
- (void)onMoveFoward:(UIButton *)sender {
    
    if ([_industryCategoryPage.choosedIdArray count]>0) {
        
        self.choosedIndustryDetailIds = _industryCategoryPage.choosedIdArray;
    }
    self.detailChoosedStr = _industryCategoryPage.detailChoosedStr;
    
    [self.postData set:@"Introduction" string:_merchantIntroduce.text];
    [self.postData set:@"Feature" string:_merchantAdvantageTextField.text];
    [self.postData set:@"ServicePersonnelNumber" string:_serviceNumberTextField.text];
    [self.postData set:@"IndustryIds" value:_choosedIndustryDetailIds];
    [self.postData set:@"BusinessLicenseNo" string:_businessLicenceTextField.text];
    [self.postData set:@"LogoPicId" string:_merchantLogoPicId];
    [self.postData set:@"BusinessLicensePicId" string:_businessLicencePicId];
    
    NSMutableArray *extraArray = WEAK_OBJECT(NSMutableArray, init);
    

//新增资质
    if (_picID_1_1.length > 0) {
        WDictionaryWrapper *itemData = WEAK_OBJECT(WDictionaryWrapper, init);
        [itemData set:@"CertType" int:101];
        [itemData set:@"PictureId" string:_picID_1_1];
        [itemData set:@"Code" string:nil];
        [extraArray addObject:itemData.dictionary];
    }
    
    if (_picID_1_2.length > 0) {
        WDictionaryWrapper *itemData = WEAK_OBJECT(WDictionaryWrapper, init);
        [itemData set:@"CertType" int:102];
        [itemData set:@"PictureId" string:_picID_1_2];
        [itemData set:@"Code" string:nil];
        [extraArray addObject:itemData.dictionary];
    }
    
    if (_picID_2_1.length > 0) {
        WDictionaryWrapper *itemData = WEAK_OBJECT(WDictionaryWrapper, init);
        [itemData set:@"CertType" int:104];
        [itemData set:@"PictureId" string:_picID_2_1];
        [itemData set:@"Code" string:nil];
        [extraArray addObject:itemData.dictionary];
    }
    
    if (_picID_3_1.length > 0) {
        WDictionaryWrapper *itemData = WEAK_OBJECT(WDictionaryWrapper, init);
        [itemData set:@"CertType" int:103];
        [itemData set:@"PictureId" string:_picID_3_1];
        [itemData set:@"Code" string:nil];
        [extraArray addObject:itemData.dictionary];
    }
    
    if (_picID_3_2.length > 0) {
        WDictionaryWrapper *itemData = WEAK_OBJECT(WDictionaryWrapper, init);
        [itemData set:@"CertType" int:103];
        [itemData set:@"PictureId" string:_picID_3_2];
        [itemData set:@"Code" string:nil];
        [extraArray addObject:itemData.dictionary];
    }
    
    if (_picID_3_3.length > 0) {
        WDictionaryWrapper *itemData = WEAK_OBJECT(WDictionaryWrapper, init);
        [itemData set:@"CertType" int:103];
        [itemData set:@"PictureId" string:_picID_3_3];
        [itemData set:@"Code" string:nil];
        [extraArray addObject:itemData.dictionary];
    }

    [self.postData set:@"OtherCert" value:[NSArray arrayWithArray:extraArray]];
    
    if ([self checkInformationCompeleted:_postData]) {
        ADAPI_CreatMerchant([self genDelegatorID:@selector(creatMerchantPost:)], _postData.dictionary);
    }
}

- (void)creatMerchantPost:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed) {
    
        DictionaryWrapper *dataSource = wrapper.data;
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".EnterpriseId" string:[NSString stringWithFormat:@"%d",[dataSource getInt:@"EnterpriseId"]]];
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".EnterpriseLogoUrl" string:[dataSource getString:@"LogoUrl"]];
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".EnterpriseStatus" int:3];
        UINavigationController* navigationController = self.navigationController;
        [navigationController popViewControllerAnimated:FALSE];
        [navigationController popViewControllerAnimated:FALSE];
        [navigationController popViewControllerAnimated:FALSE];
    }else {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (BOOL)checkInformationCompeleted:(DictionaryWrapper*)dicWrapper {
    
    if ([[dicWrapper getArray:@"IndustryIds"] count] == 0) {
        
        [HUDUtil showErrorWithStatus:@"请选择行业类别"];
        return NO;
        
    }else if (![dicWrapper getString:@"Introduction"]||[[dicWrapper getString:@"Introduction"] isEqualToString:@""]) {
        
        [HUDUtil showErrorWithStatus:@"请填写商家简介"];
        return NO;
    }else if (![dicWrapper getString:@"Feature"]||[[dicWrapper getString:@"Feature"] isEqualToString:@""]) {
        
        [HUDUtil showErrorWithStatus:@"请填写特色优势"];
        return NO;
        
    }else if (![dicWrapper getString:@"BusinessLicenseNo"]||[[dicWrapper getString:@"BusinessLicenseNo"] isEqualToString:@""]){
    
        [HUDUtil showErrorWithStatus:@"请上传营业执照号码"];
        return NO;
    }else if (![dicWrapper getString:@"LogoPicId"]) {
        
        [HUDUtil showErrorWithStatus:@"请上传商家Logo"];
        return NO;
    }else if (![dicWrapper getString:@"BusinessLicensePicId"]) {
        
        [HUDUtil showErrorWithStatus:@"请上传公司资质"];
        return NO;
    }
//    else {
//    
//        if ([APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTINTRODUCE"] == 1) {
//            
//            [HUDUtil showErrorWithStatus:@"请修改商家介绍！"];
//            return NO;
//        }
//        
//        if ([APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTFEATURE"] == 1) {
//            
//            [HUDUtil showErrorWithStatus:@"请修改商家特色！"];
//            return NO;
//        }
//        
//        if ([APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTLOGO"] == 1) {
//            
//            [HUDUtil showErrorWithStatus:@"请修改商家Logo！"];
//            return NO;
//        }
//    
//        if ([APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTCERTIFICATION"] == 1) {
//            
//            [HUDUtil showErrorWithStatus:@"请重新上传商家资质！"];
//            return NO;
//        }
//    
//        if ([APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTBUSINESSLICENCE"] == 1) {
//            
//            [HUDUtil showErrorWithStatus:@"请重新填写营业执照号"];
//            return NO;
//        }
//        if ([APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTEXTRAERROR1_1"] == 1) {
//            
//            [HUDUtil showErrorWithStatus:@"请重新上传税务登记证"];
//            return NO;
//        }
//        if ([APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTEXTRAERROR1_2"] == 1) {
//            
//            [HUDUtil showErrorWithStatus:@"请重新上传组织结构代码证"];
//            return NO;
//        }
    return YES;
//    }
}

- (IBAction)uploadButtonClicked:(UIButton*)sender {
    
    _imageChoose = sender.tag;
    [self showActionSheet];
}

//点击按钮
- (void)showActionSheet {
    
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照上传",@"相册选取", nil];
    }else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
    
    [sheet release];
}

//点击图片
- (void)showActionSheet1:(UIButton*)sender {

    
    _imageChoose = sender.tag;
    
    switch (_imageChoose) {
        case 1:{
            self.logoErrorBubble.hidden = YES;
            self.merchantLogoImage.layer.borderWidth = 0;
            break;}
        case 2:{
            
            self.certificationErrorBubble.hidden = YES;
            self.merchantQualificationImage.layer.borderWidth = 0;
            break;}
            
        case 11:{
            
            self.extraErrorBubble1_1.hidden = YES;
            self.extraView1_Image1.layer.borderWidth = 0;
            break;}
        case 12:{
            
            self.extraErrorBubble1_2.hidden = YES;
            self.extraView1_Image2.layer.borderWidth = 0;
            break;}
        case 21:{
            
            break;}
        case 31:{
            
            break;}
        case 32:{
            
            break;}
        case 33:{
            
            break;}
        default:
            break;
    }
    
    UIActionSheet *sheet;
    //判断是否支持相机again
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        if (_imageChoose == 11 || _imageChoose == 12) {
            
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"预览",@"拍照上传",@"相册选取",@"删除",nil];
        }else {
            
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"预览",@"拍照上传",@"相册选取",nil];
        }
    }else {
    
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"预览",@"相册选取",@"删除",nil];
    }
    
    sheet.tag = 266;
    
    [sheet showInView:self.view];

    [sheet release];
}

#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 255) {
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                    
                case 0:
                    // 相机
                    [UICommon showCamera:self view:self allowsEditing:NO];
                    break;
                case 1:
                    // 相册
                    [UICommon showImagePicker:self view:self];
                    
                    break;
                    //取消
                case 2:
                    return;
            }
        }else {
            if(buttonIndex == 0)
            {
                [UICommon showImagePicker:self view:self];
            }
        }
    }
    
    if (actionSheet.tag == 266) {
        
        
        BOOL supportCamara;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            supportCamara = YES;
            switch (buttonIndex) {
                    
                case 0:
                    // 预览
                    [self previewPicFromUrl];
                    break;
                case 1:
                    // 相机
                    [UICommon showCamera:self view:self allowsEditing:NO];
                    break;
                case 2:
                    //相册
                    [UICommon showImagePicker:self view:self];
                    break;
                    //删除或取消
                case 3:
                    
                    //删除
                    if (_imageChoose == 11 || _imageChoose == 12) {
                        
                        switch (_imageChoose) {
                            case 11:{
                                
                                self.picID_1_1 = nil;
                                self.picURL_1_1 = nil;
                                [self.extraView1_Image1 setImage:nil];
                                
                                self.extraView1_Image1.hidden = YES;
                                for (UIButton *btn in [_extraView1 subviews]) {
                                    
                                    if (btn.tag == 11 && !btn.hidden) {
                                        
                                        [btn removeFromSuperview];
                                    }
                                    
                                }
                                self.extraView1_Button1.hidden = NO;
                                [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTEXTRAERROR1_1" int:1];
                                break;}
                            case 12:{
                                
                                self.picID_1_2 = nil;
                                self.picURL_1_2 = nil;
                                [self.extraView1_Image2 setImage:nil];
                                self.extraView1_Image2.hidden = YES;
                                
                                for (UIButton *btn in [_extraView1 subviews]) {
                                    
                                    if (btn.tag == 12 && !btn.hidden) {
                                        
                                        [btn removeFromSuperview];
                                    }
                                }
                                self.extraView1_Button2.hidden = NO;
                                [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTEXTRAERROR1_2" int:1];
                                break;}
                                
                            default:
                                break;
                        }
                    }else {
                    
                        return;
                    }
                    return;
                    //取消
                case 4:
                    return;
            }
        }else {
            supportCamara = NO;
            switch (buttonIndex) {
                    //预览
                case 0:
                    [self previewPicFromUrl];
                    break;
                    //相册
                case 1:
                    [UICommon showImagePicker:self view:self];
                    break;
                    //删除或取消
                case 2:
                    
                    //删除
                    if (_imageChoose == 11 || _imageChoose == 12) {
                        
                        switch (_imageChoose) {
                            case 11:{
                                
                                self.picID_1_1 = nil;
                                self.picURL_1_1 = nil;
                                [self.extraView1_Image1 setImage:nil];
                                self.extraView1_Image1.hidden = YES;
                                
                                for (UIButton *btn in [_extraView1 subviews]) {
                                    
                                    if (btn.tag == 11 && !btn.hidden) {
                                        
                                        [btn removeFromSuperview];
                                    }
                                }
                                self.extraView1_Button1.hidden = NO;
                                [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTEXTRAERROR1_1" int:1];
                                break;}
                            case 12:{
                                
                                self.picID_1_2 = nil;
                                self.picURL_1_2 = nil;
                                [self.extraView1_Image2 setImage:nil];
                                self.extraView1_Image2.hidden = YES;
                                
                                for (UIButton *btn in [_extraView1 subviews]) {
                                    
                                    if (btn.tag == 12 && !btn.hidden) {
                                        
                                        [btn removeFromSuperview];
                                    }
                                    
                                }
                                self.extraView1_Button2.hidden = NO;
                                [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTEXTRAERROR1_2" int:1];
                                break;}
                            default:
                                break;
                        }
                    }else {
                        
                        return;
                    }
                    return;
                    //取消
                case 3:
                    return;
            }
        }
    }
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    UIImage *image =  [info objectForKey:UIImagePickerControllerOriginalImage];
    NSURL *assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
        
    ALAssetsLibrary *library = [[[ALAssetsLibrary alloc] init] autorelease];
    [library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
        UIImage *preview = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
        
        int type = 0;
        
        if (_imageChoose == 1) {
            
            type = 1 << 0;
        }else {
        
            type = 1 << 5;
        }
        
        EditImageViewController *imageEditor = WEAK_OBJECT(EditImageViewController,
                                                            initWithNibName:@"EditImageViewController"
                                                            bundle:nil
                                                            ImgType:type);
        imageEditor.rotateEnabled = YES;
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

- (void)passImage:(UIImage *)image {
    
    self.imageUserChoosed = [image compressedImage];
    ADAPI_Picture_Upload([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleUploadPic:)], UIImagePNGRepresentation(_imageUserChoosed));
}

- (void)handleUploadPic:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        DictionaryWrapper *dataSource = wrapper.data;
    
        [HUDUtil showSuccessWithStatus:@"上传成功"];
        
        switch (_imageChoose) {
            case 1:{
                
                self.merchantLogoPicId = [[dataSource getString:@"PictureId"] copy];
                self.merchantLogoPicUrl = [[dataSource getString:@"PictureUrl"] copy];
                [self.merchantLogoImage setImage:_imageUserChoosed];
                _merchantLogoImage.hidden = NO;
                _merchantLogoButton.hidden = YES;
                
                self.logoErrorBubble.hidden = YES;
                [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTLOGO" int:0];
                
                UIButton *button = WEAK_OBJECT(UIButton, init);
                button.tag = 1;
                [button setFrame:_merchantLogoImage.frame];
                [button addTarget:self action:@selector(showActionSheet1:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundColor:[UIColor clearColor]];
                [_logoView addSubview:button];
                break;}
            case 2:{
                
                self.businessLicencePicId = [[dataSource getString:@"PictureId"] copy];
                self.businessLicencePicUrl = [[dataSource getString:@"PictureUrl"] copy];
                [self.merchantQualificationImage setImage:_imageUserChoosed];
                _merchantQualificationImage.hidden = NO;
                _merchantQualificationButton.hidden = YES;
                
                self.certificationErrorBubble.hidden = YES;
                [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTCERTIFICATION" int:0];
                
                UIButton *button = WEAK_OBJECT(UIButton, init);
                button.tag = 2;
                [button setFrame:_merchantQualificationImage.frame];
                [button addTarget:self action:@selector(showActionSheet1:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundColor:[UIColor clearColor]];
                [_zizhiView addSubview:button];
                
                break;}
                
            case 11:{
                
                self.picID_1_1 = [[dataSource getString:@"PictureId"] copy];
                self.picURL_1_1 = [[dataSource getString:@"PictureUrl"] copy];
                [self.extraView1_Image1 setImage:_imageUserChoosed];
                self.extraView1_Button1.hidden = YES;
                self.extraView1_Image1.hidden = NO;
                
                [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTEXTRAERROR1_1" int:0];
                
                UIButton *button = WEAK_OBJECT(UIButton, init);
                button.tag = 11;
                [button setFrame:_extraView1_Image1.frame];
                [button addTarget:self action:@selector(showActionSheet1:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundColor:[UIColor clearColor]];
                [_extraView1 addSubview:button];
                break;}
            case 12:{
                
                self.picID_1_2 = [[dataSource getString:@"PictureId"] copy];
                self.picURL_1_2 = [[dataSource getString:@"PictureUrl"] copy];
                [self.extraView1_Image2 setImage:_imageUserChoosed];
                self.extraView1_Image2.hidden = NO;
                self.extraView1_Button2.hidden = YES;
                
                [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTEXTRAERROR1_2" int:0];
                
                UIButton *button = WEAK_OBJECT(UIButton, init);
                button.tag = 12;
                [button setFrame:_extraView1_Image2.frame];
                [button addTarget:self action:@selector(showActionSheet1:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundColor:[UIColor clearColor]];
                [_extraView1 addSubview:button];
                break;}
            case 21:{
                
                self.picID_2_1 = [[dataSource getString:@"PictureId"] copy];
                self.picURL_2_1 = [[dataSource getString:@"PictureUrl"] copy];
                [self.extraView2_Image1 setImage:_imageUserChoosed];
                self.extraView2_Image1.hidden = NO;
                self.extraView2_Button1.hidden = YES;
                
                UIButton *button = WEAK_OBJECT(UIButton, init);
                button.tag = 21;
                [button setFrame:_extraView2_Image1.frame];
                [button addTarget:self action:@selector(showActionSheet1:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundColor:[UIColor clearColor]];
                [_extraView2 addSubview:button];
                
                break;}
            case 31:{
                
                self.picID_3_1 = [[dataSource getString:@"PictureId"] copy];
                self.picURL_3_1 = [[dataSource getString:@"PictureUrl"] copy];
                
                [self.extraView3_Image1 setImage:_imageUserChoosed];
                self.extraView3_Image1.hidden = NO;
                self.extraView3_Button1.hidden = YES;
                
                UIButton *button = WEAK_OBJECT(UIButton, init);
                button.tag = 31;
                [button setFrame:_extraView3_Image1.frame];
                [button addTarget:self action:@selector(showActionSheet1:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundColor:[UIColor clearColor]];
                [_extraView3 addSubview:button];
                
                break;}
            case 32:{
                
                self.picID_3_2 = [[dataSource getString:@"PictureId"] copy];
                self.picURL_3_2 = [[dataSource getString:@"PictureUrl"] copy];
                
                [self.extraView3_Image2 setImage:_imageUserChoosed];
                self.extraView3_Image2.hidden = NO;
                self.extraView3_Button2.hidden = YES;
                
                UIButton *button = WEAK_OBJECT(UIButton, init);
                button.tag = 32;
                [button setFrame:_extraView3_Image2.frame];
                [button addTarget:self action:@selector(showActionSheet1:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundColor:[UIColor clearColor]];
                [_extraView3 addSubview:button];
                
                break;}
            case 33:{
                
                self.picID_3_3 = [[dataSource getString:@"PictureId"] copy];
                self.picURL_3_3 = [[dataSource getString:@"PictureUrl"] copy];
                
                [self.extraView3_Image3 setImage:_imageUserChoosed];
                self.extraView3_Image3.hidden = NO;
                self.extraView3_Button3.hidden = YES;
                
                UIButton *button = WEAK_OBJECT(UIButton, init);
                button.tag = 33;
                [button setFrame:_extraView3_Image3.frame];
                [button addTarget:self action:@selector(showActionSheet1:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundColor:[UIColor clearColor]];
                [_extraView3 addSubview:button];
                
                break;}
            default:
                break;
        }
    }else{
        [HUDUtil showErrorWithStatus:@"上传失败"];
    }
}


//预览图片
- (void)previewPicFromUrl{
    
    NSMutableArray *tempArray = WEAK_OBJECT(NSMutableArray, init);
    
    if (_merchantLogoPicUrl.length && ![_merchantLogoPicUrl isKindOfClass:[NSNull class]]) {
        
        NSDictionary *url1 = [[NSDictionary alloc]initWithObjectsAndKeys:_merchantLogoPicUrl,@"PictureUrl",nil];
        [tempArray addObject:url1];
    }
    
    if (_businessLicencePicUrl.length && ![_businessLicencePicUrl isKindOfClass:[NSNull class]]) {

        NSDictionary *url2 = [[NSDictionary alloc]initWithObjectsAndKeys:_businessLicencePicUrl,@"PictureUrl",nil];
        [tempArray addObject:url2];
    }
    
    if (_picURL_1_1.length && ![_picURL_1_1 isKindOfClass:[NSNull class]]) {
    
        NSDictionary *url3 = [[NSDictionary alloc]initWithObjectsAndKeys:_picURL_1_1,@"PictureUrl",nil];
        [tempArray addObject:url3];
    }
    
    if (_picURL_1_2.length && ![_picURL_1_2 isKindOfClass:[NSNull class]]) {
        
        NSDictionary *url4 = [[NSDictionary alloc]initWithObjectsAndKeys:_picURL_1_2,@"PictureUrl",nil];
        [tempArray addObject:url4];
    }

    if (_picURL_2_1.length && ![_picURL_2_1 isKindOfClass:[NSNull class]]) {
        
        NSDictionary *url5 = [[NSDictionary alloc]initWithObjectsAndKeys:_picURL_2_1,@"PictureUrl",nil];
        [tempArray addObject:url5];
    }

    if (_picURL_3_1.length && ![_picURL_3_1 isKindOfClass:[NSNull class]]) {
   
        NSDictionary *url6 = [[NSDictionary alloc]initWithObjectsAndKeys:_picURL_3_1,@"PictureUrl",nil];
        [tempArray addObject:url6];
    }

    if (_picURL_3_2.length && ![_picURL_3_2 isKindOfClass:[NSNull class]]) {
    
        NSDictionary *url7 = [[NSDictionary alloc]initWithObjectsAndKeys:_picURL_3_2,@"PictureUrl",nil];
        [tempArray addObject:url7];
    }
    
    if (_picURL_3_3.length && ![_picURL_3_3 isKindOfClass:[NSNull class]]) {
        
        NSDictionary *url8 = [[NSDictionary alloc]initWithObjectsAndKeys:_picURL_3_3,@"PictureUrl",nil];
        [tempArray addObject:url8];
    }
    PreviewViewController *temp = WEAK_OBJECT(PreviewViewController, init);
    temp.dataArray = [NSArray arrayWithArray:tempArray];
    [self presentViewController:temp animated:YES completion:^{
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _industryCategory) {
        
        self.industryCategoryPage = WEAK_OBJECT(IndustryCategotiesViewController, init);
        self.industryCategoryPage.delegateForSpecialQualification = self;
        [self.navigationController pushViewController:_industryCategoryPage animated:YES];
        return NO;
    }else{
        
        switch (textField.tag) {
            case 10:
                
                self.advantageErrorBubble.hidden = YES;
                self.merchantAdvantageTextField.textColor = AppColor(85);
                _middleTextFieldBeginEditing = YES;
                break;
            case 11:
                _middleTextFieldBeginEditing = YES;
                break;
            case 12:
                
                self.businessLicenceErrorBubble.hidden = YES;
                self.businessLicenceTextField.textColor = AppColor(85);
            
                _buttomTextFieldBeginEditing = YES;
                break;
                
            default:
                break;
        }
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".IFEDITED" int:1];
    switch (textField.tag) {
        case 10:
            
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTFEATURE" int:0];
            break;
        case 11:
            
            break;
        case 12:
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTBUSINESSLICENCE" int:0];
            break;
        default:
            break;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    switch (textField.tag) {
        case 10:
            if ([aString length] > 20) {
                textField.text = [aString substringToIndex:20];
                [HUDUtil showErrorWithStatus:@"最多可输入20字"];
            return NO;
        }
        case 11:
            break;
        case 12:
            if ([aString length] > 50) {
                textField.text = [aString substringToIndex:50];
                [HUDUtil showErrorWithStatus:@"最多可输入50位"];
                return NO;
            }
        default:
            break;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    switch (textField.tag) {
        case 10:
            
            self.merchantAdvantageStr = textField.text;
            _middleTextFieldBeginEditing = NO;
            break;
        case 11:
            
            self.serviceNumberStr = textField.text;
            _middleTextFieldBeginEditing = NO;
            break;
        case 12:
            
            self.businessLicenceStr = textField.text;
            _buttomTextFieldBeginEditing = NO;
            break;
        default:
            break;
    }
}

#pragma mark -UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    
    _introduceLabel.hidden = textView.text.length != 0;
    self.merchantIntroduce.textColor = AppColor(85);
    self.introduceErrorBubble.hidden = YES;
    [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTINTRODUCE" int:0];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([aString length] > 100) {
        textView.text = [textView.text substringToIndex:100];
        [HUDUtil showErrorWithStatus:@"最多可输入100字"];
        return NO;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {

    self.merchantIntroduceStr = textView.text;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_merchantLogoPicId release];
    [_merchantLogoPicUrl release];
    [_businessLicencePicId release];
    [_businessLicencePicUrl release];
    
    [_oldData release];
    [_businessLicenceStr release];
    [_serviceNumberStr release];
    [_merchantAdvantageStr release];
    [_merchantIntroduceStr release];
    [_choosedIndustryDetailIds release];
    [_industryCategoryPage release];
    [_detailChoosedStr release];
    [_postData release];
    [_merchantIntroduce release];
    [_introduceLabel release];
    [_industryCategory release];
    [_merchantLogoImage release];
    [_merchantLogoButton release];
    [_merchantQualificationImage release];
    [_merchantQualificationButton release];
    [_mainScrollerView release];
    [_merchantAdvantageTextField release];
    [_serviceNumberTextField release];
    [_businessLicenceTextField release];
    [_aboveView release];
    [_belowView release];
    
    [_introduceErrorBubble release];
    [_advantageErrorBubble release];
    [_logoErrorBubble release];
    [_certificationErrorBubble release];
    [_businessLicenceErrorBubble release];
    [_imageUserChoosed release];
    [_UILineView release];
    [_extraView1 release];
    [_extraView2 release];
    [_extraView3 release];
    [_UILineView2 release];
    [_extraView1_Image1 release];
    [_extraView1_Image2 release];
    [_extraView2_Image1 release];
    [_extraView3_Image1 release];
    [_extraView3_Image2 release];
    [_extraView3_Image3 release];
    [_extraView1_Button1 release];
    [_extraView1_Button2 release];
    [_extraView2_Button1 release];
    [_extraView3_Button1 release];
    [_extraView3_Button2 release];
    [_extraView3_Button3 release];
    [_picID_1_1 release];
    [_picID_1_2 release];
    [_picID_2_1 release];
    [_picID_3_1 release];
    [_picID_3_2 release];
    [_picID_3_3 release];
    [_picURL_1_1 release];
    [_picURL_1_2 release];
    [_picURL_2_1 release];
    [_picURL_3_1 release];
    [_picURL_3_2 release];
    [_picURL_3_3 release];
    [_extraErrorBubble1_1 release];
    [_extraErrorBubble1_2 release];
    [_topReasonView release];
    [_reasonLbl release];
    [_logoView release];
    [_logoReasonView release];
    [_zizhiView release];
    [_zizhiReasonView release];
    [_logoReasonLbl release];
    [_zizhiReasonLbl release];
    [_logoBottomLine release];
    [_shuiLbl release];
    [_topReasonLine release];
    [_logoLine release];
    [_zizhiBottomLine release];
    [super dealloc];
}
@end
