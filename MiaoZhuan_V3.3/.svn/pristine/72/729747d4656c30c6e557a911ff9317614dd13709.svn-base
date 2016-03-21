//
//  YinYuanAdvertEditController.m
//  miaozhuan
//
//  Created by momo on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanAdvertEditController.h"
#import "YinYuanProdEditSubController.h"
#import "YinYuanAdvertEditSubController.h"
#import "YinYuanAdvertBindingProdController.h"
#import "PSTCollectionView.h"
#import "AddPictureCell.h"
#import "PreviewViewController.h"
#import "SendOutAreaViewController.h"
#import "AccurateService.h"
#import "CRInfoNotify.h"
#import "WebhtmlViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import "EditImageViewController.h"
#import "RRLineView.h"

@interface YinYuanAdvertEditController ()<PSTCollectionViewDataSource, PSTCollectionViewDelegate, UIImagePickerControllerDelegate>
{
    PSTCollectionView *_collectionview;
    NSInteger _deleteIndex;
    NSInteger _currentItem;//选择的某个图片
    
}

@property (nonatomic, retain) NSMutableArray *pickedUrls;
@property (nonatomic, retain) NSMutableArray *pickedIds;
@property (retain, nonatomic) IBOutlet RRLineView *line;
@property (retain, nonatomic) IBOutlet RRLineView *line2;
@property (retain, nonatomic) IBOutlet RRLineView *line3;
@property (nonatomic, retain) DictionaryWrapper * wrapDic;
@property (retain, nonatomic) IBOutlet UIView *topReasonView;
@property (retain, nonatomic) IBOutlet UILabel *topReasonLbl;
@property (retain, nonatomic) IBOutlet UIView *firstReasonView;
@property (retain, nonatomic) IBOutlet UILabel *firstReasonLbl;
@property (retain, nonatomic) IBOutlet UIView *picView;
@property (retain, nonatomic) IBOutlet UIView *picReasonView;
@property (retain, nonatomic) IBOutlet UILabel *picReasonLbl;
@property (retain, nonatomic) IBOutlet UIView *topNavView;
@property (retain, nonatomic) IBOutlet RRLineView *topLine;
@property (retain, nonatomic) IBOutlet RRLineView *navTopLine;
@property (retain, nonatomic) IBOutlet RRLineView *topReasonLine;

@end


@implementation YinYuanAdvertEditController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"存入草稿"];
    
    [_mainScrollView setContentSize:CGSizeMake(320, _firstView.bottom + 80)];
    
    _telIconBtn.selected = YES;
    
    _addressIconBtn.selected = YES;
    
    _topLine.top = 49.5;
    
    _navTopLine.top = 64.5;
    
    _srcData = STRONG_OBJECT(NSMutableDictionary, init);
    
    _bindingProdArr = STRONG_OBJECT(NSMutableArray, init);
    
    self.userDic = STRONG_OBJECT(NSMutableDictionary, init);
    
    _PushRegionals = STRONG_OBJECT(NSMutableArray, init);
    
    _notifyPicMsg = STRONG_OBJECT(NSMutableDictionary, init);
    
    self.ADsDes = @"";
    
    _datePickerView = STRONG_OBJECT(DatePickerViewController, initWithNibName:@"DatePickerViewController" bundle:nil);
    
    CGFloat offset = [UICommon getIos4OffsetY];
    
    _datePickerView.view.frame = CGRectMake(0, 0, 320, 460 + offset);
    
    _datePickerView.delegate = self;
    
    NSLocale * loca = WEAK_OBJECT(NSLocale, initWithLocaleIdentifier:@"zh_CN");
    
    [_datePickerView.picker setLocale:loca ];
   
    _datePickerView.picker.timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    
    NSDate * today = [NSDate date];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    NSDate *tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    
    _datePickerView.picker.minimumDate = tomorrow;
    
    _sexType = 0;
    
    [self registerForKeyboardNotifications];
    
    [self _initData];
    
    [self fixView];
}

- (void) fixView
{
    _line.top = 49.5;
    
    _line2.top = 49.5;
    
    _line3.top = 49.5;
}

- (void) _initData
{
    _currentItem = -1;
    _deleteIndex = -1;
    
    self.pickedUrls = [NSMutableArray arrayWithCapacity:0];
    self.pickedIds = [NSMutableArray arrayWithCapacity:0];
    
    [self _initPstCollectionView];
    
    if(_isEdit)
    {
        ADAPI_SilverAdvertEnterpriseGetAdvertDetail([self genDelegatorID:@selector(handleGetAdvertDetail:)], _advertId);
        
        [self setNavigateTitle:@"设置银元广告"];

    }
    else{
        
        DictionaryWrapper* dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
        
        ADAPI_Enterprise_ContactInfo([self genDelegatorID:@selector(EnterpriseContactInfo:)], [dic getString:@"EnterpriseId"]);
        
        [self setNavigateTitle:@"新增银元广告"];
        
        [AccurateService clearData];

    }
}

