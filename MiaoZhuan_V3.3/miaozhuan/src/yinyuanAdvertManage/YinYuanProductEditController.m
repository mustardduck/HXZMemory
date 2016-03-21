//
//  YinYuanProductEditController.m
//  miaozhuan
//
//  Created by momo on 14-11-15.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanProductEditController.h"
#import "IndustryCategotiesViewController.h"
#import "YinYuanProdEditSubController.h"
#import "UIImage+expanded.h"
#import "AddConvertCenterViewController.h"
#import "SetConvertCenterViewController.h"

#import "PSTCollectionView.h"
#import "AddPictureCell.h"
#import "PreviewViewController.h"
#import "YinYuanDuiHuanDianCell.h"

#import "CRInfoNotify.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import "EditImageViewController.h"
#import "RRAttributedString.h"
#import "CollectionReusableView.h"
#import "MsgCollectionReusableView.h"
#import "WebhtmlViewController.h"

@interface YinYuanProductEditController ()<PSTCollectionViewDataSource, PSTCollectionViewDelegate, PSTCollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate>
{
    PSTCollectionView *_collectionview;
    NSInteger _deleteIndex;
    NSInteger _currentItem;//选择的某个图片
    BOOL _isMoveBack;
    
    BOOL _IS_PROIMAGE_FAILE;//商品图片 有无错误信息
    BOOL _IS_PROMISE_FAILE; //承诺书   有无错误信息
    
    
}

@property (nonatomic, retain) NSMutableArray *pickedUrls;
@property (nonatomic, retain) NSMutableArray *pickedIds;

@property (nonatomic, retain) NSMutableArray *clsPickedUrls;
@property (nonatomic, retain) NSMutableArray *clsPickedIds;

@property (retain, nonatomic) IBOutlet RRLineView *line1;
@property (retain, nonatomic) IBOutlet RRLineView *line2;
@property (retain, nonatomic) IBOutlet RRLineView *line3;
@property (retain, nonatomic) IBOutlet RRLineView *line4;
//@property (retain, nonatomic) IBOutlet UIView *picDuiHuanView;
@property (retain, nonatomic) IBOutlet UIView *firstReasonView;
@property (retain, nonatomic) IBOutlet UILabel *firstReasonLbl;
@property (retain, nonatomic) IBOutlet UIView *xianzhiView;
@property (retain, nonatomic) IBOutlet UIView *topReasonView;
@property (retain, nonatomic) IBOutlet UILabel *topReasonLbl;

@property (retain, nonatomic) NSString * picMsg;
@property (retain, nonatomic) NSString * promiseMsg;
@property (retain, nonatomic) IBOutlet RRLineView *topReasonLine;
@property (retain, nonatomic) IBOutlet RRLineView *xianzhiLine;
@property (retain, nonatomic) IBOutlet RRLineView *miaoshuLine;

@end

@implementation YinYuanProductEditController
const int failCollReusableTitleHeight = 93;
const int collReusableTileHeight = 73;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _mainScrollView.contentSize = CGSizeMake(320, YH(_mainView) + 10);
    
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"存入草稿"];
    
    _dayCount = 1;
    
    _totalCount = 1;
    
    _exType = -1;
    
    _productDes = @"";
    
    _xianzhiLine.top = 49.5;
    _miaoshuLine.top = 49.5;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    [self registerForKeyboardNotifications];
    
    _srcData = STRONG_OBJECT(NSMutableDictionary, init);
    
    _exPointsArr = STRONG_OBJECT(NSMutableArray, init);
    
    _notifyPicMsg = STRONG_OBJECT(NSMutableDictionary, init);
    
    [_promiseImageView setBorderWithColor:[UIColor borderPicGreyColor]];
    
    if(_isEdit)
    {
        ADAPI_SilverAdvertEnterpriseGetProductDetail([self genDelegatorID:@selector(handleGetProductDetail:)], _productId);
        
        [self setNavigateTitle:@"设置绑定兑换商品"];
    }
    else
    {
        ADAPI_SilverAdvertGetExchangeAddress([self genDelegatorID:@selector(GetExchangeAddress:)], @"0", @"1");
        
        [self setNavigateTitle:@"新增兑换商品"];
    }
    
    [self _initData];
    
    [self fixView];
}

- (void) viewWillAppear:(BOOL)animated
{
}

- (void) fixView
{
//    _line1.top = 49.5;
//    
    _line3.top = 44.5;
//
    _line4.top = 264.5;
    
    
}

- (void) _initData
{
    _currentItem = -1;
    _deleteIndex = -1;
    
    self.pickedUrls = [NSMutableArray arrayWithCapacity:0];
    self.pickedIds = [NSMutableArray arrayWithCapacity:0];
    
    self.clsPickedUrls = [NSMutableArray arrayWithCapacity:0];
    self.clsPickedIds = [NSMutableArray arrayWithCapacity:0];
    
    [self _initPstCollectionView];
    
}

- (void)handleGetProductDetail:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        
        if(dic.data)
        {
            [_srcData removeAllObjects];
            
            [self setSrcDataView:dic];
            
        }
        
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}



