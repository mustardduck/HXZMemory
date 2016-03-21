//
//  AddAccurateAdsViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AddAccurateAdsViewController.h"
#import "PSTCollectionView.h"
#import "AddPictureCell.h"
#import "UIImage+expanded.h"
#import "PreviewViewController.h"
#import "EditContentViewController.h"
#import "AddNextStepViewController.h"
#import "AccurateService.h"
#import "UserInfo.h"
#import "NSDictionary+expanded.h"
#import "CRInfoNotify.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import "EditImageViewController.h"
#import "RRLineView.h"
#import "RRAttributedString.h"
#import "WebhtmlViewController.h"

@interface AddAccurateAdsViewController ()<PSTCollectionViewDataSource, PSTCollectionViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>{
    PSTCollectionView *_collectionview;
    NSInteger _deleteIndex;
    BOOL _isBack;
    NSInteger _currentItem;//选择的某个图片
    RRLineView *_lineview;
}

@property (retain, nonatomic) IBOutlet UIView *headView;
@property (retain, nonatomic) IBOutlet UIView *adsNameAndWordView;
@property (retain, nonatomic) IBOutlet UIView *adsPicView;
@property (retain, nonatomic) IBOutlet UIView *totalErrorMessage;
@property (retain, nonatomic) IBOutlet UIView *adsErrorView;
@property (retain, nonatomic) IBOutlet UIView *picErrorView;
@property (retain, nonatomic) IBOutlet UILabel *lblTotalErrorMsg;
@property (retain, nonatomic) IBOutlet UILabel *lblAdsErrorMsg;
@property (retain, nonatomic) IBOutlet UILabel *lblPicErrorMsg;
@property (retain, nonatomic) IBOutlet UIView *itemsView;
@property (retain, nonatomic) IBOutlet RRLineView *eline;

@property (retain, nonatomic) IBOutlet UILabel *lblHetong;
@property (retain, nonatomic) IBOutlet UITextField *txtAdsName;
@property (retain, nonatomic) IBOutlet UITextField *txtAdsKeyWord;
@property (retain, nonatomic) IBOutlet UILabel *lblAdsContent;
@property (retain, nonatomic) IBOutlet UITextField *txtLink;
@property (retain, nonatomic) IBOutlet UITextField *txtMobile;
@property (retain, nonatomic) IBOutlet UITextField *txtAddress;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollVIew;
@property (retain, nonatomic) IBOutlet UIView *bottomView;
@property (retain, nonatomic) IBOutlet UIButton *btnShowPhone;
@property (retain, nonatomic) IBOutlet UIButton *btnShowAddress;
@property (retain, nonatomic) IBOutlet UIView *adsinfoView;
@property (retain, nonatomic) IBOutlet UIView *pinfoView;

@property (nonatomic, retain) CRInfoNotify *nameNoti;
@property (nonatomic, retain) CRInfoNotify *desNoti;
@property (nonatomic, retain) CRInfoNotify *linkNoti;
@property (nonatomic, retain) CRInfoNotify *phoneNoti;
@property (nonatomic, retain) CRInfoNotify *addressNoti;
@property (nonatomic, retain) CRInfoNotify *sloganNoti;

@property (nonatomic, retain) NSMutableArray *pickedUrls;
@property (nonatomic, retain) NSMutableArray *pickedIds;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, retain) NSMutableArray *errorPics;

@property (nonatomic, retain) DictionaryWrapper *dataDic;//所有数据

@end

@implementation AddAccurateAdsViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigateTitle:_directAdvertId.length ? @"设置红包广告" : @"新增红包广告"];
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"存入草稿"];
    
    [self _initData];
    
    NSAttributedString *attrStr = [RRAttributedString setText:_lblHetong.text color:RGBCOLOR(34, 34, 34) range:NSMakeRange(9, _lblHetong.text.length - 9)];
    _lblHetong.attributedText = attrStr;
    
    if (![_directAdvertId intValue]) {
        ADAPI_adv3_GetBasicInfo([self genDelegatorID:@selector(infoHandle:)],nil);
    }
    
    [self addDoneToKeyboard:_txtAddress];
    [self addDoneToKeyboard: _txtAdsKeyWord];
    [self addDoneToKeyboard:_txtAdsName];
    [self addDoneToKeyboard:_txtLink];
    [self addDoneToKeyboard:_txtMobile];
}