- (void)handleGetAdvertDetail:(DelegatorArguments *)arguments{
    
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed) {
        
        if(dic.data)
        {
            [_srcData removeAllObjects];
            
            [self setSrcDataView:dic];
            
            [AccurateService saveData:[dic.data wrapper] isYinyuan:YES];
        }
        
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (void) setSrcDataView:(DictionaryWrapper *)dic
{
    DictionaryWrapper * wrap = dic.data;
    
    self.wrapDic = dic.data;
    
    [_srcData setObject:[wrap getString:@"Id"] forKey:@"Id"];
    
    NSString * name = [wrap getString:@"Title"];
    
    if(name.length)
    {
        [_srcData setObject:name forKey:@"Title"];
        
        _titleField.text = name;
    }
    
    NSArray * picArr = [wrap getArray:@"Pictures"];
    
    if(picArr.count)
    {
        for(NSDictionary * dic in picArr)
        {
            [_pickedIds addObject:[dic.wrapper getString:@"PictureId"]];
            
            [_pickedUrls addObject:[dic.wrapper getString:@"PictureUrl"]];
        }
        [self countHeight];
        [_collectionview reloadData];
    }
    
    NSString * des = [wrap getString:@"Content"];
    if(des.length)
    {
        [_srcData setObject:des forKey:@"Content"];
        
        [_desBtn setTitle:@"已填写" forState:UIControlStateNormal];
        
        self.ADsDes = des;
    }
    
    des = [wrap getString:@"Slogan"];
    if(des.length)
    {
        [_srcData setObject:des forKey:@"Slogan"];
        _sloganField.text = des;
    }
    
    des = [wrap getString:@"SloganCoreWord"];
    if(des.length)
    {
        [_srcData setObject:des forKey:@"SloganCoreWord"];
        _keywordField.text = des;
    }
    
    des = [wrap getString:@"LinkUrl"];
    if(des.length)
    {
        [_srcData setObject:des forKey:@"LinkUrl"];
        
        _webField.text = des;
    }
    
    des = [wrap getString:@"Tel"];
    if(des.length)
    {
        [_srcData setObject:des forKey:@"Tel"];
        
        _telField.text = des;
    }
    
    des = [wrap getString:@"Address"];
    if(des.length)
    {
        [_srcData setObject:des forKey:@"Address"];
        
        _addressField.text = des;
    }
    
    BOOL isShowTel = [wrap getBool:@"IsShowTel"];
    _telIcon.image = isShowTel ? [UIImage imageNamed:@"findShopfilterSelectBtn"] : [UIImage imageNamed:@"findShopfilterBtn"];
    _telIconBtn.selected = isShowTel;
    
    isShowTel = [wrap getBool:@"IsShowAddress"];
    _addressIcon.image = isShowTel ? [UIImage imageNamed:@"findShopfilterSelectBtn"] : [UIImage imageNamed:@"findShopfilterBtn"];
    _addressIconBtn.selected = isShowTel;
    
    des = [wrap getString:@"AdvertType"];
    if(des.length)
    {
        [_srcData setObject:des forKey:@"AdvertType"];
    }
    
    NSArray * prodArr = [wrap getArray:@"SilverProducts"];
    
    if(prodArr.count)
    {
        [_bindingProdArr removeAllObjects];
        
        [_bindingProdArr addObjectsFromArray:prodArr];
        
        [_bindingProdBtn setTitle:@"已绑定" forState:UIControlStateNormal];
    }
    else
    {
        [_bindingProdBtn setTitle:@"未绑定" forState:UIControlStateNormal];
    }
    
    des = [wrap getString:@"SingleUserPutNumber"];
    if(des.length && [des intValue] != 0)
    {
        [_srcData setObject:des forKey:@"SingleUserPutNumber"];
        _totalCountField.text = des;
    }
    
    des = [wrap getString:@"EveryDayPutNumber"];
    if(des.length && [des intValue] != 0)
    {
        [_srcData setObject:des forKey:@"EveryDayPutNumber"];
        _dayCountField.text = des;
        
    }
    
    NSString * startT = [wrap getString:@"StartTime"];
    NSString * endT = [wrap getString:@"EndTime"];
    
    if(startT.length)
    {
        [_srcData setObject:startT forKey:@"StartTime"];
        
        startT = [UICommon formatDate:startT];
        
        self.startDate = [UICommon dateShortFromString:startT];
        
        [_startDateBtn setTitle:startT forState:UIControlStateNormal];
    }
    if(endT.length)
    {
        [_srcData setObject:endT forKey:@"EndTime"];
        
        endT = [UICommon formatDate:endT];
        
        self.endDate = [UICommon dateShortFromString:endT];
        
        [_endDateBtn setTitle:endT forState:UIControlStateNormal];
    }
    
    NSArray * locaArr = [wrap getArray:@"PushRegionals"];
    
    if(locaArr.count)
    {
        [_PushRegionals removeAllObjects];
        
        [_PushRegionals addObjectsFromArray:locaArr];
        
        [_areaBtn setTitle:@"已设置" forState:UIControlStateNormal];
    }
    
    _sexType = [wrap getInt:@"PutSex"];
    
    NSString * minAge = [wrap getString:@"PutMinAge"];
    if(minAge.length)
    {
        [_srcData setObject:minAge forKey:@"PutMinAge"];
    }
    
    NSString * maxAge = [wrap getString:@"PutMaxAge"];
    if(maxAge.length)
    {
        [_srcData setObject:maxAge forKey:@"PutMaxAge"];
    }
    
    NSArray * incomesArr = [wrap getArray:@"PutAnnualIncomes"];
    
    NSMutableArray * arr = WEAK_OBJECT(NSMutableArray, init);
    
    NSMutableArray * userIncomArr = WEAK_OBJECT(NSMutableArray, init);
    
    for (NSDictionary * dic in incomesArr) {
        
        if([dic.wrapper getBool:@"IsSelected"])
        {
            [arr addObject:[dic.wrapper getString:@"Id"]];
            
            [userIncomArr addObject:dic];
        }
    }
    
    NSString * userText = @"已设置 ";
    
    if(_sexType != 0)
    {
        userText = [userText stringByAppendingString:@"性别 "];
    }
    
    NSString * isQuesAll = @"1";
    
    if(arr.count)
    {
        if(arr.count < incomesArr.count)
        {
            userText = [userText stringByAppendingString:@"年收入 "];
            
            [_srcData setObject:arr forKey:@"PutAnnualIncomeOptions"];
            
            isQuesAll = @"0";
        }
    }
    
    if([minAge intValue] == 0 && [maxAge intValue] == 0)
    {
        maxAge = @"100";
    }
    else if([minAge intValue] >= 0 && [maxAge intValue] <= 100)
    {
        userText = [userText stringByAppendingString:@"年龄"];
    }
    
    if([userText isEqualToString:@"已设置 "])
    {
        userText = @"不限";
    }
    
    [_userBtn setTitle:userText forState:UIControlStateNormal];
    
    [_userDic setObject:[NSNumber numberWithInteger:_sexType] forKey:@"PutSex"];
    [_userDic setObject: minAge forKey:@"PutMinAge"];
    [_userDic setObject: maxAge forKey:@"PutMaxAge"];
    [_userDic setObject: isQuesAll forKey:@"isQuesAll"];
    [_userDic setObject: userIncomArr forKey:@"PutAnnualIncomeOptions"];
    
    NSDictionary * auditDic = [wrap getDictionary:@"AuditMessage"];
    
    if(auditDic && _isFail)
    {
        [self showFailReason:auditDic ];
    }
    
}

- (void) showAuditStatus:(BOOL)auditStatus textField:(UITextField *) textField Notify:(CRInfoNotify *)notify Name:(NSString *)text View:(UIView *)view point:(CGPoint)point
{
    if(auditStatus)
    {
        [view addSubview:notify];
        
        [notify display:YES];
        
        textField.tag = 1;
        
        textField.textColor = [UIColor titleRedColor];
    }
    else
    {
        [notify display:NO];
    }
}

- (void) showPicAuditStatus:(NSArray *)picArr
{
    for(NSDictionary * dic in picArr)
    {
        NSString * msg = [dic.wrapper getString:@"AuditMessage"];
        
        if(msg.length)
        {
            NSString * picId = [dic.wrapper getString:@"PictureId"];
            
            [_notifyPicMsg setObject:msg forKey:picId];
        }
    }
    
    [self setNotifyFrame];

}

- (void) setNotifyFrame
{
    for (int i = 0; i < _pickedIds.count; i ++) {
        
        NSString * picId = _pickedIds[i];
        
        NSString * msg = [_notifyPicMsg.wrapper getString:picId];
        
        if(msg.length)
        {
            int row = i / 3;
            
            int index = i % 3;
            
            if(_isFail)
            {
                CRInfoNotify * noti = (CRInfoNotify *) [self.firstView viewWithTag:1000 + i];
                
                if(!noti)
                {
                    noti = STRONG_OBJECT(CRInfoNotify, initWith:msg at: CGPointMake(100 + 100 * index, Y(_collectionview) + 10 + 135 * row));
                    
                    noti.tag = 1000 + i;
                    
                    [_firstView addSubview:noti];
                }
                else
                {
                    [noti display:YES];
                }
            }
        }
    }
}

- (void) showAuditStatus:(BOOL)auditStatus Button:(UIButton *) btn Notify:(CRInfoNotify *)notify Name:(NSString *)text View:(UIView *)view point:(CGPoint)point
{
    if(auditStatus)
    {
        [view addSubview:notify];
        
        [notify display:YES];
        
        btn.tag = 1;
        
        btn.titleLabel.textColor = [UIColor titleRedColor];
    }
    else
    {
        [notify display:NO];
    }
}

- (void) showFailReason:(NSDictionary *)dic
{
    DictionaryWrapper * auditDic = dic.wrapper;
    
    NSString * text = [auditDic getString:@"OtherErrmsg"];
//    NSString * text = @"测试测试测试测\n试测试测试测试测试测试测\n试测试测试测试测试测试";
    
    if(text)
    {
        _topReasonView.hidden = NO;
        
        _topReasonLbl.text = text;
        
        CGSize textSize = [UICommon getSizeFromString:text
                                             withSize:CGSizeMake(_topReasonLbl.width, MAXFLOAT)
                                             withFont:14];
        _topReasonLbl.height = textSize.height < 30 ? 30 : textSize.height;
        
        _topReasonView.height = _topReasonLbl.bottom + 15;
        
        _topReasonLine.top = _topReasonView.height - 0.5;
        
        _topNavView.top = _topReasonView.bottom;
        
    }
    
    text = [auditDic getString:@"BasicErrmsg"];
//    text = @"测试测试测试测试";

    if(text)
    {
        _firstReasonView.hidden = NO;
        
        _firstReasonLbl.text = text;
        
        [_firstView bringSubviewToFront:_firstReasonView];
        
        _firstTopView.top = _firstReasonView.bottom - 16;
        
    }
    
    text = [auditDic getString:@"PicErrmsg"];
//    text = @"测试测试测试测试";

    if(text)
    {
        _picReasonView.hidden = NO;
        
        _picReasonView.top = _firstTopView.bottom + 10;
        
        [_firstView bringSubviewToFront:_picReasonView];
        
        _picReasonLbl.text = text;
        
        _picView.top = _picReasonView.bottom - 16;
        
    }
    else
    {
        _picView.top = _firstTopView.bottom + 10;
    }
    
    _mainScrollView.top = _topNavView.bottom;
    
    _collectionview.top = _picView.bottom - 10;
    
    _firstBottomView.top = _collectionview.bottom;
    
    CGRect rect = _firstView.frame;
    rect.size.height = _firstBottomView.bottom;
    _firstView.frame = rect;
    
    _mainScrollView.contentSize = CGSizeMake(SCREENWIDTH, _firstView.bottom + 80);
    
    
    text = [auditDic getString:@"ContentErrmsg"];
    
    BOOL status = text.length;
    
    CGPoint point = CGPointMake(298, 30);
    
    if(!_contentNotify)
    {
        _contentNotify = STRONG_OBJECT(CRInfoNotify, initWith:text at: point);
    }
    
    [self showAuditStatus:status Button:_desBtn Notify:_contentNotify Name:text View:_firstBottomView point: point];
    
    //
    text = [auditDic getString:@"UrlErrmsg"];
    
    status = text.length;
    
    point = CGPointMake(298, 30 + 50);
    
    if(!_linkNotify)
    {
        _linkNotify = STRONG_OBJECT(CRInfoNotify, initWith:text at: point);
    }
    
    [self showAuditStatus:status textField:_webField Notify:_linkNotify Name:text View:_firstBottomView point: point];
    
    //
    text = [auditDic getString:@"PhoneErrmsg"];
    
    status = text.length;
    
    point = CGPointMake(298 - 100, 40 + 50 * 2);
    
    if(!_telNotify)
    {
        _telNotify = STRONG_OBJECT(CRInfoNotify, initWith:text at: point);
    }
    
    [self showAuditStatus:status textField:_telField Notify:_telNotify Name:text View:_firstBottomView point: point];
    
    //
    text = [auditDic getString:@"AddressErrmsg"];
    
    status = text.length;
    
    point = CGPointMake(298 - 100, 40 + 50 * 3);
    
    if(!_addressNotify)
    {
        _addressNotify = STRONG_OBJECT(CRInfoNotify, initWith:text at: point);
    }
    
    [self showAuditStatus:status textField:_addressField Notify:_addressNotify Name:text View:_firstBottomView point: point];

}

- (void) showFailBubble:(NSDictionary *) dic
{
    DictionaryWrapper * auditDic = dic.wrapper;
    
    NSString * text = [auditDic getString:@"TitleValidRemark"];
    
    BOOL status = text.length;
    
    CGPoint point = CGPointMake(298, 30);
    
    if(!_titleNotify)
    {
        _titleNotify = STRONG_OBJECT(CRInfoNotify, initWith:text at: point);
    }
    
    [self showAuditStatus:status textField:_titleField Notify:_titleNotify Name:text View:_firstView point: point];
    
    
    NSArray * picArr = [auditDic getArray:@"PictureAuditMessages"];

    [self showPicAuditStatus:picArr];
    
    //
    text = [auditDic getString:@"SloganValidRemark"];
    
    status = text.length;
    
    point = CGPointMake(298, 30);
    
    if(!_sloganNotify)
    {
        _sloganNotify = STRONG_OBJECT(CRInfoNotify, initWith:text at: point);
    }
    
    [self showAuditStatus:status textField:_sloganField Notify:_sloganNotify Name:text View:_firstBottomView point: point];
    
    //
    text = [auditDic getString:@"SloganCoreWordValidRemark"];
    
    status = text.length;
    
    point = CGPointMake(298, 30 + 50);
    
    if(!_keywordNotify)
    {
        _keywordNotify = STRONG_OBJECT(CRInfoNotify, initWith:text at: point);
    }
    
    [self showAuditStatus:status textField:_keywordField Notify:_keywordNotify Name:text View:_firstBottomView point: point];
    
    //
    
}

- (void)countHeight{
    //计算高度
    NSInteger count = _pickedUrls.count + 1;
    NSInteger row = (count % 3) ? (count / 3 + 1) : count / 3;
    float height = row * (115 + 20);
    
    _collectionview.height = height;
    
    //计算高度
    _firstBottomView.top = _collectionview.bottom;
    
    CGRect rect = _firstView.frame;
    rect.size.height = _firstBottomView.bottom;
    _firstView.frame = rect;
    
    _mainScrollView.contentSize = CGSizeMake(SCREENWIDTH, _firstView.bottom + 80);
}

#pragma mark - uiacrionshee delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag >= 1000 && actionSheet.tag < 1000000) {
        
        if (buttonIndex == 0) {
            //预览
            PreviewViewController *preview = WEAK_OBJECT(PreviewViewController, init);
            preview.dataArray = @[@{@"PictureUrl":_pickedUrls[actionSheet.tag - 1000]}];
            preview.currentPage = 0;
            [self presentViewController:preview animated:NO completion:^{
                preview.pageControl.hidden = YES;
            }];
        } else if (buttonIndex == 1) {
            _currentItem = actionSheet.tag - 1000;
            [UICommon showCamera:self view:self allowsEditing:YES];
        } else if (buttonIndex == 2) {
            _currentItem = actionSheet.tag - 1000;
            [UICommon showImagePicker:self view:self];
        } else if (buttonIndex == 3){
            //删除
            _deleteIndex = actionSheet.tag - 1000;
            
            [_pickedIds removeObjectAtIndex:_deleteIndex];
            [_pickedUrls removeObjectAtIndex:(long)_deleteIndex];
            
            [self countHeight];
            [_collectionview reloadData];
            
            if(_isFail)
            {
                for(UIView * view in [_firstView subviews])
                {
                    if([view isKindOfClass:[CRInfoNotify class]])
                    {
                        [view removeFromSuperview];
                    }
                }

                [self setNotifyFrame];
            }
            
        }
        
    }
    else if(actionSheet.tag == 1000000)
    {
        if(buttonIndex == 0)
        {
            [self goToSave];
            
        }
        else if (buttonIndex == 1)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        if (buttonIndex == 0) {
            [UICommon showCamera:self view:self allowsEditing:YES];
        } else if (buttonIndex == 1) {
            [UICommon showImagePicker:self view:self];
        }
    }
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
        if (_currentItem == -1) {
            [_pickedUrls addObject:url];
            [_pickedIds addObject:pid];
        } else {
            
            if(_isFail)
            {
                CRInfoNotify * noti = (CRInfoNotify *) [self.firstView viewWithTag: 1000 + _currentItem];
                
                if(noti)
                {
                    [noti display:NO];
                }
            }
            
            [_pickedUrls removeObjectAtIndex:_currentItem];
            [_pickedUrls insertObject:url atIndex:_currentItem];
            [_pickedIds removeObjectAtIndex:_currentItem];
            [_pickedIds insertObject:pid atIndex:_currentItem];
        }
        [self countHeight];
        [_collectionview reloadData];
    } else {
        NSLog(@"%@",dic.operationMessage);
        [HUDUtil showErrorWithStatus:dic.operationMessage];

        return;
    }
}
//删除图片
- (void)handleDeletePic:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed) {
        NSLog(@"%@",dic.data);
        [_pickedUrls removeObjectAtIndex:(long)_deleteIndex];
        [self countHeight];
        [_collectionview reloadData];
        
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
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
                                                           ImgType:EditImageTypeAdertPic);
        imageEditor.rotateEnabled = NO;
        imageEditor.doneCallback = ^(UIImage *editedImage, BOOL canceled){
            if(!canceled) {
                [self passImage:editedImage];
            }
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
    ADAPI_Picture_Upload([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleUploadPic:)], UIImagePNGRepresentation(image));
}