- (void) setSrcDataView:(DictionaryWrapper *)dic
{
    DictionaryWrapper * wrap = dic.data;
    
    [_srcData setObject:[wrap getString:@"Id"] forKey:@"Id"];
    
    NSString * name = [wrap getString:@"Name"];
    
    if(name.length)
    {
        [_srcData setObject:name forKey:@"Name"];
        
        self.prodNameField.text = name;
    }
    
    NSString * des = [wrap getString:@"Describe"];
    if(des.length)
    {
        [_srcData setObject:des forKey:@"Describe"];
        
        self.productDes = des;
        
        [self.prodDesBtn setTitle:@"已填写" forState:UIControlStateNormal];
        
        [_prodDesBtn setTitleColor:AppColor(34) forState:UIControlStateNormal];
    }
    else{
        
        [self.prodDesBtn setTitle:@"未填写" forState:UIControlStateNormal];
        [_prodDesBtn setTitleColor:RGBCOLOR(209, 209, 213) forState:UIControlStateNormal];

    }
    
    NSArray * silverProdArr = [wrap getArray:@"SilverProductPictures"];
    NSArray * exchProdArr = [wrap getArray:@"ExchangePromisePictures"];
    
    if(silverProdArr.count)
    {
        [_srcData setObject:silverProdArr forKey:@"SilverProductPictures"];
        
        for(NSDictionary * dic in silverProdArr)
        {
            [_pickedIds addObject:[dic.wrapper getString:@"PictureId"]];
            
            [_pickedUrls addObject:[dic.wrapper getString:@"PictureUrl"]];
        }
    }
    
    if(exchProdArr.count)
    {
        [_srcData setObject:exchProdArr forKey:@"ExchangePromisePictures"];
        
        for(NSDictionary * dic in exchProdArr)
        {
            [_clsPickedIds addObject:[dic.wrapper getString:@"PictureId"]];
            
            [_clsPickedUrls addObject:[dic.wrapper getString:@"PictureUrl"]];
        }
    }
    
    [self countHeight];
    [_collectionview reloadData];
    
    NSString * cateName = [wrap getString:@"CategoryName"];
    if(cateName.length)
    {
        [_srcData setObject:cateName forKey:@"CategoryName"];
        
        [self.cateBtn setTitle:cateName forState:UIControlStateNormal];
        
    }
    
    NSString * cateId = [wrap getString:@"CategoryId"];
    if(cateId.length)
    {
        [_srcData setObject:[wrap getString:@"CategoryId"] forKey:@"CategoryId"];
    }
    
    NSString * price = [wrap getString:@"UnitPrice"];
    if(price.length)
    {
        [_srcData setObject:price forKey:@"UnitPrice"];
        
        self.prodPriceField.text = price;
    }
    
    NSString * unitInte = [wrap getString:@"UnitIntegral"];
    if(unitInte.length)
    {
        [_srcData setObject:unitInte forKey:@"UnitIntegral"];
        
        self.prodYinyuanLbl.text = [NSString stringWithFormat:@"(等于 %@ 银元)", unitInte];
        
    }
    
    [_duihuanLimitBtn setTitle:@"已设置" forState:UIControlStateNormal];
    [_duihuanLimitBtn setTitleColor:AppColor(34) forState:UIControlStateNormal];
    
    _dayCount = [wrap getInt:@"PerPersonPerDayNumber"];
    _totalCount = [wrap getInt:@"PerPersonNumber"];
    [_srcData setObject:[NSNumber numberWithInteger:_totalCount] forKey:@"PerPersonNumber"];
    [_srcData setObject:[NSNumber numberWithInteger:_dayCount] forKey:@"PerPersonPerDayNumber"];
    
    
    _exType = [wrap getInt:@"ExchangeType"];
    [self setDuiHuanType];
    [_srcData setObject:[NSNumber numberWithInteger:_exType] forKey:@"ExchangeType"];
    
    NSArray * prodExchArr = [wrap getArray:@"ProductExchangeAddress"];
    if(prodExchArr.count && (_exType == 0 || _exType == 1))
    {
        [_srcData setObject:prodExchArr forKey:@"ProductExchangeAddress"];
        
        [_duihuanDianBtn setTitle:@"选择兑换点" forState:UIControlStateNormal];
        
        [_exPointsArr removeAllObjects];
        
        [_exPointsArr addObjectsFromArray:prodExchArr];
        
        [self layoutExchangePointView];
    }
    else
    {
        ADAPI_SilverAdvertGetExchangeAddress([self genDelegatorID:@selector(GetExchangeAddress:)], @"0", @"1");
    }
    
    NSDictionary * auditDic = [wrap getDictionary:@"AuditMessage"];
    
    if(auditDic && _isFail)
    {
//        [self showFailBubble:auditDic ];
        [self showFailReason:auditDic];
    }
}

//商品名称 --- 错误信息
- (void) showAuditStatus:(BOOL)auditStatus textField:(UITextField *) textField Notify:(CRInfoNotify *)notify Name:(NSString *)text View:(UIView *)view point:(CGPoint)point
{
    if(auditStatus)
    {
        [view addSubview:notify];
        
        [notify display:YES];
        
        textField.tag = 222;
        
        textField.textColor = [UIColor titleRedColor];
    }
    else
    {
        [notify display:NO];
    }
}

//商品描述 --- 错误信息
- (void) showAuditStatus:(BOOL)auditStatus Button:(UIButton *) btn Notify:(CRInfoNotify *)notify Name:(NSString *)text View:(UIView *)view point:(CGPoint)point
{
    if(auditStatus)
    {
        [view addSubview:notify];
        
        [notify display:YES];
        
        btn.tag = 222;
        
        btn.titleLabel.textColor = [UIColor titleRedColor];
    }
    else
    {
        [notify display:NO];
    }
}

- (void) showPicAuditStatus:(NSArray *)picArr withIDArr:(NSMutableArray *)pickIds andTag:(int)tag
{
    for(NSDictionary * dic in picArr)
    {
        NSString * msg = [dic.wrapper getString:@"AuditMessage"];
        
        if(msg.length)
        {
            NSString * picId = [dic.wrapper getString:@"PictureId"];
            
            [_notifyPicMsg setObject:msg forKey:picId];
            
            
            //商品图片 储存有错误信息
            if(tag == 1000)
                _IS_PROIMAGE_FAILE = YES;
            
            //承诺书 储存有错误信息
            else if(tag == 2000)
                _IS_PROMISE_FAILE = YES;
        }
    }
    
    [self setNotifyFrame:pickIds withTag:tag];
}

- (void) showFailReason:(NSDictionary *) dic
{
    DictionaryWrapper * auditDic = dic.wrapper;

    NSString * text = [auditDic getString:@"OtherErrmsg"];
//    NSString *text = @"测试测试测试测试测试测试测试测试测试测试测试测试试测试测试测试测试测试测试测试测";

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
        
        _mainView.top = _topReasonView.bottom + 10;

    }
    
    text = [auditDic getString:@"BasicErrmsg"];
//    text = @"测试测试测试测试";
    
    if(text)
    {
        _firstReasonView.hidden = NO;
        
        _firstReasonLbl.text = text;
        
        [_mainView bringSubviewToFront:_firstReasonView];
        
        _bottomView.top = _firstReasonView.bottom - 16;
    }

    _xianzhiView.top = _bottomView.bottom + 10;
    
    text = [auditDic getString:@"IntroductionErrmsg"];
//    text = @"测试测试测试测试";
    
    BOOL status = text.length;
    
    CGPoint point = CGPointMake(298, 30 + 50);
    
    _desNotify = STRONG_OBJECT(CRInfoNotify, initWith:text at: point);
    
    [self showAuditStatus:status Button:_prodDesBtn Notify:_desNotify Name:text View:_xianzhiView point:point];
    
    self.picMsg = [auditDic getString:@"PicErrmsg"];

    self.promiseMsg = [auditDic getString:@"PromisePicErrmsg"];
    
//    self.picMsg = @"图片错误提示";
//    
//    self.promiseMsg = @"承诺书错误提示";
    
    [self countHeight];
    
    [_collectionview reloadData];
    
    _collectionview.top = _xianzhiView.bottom;
    
    _mainScrollView.contentSize = CGSizeMake(SCREENWIDTH, YH(_mainView) + 10);

}