-(void)hiddenKeyboard
{
    [_txtMobile resignFirstResponder];
    [_txtLink resignFirstResponder];
    [_txtAdsName resignFirstResponder];
    [_txtAdsKeyWord resignFirstResponder];
    [_txtAddress resignFirstResponder];
    
    _scrollVIew.contentSize = CGSizeMake(SCREENWIDTH, _bottomView.bottom);
    [self.view endEditing:YES];
}

//商家信息
- (void)infoHandle:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        
        NSString *address = [NSString stringWithFormat:@"%@%@%@%@",[dic.data getString:@"Province"],[dic.data getString:@"City"],[dic.data getString:@"District"], [dic.data getString:@"Address"]];
        _txtAddress.text = address;
        _txtMobile.text = [dic.data getString:@"Tel"];
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

#pragma mark - 初始化数据
- (void)_initData{
    _content = @"";
    _currentItem = -1;
    _deleteIndex = -1;
    self.pickedUrls = [NSMutableArray arrayWithCapacity:0];
    self.pickedIds = [NSMutableArray arrayWithCapacity:0];
    
    if (!_directAdvertId.length) {
        [self _initPstCollectionView];
    }
    
//    _scrollVIew.panGestureRecognizer.delaysTouchesBegan = YES;
    
    if (_directAdvertId.length) {
        ADAPI_DirectAdvert_LoadAdvert([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleAdsDetail:)], _directAdvertId);
    } else {
        self.directAdvertId = @"0";
        [AccurateService clearData];//新建清除缓存
    }
}

- (void)_initPstCollectionView{
    
    PSTCollectionViewFlowLayout *layout = WEAK_OBJECT(PSTCollectionViewFlowLayout, init);
    layout.minimumInteritemSpacing = 20.f;
    layout.minimumLineSpacing = 20.f;
    UIEdgeInsets insets = {.top = 0,.left = 20,.bottom = 40,.right = 20};
    layout.sectionInset = insets;

    _collectionview = STRONG_OBJECT(PSTCollectionView, initWithFrame:CGRectMake(0, _headView.bottom, SCREENWIDTH, 135) collectionViewLayout:layout);
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.scrollEnabled = NO;
    _collectionview.backgroundColor = [UIColor whiteColor];
    [_collectionview registerNib:[UINib nibWithNibName:@"AddPictureCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AddPictureCell"];
    [self.scrollVIew addSubview:_collectionview];
    
    //计算高度
    _bottomView.top = _collectionview.bottom;
    
    if (![_lineview superview]) {
        _lineview = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, _collectionview.bottom, SCREENWIDTH, 1));
        [_scrollVIew addSubview:_lineview];
    }
    
    _scrollVIew.contentSize = CGSizeMake(SCREENWIDTH, _bottomView.bottom);
}

- (void)countHeight{
    //计算高度
    NSInteger count = _pickedUrls.count + 1;
    NSInteger row = (count % 3) ? (count / 3 + 1) : count / 3;
    float height = row * (115 + 20);
    
    _collectionview.height = height;
    
    //计算高度
    _bottomView.top = _collectionview.bottom;
    
    if (![_lineview superview]) {
        _lineview = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, _collectionview.bottom, SCREENWIDTH, 1));
        [_scrollVIew addSubview:_lineview];
    }
    _lineview.top = _collectionview.bottom;
    
    _scrollVIew.contentSize = CGSizeMake(SCREENWIDTH, _bottomView.bottom);
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
        [cell.imageView setRoundCorner:0.f withBorderColor:AppColorLightGray204];
        [cell.imageView requestWithRecommandSize:[_pickedUrls[indexPath.row] valueForKey:@"PictureUrl"]];
    }
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