//点击add图片
- (void)clickImage:(UIButton *)button{
    [self.view endEditing:YES];
    _currentItem = -1;
    UIActionSheet *sheet = [[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机拍摄" otherButtonTitles:@"从相册中选择", nil] autorelease];
    [sheet showInView:self.view];
}

#pragma mark - collectionview delegate / datasource
- (NSInteger)collectionView:(PSTCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _pickedUrls.count >= 10 ? 10 : _pickedUrls.count + 1;
}

- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddPictureCell" forIndexPath:indexPath];
    if (indexPath.row == _pickedUrls.count && _pickedUrls.count != 10) {
        cell.imageView.hidden = YES;
        cell.btnAdd.hidden = NO;
        [cell.btnAdd addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        cell.btnAdd.hidden = YES;
        cell.imageView.hidden = NO;
        [cell.imageView requestWithRecommandSize:_pickedUrls[indexPath.row]];
    }
    
    [cell.imageView setBorderWithColor:AppColor(204)];

    return cell;
}

- (CGSize)collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 115);
}

- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIActionSheet *sheet = [[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"预览" otherButtonTitles:@"相机拍摄", @"从相册中选择", @"删除", nil] autorelease];
    sheet.tag = indexPath.row + 1000;
    [sheet showInView:self.view];
}