- (void) showFailBubble:(NSDictionary *) dic
{
    DictionaryWrapper * auditDic = dic.wrapper;
    
    NSString * text = [auditDic getString:@"NameValidRemark"];
    
    BOOL status = text.length;
    
    CGPoint point = CGPointMake(298, 30);
    
    _titleNotify = STRONG_OBJECT(CRInfoNotify, initWith:text at: point);
    
    [self showAuditStatus:status textField:_prodNameField Notify:_titleNotify Name:text View:_mainView point: point];
    
    text = [auditDic getString:@"CategoryValidRemark"];
    
    status = text.length;
    
    point = CGPointMake(298, 30 + 50);
    
    _categoryNotify = STRONG_OBJECT(CRInfoNotify, initWith:text at: point);
    
    [self showAuditStatus:status Button:_cateBtn Notify:_categoryNotify Name:text View:_mainView point:point];
    
    
    NSArray * picArr = [auditDic getArray:@"ProductPictureAuditMessages"];
    
    [self showPicAuditStatus:picArr withIDArr:_pickedIds andTag:1000];
    
    NSArray * proArr = [auditDic getArray:@"PromisePictureAuditMessages"];
    
    [self showPicAuditStatus:proArr withIDArr:_clsPickedIds andTag:2000];
    
    
    text = [auditDic getString:@"DescribeValidRemark"];
    
    status = text.length;
    
    point = CGPointMake(298, 20);
    
    _desNotify = STRONG_OBJECT(CRInfoNotify, initWith:text at: point);
    
    [self showAuditStatus:status Button:_prodDesBtn Notify:_desNotify Name:text View:_bottomSubView point:point];
    
    
    text = [auditDic getString:@"UnitPriceValidRemark"];
    
    status = text.length;
    
    point = CGPointMake(298, 20 + 50);
    
    _unitPriceNotify = STRONG_OBJECT(CRInfoNotify, initWith:text at: point);
    
    [self showAuditStatus:status textField:_prodPriceField Notify:_unitPriceNotify Name:text View:_bottomSubView point: point];
    
}

- (void) setDuiHuanType
{
    _duihuanDianView.hidden = NO;
    
    if (_exType == 1)//现场
    {
        _xianchangDuihuanBtn.selected = YES;
        
        _xianchangIcon.image = [UIImage imageNamed:@"findShopfilterSelectBtn"];
    }
    else if (_exType == 2)//邮寄
    {
        _youjiDuihuanBtn.selected = YES;
        
        _duihuanDianView.hidden = YES;
        
        _youjiIcon.image = [UIImage imageNamed:@"findShopfilterSelectBtn"];
        
    }
    else if (_exType == 0)//不限
    {
        _xianchangDuihuanBtn.selected = YES;
        _youjiDuihuanBtn.selected = YES;
        
        _xianchangIcon.image = [UIImage imageNamed:@"findShopfilterSelectBtn"];
        _youjiIcon.image = [UIImage imageNamed:@"findShopfilterSelectBtn"];
    }
    else
    {
        _duihuanDianView.hidden = YES;
    }
}


- (void)countHeight{
    //计算高度
    NSInteger count = _pickedUrls.count + 1;
    NSInteger row = (count % 3) ? (count / 3 + 1) : count / 3;
    float height = row * (80 + 20);
    
    NSInteger clsCount = _clsPickedUrls.count + 1;
    NSInteger clsRow = (clsCount % 3) ? (clsCount / 3 + 1) : clsCount / 3;
    float clsHeight = clsRow * (80 + 20);
    
    if(_picMsg.length == 0 && _promiseMsg.length == 0)
    {
        height = height + clsHeight + collReusableTileHeight * 2;
    }
    else if(_picMsg.length && _promiseMsg.length)
    {
        height = height + clsHeight + failCollReusableTitleHeight * 2;
    }
    else
    {
        height = height + clsHeight + collReusableTileHeight + failCollReusableTitleHeight;
    }
    
    _collectionview.height = height;
    
    //计算高度
//    _bottomView.top = _collectionview.bottom + 10;
    
    CGRect rect = _mainView.frame;
    rect.size.height = _collectionview.bottom;
    _mainView.frame = rect;
    
    _line2.top = _collectionview.bottom;
    
    _mainScrollView.contentSize = CGSizeMake(SCREENWIDTH, YH(_mainView) + 10);
    
}

//上传图片
- (void)handleUploadPic:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed) {
        NSLog(@"%@",dic.data);
        
        self.isAlert = YES;
        
        NSString *url = [dic.data getString:@"PictureUrl"];
        NSString *pid = [dic.data getString:@"PictureId"];
        
        if (!url) {
            return;
        }
        
        if(!_isChengNuo)
        {
            _IS_PROIMAGE_FAILE = NO;
            
            if (_currentItem == -1) {
                [_pickedUrls addObject:url];
                [_pickedIds addObject:pid];
            } else {
                
//                if(_isFail)
//                {
//                    CRInfoNotify * noti = (CRInfoNotify *) [self.mainView viewWithTag: 1000 + _currentItem];
//                    
//                    BOOL isCRInfo = [noti isKindOfClass:[CRInfoNotify class]];
//                    
//                    if(noti && isCRInfo)
//                    {
//                        [noti display:NO];
//                    }
//                }
                
                [_pickedUrls removeObjectAtIndex:_currentItem];
                [_pickedUrls insertObject:url atIndex:_currentItem];
                [_pickedIds removeObjectAtIndex:_currentItem];
                [_pickedIds insertObject:pid atIndex:_currentItem];
            }
            
        }
        else
        {
            _IS_PROMISE_FAILE = NO;
            
            if (_currentItem == -1) {
                [_clsPickedUrls addObject:url];
                [_clsPickedIds addObject:pid];
            } else {
                
//                if(_isFail)
//                {
//                    CRInfoNotify * noti = (CRInfoNotify *) [self.mainView viewWithTag: 2000 + _currentItem];
//                    
//                    BOOL isCRInfo = [noti isKindOfClass:[CRInfoNotify class]];
//                    
//                    if(noti && isCRInfo)
//                    {
//                        [noti display:NO];
//                    }
//                }
                
                [_clsPickedUrls removeObjectAtIndex:_currentItem];
                [_clsPickedUrls insertObject:url atIndex:_currentItem];
                [_clsPickedIds removeObjectAtIndex:_currentItem];
                [_clsPickedIds insertObject:pid atIndex:_currentItem];
            }
        }
        
        [self countHeight];
        [_collectionview reloadData];
        
        if(_isFail)
        {
            for(UIView * view in [_mainView subviews])
            {
                if([view isKindOfClass:[CRInfoNotify class]])
                {
//                    NSLog(@"ttt :%d", [view tag]);
                    if(view.tag >= 1000)
                    [view removeFromSuperview];
                }
            }
            
            [self setNotifyFrame:_pickedIds withTag:1000];
            [self setNotifyFrame:_clsPickedIds withTag:2000];
        }
        
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}
//删除图片
- (void)handleDeletePic:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed) {
        NSLog(@"%@",dic.data);
        
        if(!_isChengNuo)
        {
            [_pickedUrls removeObjectAtIndex:(long)_deleteIndex];
        }
        else
        {
            [_clsPickedUrls removeObjectAtIndex:(long)_deleteIndex];
        }
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
        
        NSInteger imgType = EditImageType800;
        
        if(_isChengNuo)
        {
            imgType = EditImageTypeExchange;
        }
        
        EditImageViewController *imageEditor = WEAK_OBJECT(EditImageViewController,
                                                           initWithNibName:@"EditImageViewController"
                                                           bundle:nil
                                                           ImgType:imgType);
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
    //    if(_isChengNuo)
    //    {
    //        self.promiseImage = image;
    //    }
    ADAPI_Picture_Upload([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleUploadPic:)], UIImagePNGRepresentation(image));
}