#pragma mark - uiacrionshee delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    _deleteIndex = -1;
    _currentItem = -1;
    if (actionSheet.tag >= 1000) {
        if (buttonIndex == 0) {
            //预览
            PreviewViewController *preview = WEAK_OBJECT(PreviewViewController, init);
            preview.dataArray = _pickedUrls;
            preview.currentPage = actionSheet.tag - 1000;
            [self presentViewController:preview animated:NO completion:^{
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
            [self removeNotifyHover:nil str:nil];
            [_pickedUrls removeObjectAtIndex:(long)_deleteIndex];
            
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
             [UICommon showCamera:self view:self allowsEditing:NO];
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
    
    ALAssetsLibrary *library = [[[ALAssetsLibrary alloc] init] autorelease];
    __block typeof(self) weakself = self;
    [library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
        UIImage *preview = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
        
        EditImageViewController *imageEditor = WEAK_OBJECT(EditImageViewController,
                                                           initWithNibName:@"EditImageViewController"
                                                           bundle:nil
                                                           ImgType:EditImageTypeAdertPic);
        imageEditor.rotateEnabled = NO;
        imageEditor.doneCallback = ^(UIImage *editedImage, BOOL canceled){
            if(!canceled) {
                [weakself passImage:editedImage];
            }
            [picker setNavigationBarHidden:NO animated:NO];
            [weakself dismissModalViewControllerAnimated:YES];
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

- (void)passImage:(UIImage *)image
{
    image = [image scaleToSize:CGSizeMake(200, 200)];
    
    ADAPI_Picture_Upload([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleUploadPic:)], UIImagePNGRepresentation(image));
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    _scrollVIew.contentSize = CGSizeMake(SCREENWIDTH, _bottomView.bottom + 216);//原始滑动距离加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:_scrollVIew];//把当前的textField的坐标映射到scrollview上
    if(_scrollVIew.contentOffset.y - pt.y + 64 <= 0)//判断最上面不要去滚动
        [_scrollVIew setContentOffset:CGPointMake(0, pt.y - 64) animated:YES];//滑动
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
     NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([textField.textColor isEqual:AppColorRed]) {
        [self removeNotifyHover:textField str:aString];
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IsChanged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([textField isEqual:_txtAdsName]) {
        if(aString.length > 25)
        {
            textField.text = [aString substringToIndex:25];
            [HUDUtil showErrorWithStatus:@"最多可填25个字"];
            return NO;
        }
    }
    if ([textField isEqual:_txtAdsKeyWord]) {
        if(aString.length > 20)
        {
            textField.text = [aString substringToIndex:20];
            [HUDUtil showErrorWithStatus:@"最多可填20个字"];
            return NO;
        }
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hiddenKeyboard];
    return YES;
}

- (void)removeNotifyHover:(UIView *)view str:(NSString *)str{
    if ([view isKindOfClass:[UILabel class]] && ![_content isEqualToString:[_dataDic getString:@"Description"]]) {
        //内容简介
        if ([_desNoti superview]) {
            [_desNoti removeFromSuperview];
        }
    } else if ([view isKindOfClass:[UITextField class]]) {
    
        //textfield
        if ([view isEqual:_txtAddress] && ![str isEqualToString:[_dataDic getString:@"Address"]]) {
            if ([_addressNoti superview]) {
                ((UITextField *)view).textColor = AppColorBlack43;
                [_addressNoti removeFromSuperview];
            }
        } else if ([view isEqual:_txtAdsKeyWord] && ![str isEqualToString:[_dataDic getString:@"Slogan"]]){
            if ([_sloganNoti superview]) {
                ((UITextField *)view).textColor = AppColorBlack43;
                [_sloganNoti removeFromSuperview];
            }
        } else if ([view isEqual:_txtAdsName] && ![str isEqualToString:[_dataDic getString:@"Name"]]){
            if ([_nameNoti superview]) {
                ((UITextField *)view).textColor = AppColorBlack43;
                [_nameNoti removeFromSuperview];
            }
        } else if ([view isEqual:_txtLink] && ![str isEqualToString:[_dataDic getString:@"LinkUrl"]]){
            if ([_linkNoti superview]) {
                ((UITextField *)view).textColor = AppColorBlack43;
                [_linkNoti removeFromSuperview];
            }
        } else if ([view isEqual:_txtMobile] && ![str isEqualToString:[_dataDic getString:@"Phone"]]){
            if ([_phoneNoti superview]) {
                ((UITextField *)view).textColor = AppColorBlack43;
                [_phoneNoti removeFromSuperview];
            }
        }
    } else {
        
        
        
        if (_state == 5) {
            
            NSInteger index = _currentItem;
            if (index == -1) {
                index = _deleteIndex;
            }
            
            UIView *view = [_scrollVIew viewWithTag:100000 + index];
            if (view && [view superview]) {
                [view removeFromSuperview];
            }
            
            NSArray *picErr = self.errorPics;
            if (!picErr.count) {
                return;
            }
            
            for (NSDictionary *dic in picErr) {
                NSString *eid = [dic valueForJSONStrKey:@"PictureId"];
                NSString *pid = [_pickedIds objectAtIndex:index];
                if ([eid isEqual:pid]) {
                    [self.errorPics removeObject:dic];
                    break;
                }
            }
            
            if (_currentItem != -1) {
                return;
            }
            [_pickedIds removeObjectAtIndex:(long)_deleteIndex];
            [self picError:self.errorPics];
            
        } else {
            if (_deleteIndex != -1) {
                [_pickedIds removeObjectAtIndex:(long)_deleteIndex];
            }
        }
    }
}

////隐藏键盘
//- (void)hiddenKeyboard{
//    _scrollVIew.contentSize = CGSizeMake(SCREENWIDTH, _bottomView.bottom);
//    [self.view endEditing:YES];
//}

#pragma mark - 网络请求数据回调
//读取广告
- (void)handleAdsDetail:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        NSLog(@"%@",dic.dictionary);
        self.dataDic = dic.data;
        //刷新页面
        [self refreshPage:dic.data];
        
        [[NSUserDefaults standardUserDefaults] setValue:[dic.data getString:@"DirectAdvertId"] forKey:@"CurrentDirectAdId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //处理缓存本地数据
        [AccurateService saveData:dic.data isYinyuan:NO];
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}
//上传图片
- (void)handleUploadPic:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IsChanged"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"%@",dic.data);
        NSString *url = [dic.data getString:@"PictureUrl"];
        NSString *pid = [dic.data getString:@"PictureId"];
        if (!url) {
            return;
        }
        
        [self removeNotifyHover:nil str:nil];
        
        if (_currentItem == -1) {
            [_pickedUrls addObject:@{@"PictureUrl":url}];
            [_pickedIds addObject:pid];
        } else {
            [_pickedUrls removeObjectAtIndex:_currentItem];
            [_pickedUrls insertObject:@{@"PictureUrl":url} atIndex:_currentItem];
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
//秒赚合同
- (IBAction)agreementClicked:(id)sender {
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.ContentCode = @"d3622ea0ab5ffc3b58b104a5d36d6ea4";
    model.navTitle = @"秒赚广告商户服务协议";
}
//存入草稿
- (void)handleSave:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed) {
        [HUDUtil showSuccessWithStatus:@"保存成功!"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"IsChanged"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        _directAdvertId = nil;
        self.directAdvertId = [dic.data getString:@"DirectAdvertId"];
        [[NSUserDefaults standardUserDefaults] setValue:_directAdvertId forKey:@"CurrentDirectAdId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if (_isBack) {
            [UI_MANAGER.mainNavigationController popViewControllerAnimated:YES];
        }
        
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}
#pragma mark - 事件
//显示数据
- (void)refreshPage:(DictionaryWrapper *)dict{
    //图片
    self.pickedIds = [NSMutableArray arrayWithCapacity:0];
    for (DictionaryWrapper *pdic in [dict getArray:@"Pictures"]) {
        [self.pickedUrls addObject:@{@"PictureUrl" : [[pdic wrapper] getString:@"PictureUrl"]}];
        [self.pickedIds addObject:[[pdic wrapper] getString:@"PictureId"]];
    }
    [self countHeight];
    [_collectionview reloadData];
    
    _txtAdsKeyWord.text = [dict getString:@"Slogan"];
    _txtAdsName.text = [dict getString:@"Name"];
    _txtLink.text = [dict getString:@"LinkUrl"];
    
    _txtAddress.text = [dict getString:@"Address"];
    if (!_txtAddress.text.length) {
        _btnShowAddress.selected = NO;
    }
    _txtMobile.text = [dict getString:@"Phone"];
    if (!_txtMobile.text.length) {
        _btnShowPhone.selected = NO;
    }
    
    NSString *content = [dict getString:@"Description"];
    _lblAdsContent.text = content.length ? @"已填写" : @"未填写";
    self.content = content;
    
    if (_state != 5) {
        [self _initPstCollectionView];
        [self countHeight];
        [_collectionview reloadData];
        return;
    }
    
    //错误
    NSDictionary *errorMsgs =/* @{@"OtherErrmsg":@"短发角度看风景撒可怜的风景苦辣是大家分开了撒娇的发奋开始觉得开发建设看到减肥开始的减肥",
                                @"BasicErrmsg":@"dfasdfa",
                                @"PicErrmsg":@"fsdfa",
                                @"DescriptionErrmsg":@"DescriptionErrmsg",
                                @"LinkUrlErrmsg":@"LinkUrlErrmsg",
                                @"PhoneErrmsg":@"PhoneErrmsg",
                                @"AddressErrmsg":@"AddressErrmsg"
                                };//*/[dict getDictionary:@"AuditMessages"];
    if (![errorMsgs isKindOfClass:[NSNull class]] || errorMsgs) {
        
        
#warning 3.2 需求
        
        NSString *otherMsg = [errorMsgs valueForJSONStrKey:@"OtherErrmsg"];
        if (otherMsg.length && ![otherMsg isKindOfClass:[NSNull class]]) {
            
            CGSize size = [UICommon getSizeFromString:otherMsg withSize:CGSizeMake(290, MAXFLOAT) withFont:12];
            _lblTotalErrorMsg.height = size.height;
            _totalErrorMessage.height = _lblTotalErrorMsg.bottom + 15;
            
            _totalErrorMessage.hidden = NO;
            _lblTotalErrorMsg.text = otherMsg;
            _totalErrorMessage.top = 0;
            _itemsView.top = _totalErrorMessage.bottom;
            _eline.top = _totalErrorMessage.height - 0.5;
        }
        
        NSString *basicErrmsg = [errorMsgs valueForJSONStrKey:@"BasicErrmsg"];
        if (basicErrmsg.length && ![basicErrmsg isKindOfClass:[NSNull class]]) {
            _adsErrorView.hidden = NO;
            _lblAdsErrorMsg.text = basicErrmsg;
            _adsErrorView.top = _itemsView.bottom;
            _adsNameAndWordView.top = _adsErrorView.top + 16;
        } else {
            _adsNameAndWordView.top = _itemsView.bottom;
        }
        
        NSString *picErrmsg = [errorMsgs valueForJSONStrKey:@"PicErrmsg"];
        if (picErrmsg.length && ![picErrmsg isKindOfClass:[NSNull class]]) {
            _picErrorView.hidden = NO;
            _lblPicErrorMsg.text = picErrmsg;
            _picErrorView.top = _adsNameAndWordView.bottom + 10;
            _adsPicView.top = _picErrorView.top + 16;
        } else {
            _adsPicView.top = _adsNameAndWordView.bottom + 10;
        }
        
        _headView.height = _adsPicView.bottom;
        
        [self _initPstCollectionView];
        [self countHeight];
        [_collectionview reloadData];
        
//        NSString *nameErr = [errorMsgs valueForJSONStrKey:@"NameErrmsg"];
//        if (nameErr.length) {
//
//            CGPoint point = [_txtAdsName convertPoint:CGPointMake(_txtAdsName.left + _txtAdsName.width/2, _txtAdsName.top) toView:_scrollVIew];
//            self.nameNoti = WEAK_OBJECT(CRInfoNotify, initWith:nameErr at:point);
//            [self.scrollVIew addSubview:_nameNoti];
//            self.txtAdsName.textColor = AppColorRed;
//        }
//        NSString *sloganErr = [errorMsgs valueForJSONStrKey:@"SloganErrmsg"];
//        if (sloganErr.length) {
//            CGPoint point = CGPointMake(_txtAdsKeyWord.right, _txtAdsKeyWord.top+7);
//            self.sloganNoti = WEAK_OBJECT(CRInfoNotify, initWith:sloganErr at:point);
//            [_adsinfoView addSubview:_sloganNoti];
//            _txtAdsKeyWord.textColor = AppColorRed;
//        }
        NSString *desErr = [errorMsgs valueForJSONStrKey:@"ContentErrmsg"];
        if (desErr.length) {
            CGPoint point = CGPointMake(_lblAdsContent.right, _lblAdsContent.top + 5);
            self.desNoti = WEAK_OBJECT(CRInfoNotify, initWith:desErr at:point);
            [_adsinfoView addSubview:_desNoti];
        }
        NSString *linkErr = [errorMsgs valueForJSONStrKey:@"UrlErrmsg"];
        if (linkErr.length) {
            CGPoint point = CGPointMake(_txtLink.right, _txtLink.top);
            self.linkNoti = WEAK_OBJECT(CRInfoNotify, initWith:linkErr at:point);
            [_adsinfoView addSubview:_linkNoti];
            self.txtLink.textColor = AppColorRed;
        }
        NSString *phoneErr = [errorMsgs valueForJSONStrKey:@"PhoneErrmsg"];
        if (phoneErr.length) {
            CGPoint point = CGPointMake(_txtMobile.left + _txtMobile.width/2, _txtMobile.top);
            self.phoneNoti = WEAK_OBJECT(CRInfoNotify, initWith:phoneErr at:point);
            [_pinfoView addSubview:_phoneNoti];
            self.txtMobile.textColor = AppColorRed;
        }
        NSString *addressErr = [errorMsgs valueForJSONStrKey:@"AddressErrmsg"];
        if (addressErr.length) {
            CGPoint point = CGPointMake(_txtAddress.left + _txtAddress.width/2, _txtAddress.top);
            self.addressNoti = WEAK_OBJECT(CRInfoNotify, initWith:addressErr at:point);
            [_pinfoView addSubview:_addressNoti];
            self.txtAddress.textColor = AppColorRed;
        }
        //图片错误
//        NSArray *picErr = [errorMsgs valueForJSONKey:@"PicturesErrmsg"];
//        self.errorPics = [NSMutableArray arrayWithArray:picErr];
//        [self picError:picErr];
    } else {
        [self _initPstCollectionView];
        [self countHeight];
        [_collectionview reloadData];
    }
    
}

- (void)picError:(NSArray *)picErr{
    
    
    if (picErr.count) {
        
        for (UIView *v in self.scrollVIew.subviews) {
            if (v.tag >= 100000 && [v isKindOfClass:[CRInfoNotify class]]) {
                [v removeFromSuperview];
            }
        }
        
        for (NSDictionary *dic in picErr) {
            NSString *eid = [dic valueForJSONStrKey:@"PictureId"];
            NSString *errorStr = [dic valueForJSONStrKey:@"AuditMessage"];
            NSInteger index = [_pickedIds indexOfObject:eid];
            float y = 0;
            float x = 0;
            if (index > 2 && index <= 5) {
                y = _collectionview.top + 115 + 10;
                x = (60 + 20) * (index - 2) + 20 * (index - 2);
            } else if (index > 5 && index <= 8) {
                y = _collectionview.top + (115 + 20) * 2;
                x = (60 + 20) * (index - 5)+ 20 * (index - 5);
            } else if (index > 8) {
                y = _collectionview.top + (115 + 30) * 3;
                x = (60 + 20) * (index - 8)+ 20 * (index - 8);
            } else {
                y = _collectionview.top;
                x = (60 + 20) * (index + 1) + 20 * index;
            }
            CGPoint point = CGPointMake(x, y);
            CRInfoNotify *noti = WEAK_OBJECT(CRInfoNotify, initWith:errorStr at:point);
            noti.tag = 100000 + index;
            [self.scrollVIew addSubview:noti];
        }
        
    }

}

//存入草稿
- (void)onMoveFoward:(UIButton *)sender{
    [self.view endEditing:YES];
    if ([self checkInputCorrectWithIsSave:YES]) {
        [AccurateService saveDraftBoxWithDelegator:self selector:@selector(handleSave:)];
    }
}
//点击add图片
- (void)clickImage:(UIButton *)button{
    
    [self.view endEditing:YES];
    _currentItem = -1;
    UIActionSheet *sheet = [[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机拍摄" otherButtonTitles:@"从相册中选择", nil] autorelease];
    [sheet showInView:self.view];
}
//内容简介
- (IBAction)contentClicked:(id)sender {
    [self.view endEditing:YES];
    EditContentViewController *edit = WEAK_OBJECT(EditContentViewController, init);
    edit.content = _content;
    edit.value = ^(NSString *value){
        _lblAdsContent.text = @"已填写";
        _content = nil;
        _content = [value copy];
        for (UIView *v in _adsinfoView.subviews) {
            if ([v superview] && [v isEqual:_desNoti]) {
                [v removeFromSuperview];
                break;
            }
        }
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IsChanged"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    };
    [UI_MANAGER.mainNavigationController pushViewController:edit animated:YES];
}

- (BOOL)tishi:(UIView *)temp{
    for (UIView *v in temp.subviews) {
        if ([v isKindOfClass:[CRInfoNotify class]]) {
            [HUDUtil showErrorWithStatus:@"请先修改错误项"];
            return NO;
        }
    }
    
    return YES;
}

//判断数据
- (BOOL)checkInputCorrectWithIsSave:(BOOL)isSave{
    NSString *adsName = _txtAdsName.text.length ? _txtAdsName.text : @"";
    NSString *adsWord = _txtAdsKeyWord.text.length ? _txtAdsKeyWord.text : @"";
    NSString *link = _txtLink.text.length ? _txtLink.text : @"";
    NSString *address = @"";
    NSString *mobile = @"";
//
//    if (!isSave) {
//        BOOL sc = [self tishi:_scrollVIew];
//        BOOL ads = [self tishi:_adsinfoView];
//        BOOL per = [self tishi:_pinfoView];
//        if (!sc || !ads || !per) {
//            return NO;
//        }
//    }
    
    if (_txtMobile.userInteractionEnabled && _txtMobile.text.length) {
        mobile = _txtMobile.text;
    }
    if (_txtAddress.userInteractionEnabled && _txtAddress.text.length) {
        address = _txtAddress.text;
    }
    if (isSave){
        if (!adsName.length && !adsWord.length && !link.length && !_pickedIds.count && !_content.length) {
            [HUDUtil showErrorWithStatus:@"暂无可保存的内容"];
            return NO;
        }
    } else {
        if (!adsName.length) {
            [HUDUtil showErrorWithStatus:@"请填写广告名称"]; return NO;
        }
        NSInteger phoneNumLength = _txtMobile.text.length;
        BOOL valiable = _txtMobile.userInteractionEnabled && phoneNumLength && phoneNumLength != 7 && phoneNumLength != 8 && phoneNumLength != 10 && phoneNumLength != 11 && phoneNumLength != 12;
        if (valiable) {
            [HUDUtil showErrorWithStatus:@"请填写正确的电话号码"];return NO;
        }
        if (!_pickedIds.count) {
            [HUDUtil showErrorWithStatus:@"请上传广告图片"];return NO;
        }
        if (!adsWord.length) {
            [HUDUtil showErrorWithStatus:@"请填写广告语"];return NO;
        }
        if (!_content.length) {
            [HUDUtil showErrorWithStatus:@"请填写广告内容简介"];return NO;
        }
    }
    NSString *adId = [[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentDirectAdId"];
    NSDictionary *dic = @{
                          @"Action":@"0",
                          @"DirectAdvertId":adId.length ? adId : @"",
                          @"Name":adsName,
                          @"Description":_content,
                          @"PictureIds":_pickedIds,
                          @"LinkUrl":link,
                          @"Phone":mobile,
                          @"Address":address,
                          @"Slogan":adsWord
                          };
    [[NSUserDefaults standardUserDefaults] setValue:dic forKey:@"FirstPage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

//下一步
- (IBAction)nextStepClicked:(id)sender {
    if ([self checkInputCorrectWithIsSave:NO]) {
        AddNextStepViewController *next = WEAK_OBJECT(AddNextStepViewController, init);
        next.otherErrorMsg = _lblTotalErrorMsg.text.length ? _lblTotalErrorMsg.text : @"";
        [UI_MANAGER.mainNavigationController pushViewController:next animated:YES];
    }
}
//显示地址
- (IBAction)showAddressClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    _txtAddress.userInteractionEnabled = sender.selected;
    if (!sender.selected) {
        [self hiddenKeyboard];
    }
    [[NSUserDefaults standardUserDefaults] setBool:!sender.selected forKey:@"IsChanged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//显示电话
- (IBAction)showMobileClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    _txtMobile.userInteractionEnabled = sender.selected;
    if (!sender.selected) {
        [self hiddenKeyboard];
    }
    [[NSUserDefaults standardUserDefaults] setBool:!sender.selected forKey:@"IsChanged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)onMoveBack:(UIButton *)sender{
    //返回提示
    [self.view endEditing:YES];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"IsChanged"]) {
        UIActionSheet *sheet = [[[UIActionSheet alloc] initWithTitle:@"是否保存到草稿箱" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存草稿" otherButtonTitles:@"不保存", nil] autorelease];
        sheet.tag = 10;
        [sheet showInView:self.view];
        
    } else {
        [UI_MANAGER.mainNavigationController popViewControllerAnimated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"IsChanged"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CurrentDirectAdId"];
    }
    
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_collectionview release];
    [_nameNoti release];
    [_desNoti release];
    [_linkNoti release];
    [_phoneNoti release];
    [_addressNoti release];
    [_sloganNoti release];
    [_content release];
    [_pickedIds release];
    [_txtAdsName release];
    [_txtAdsKeyWord release];
    [_lblAdsContent release];
    [_txtLink release];
    [_txtMobile release];
    [_txtAddress release];
    [_scrollVIew release];
    [_bottomView release];
    [_btnShowPhone release];
    [_btnShowAddress release];
    [_adsinfoView release];
    [_pinfoView release];
    [_lblHetong release];
    [_headView release];
    [_adsNameAndWordView release];
    [_adsPicView release];
    [_totalErrorMessage release];
    [_adsErrorView release];
    [_picErrorView release];
    [_lblTotalErrorMsg release];
    [_lblAdsErrorMsg release];
    [_lblPicErrorMsg release];
    [_itemsView release];
    [_eline release];
    [super dealloc];
}
@end