- (void) EnterpriseContactInfo:(DelegatorArguments*)arguments
{
    [arguments logError];
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        _telField.text = [wrapper.data getString:@"Tel"];
        
        _addressField.text = [wrapper.data getString:@"FullAddress"];
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        
    }
}

- (void) onMoveFoward:(UIButton *)sender
{
    [self goToSave];
}

- (void) goToSave
{
    self.isVerify = @"-1";
    
    if(![self checkToSave])
    {
        return;
    }
    
    [self saveSilverAdvert];
}

- (BOOL) validFirstViewField
{
    if([_titleField.text length] > 25)
    {
        [HUDUtil showErrorWithStatus:@"广告名称不能超过25个字"];
        
        [self showFirstView:YES];
        
        [_titleField becomeFirstResponder];
        
        return NO;
    }
    if([_sloganField.text length] > 20)
    {
        [HUDUtil showErrorWithStatus:@"广告语不能超过20个字"];
        
        [self showFirstView:YES];
        
        [_sloganField becomeFirstResponder];
        
        return NO;
    }
    if([_keywordField.text length] > 5)
    {
        [HUDUtil showErrorWithStatus:@"核心记忆词不能超过5个字"];
        
        [self showFirstView:YES];
        
        [_keywordField becomeFirstResponder];
        
        return NO;
    }
    
    NSInteger phoneNumLength = [_telField.text length];
    BOOL valiable = phoneNumLength && phoneNumLength != 7 && phoneNumLength != 8 && phoneNumLength != 10 && phoneNumLength != 11 && phoneNumLength != 12;
    
    if (valiable) {
        [HUDUtil showErrorWithStatus:@"请填写正确的电话号码"];
       
        [_telField becomeFirstResponder];
        
        return NO;
    }
    
    return YES;
}

- (BOOL) validSecondViewField
{
    if([_totalCountField.text intValue] > 500)
    {
        [HUDUtil showErrorWithStatus:@"每个用户最多收到广告数不能超过500"];
        
        [self showFirstView:NO];

        [_totalCountField becomeFirstResponder];
        
        return NO;
    }
    if([_dayCountField.text intValue] > 10)
    {
        [HUDUtil showErrorWithStatus:@"每个用户每天最多收到广告数10"];
        
        [self showFirstView:NO];

        [_dayCountField becomeFirstResponder];
        
        return NO;
    }
    if([_dayCountField.text intValue] > [_totalCountField.text intValue])
    {
        [HUDUtil showErrorWithStatus:@"每天最多可兑换数不能大于总兑换数"];
        
        [self showFirstView:NO];
        
        [_dayCountField becomeFirstResponder];
        
        return NO;
    }
    
    if(![self validStartDateAndEndDate])
    {
        return NO;
    }
    
    return YES;
}

- (BOOL) checkToSave
{
    if(!_titleField.text.length
       && !_pickedIds.count
       && !_sloganField.text.length
       && !_keywordField.text.length
       && !_ADsDes.length
       && [_bindingProdBtn.titleLabel.text isEqualToString:@"未绑定"]
       && !_totalCountField.text.length
       && !_dayCountField.text.length
       && !_startDate
       && !_endDate
       && [_areaBtn.titleLabel.text isEqualToString:@"未设置"]
       && ![_userBtn.titleLabel.text hasPrefix:@"已设置"])
    {
        [HUDUtil showErrorWithStatus:@"暂无可保存的内容"];
        
        return NO;
    }
    return YES;
}

- (BOOL) checkFirstViewField
{
    if(![_titleField.text length])
    {
        [HUDUtil showErrorWithStatus:@"请填写广告名称"];
        
        [self showFirstView:YES];
        
        [_titleField becomeFirstResponder];
        
        return NO;
    }
    if(![_sloganField.text length])
    {
        [HUDUtil showErrorWithStatus:@"请填写广告语"];
        
        [self showFirstView:YES];
        
        [_sloganField becomeFirstResponder];
        
        return NO;
    }
    if(![_keywordField.text length])
    {
        [HUDUtil showErrorWithStatus:@"请填写核心记忆词"];
        
        [self showFirstView:YES];
        
        [_keywordField becomeFirstResponder];
        
        return NO;
    }
    if (!_pickedIds.count) {
        
        [HUDUtil showErrorWithStatus:@"请上传广告图片"];
        
        return NO;
    }
    if(!_ADsDes.length)
    {
        [HUDUtil showErrorWithStatus:@"请填写广告内容简介"];
        
        return NO;
    }
    
    return YES;
}