//点击add图片
- (void)clickImage:(UIButton *)button{
    [self.view endEditing:YES];
    _currentItem = -1;
    
    if(button.tag == 1000)
    {
        _isChengNuo = NO;
    }
    else
    {
        _isChengNuo = YES;
    }
    UIActionSheet *sheet = [[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机拍摄" otherButtonTitles:@"从相册中选择", nil] autorelease];
    //    sheet.tag = button.tag;
    [sheet showInView:self.view];
}

#pragma mark - collectionview delegate / datasource
- (NSInteger)collectionView:(PSTCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section == 0)
    {
        return _pickedUrls.count >= 5 ? 5 : _pickedUrls.count + 1;
    }
    else
    {
        return _clsPickedUrls.count >= 5 ? 5 : _clsPickedUrls.count + 1;
    }
}

- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddPictureCell" forIndexPath:indexPath];
    
    CGRect rect = cell.btnAdd.frame;
    rect.size.width = 80;
    rect.size.height = 80;
    cell.btnAdd.frame = rect;
    
    cell.imageView.frame = rect;
    
    [cell.btnAdd setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
    [cell.btnAdd setImage:[UIImage imageNamed:@"increasehover"] forState:UIControlStateHighlighted];
    
    [cell.imageView setBorderWithColor:AppColor(204)];
    
    if(indexPath.section == 0)
    {
        if (indexPath.row == _pickedUrls.count && _pickedUrls.count != 5) {
            cell.imageView.hidden = YES;
            cell.btnAdd.hidden = NO;
            cell.btnAdd.tag = 1000;
            [cell.btnAdd addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            cell.btnAdd.hidden = YES;
            cell.imageView.hidden = NO;
            [cell.imageView requestWithRecommandSize:_pickedUrls[indexPath.row]];
        }
    }
    else
    {
        if (indexPath.row == _clsPickedUrls.count && _clsPickedUrls.count != 5) {
            cell.imageView.hidden = YES;
            cell.btnAdd.hidden = NO;
            cell.btnAdd.tag = 2000;
            [cell.btnAdd addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            cell.btnAdd.hidden = YES;
            cell.imageView.hidden = NO;
            [cell.imageView requestWithRecommandSize:_clsPickedUrls[indexPath.row]];
        }
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(PSTCollectionView *)collectionView
{
    return 2;
}

- (PSTCollectionReusableView *)collectionView:(PSTCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    PSTCollectionReusableView *reusableView = nil;
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        
        NSAttributedString *attrStr = nil;
        
        NSString * text = @"";
        
        if(indexPath.section == 0)//商品图片
        {
            if(_picMsg.length)
            {
                reuseIdentifier = @"MsgCollectionReusableView";
                
                MsgCollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];

                text = @"商品图片（最多5张）";
                
                attrStr = [RRAttributedString setText:text font:Font(12) color:RGBCOLOR(153, 153, 153) range:NSMakeRange(4, text.length - 4)];
                
                view.titleLbl.text = text;
                view.titleLbl.attributedText = attrStr;
                view.downloadBtn.hidden = YES;
                
                view.msgLbl.text = _picMsg;
                
                reusableView = view;
            }
            else
            {
                reuseIdentifier = @"CollectionReusableView";
                
                CollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
                
                text = @"商品图片（最多5张）";
                
                attrStr = [RRAttributedString setText:text font:Font(12) color:RGBCOLOR(153, 153, 153) range:NSMakeRange(4, text.length - 4)];
                
                view.titleLbl.text = text;
                view.titleLbl.attributedText = attrStr;
                view.downloadBtn.hidden = YES;
                
                reusableView = view;
            }
            
        }
        else
        {
            if(_promiseMsg.length)
            {
                reuseIdentifier = @"MsgCollectionReusableView";
                
                MsgCollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
                
                text = @"商品承诺书（最多5张）";
                
                attrStr = [RRAttributedString setText:text font:Font(12) color:RGBCOLOR(153, 153, 153) range:NSMakeRange(5, text.length - 5)];
                
                view.titleLbl.text = text;
                view.titleLbl.attributedText = attrStr;
                [view.downloadBtn addTarget:self action:@selector(downloadImage) forControlEvents:UIControlEventTouchUpInside];

                view.msgLbl.text = _promiseMsg;
                
                reusableView = view;
            }
            else
            {
                reuseIdentifier = @"CollectionReusableView";
                
                CollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
                
                text = @"商品承诺书（最多5张）";
                
                attrStr = [RRAttributedString setText:text font:Font(12) color:RGBCOLOR(153, 153, 153) range:NSMakeRange(5, text.length - 5)];
                
                view.titleLbl.text = text;
                view.titleLbl.attributedText = attrStr;
                
                [view.downloadBtn addTarget:self action:@selector(downloadImage) forControlEvents:UIControlEventTouchUpInside];
                
                reusableView = view;
            }
        }
    }
    
    return reusableView;
}

- (void) downloadImage
{
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.ContentCode = @"d1d23f03edbc383f6c6873822f305584";
    
}

- (CGSize)collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 80);
}

- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIActionSheet *sheet = [[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"预览" otherButtonTitles:@"相机拍摄", @"从相册中选择", @"删除", nil] autorelease];
    if(indexPath.section == 0)
    {
        sheet.tag = indexPath.row + 1000;
        
        _isChengNuo = NO;
    }
    else
    {
        sheet.tag = indexPath.row + 2000;
        
        _isChengNuo = YES;
    }
    
    [sheet showInView:self.view];
}