- (BOOL) checkSecondViewField
{
    if([_bindingProdBtn.titleLabel.text isEqualToString:@"未绑定"])
    {
        [HUDUtil showErrorWithStatus:@"请选择绑定商品"];
        
        return NO;
    }
    if(![_totalCountField.text intValue])
    {
        [HUDUtil showErrorWithStatus:@"请填写每个用户最多收到的广告数"];
        
        [_totalCountField becomeFirstResponder];
        
        return NO;
    }
    if(![_dayCountField.text intValue])
    {
        [HUDUtil showErrorWithStatus:@"请填写每个用户每天最多收到的广告数"];
        
        [_dayCountField becomeFirstResponder];
        
        return NO;
    }
    if(!_startDate)
    {
        [HUDUtil showErrorWithStatus:@"请选择起止时间"];
        
        return NO;
    }
    if(!_endDate)
    {
        [HUDUtil showErrorWithStatus:@"请选择起止时间"];
        
        return NO;
    }
    if([_areaBtn.titleLabel.text isEqualToString:@"未设置"])
    {
        [HUDUtil showErrorWithStatus:@"请设置投放区域"];
        
        return NO;
    }
    
    return YES;
}

- (BOOL) validStartDateAndEndDate
{
    if (_startDate) {
        
        NSTimeInterval aa;
        
        NSDate * today = [NSDate date];
        
        if(_endDate)
        {
            aa = [_endDate timeIntervalSinceDate:_startDate];
            
            if (aa <= 0) {
                
                [HUDUtil showErrorWithStatus:@"结束时间不能早于或等于开始时间。"];
                
                [self showFirstView:NO];
                
                return NO;
            }
            
            aa = [_startDate timeIntervalSinceDate:today];
            
            if (aa <= 0) {
                
                [HUDUtil showErrorWithStatus:@"开始时间设置必须大于当前时间。"];
                
                [self showFirstView:NO];
                
                return NO;
            }
            
            aa = [_endDate timeIntervalSinceDate:today];
            
            if (aa <= 0) {
                
                [HUDUtil showErrorWithStatus:@"结束时间设置必须大于当前时间。"];
                
                [self showFirstView:NO];
                
                return NO;
            }
        }
    }
    return YES;
}

#pragma mark -date delegate

- (void) selectDateCallBack:(NSDate*)date{
    
    [_datePickerView.view removeFromSuperview];
    
    NSString* text = [UICommon usaulFormatTime:date formatStyle:@"yyyy-MM-dd"];
    
    if (_datePickerView.view.tag == 200) {
        
        [_startDateBtn setTitle:text forState:UIControlStateNormal];
        
        [_srcData setObject:text forKey:@"StartTime"];
        
        date = [UICommon usaulFormatDate:text formatStyle:@"yyyy-MM-dd"];
        
        self.startDate = date;
        
        _datePickerView.view.tag = 300;
        
        _datePickerView.titleLable.text = @"结束时间";
        
        [self.view addSubview:_datePickerView.view];
        
    }
    else{
        
        [_endDateBtn setTitle:text forState:UIControlStateNormal];
        
        [_srcData setObject:text forKey:@"EndTime"];
        
        date = [UICommon usaulFormatDate:text formatStyle:@"yyyy-MM-dd"];
        
        self.endDate = date;
        
    }
    
    NSDate * today = [NSDate date];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    NSDate *tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    
    _datePickerView.picker.date = tomorrow;
    
}

- (void) cancelDateCallBack:(NSDate*)date{
    
    [_datePickerView.view removeFromSuperview];
}