- (void)_initPstCollectionView{
    
    PSTCollectionViewFlowLayout *layout = WEAK_OBJECT(PSTCollectionViewFlowLayout, init);
    layout.minimumInteritemSpacing = 20.f;
    layout.minimumLineSpacing = 20.f;
    UIEdgeInsets insets = {.top = 0,.left = 20,.bottom = 20,.right = 20};
    layout.sectionInset = insets;
    
    _collectionview = WEAK_OBJECT(PSTCollectionView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100 * 2 + collReusableTileHeight * 2) collectionViewLayout:layout);
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.scrollEnabled = NO;
    _collectionview.backgroundColor = [UIColor whiteColor];
    [_collectionview registerNib:[UINib nibWithNibName:@"AddPictureCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AddPictureCell"];
    
    [_collectionview registerNib:[UINib nibWithNibName:@"CollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableView"];
    
    [_collectionview registerNib:[UINib nibWithNibName:@"MsgCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MsgCollectionReusableView"];

    [_mainView addSubview:_collectionview];
    
    
    //计算高度
//    _bottomView.top = _collectionview.bottom + 10;
    
    _xianzhiView.top = _bottomView.bottom + 10;
    
    _collectionview.top = _xianzhiView.bottom;
    
    CGRect rect = _mainView.frame;
    rect.size.height = _collectionview.bottom;
    _mainView.frame = rect;
    
    _line2.top = _collectionview.bottom;
    
    _mainScrollView.contentSize = CGSizeMake(SCREENWIDTH, _mainView.bottom + 10);
}

- (CGSize)collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size= CGSizeMake(320, 30);
    
    if(_picMsg.length && section == 0)
    {
        size= CGSizeMake(320, failCollReusableTitleHeight);
    }
    else if (_promiseMsg.length && section == 1)
    {
        size = CGSizeMake(320, failCollReusableTitleHeight);
    }
    else
    {
        size = CGSizeMake(320, collReusableTileHeight);
    }
    
    return size;
}

- (void) selectProductCategorey:(NSString *)cateName withId:(NSString *)cateId
{
    self.isAlert = YES;
    
    [_cateBtn setTitle:cateName forState:UIControlStateNormal];
    
    [_srcData setObject:cateId forKey:@"CategoryId"];
}

- (void)GetExchangeAddress:(DelegatorArguments*)arguments
{
    [arguments logError];
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        NSArray * arr = [wrapper.data getArray:@"PageData"];
        
        if([arr count])//选择兑换点
        {
            [_duihuanDianBtn setTitle:@"选择兑换点" forState:UIControlStateNormal];
        }
        else
        {
            [_duihuanDianBtn setTitle:@"新增兑换点" forState:UIControlStateNormal];
        }
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sheetTag = actionSheet.tag;
    
    if (sheetTag >= 1000 && sheetTag != 1000000)
    {
        int tag = 2000;
        if(sheetTag >= 1000 && sheetTag < 2000)
        {
            tag = 1000;
        }
        
        if (buttonIndex == 0) {
            //预览
            PreviewViewController *preview = WEAK_OBJECT(PreviewViewController, init);
            if(sheetTag >= 1000 && sheetTag < 2000)
            {
                preview.dataArray = @[@{@"PictureUrl":_pickedUrls[actionSheet.tag - tag]}];
            }
            else
            {
                preview.dataArray = @[@{@"PictureUrl":_clsPickedUrls[actionSheet.tag - tag]}];
            }
            
            preview.currentPage = 0;
            [self presentViewController:preview animated:NO completion:^{
                preview.pageControl.hidden = YES;
            }];
        } else if (buttonIndex == 1) {
            _currentItem = actionSheet.tag - tag;
            [UICommon showCamera:self view:self allowsEditing:YES];
        } else if (buttonIndex == 2) {
            
            _currentItem = actionSheet.tag - tag;
            [UICommon showImagePicker:self view:self];
        } else if (buttonIndex == 3){
            //删除
            _deleteIndex = actionSheet.tag - tag;
            if(sheetTag >= 1000 && sheetTag < 2000)
            {
                [_pickedIds removeObjectAtIndex:_deleteIndex];
                [_pickedUrls removeObjectAtIndex:(long)_deleteIndex];
            }
            else
            {
                [_clsPickedIds removeObjectAtIndex:_deleteIndex];
                [_clsPickedUrls removeObjectAtIndex:(long)_deleteIndex];
            }
            
            [self countHeight];
            [_collectionview reloadData];
            
            if(_isFail)
            {
                for(UIView * view in [_mainView subviews])
                {
                    if([view isKindOfClass:[CRInfoNotify class]])
                    {
                        [view removeFromSuperview];
                    }
                }
                
                [self setNotifyFrame:_pickedIds withTag:1000];
                [self setNotifyFrame:_clsPickedIds withTag:2000];
            }
            
            self.isAlert = YES;
            
        }
    }
    else if(sheetTag == 1000000)
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

- (void)setNotifyFrame:(NSMutableArray *)pickedIds withTag:(int)tag
{
    for (int i = 0; i < pickedIds.count; i ++) {
        
        NSString * picId = pickedIds[i];
        
        NSString * msg = [_notifyPicMsg.wrapper getString:picId];
        
        if(msg.length)
        {
            int row = i / 3;
            
            int index = i % 3;
            
            if(_isFail)
            {
                CRInfoNotify * noti = (CRInfoNotify *) [_mainView viewWithTag:tag + i];
                
                if(!noti)
                {
                    if(tag == 1000)
                    {
                        noti = STRONG_OBJECT(CRInfoNotify, initWith:msg at: CGPointMake(100 + 100 * index, _topView.bottom + 30 + 100 * row));
                    }
                    else
                    {
                        int height = 0;
                        
                        if(_pickedIds.count <= 2)//商品图片一行
                        {
                            height = 100 + 30 * 2;
                        }
                        else
                        {
                            height = 200 + 30 * 2;
                        }
                        
                        noti = STRONG_OBJECT(CRInfoNotify, initWith:msg at: CGPointMake(100 + 100 * index, _topView.bottom + height + 100 * row));
                    }
                    
                    noti.tag = tag + i;
                    
                    [_mainView addSubview:noti];
                }
                else
                {
                    [noti display:YES];
                }
            }
        }
    }
}


- (BOOL) checkFailFieldState
{
    if(!_titleNotify.hidden)
    {
        [HUDUtil showErrorWithStatus:@"请修改商品名称"];
        
        [_prodNameField becomeFirstResponder];
        
        return NO;
    }
    
    if(!_categoryNotify.hidden)
    {
        [HUDUtil showErrorWithStatus:@"请修改商品类别"];
        
        return NO;
    }
    
    for (int i = 0; i < _pickedIds.count; i ++) {
        
        CRInfoNotify * noti = (CRInfoNotify *) [self.mainView viewWithTag:1000 + i];
        
        BOOL isCRInfo = [noti isKindOfClass:[CRInfoNotify class]];
        
        if(!noti.hidden && isCRInfo)
        {
            [HUDUtil showErrorWithStatus:@"请修改商品图片"];
            
            return NO;
        }
    }
    for (int i = 0; i < _clsPickedIds.count; i ++) {
        
        CRInfoNotify * noti = (CRInfoNotify *) [self.mainView viewWithTag:2000 + i];
        
        BOOL isCRInfo = [noti isKindOfClass:[CRInfoNotify class]];
        
        if(!noti.hidden && isCRInfo)
        {
            [HUDUtil showErrorWithStatus:@"请修改商品承诺书"];
            
            return NO;
        }
    }
    
    if(!_desNotify.hidden)
    {
        [HUDUtil showErrorWithStatus:@"请修改商品描述"];
        
        return NO;
    }
    if(!_unitPriceNotify.hidden)
    {
        [HUDUtil showErrorWithStatus:@"请修改价格"];
        
        [_prodPriceField becomeFirstResponder];
        
        return NO;
    }
    
    return YES;
}

//提交审核
- (void) goToCommit
{
    _isVerify = @"0";
    
    if(![self checkField] && !_isFail)
    {
        return;
    }
    
    if(![self validField])
    {
        return;
    }
    
//        if(_isFail)
//        {
//            if(![self checkFailFieldState])
//            {
//                return;
//            }
//        }
    
//    if(_isFail) if(![self FaileMsg]) return;
    
    NSString * text = @"银元兑换商品一旦提交则不可更改";
    
    if(_exType == 0 || _exType == 1)
    {
        text = @"兑换点地址一旦提交则不可更改";
    }
    
    UIAlertView * alert = [[[UIAlertView alloc] initWithTitle: @"确认提交"
                                                      message: text
                                                     delegate: self
                                            cancelButtonTitle: @"取消"
                                            otherButtonTitles: @"确定", nil] autorelease];
    [alert show];
}

//错误提示信息 Nick修改
-(BOOL)FaileMsg
{
    if(!_titleNotify.hidden)
    {
        [HUDUtil showErrorWithStatus:@"请修改商品名称"];
        
        [_prodNameField becomeFirstResponder];
        
        return NO;
    }
    
    if(!_categoryNotify.hidden)
    {
        [HUDUtil showErrorWithStatus:@"请修改商品类别"];
        
        return NO;
    }
    
    for (int i = 0; i < _pickedIds.count; i ++) {
        
        CRInfoNotify * noti = (CRInfoNotify *) [self.mainView viewWithTag:1000 + i];
        
        BOOL isCRInfo = [noti isKindOfClass:[CRInfoNotify class]];
        
        if(!noti.hidden && isCRInfo)
        {
            [HUDUtil showErrorWithStatus:@"请修改商品图片"];
            
            return NO;
        }
        
        
        if(_IS_PROIMAGE_FAILE)
        {
            [HUDUtil showErrorWithStatus:@"请修改商品图片"];
            return NO;
        }
    }
    
    for (int i = 0; i < _clsPickedIds.count; i ++) {
        
        CRInfoNotify * noti = (CRInfoNotify *) [self.mainView viewWithTag:2000 + i];
        
        BOOL isCRInfo = [noti isKindOfClass:[CRInfoNotify class]];
        
        if(!noti.hidden && isCRInfo)
        {
            [HUDUtil showErrorWithStatus:@"请修改商品承诺书"];
            
            return NO;
        }
        
        if(_IS_PROMISE_FAILE)
        {
            [HUDUtil showErrorWithStatus:@"请修改商品承诺书"];
            return NO;
        }
    }
    
    if(!_desNotify.hidden)
    {
        [HUDUtil showErrorWithStatus:@"请修改商品描述"];
        
        return NO;
    }
    if(!_unitPriceNotify.hidden)
    {
        [HUDUtil showErrorWithStatus:@"请修改价格"];
        
        [_prodPriceField becomeFirstResponder];
        
        return NO;
    }
    
    return YES;
}

- (void) goToSave
{
    _isVerify = @"-1";
    
    if(![self checkToSave])
    {
        return;
    }
    if(![self validField])
    {
        return;
    }
    
    [self SaveSilverProduct];
}

- (void) onMoveFoward:(UIButton *)sender
{
    [self goToSave];
}

- (void)showActionSheet
{
    UIActionSheet *actionSheet = nil;
    
    actionSheet = [[[UIActionSheet alloc]
                    initWithTitle:@""
                    delegate:self
                    cancelButtonTitle:@"取消"
                    destructiveButtonTitle:nil
                    otherButtonTitles:@"相机拍摄", @"从相册选择",nil]autorelease];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [actionSheet showInView:self.view];
    
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
        
        [self.mainScrollView setContentOffset:p animated:YES];
        
    }
    else if (_textFeildTouchedY > 210)
    {
        CGPoint p = CGPointMake(0,  _textFeildTouchedY - 210 + y + 35);
        
        [self.mainScrollView setContentOffset:p animated:YES];
    }
    
    if(_isFail)
    {
        [self hiddenNotify:textField];
    }
}

- (void) hiddenNotify:(UITextField *)textField
{
    if(textField == _prodNameField && textField.tag == 222)
    {
        [_titleNotify display:NO];
    }
    else if (textField == _prodPriceField && textField.tag == 222)
    {
        [_unitPriceNotify display:NO];
    }
    
    textField.textColor = AppColor(85);
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

- (void)changeExchangeState
{
    if(_xianchangDuihuanBtn.selected && _youjiDuihuanBtn.selected)
    {
        _exType = 0;
    }
    else if (_xianchangDuihuanBtn.selected && !_youjiDuihuanBtn.selected)
    {
        _exType = 1;
    }
    else if (!_xianchangDuihuanBtn.selected && _youjiDuihuanBtn.selected)
    {
        _exType = 2;
    }
    else
    {
        _exType = -1;
    }
}

//按钮点击事件
- (IBAction)touchUpInsideOnBtn:(id)sender
{
    if(sender == _cateBtn)
    {
        IndustryCategotiesViewController * view = WEAK_OBJECT(IndustryCategotiesViewController, init);
        
        view.delegate = self;
        
        view.isCateForYinYuan = YES;
        
        if(_isFail && _cateBtn.tag == 222)
        {
            [_categoryNotify display:NO];
        }
        
        [self.navigationController pushViewController:view animated:YES];
        
    }
    else if (sender == _prodDesBtn)
    {
        YinYuanProdEditSubController * view = WEAK_OBJECT(YinYuanProdEditSubController, init);
        
        view.delegate = self;
        
        view.naviTitle = @"商品描述";
        
        view.prodDes = _productDes;
        
        view.limitNum = 500;
        
        if(_isFail && _prodDesBtn.tag == 222)
        {
            [_desNotify display:NO];
        }
        
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender == _duihuanLimitBtn)
    {
        YinYuanProdEditSubController * view = WEAK_OBJECT(YinYuanProdEditSubController, initWithNibName:@"YinYuanProdEditSubController" bundle:nil);
        
        view.delegate = self;
        
        view.naviTitle = @"兑换限制";
        
        view.dayCount = _dayCount;
        
        view.totalCount = _totalCount;
        
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender == _xianchangDuihuanBtn)
    {
        self.isAlert = YES;
        
        _xianchangIcon.image = _xianchangDuihuanBtn.selected ? [UIImage imageNamed:@"findShopfilterBtn"] : [UIImage imageNamed:@"findShopfilterSelectBtn"];
        
        _xianchangDuihuanBtn.selected = !_xianchangDuihuanBtn.selected;
        
        if(_xianchangDuihuanBtn.selected)
        {
            _duihuanDianView.hidden = _exPointsArr.count ? YES : NO;
            
            _line4.hidden = _duihuanDianView.hidden;
            
            _duihuanTableView.hidden = !_duihuanDianView.hidden;
        }
        else
        {
            _duihuanTableView.hidden = YES;
            
            _duihuanDianView.hidden = YES;
            
            _line4.hidden = YES;
            
        }
        
        [self hiddenDuiHuanTableView];
        
        [self changeExchangeState];
        
    }
    else if (sender == _youjiDuihuanBtn)
    {
        self.isAlert = YES;
        
        _youjiIcon.image = _youjiDuihuanBtn.selected ? [UIImage imageNamed:@"findShopfilterBtn"] : [UIImage imageNamed:@"findShopfilterSelectBtn"];
        _youjiDuihuanBtn.selected = !_youjiDuihuanBtn.selected;
        
        [self changeExchangeState];
    }
    else if (sender == _duihuanDianBtn)
    {
        if([_duihuanDianBtn.titleLabel.text isEqualToString:@"新增兑换点"])//create
        {
            AddConvertCenterViewController * view = WEAK_OBJECT(AddConvertCenterViewController, init);
            
            view.isYinYuanProduct = YES;
            
            view.yinYuanDelegate = self;
            
            [self.navigationController pushViewController:view animated:YES];
        }
        else
        {
            SetConvertCenterViewController * view = WEAK_OBJECT(SetConvertCenterViewController, init);
            
            view.delegate = self;
            
            view.isSelect = YES;
            
            [self.navigationController pushViewController:view animated:YES];
        }
    }
    else if (sender == _commitBtn)
    {
        [self goToCommit];
        
    }
}

- (void) yinYuanSelectExPointFinish:(NSMutableArray *)selExPointArr
{
    [_exPointsArr removeAllObjects];
    
    [_exPointsArr addObjectsFromArray:selExPointArr];
    
    [_duihuanTableView reloadData];
    
    [self layoutExchangePointView];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(textField == _prodPriceField && [_prodPriceField.text isEqualToString:@"0"]){
        
        double money = [string doubleValue] * 100.0;
        
        _prodYinyuanLbl.text = [NSString stringWithFormat:@"(等于 %.f 银元)", money];
    }
    
    if (textField == _prodPriceField) {
        
        if(![UICommon validDecimalPoint:textField withRange:range replacementString:string andRemain:1])
        {
            return NO;
        }
    }
    
    return YES;
}

- (void) textFieldDidChange:(id)sender
{
    UITextField * textField = (UITextField *)[sender object];
    
    if(textField == _prodPriceField){
        
        double money = [[_prodPriceField text] doubleValue] * 100.0;
        
        _prodYinyuanLbl.text = [NSString stringWithFormat:@"(等于 %.f 银元)", money];
    }
}

- (BOOL) checkField
{
    if(!_prodNameField.text.length)
    {
        [HUDUtil showErrorWithStatus:@"请填写商品名称"];
        
        [_prodNameField becomeFirstResponder];
        
        return NO;
    }
    if(!_cateBtn.titleLabel.text.length)
    {
        [HUDUtil showErrorWithStatus:@"请选择商品类别"];
        
        return NO;
    }
    if (![_prodPriceField.text floatValue]) {
        
        [HUDUtil showErrorWithStatus:@"请设置商品价格"];
        
        [_prodPriceField becomeFirstResponder];
        
        return NO;
    }
    if(_exType == -1)
    {
        [HUDUtil showErrorWithStatus:@"请选择兑换方式"];
        
        return NO;
    }
    if(_exType == 1 || _exType == 0)
    {
        if(_exPointsArr.count == 0)
        {
            [HUDUtil showErrorWithStatus:@"请选择现场兑换点"];
            
            return NO;
        }
    }
    if(![_duihuanLimitBtn.titleLabel.text isEqualToString:@"已设置"])
    {
        [HUDUtil showErrorWithStatus:@"请设置兑换限制"];
        
        return NO;
    }
    if(!_productDes.length)
    {
        [HUDUtil showErrorWithStatus:@"请填写商品描述"];
        
        return NO;
    }
    if(!_pickedIds.count)
    {
        [HUDUtil showErrorWithStatus:@"请上传商品图片"];
        
        return NO;
    }
    if(!_clsPickedIds.count)
    {
        [HUDUtil showErrorWithStatus:@"请上传商品承诺书"];
        
        return NO;
    }
    return YES;
}

- (void) layoutExchangePointView
{
    if(_exPointsArr.count)
    {
        _duihuanTableView.hidden = NO;
        
        _duihuanDianView.hidden = YES;
        
        _line4.hidden = YES;
        
        CGRect rect = _duihuanTableView.frame;
        
        rect.size.height = 87 * [_exPointsArr count];
        
        rect.origin.y = 220;
        
        rect.size.width = 320;
        
        _duihuanTableView.frame = rect;
        
        [self hiddenDuiHuanTableView];
        
    }
    else
    {
        _duihuanTableView.hidden = YES;
        
        _duihuanDianView.hidden = NO;
    }
    
}

- (void) hiddenDuiHuanTableView
{
    CGRect rect = CGRectZero;
    
    if(!_duihuanTableView.hidden)
    {
        rect = _bottomSubView.frame;
        
        rect.size.height = YH(_duihuanTableView);
        
        _bottomSubView.frame = rect;
    }
    else
    {
        rect = _bottomSubView.frame;
        
        rect.size.height = YH(_duihuanDianView);
        
        _bottomSubView.frame = rect;
    }
    
    rect = _bottomView.frame;
    
    rect.size.height = YH(_bottomSubView);
    
    _bottomView.frame = rect;
    
    
    _xianzhiView.top = _bottomView.bottom + 10;
    
    _collectionview.top = _xianzhiView.bottom ;
    
    
    rect = _mainView.frame;
    
    rect.size.height = YH(_collectionview);
    
    _mainView.frame = rect;
    
    _mainScrollView.contentSize = CGSizeMake(320, YH(_mainView) + 10);

}

- (BOOL) validField
{
    if(_prodNameField.text.length > 30)
    {
        [HUDUtil showErrorWithStatus:@"商品名称不能超出30个字"];
        
        [_prodNameField becomeFirstResponder];
        
        return NO;
    }
    if(_prodPriceField.text.length > 9)
    {
        [HUDUtil showErrorWithStatus:@"商品价格太高，请重新填写"];
        
        [_prodPriceField becomeFirstResponder];
        
        return NO;
    }
    //    if(_xianchangDuihuanBtn.selected && !_exPointsArr.count)
    //    {
    //        [HUDUtil showErrorWithStatus:@"请设置兑换点"];
    //
    //        return NO;
    //    }
    return YES;
}

- (void) SaveSilverProduct
{
    [_activeField resignFirstResponder];
    
    if(_prodNameField.text.length)
    {
        [_srcData setObject:_prodNameField.text forKey:@"Name"];
    }
    
    if(_productDes.length)
    {
        [_srcData setObject:_productDes forKey:@"Describe"];
    }
    
    [_srcData setObject:_pickedIds forKey:@"SilverProductPictures"];
    [_srcData setObject:_clsPickedIds forKey:@"ExchangePromisePictures"];
    
    if(_prodPriceField.text.length)
    {
        [_srcData setObject:_prodPriceField.text forKey:@"UnitPrice"];
    }
    
    double money = [[_prodPriceField text] doubleValue] * 100.0;
    
    NSString  *UnitIntegral = [NSString stringWithFormat:@"%.f", money];
    
    [_srcData setObject:UnitIntegral forKey:@"UnitIntegral"];
    
    [_srcData setObject:[NSNumber numberWithInteger:_dayCount] forKey:@"PerPersonPerDayNumber"];
    
    [_srcData setObject:[NSNumber numberWithInteger:_totalCount] forKey:@"PerPersonNumber"];
    
    [_srcData setObject:_isVerify forKey:@"VerifyState"];
    
    [_srcData setObject:[NSNumber numberWithInteger:_exType] forKey:@"ExchangeType"];
    
    if(_xianchangDuihuanBtn.selected)
    {
        NSMutableArray * addsArr = WEAK_OBJECT(NSMutableArray, init);
        
        for(int i = 0; i < [_exPointsArr count]; i ++ )
        {
            NSDictionary * dic = _exPointsArr[i];
            
            int addrssId = [dic.wrapper getInt:@"Id"];
            
            [addsArr addObject:[NSNumber numberWithInteger:addrssId]];
            
        }
        
        [_srcData setObject:addsArr forKey:@"ProductExchangeAddress"];
    }
    else
    {
        [_srcData setObject:@"" forKey:@"ProductExchangeAddress"];
    }
    
    if(!_isEdit)
    {
        [_srcData setObject:@"0" forKey:@"Id"];
    }
    
    ADAPI_SilverAdvertSaveSilverProduct([self genDelegatorID:@selector(handleSaveSilverProduct:)], _srcData);
}

- (void)handleSaveSilverProduct:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        if([_isVerify isEqualToString:@"0"])
        {
            //审核
            [HUDUtil showSuccessWithStatus:@"提交成功"];
            
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
            
            if(_isMoveBack)
            {
                [self.navigationController popViewControllerAnimated:YES];
                
                return;
            }
        }
        
        [_srcData setObject:[wrapper getString:@"Data"] forKey:@"Id"];
        
        _isAlert = NO;
        
        _isEdit = YES;
    }
    else
    {
        if(!wrapper.operationMessage)
        {
            [HUDUtil showErrorWithStatus:@"保存失败，请重试"];
        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}

- (void) onMoveBack:(UIButton *)sender
{
    [_activeField resignFirstResponder];
    
    _isMoveBack = YES;
    
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

- (BOOL) checkToSave
{
    if(!_prodNameField.text.length
       && !_cateBtn.titleLabel.text.length
       && !_clsPickedIds.count
       && !_pickedIds.count
       && !_productDes.length
       && ![_prodPriceField.text intValue]
       && ![_duihuanLimitBtn.titleLabel.text isEqualToString:@"已设置"]
       && (_exType == -1 ) )
        //       && (_exType == -1 || (_exType == 0 && !_exPointsArr.count) || (_exType == 1 && !_exPointsArr.count) ) )
    {
        [HUDUtil showErrorWithStatus:@"暂无可保存的内容"];
        
        return NO;
    }
    return YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)//提交审核
    {
        [self SaveSilverProduct];
    }
}

- (void) passDuihuanLimit:(int)dayCount andTotalCount:(int)totalCount
{
    if(dayCount >= 1 && totalCount >= 1)
    {
        self.isAlert = YES;
        
        [_duihuanLimitBtn setTitle:@"已设置" forState:UIControlStateNormal];
        
        [_duihuanLimitBtn setTitleColor:AppColor(34) forState:UIControlStateNormal];
        
        _dayCount = dayCount;
        
        _totalCount = totalCount;
    }
    else
    {
        [_duihuanLimitBtn setTitle:@"未设置" forState:UIControlStateNormal];
        
        [_duihuanLimitBtn setTitleColor:RGBCOLOR(209, 209, 213) forState:UIControlStateNormal];

    }
}

- (void) passProdDes:(NSString *)prodDes
{
    if(prodDes.length > 0)
    {
        self.isAlert = YES;
        
        [_prodDesBtn setTitle:@"已填写" forState:UIControlStateNormal];
        
        [_prodDesBtn setTitleColor:AppColor(34) forState:UIControlStateNormal];
        
        self.productDes = prodDes;
    }
    else
    {
        [_prodDesBtn setTitle:@"未填写" forState:UIControlStateNormal];
        
        [_prodDesBtn setTitleColor:RGBCOLOR(209, 209, 213) forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark UITableViewDelegate and UITableViewDatasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_exPointsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = [indexPath row];
    
    YinYuanDuiHuanDianCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"YinYuanDuiHuanDianCell"];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YinYuanDuiHuanDianCell"
                                                     owner:self
                                                   options:nil];
        for (id oneObj in nib) {
            if ([oneObj isKindOfClass:[YinYuanDuiHuanDianCell class]]) {
                cell = (YinYuanDuiHuanDianCell *)oneObj;
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary * dic = [_exPointsArr objectAtIndex:row];
    
    cell.iconView.hidden = (row == 0) ? NO : YES;
    
    cell.titleLbl.text = [dic.wrapper getString:@"Name"];
    
    cell.telLbl.text = [dic.wrapper getString:@"ContactNumber"];
    
    cell.addressLbl.text = [dic.wrapper getString:@"DetailedAddress"];
    
    cell.line.top = 86.5;
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    
    if(row == 0)
    {
        SetConvertCenterViewController * view = WEAK_OBJECT(SetConvertCenterViewController, init);
        
        view.delegate = self;
        
        view.isSelect = YES;
        
        view.selArr = _exPointsArr;
        
        [self.navigationController pushViewController:view animated:YES];
    }
}


- (void)dealloc {
    
    [_titleNotify release];
    [_categoryNotify release];
    [_desNotify release];
    [_unitPriceNotify release];
    
    [_notifyPicMsg release];
    _notifyPicMsg = nil;
    
    [_mainScrollView release];
    [_mainView release];
    [_prodNameField release];
    [_cateBtn release];
    [_picMainView release];
    [_picView release];
    [_picScrollView release];
    [_bottomView release];
    [_duihuanTableView release];
    [_prodDesBtn release];
    [_prodPriceField release];
    [_prodYinyuanLbl release];
    [_duihuanLimitBtn release];
    [_xianchangDuihuanBtn release];
    [_xianchangIcon release];
    [_youjiDuihuanBtn release];
    [_youjiIcon release];
    [_duihuanDianView release];
    [_duihuanDianBtn release];
    
    [self unregisterForKeyboardNotifications];
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UITextFieldTextDidChangeNotification
                                                 object:nil];
    
    [_srcData release];
    _srcData = nil;
    
    [_exPointsArr release];
    _exPointsArr = nil;
    
    [_topView release];
    [_commitBtn release];
    [_promiseImageView release];
    [_bottomSubView release];
    [_line1 release];
    [_line2 release];
    [_line3 release];
    [_line4 release];
    [_firstReasonView release];
    [_firstReasonLbl release];
    [_xianzhiView release];
    [_topReasonView release];
    [_topReasonLbl release];
    [_topReasonLine release];
    [_xianzhiLine release];
    [_miaoshuLine release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainScrollView:nil];
    [self setMainView:nil];
    [self setProdNameField:nil];
    [self setCateBtn:nil];
    [self setPicMainView:nil];
    [self setPicView:nil];
    [self setPicScrollView:nil];
    [self setBottomView:nil];
    [self setDuihuanTableView:nil];
    [self setProdDesBtn:nil];
    [self setProdPriceField:nil];
    [self setProdYinyuanLbl:nil];
    [self setDuihuanLimitBtn:nil];
    [self setXianchangDuihuanBtn:nil];
    [self setXianchangIcon:nil];
    [self setYoujiDuihuanBtn:nil];
    [self setYoujiIcon:nil];
    [self setDuihuanDianView:nil];
    [self setDuihuanDianBtn:nil];
    [super viewDidUnload];
}
@end