- (void) saveSilverAdvert
{
    [_activeField resignFirstResponder];
    
//    if(![self validFirstViewField])
//    {
//        return;
//    }
//    if(![self validSecondViewField])
//    {
//        return;
//    }
    
    if(!_isEdit)//create
    {
        [_srcData setObject:@"0" forKey:@"Id"];
    }
    
    if(_pickedIds.count)
    {
        [_srcData setObject:_pickedIds forKey:@"PictureIds"];
    }
    
    if(_titleField.text.length)
    {
        [_srcData setObject:_titleField.text forKey:@"Title"];
    }
    
    [_srcData setObject:_ADsDes forKey:@"Content"];
    
    if(_sloganField.text.length)
    {
        [_srcData setObject:_sloganField.text forKey:@"Slogan"];
    }
    
    if(_keywordField.text.length)
    {
        [_srcData setObject:_keywordField.text forKey:@"SloganCoreWord"];
    }
    
    NSString * webLinkUrl = _webField.text;
//    if(![webLinkUrl hasPrefix:@"http://"] && ![webLinkUrl hasPrefix:@"https://"] && webLinkUrl.length > 0)
//    {
//        webLinkUrl = [NSString stringWithFormat:@"http://%@", webLinkUrl];
//    }
    
    if(webLinkUrl.length)
    {
        [_srcData setObject:webLinkUrl forKey:@"LinkUrl"];
    }
    
    if(_telField.text.length)
    {
        [_srcData setObject:_telField.text forKey:@"Tel"];
    }
    
    if(_addressField.text.length)
    {
        [_srcData setObject:_addressField.text forKey:@"Address"];
    }
    
    if(_telField.text.length == 0)
    {
        _telIconBtn.selected = NO;
        
        _telIcon.image = [UIImage imageNamed:@"findShopfilterBtn"];
        
    }
    
    if(_addressField.text.length == 0)
    {
        _addressIconBtn.selected = NO;
        
        _addressIcon.image = [UIImage imageNamed:@"findShopfilterBtn"];
        
    }
    
    NSString * telStr = _telIconBtn.selected ? @"true" : @"false";
    NSString * addStr = _addressIconBtn.selected ? @"true" : @"false";
    
    [_srcData setObject:telStr forKey:@"IsShowTel"];
    [_srcData setObject:addStr forKey:@"IsShowAddress"];
    
    [_srcData setObject:@"0" forKey:@"AdvertType"];
    
    [_srcData setObject:_isVerify forKey:@"VerifyState"];
    
    if(_totalCountField.text.length)
    {
        [_srcData setObject:_totalCountField.text forKey:@"SingleUserPutNumber"];
    }
    
    if(_dayCountField.text.length)
    {
        [_srcData setObject:_dayCountField.text forKey:@"EveryDayPutNumber"];
    }
    
    [_srcData setObject:[NSNumber numberWithInteger:_sexType] forKey:@"PutSex"];
    
    if(_PushRegionals.count)
    {
        [_srcData setObject:_PushRegionals forKey:@"PushRegionals"];
    }
    
    NSMutableArray * arr = WEAK_OBJECT(NSMutableArray, init);
    
    for(NSDictionary * dic in _bindingProdArr)
    {
        NSMutableDictionary * src = WEAK_OBJECT(NSMutableDictionary, init);
        
        int prodId = [dic.wrapper getInt:@"SilverProductId"];
        
        int total = [dic.wrapper getInt:@"Total"];
        
        [src setObject:[NSNumber numberWithInteger:prodId] forKey:@"ProductId"];
        
        [src setObject:[NSNumber numberWithInteger:total] forKey:@"Total"];
        
        [arr addObject:src];
    }
    
    if(arr.count)
    {
        [_srcData setObject:arr forKey:@"SilverProducts"];
    }
    
    [_srcData setObject:@"9" forKey:@"QuestionId"];
    
    ADAPI_SilverAdvertSaveSilverAdvert([self genDelegatorID:@selector(SaveSilverAdvert:)], _srcData);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)SaveSilverAdvert:(DelegatorArguments*)arguments
{
    [arguments logError];
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        if([_isVerify isEqualToString:@"0"])
        {
            //审核
            [HUDUtil showSuccessWithStatus:@"提交成功"];
            
            [AccurateService clearData];
            
            if(_isEdit)
            {
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            [HUDUtil showSuccessWithStatus:@"保存成功"];
        }
        
        [_srcData setObject:[wrapper getString:@"Data"] forKey:@"Id"];
        
        _isAlert = NO;
        
        _isEdit = YES;
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void) showFirstView:(BOOL) isShow
{
    if(isShow)
    {
        _firstView.hidden = NO;
        
        _secondView.hidden = YES;
        
        [_firstBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_secondBtn setTitleColor:[UIColor titleRedColor] forState:UIControlStateNormal];
        
        _tabimageView.image = [UIImage imageNamed:@"YinYuanAdvertTopOne"];
        
        _mainScrollView.contentOffset = CGPointZero;
        
        _mainScrollView.contentSize = CGSizeMake(320, _firstView.bottom + 80);
        
    }
    else
    {
        _firstView.hidden = YES;
        
        _secondView.hidden = NO;
        
        [_firstBtn setTitleColor:[UIColor titleRedColor] forState:UIControlStateNormal];
        [_secondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _tabimageView.image = [UIImage imageNamed:@"YinYuanAdvertTopTwo"];
        
        _mainScrollView.contentOffset = CGPointZero;
        
        _mainScrollView.contentSize = CGSizeMake(320, _secondView.bottom + 80);
    }
}

- (void) onMoveBack:(UIButton *)sender
{
    [_activeField resignFirstResponder];
    
    if(_firstView.hidden)
    {
        [self showFirstView:_firstView.hidden];
    }
    else
    {
        if(_isAlert)
        {
            UIActionSheet *actionSheet = [[[UIActionSheet alloc]
                                           initWithTitle:nil
                                           delegate:self
                                           cancelButtonTitle:@"取消"
                                           destructiveButtonTitle:nil
                                           otherButtonTitles:@"保存草稿", @"不保存",nil]autorelease];
            
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
            
            [actionSheet showInView:self.view];
            
            actionSheet.tag = 1000000;
            
            return;
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)touchUpInsideOnBtn:(id)sender
{
    if(sender == _secondBtn)
    {
        [self showFirstView:NO];
    }
    else if (sender == _firstBtn)
    {
        [self showFirstView:YES];
    }
    else if (sender == _commitBtn)
    {
        [self goToCommit];
    }
    
//    if(sender == _nextBtn)
//    {
//        if(!_firstView.hidden)//下一步
//        {
//            if(![self checkFirstViewField])
//            {
//                return;
//            }
//            
//            if(![self validFirstViewField])
//            {
//                return;
//            }
//            
//            [self showFirstView:NO];
//        }
//        else//提交审核
//        {
//            [self goToCommit];
//
//        }
//    }
    
    
    else if (sender == _desBtn)
    {
        YinYuanProdEditSubController * view = WEAK_OBJECT(YinYuanProdEditSubController, init);
        
        view.delegate = self;
        
        view.naviTitle = @"内容简介";
        
        view.isADs = YES;
        
        view.ADsDes = _ADsDes;
        
        view.limitNum = 500;
        
        if(_isFail && _desBtn.tag == 1)
        {
            [_contentNotify display:NO];
        }
        
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender == _telIconBtn)
    {
        _telIcon.image = _telIconBtn.selected ? [UIImage imageNamed:@"findShopfilterBtn"] : [UIImage imageNamed:@"findShopfilterSelectBtn"];
        
        _telIconBtn.selected = !_telIconBtn.selected;
    }
    else if (sender == _addressIconBtn)
    {
        _addressIcon.image = _addressIconBtn.selected ? [UIImage imageNamed:@"findShopfilterBtn"] : [UIImage imageNamed:@"findShopfilterSelectBtn"];
        
        _addressIconBtn.selected = !_addressIconBtn.selected;
    }
    else if (sender == _readmeBtn)
    {
        WebhtmlViewController * view = WEAK_OBJECT(WebhtmlViewController, init);
        view.navTitle = @"秒赚广告商户服务协议";
        view.ContentCode = @"d3622ea0ab5ffc3b58b104a5d36d6ea4";
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender == _bindingProdBtn)
    {
        YinYuanAdvertBindingProdController * view = WEAK_OBJECT(YinYuanAdvertBindingProdController, init);
        
        view.delegate = self;
        
        if(_bindingProdArr.count)
        {
            view.selProdArr = _bindingProdArr;
        }
        
        view.titleName = @"选择绑定商品";
        
        [self.navigationController pushViewController:view animated:YES];
        
    }
    else if (sender == _startDateBtn)
    {
        _datePickerView.view.tag = 200;
        
        _datePickerView.titleLable.text = @"开始时间";
        
        [self.view addSubview:_datePickerView.view];
        

    }
    else if (sender == _endDateBtn)
    {
        _datePickerView.view.tag = 300;
        
        _datePickerView.titleLable.text = @"结束时间";

        [self.view addSubview:_datePickerView.view];
    }
    else if (sender == _areaBtn)
    {
        SendOutAreaViewController * view = WEAK_OBJECT(SendOutAreaViewController, init);
        
        view.block = ^(NSArray *arr) {
            
            if(arr.count)
            {
                [_PushRegionals removeAllObjects];
                
                [_PushRegionals addObjectsFromArray:arr];
                
                [_areaBtn setTitle:@"已设置" forState:UIControlStateNormal];
            }
            else
            {
                [_PushRegionals removeAllObjects];
                
                [_areaBtn setTitle:@"未设置" forState:UIControlStateNormal];
            }
        };
        
        [self.navigationController pushViewController:view animated:YES];
        
    }
    else if (sender == _userBtn)
    {
        YinYuanAdvertEditSubController * view = WEAK_OBJECT(YinYuanAdvertEditSubController, init);
        
        view.delegate = self;
        
        if([_userDic allKeys].count)
        {
            view.userDic = _userDic;
        }

        view.naviTitle = @"用户属性设置";
        
        [self.navigationController pushViewController:view animated:YES];
    }
}

- (BOOL) checkFailFieldState
{
    DictionaryWrapper * auditDic = [_wrapDic getDictionary:@"AuditMessage"].wrapper;

    if(!_titleNotify.hidden || ([_titleField.text isEqualToString:[_wrapDic getString:@"Title"]] && [auditDic getString:@"TitleValidRemark"].length))
    {
        [HUDUtil showErrorWithStatus:@"请修改广告名称"];
        
        [self showFirstView:YES];
        
        [_titleField becomeFirstResponder];
        
        return NO;
    }
    
    for (int i = 0; i < _pickedIds.count; i ++) {
        
        CRInfoNotify * noti = (CRInfoNotify *) [self.firstView viewWithTag:1000 + i];
        
        if(!noti.hidden && noti)
        {
            [HUDUtil showErrorWithStatus:@"请修改广告图片"];
            
            [self showFirstView:YES];

            return NO;
        }
    }
    
    if(!_sloganNotify.hidden || ([_sloganField.text isEqualToString:[_wrapDic getString:@"Slogan"]] && [auditDic getString:@"SloganValidRemark"].length))
    {
        [HUDUtil showErrorWithStatus:@"请修改广告语"];
        
        [self showFirstView:YES];

        [_sloganField becomeFirstResponder];

        return NO;
    }
    
    if(!_keywordNotify.hidden || ([_keywordField.text isEqualToString:[_wrapDic getString:@"SloganCoreWord"]] && [auditDic getString:@"SloganCoreWordValidRemark"].length))
    {
        [HUDUtil showErrorWithStatus:@"请修改核心记忆词"];
        
        [self showFirstView:YES];

        [_keywordField becomeFirstResponder];

        return NO;
    }
    if(!_contentNotify.hidden)
    {
        [HUDUtil showErrorWithStatus:@"请修改内容简介"];
        
        [self showFirstView:YES];

        return NO;
    }
    if(!_linkNotify.hidden || ([_webField.text isEqualToString:[_wrapDic getString:@"LinkUrl"]] && [auditDic getString:@"LinkValidRemark"].length))
    {
        [HUDUtil showErrorWithStatus:@"请修改链接网址"];
        
        [self showFirstView:YES];

        [_webField becomeFirstResponder];

        return NO;
    }
    if(!_telNotify.hidden || ([_telField.text isEqualToString:[_wrapDic getString:@"Tel"]] && [auditDic getString:@"TelValidRemark"].length))
    {
        [HUDUtil showErrorWithStatus:@"请修改显示电话"];
        
        [self showFirstView:YES];

        [_telField becomeFirstResponder];

        return NO;
    }
    if(!_addressNotify.hidden || ([_addressField.text isEqualToString:[_wrapDic getString:@"Address"]] && [auditDic getString:@"AddressValidRemark"].length))
    {
        [HUDUtil showErrorWithStatus:@"请修改显示地址"];
        
        [self showFirstView:YES];

        [_addressField becomeFirstResponder];

        return NO;
    }

    return YES;
}

- (void) saveAdvert
{
    [self goToSave];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        //统计点击
        [APP_MTA MTA_touch_From:MTAEVENT_silver_ad_submit];
        
        [self saveSilverAdvert];
    }
}

- (void) goToCommit
{
    self.isVerify = @"0";
    
    if(![self checkSecondViewField])
    {
        return;
    }
    
    if(![self validSecondViewField])
    {
        return;
    }
    
    if(![self checkFirstViewField])
    {
        return;
    }
    
    if(![self validFirstViewField])
    {
        return;
    }
    
//    if(_isFail)
//    {
//        if(![self checkFailFieldState])
//        {
//            return;
//        }
//    }
    
    UIAlertView * alert = [[[UIAlertView alloc] initWithTitle: @"确认提交"
                                                      message: @"银元广告一旦提交则不可更改"
                                                     delegate: self
                                            cancelButtonTitle: @"取消"
                                            otherButtonTitles: @"确定", nil] autorelease];
    [alert show];
}

- (void)_initPstCollectionView{
    
    PSTCollectionViewFlowLayout *layout = WEAK_OBJECT(PSTCollectionViewFlowLayout, init);
    layout.minimumInteritemSpacing = 20.f;
    layout.minimumLineSpacing = 20.f;
    UIEdgeInsets insets = {.top = 0,.left = 20,.bottom = 40,.right = 20};
    layout.sectionInset = insets;
    
    _collectionview = WEAK_OBJECT(PSTCollectionView, initWithFrame:CGRectMake(0, _picView.bottom - 10, SCREENWIDTH, 135) collectionViewLayout:layout);
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.scrollEnabled = NO;
    _collectionview.backgroundColor = [UIColor whiteColor];
    [_collectionview registerNib:[UINib nibWithNibName:@"AddPictureCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AddPictureCell"];
    
    [_firstView addSubview:_collectionview];
    
    //计算高度
    _firstBottomView.top = _collectionview.bottom;
    
    CGRect rect = _firstView.frame;
    
    rect.size.height = _firstBottomView.bottom;
    
    _firstView.frame = rect;
    
    _mainScrollView.contentSize = CGSizeMake(SCREENWIDTH, _firstView.bottom + 80);
}

- (void) passAdvertUser:(NSMutableDictionary *)body
{
    self.userDic = body;
    
    _sexType = [body.wrapper getInt:@"PutSex"];
    NSString * minAge = [body.wrapper getString:@"PutMinAge"];
    NSString * maxAge = [body.wrapper getString:@"PutMaxAge"];
    NSString * isQuesAll = [body.wrapper getString:@"isQuesAll"];
    
    NSString * userText = @"已设置 ";
    
    if(_sexType != 0)
    {
        userText = [userText stringByAppendingString:@"性别 "];
    }
    if([isQuesAll intValue] != 1)
    {
        userText = [userText stringByAppendingString:@"年收入 "];
        
        NSArray * arr = [body.wrapper getArray:@"PutAnnualIncomeOptions"];
        
        NSMutableArray * incomArr = WEAK_OBJECT(NSMutableArray, init);
        
        if(arr.count)
        {
            for(NSDictionary * dic in arr)
            {
                [incomArr addObject:[dic.wrapper getString:@"Id"]];
            }
            
            [_srcData setObject:incomArr forKey:@"PutAnnualIncomeOptions"];
        }
    }
    else
    {
        //        [_srcData removeObjectForKey:@"PutAnnualIncomeOptions"];
        
        NSMutableArray * arr = WEAK_OBJECT(NSMutableArray, init);
        [_srcData setObject:arr forKey:@"PutAnnualIncomeOptions"];
    }
    if([minAge intValue] == 0 && [maxAge intValue] == 100)
    {
    }
    else
    {
        userText = [userText stringByAppendingString:@"年龄"];
    }
    
    if([userText isEqualToString:@"已设置 "])
    {
        userText = @"不限";
    }
    
    [_userBtn setTitle:userText forState:UIControlStateNormal];
    
    [_srcData setObject:minAge forKey:@"PutMinAge"];
    [_srcData setObject:maxAge forKey:@"PutMaxAge"];
    [_srcData setObject:[NSNumber numberWithInteger:_sexType] forKey:@"PutSex"];
}

- (void) passADsDes:(NSString *)ADsDes
{
    if(ADsDes.length > 0)
    {
        [_desBtn setTitle:@"已填写" forState:UIControlStateNormal];
        
        self.ADsDes = ADsDes;
    }
    else
    {
        [_desBtn setTitle:@"未填写" forState:UIControlStateNormal];
    }
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    [self addDoneToKeyboard:textField];
    
    self.isAlert = YES;
    
    if (fullSrcBtn) {
        
        [fullSrcBtn removeFromSuperview];
        
        fullSrcBtn = nil;
    }
    
    fullSrcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [fullSrcBtn addTarget:self action:@selector(hiddenKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect btnrect = CGRectMake(0, 0, W(_mainScrollView), H(_mainScrollView));
    
    fullSrcBtn.frame = btnrect;
    
    [_mainScrollView insertSubview:fullSrcBtn belowSubview:textField];
    
    _isFirstResponder = YES;
    
    _activeField = textField;
    
    CGRect rect = [textField convertRect:self.mainScrollView.frame toView:self.view];
    
    _textFeildTouchedY = rect.origin.y + 90;
    
    perPos = self.mainScrollView.contentOffset;
    CGFloat y = perPos.y;
    
    if (_textFeildTouchedY > 264)
    {
        CGPoint p = CGPointMake(0,  _textFeildTouchedY - 264 + y + 35);
        
        [_mainScrollView setContentOffset:p animated:YES];
        
    }
    else if (_textFeildTouchedY > 210)
    {
        CGPoint p = CGPointMake(0,  _textFeildTouchedY - 210 + y + 35);
        
        [_mainScrollView setContentOffset:p animated:YES];
    }
    
    if(_isFail)
    {
        [self hiddenNotify:textField];
    }
}

- (void)hiddenNotify: (UITextField *)textField
{
    if(textField == _titleField && textField.tag == 1)
    {
        [_titleNotify display:NO];
    }
    else if (textField == _sloganField && textField.tag == 1)
    {
        [_sloganNotify display:NO];
    }
    else if (textField == _keywordField && textField.tag == 1)
    {
        [_keywordNotify display:NO];
    }
    else if (textField == _webField && textField.tag == 1)
    {
        [_linkNotify display:NO];
    }
    else if (textField == _telField && textField.tag == 1)
    {
        [_telNotify display:NO];
    }
    else if (textField == _addressField && textField.tag == 1)
    {
        [_addressNotify display:NO];
    }
    
    textField.textColor = AppColor(85);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    _activeField = nil;
    
    if (fullSrcBtn) {
        
        [fullSrcBtn removeFromSuperview];
        
        fullSrcBtn = nil;
    }
}

- (void) hiddenKeyboard
{
    [self.view endEditing:YES];
}

- (void) productBindingFinish:(NSMutableArray *)selArr
{
    if(selArr.count)
    {
        [_bindingProdArr removeAllObjects];
        
        [_bindingProdArr addObjectsFromArray:selArr];
        
        [_bindingProdBtn setTitle:@"已绑定" forState:UIControlStateNormal];
    }
}

#pragma mark ----------------------------- Keyboard Functions ---------------------------------

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    //防止多个实例收到此消息
    if (_isFirstResponder == YES)
    {
        NSDictionary* info = [aNotification userInfo];
        // Get the size of the keyboard.
        
        NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
        
        CGSize keyboardSize = [aValue CGRectValue].size;
        
        
        CGRect rect = [[UIScreen mainScreen] bounds];
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        
        CGSize size = rect.size;
        
        if (orientation == UIInterfaceOrientationLandscapeLeft ||
            orientation == UIInterfaceOrientationLandscapeRight)
        {
            rect.size.width = size.height;
            
            rect.size.height = size.width;
            
            NSInteger h = keyboardSize.height;
            
            keyboardSize.height = keyboardSize.width;
            
            keyboardSize.width = h;
            
        }
        
        
        NSInteger keyBoardY = rect.size.height - keyboardSize.height;
        
        
        CGRect rectfield = [_activeField convertRect:self.view.frame toView:self.view];
        
        _textFeildTouchedY = rectfield.origin.y + 42;
        
        CGFloat y = self.mainScrollView.contentOffset.y;
        
        if (_textFeildTouchedY >= keyBoardY)
        {
            CGPoint p = CGPointMake(0,  _textFeildTouchedY - keyBoardY + y + 10);
            
            [self.mainScrollView setContentOffset:p animated:YES];
            
        }
    }
}

// Called when the UIKeyboardDidHideNotification is sent
- (void)keyboardWasHidden:(NSNotification*)aNotification
{
    if (_isFirstResponder == YES)
    {
        //        [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        _isFirstResponder = NO;
        
    }
    
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHidden:)
                                                 name:UIKeyboardDidHideNotification object:nil];
    
}

- (void) unregisterForKeyboardNotifications{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)dealloc {
    
    [self unregisterForKeyboardNotifications];
    
    [_titleNotify release];
    _titleNotify = nil;
    
    [_sloganNotify release];
    _sloganNotify = nil;
   
    [_keywordNotify release];
    _keywordNotify = nil;
    
    [_contentNotify release];
    _contentNotify = nil;
   
    [_linkNotify release];
    _linkNotify = nil;
  
    [_telNotify release];
    _telNotify = nil;
    
    [_addressNotify release];
    _addressNotify = nil;
    
    [_notifyPicMsg release];
    _notifyPicMsg = nil;
    
    [_bindingProdArr release];
    _bindingProdArr = nil;
    
    [_PushRegionals release];
    _PushRegionals = nil;
    
    [_srcData release];
    _srcData = nil;
    
    [_datePickerView release];
    
    [_userDic release];
    _userDic = nil;
    
    [_firstView release];
    [_firstTopView release];
    [_picSubScrollView release];
    [_firstBottomView release];
    [_sloganField release];
    [_titleField release];
    [_keywordField release];
    [_desBtn release];
    [_webField release];
    [_telIcon release];
    [_telIconBtn release];
    [_addressIcon release];
    [_addressIconBtn release];
    [_readmeBtn release];
    [_secondView release];
    [_bindingProdBtn release];
    [_totalCountField release];
    [_dayCountField release];
    [_startDateBtn release];
    [_endDateBtn release];
    [_areaBtn release];
    [_userBtn release];
    [_tabimageView release];
    [_commitBtn release];
    [_firstBtn release];
    [_secondBtn release];
    [_mainScrollView release];
    [_telField release];
    [_addressField release];
    [_line release];
    [_line2 release];
    [_line3 release];
    [_topReasonView release];
    [_topReasonLbl release];
    [_firstReasonView release];
    [_firstReasonLbl release];
    [_picView release];
    [_picReasonView release];
    [_picReasonLbl release];
    [_topNavView release];
    [_topLine release];
    [_navTopLine release];
    [_topReasonLine release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setFirstView:nil];
    [self setFirstTopView:nil];
    [self setPicSubScrollView:nil];
    [self setFirstBottomView:nil];
    [self setSloganField:nil];
    [self setTitleField:nil];
    [self setKeywordField:nil];
    [self setDesBtn:nil];
    [self setWebField:nil];
    [self setTelIcon:nil];
    [self setTelIconBtn:nil];
    [self setAddressIcon:nil];
    [self setAddressIconBtn:nil];
    [self setReadmeBtn:nil];
    [self setSecondView:nil];
    [self setBindingProdBtn:nil];
    [self setTotalCountField:nil];
    [self setDayCountField:nil];
    [self setStartDateBtn:nil];
    [self setEndDateBtn:nil];
    [self setAreaBtn:nil];
    [self setUserBtn:nil];
    [self setTabimageView:nil];
    [self setCommitBtn:nil];
    [self setFirstBtn:nil];
    [self setSecondBtn:nil];
    [self setMainScrollView:nil];
    [super viewDidUnload];
}
@end
