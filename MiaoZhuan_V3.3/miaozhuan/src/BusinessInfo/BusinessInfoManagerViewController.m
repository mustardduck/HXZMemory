//
//  BusinessInfoManagerViewController.m
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BusinessInfoManagerViewController.h"
#import "IndustryCategotiesViewController.h"
#import "PreviewViewController.h"
#import "DeleteBusinessViewController.h"

#import "InfoModelViewController.h"
#import "UserInfo.h"
#import "Define+RCMethod.h"
#import "EditImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIView+expanded.h"
#import "IndustryDetailViewController.h"
@interface BusinessInfoManagerViewController ()<UIActionSheetDelegate,InfoHandleDelegate,IndustryCategotiesViewControllerAddedDelgate>
{
    DictionaryWrapper *_dic;
    NSMutableDictionary *_pDic;
    NSMutableArray *_industy;
    NSInteger _pId;
    
    BOOL _wantQuit;
    BOOL _shouldSave;
    BOOL _willChangeSeverId;
    NSMutableArray *_industryDetailIds;
    
    BOOL _canEditGongHao;
}
@property (retain, nonatomic) IBOutlet UILabel *gonghao;
@end

@class InfoModelViewController;
@implementation BusinessInfoManagerViewController
@synthesize img = _img;
@synthesize vipIcon = _vipIcon;
@synthesize icon_1 = _icon_1;
@synthesize icon_2 = _icon_2;
@synthesize icon_3 = _icon_3;
@synthesize nameL = _nameL;
@synthesize phoneL = _phoneL;
@synthesize categroyL = _categroyL;
@synthesize infoL = _infoL;
@synthesize advantegeL = _advantegeL;
@synthesize addressL = _addressL;
@synthesize addressL_c = _addressL_c;


- (void)dealloc
{
    [_dic release];
    [_img release];
    [_vipIcon release];
    [_icon_1 release];
    [_icon_2 release];
    [_icon_3 release];
    [_phoneL release];
    [_categroyL release];
    [_infoL release];
    [_advantegeL release];
    [_addressL release];
    [_addressL_c release];
    [_nameL release];
    CRDEBUG_DEALLOC();
    [_gonghao release];
    [_industryDetailIds release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setImg:nil];
    [self setVipIcon:nil];
    [self setIcon_1:nil];
    [self setIcon_2:nil];
    [self setIcon_3:nil];
    [self setPhoneL:nil];
    [self setCategroyL:nil];
    [self setInfoL:nil];
    [self setAdvantegeL:nil];
    [self setAddressL:nil];
    [self setAddressL_c:nil];
    [super viewDidUnload];
}


MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ADAPI_adv3_GetBasicInfo([self genDelegatorID:@selector(infoHandle:)],nil);
    InitNav(@"商家基本信息");
    [self layoutView];
    _industryDetailIds = STRONG_OBJECT(NSMutableArray, init);
}

- (void)infoHandle:(DelegatorArguments *)arg
{
    DictionaryWrapper *wrapper = arg.ret;
    [arg logError];
    if ([arg isEqualToOperation:ADOP_adv3_GetBasicInfo])
    {
        if (wrapper.operationSucceed)
        {
            _dic = wrapper.data;
            [_dic retain];
            if (!_industy)
            {
                _industy = [NSMutableArray new];
                _pId = [_dic getInt:@"ParentIndustryId"];
                
                _canEditGongHao = [_dic getBool:@"IsCanEditWorkNo"];
                
                for (NSDictionary *dic in [_dic getArray:@"Industrys"])
                {
                    if (((NSNumber *)[dic objectForKey:@"ParentId"]).intValue == _pId)
                    {
                        [_industy addObject:[dic objectForKey:@"Name"]];
                    }
                }
            }
            
            if (!_pDic)
            {
                _pDic = [NSMutableDictionary new];
                [_pDic setValue:[_dic getString:@"Address"] forKey:@"Address"];
                [_pDic setValue:[_dic getString:@"Tel"] forKey:@"Tel"];
                [_pDic setValue:[_dic getString:@"Introduction"] forKey:@"Introduction"];
                [_pDic setValue:[_dic getString:@"Feature"] forKey:@"Feature"];
                [_pDic setValue:[_dic getString:@"LogoPicId"] forKey:@"LogoPicId"];
                [_pDic setValue:nil forKey:@"IndustryIds"];
                [_pDic setValue:[_dic getString:@"ServicePersonnelNumber"] forKey:@"ServicePersonnelNumber"];
            }
            [self layoutData];
        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
    
    else if ([arg isEqualToOperation:ADOP_Picture_Upload])
    {
        if (wrapper.operationSucceed)
        {
            _shouldSave = YES;
            NSString *newPic = [wrapper.data getString:@"PictureUrl"];
            [newPic retain];
            [_pDic setValue:[wrapper.data getString:@"PictureId"] forKey:@"LogoPicId"];
            [_img requestIcon:newPic];
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".EnterpriseLogoUrl" value:newPic];
            [newPic release];
        }
        else [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
    
    else if ([arg isEqualToOperation:ADOP_adv3_EditEnterprise])
    {
        if (wrapper.operationSucceed)
        {
            _shouldSave = NO;
            [_pDic removeAllObjects];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            NSLog(@"%@",wrapper.operationMessage);
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

- (void)layoutView
{
    ((UIScrollView *)self.view).contentSize = CGSizeMake(self.view.width, self.view.height);
    ((UIScrollView *)self.view).showsVerticalScrollIndicator = NO;
    self.view.backgroundColor = AppColorBackground;
    [_img roundCornerRadiusBorder];
//    [_img setBorderWithColor:AppColor(220)];
    [_img requestIcon:USER_MANAGER.EnterprisePic];


    _vipIcon.image = [UIImage imageNamed:![USER_MANAGER isVip]?@"fatopvip.png":@"fatopviphover.png"];
    _icon_1.image = [UIImage imageNamed:![USER_MANAGER isYin]?@"fatopyin.png":@"fatopyinhover.png"];
    _icon_2.image = [UIImage imageNamed:![USER_MANAGER isJin]?@"fatopjin.png":@"fatopjinhover.png"];
    _icon_3.image = [UIImage imageNamed:![USER_MANAGER isZhi]?@"fatopzhi.png":@"fatopzhihover.png"];
}

- (void)layoutData
{
    if (!_dic) return;
    
//    [_img requestIcon:[_dic getString:@"LogoPicUrl"]];
    
    _nameL.text = [_dic getString:@"Name"];
    if ([_nameL.text sizeWithFont:_nameL.font].width > 210)
    {
        _nameL.top = 12;
        _vipIcon.top = 54;
        _nameL.height = 45;
    }
    else
    {
        _nameL.top = 25;
        _vipIcon.top = 46;
    }
    
//    float height = AppGetTextHeight(_nameL);
//    float fix    = 3.f;
//    if (height > 45)
//    {
//        _nameL.top   -= 5;
//        _nameL.height = 45;
//        fix    = 8.f;
//    }
    _vipIcon.top = _nameL.bottom;
    _icon_1.top = _vipIcon.top;
    _icon_2.top = _vipIcon.top;
    _icon_3.top = _vipIcon.top;
    
    _phoneL.text = [_dic getString:@"Tel"];
    
    NSString * parentIndustry = [_dic getString:@"ParentIndustry"];
    NSArray *array = [_dic getArray:@"Industrys"];
    if (!parentIndustry)
    {
        parentIndustry = @"未选择行业";
        array = @[@{@"Name":@" "}];
    }
    _categroyL.text = [NSString stringWithFormat:@"%@    %@",parentIndustry,[[array[0] wrapper] getString:@"Name"]];
    
    _infoL.text = [_dic getString:@"Introduction"];
    
    _advantegeL.text = [_dic getString:@"Feature"];
    
    _addressL.text = [NSString stringWithFormat:@"%@%@%@",[_dic getString:@"Province"],[_dic getString:@"City"],[_dic getString:@"District"]];
    
    _addressL_c.text = [_dic getString:@"Address"];
    _gonghao.text = ([_dic getString:@"ServicePersonnelNumber"] == nil || [[_dic getString:@"ServicePersonnelNumber"]  isEqual: @""])?@"未填写":[_dic getString:@"ServicePersonnelNumber"];
    if ([_gonghao.text isEqualToString:@"未填写"]) _willChangeSeverId = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 跳转

- (IBAction)eventManager:(UIButton *)sender
{
    switch (sender.tag) {
        case BusinessBtTypeLogoChange:
        {
            UIActionSheet *actionSheet = [[[UIActionSheet alloc]
                                           initWithTitle:@""
                                           delegate:self
                                           cancelButtonTitle:@"取消"
                                           destructiveButtonTitle:nil
                                           otherButtonTitles:@"相机拍摄", @"从相册选择",nil]autorelease];
            
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
            [actionSheet showInView:self.view];
            break;
        }
        case BusinessBtTypeLogoLook:
        {
            PreviewViewController *p = WEAK_OBJECT(PreviewViewController, init);
            if (_img.image == nil) _img.image = [UIImage new];
            p.dataArray = @[@{@"PictureUrl":USER_MANAGER.EnterprisePic}];
            __block PreviewViewController *weakSelf = p;
            [self presentViewController:p animated:NO completion:^(void)
            {
                weakSelf.pageControl.hidden = YES;
            }];
            break;
        }
        case BusinessBtTypeCateGroy:
        {
            PUSH_VIEWCONTROLLER(IndustryDetailViewController);
            
            model.parentId = _pId;
            model.parentString = [_dic getString:@"ParentIndustry"];
            model.delegate_add = self;
            for (NSDictionary *dic in [_dic getArray:@"Industrys"]) {
                
                DictionaryWrapper *wrapper = dic.wrapper;
                if ([_industryDetailIds containsObject:[wrapper getString:@"IndustryId"]]) {
                    continue;
                }
                [_industryDetailIds addObject:[wrapper getString:@"IndustryId"]];
            }
            model.choosedIdsArray = [NSArray arrayWithArray:_industryDetailIds];
            break;
        }
        case BusinessBtTypeAddress:
        {
            PUSH_VIEWCONTROLLER(InfoModelViewController);
            
            InfoType infoType = {sender.tag,InfoModelTypeView,nil,nil};
            infoType.key = WEAK_OBJECT(NSString, initWithString:@"Address");
            infoType.title = WEAK_OBJECT(NSString, initWithString:@"详细地址");
            model.type = infoType;
            model.num = 30;
            model.delegate = self;
            model.object = *(&_addressL_c);
            break;
        }
        case BusinessBtTypeAdvantege:
        {
            PUSH_VIEWCONTROLLER(InfoModelViewController);
            InfoType infoType = {sender.tag,InfoModelTypeView,nil,nil};
            infoType.key = WEAK_OBJECT(NSString, initWithString:@"Feature");
            infoType.title = WEAK_OBJECT(NSString, initWithString:@"特色优势");
            model.type = infoType;
            model.delegate = self;
            model.object = *(&_advantegeL);
            model.num = 20;
            break;
        }
        case BusinessBtTypeInfo:
        {
            PUSH_VIEWCONTROLLER(InfoModelViewController);
            InfoType infoType = {sender.tag,InfoModelTypeView,nil,nil};
            infoType.key = WEAK_OBJECT(NSString, initWithString:@"Introduction");
            infoType.title = WEAK_OBJECT(NSString, initWithString:@"商家简介");
            model.height = 150;
            model.type = infoType;
            model.delegate = self;
            model.object = *(&_infoL);
            model.num = 100;
            break;
        }
        case BusinessBtTypePhone:
        {
            PUSH_VIEWCONTROLLER(InfoModelViewController);
            InfoType infoType = {sender.tag,InfoModelTypeField,nil,nil};
            infoType.key = WEAK_OBJECT(NSString, initWithString:@"Tel");
            infoType.title = WEAK_OBJECT(NSString, initWithString:@"联系电话");
            model.type = infoType;
            model.delegate = self;
            model.object = *(&_phoneL);
            break;
        }
            case BusinessBtTypeDelete:
        {
            PUSH_VIEWCONTROLLER(DeleteBusinessViewController);
            break;
        }
        case BusinessBtTypeGongHao:
        {
//            if (![_gonghao.text isEqualToString:@"未填写"]) return;
            if(!_canEditGongHao)
            {
                [HUDUtil showErrorWithStatus:@"已超过填写服务工号时间"];
            }
            else
            {
                PUSH_VIEWCONTROLLER(InfoModelViewController);
                InfoType infoType = {sender.tag,InfoModelTypeField,nil,nil};
                infoType.key = WEAK_OBJECT(NSString, initWithString:@"ServicePersonnelNumber");
                infoType.title = WEAK_OBJECT(NSString, initWithString:@"服务工号");
                model.type = infoType;
                model.object.text = @"请输入线下为您服务人员的工号";
                model.delegate = self;
                model.object = *(&_gonghao);
            }

            break;
        }
            
        default:
            break;
    }
}

- (void)getChooseInfo:(DictionaryWrapper *)wrapper{
    
    _industryDetailIds = [[NSMutableArray arrayWithArray:[wrapper getArray:@"childID"]] retain];
    
    NSString *parent = [wrapper getString:@"parent"];
    NSString *child = [[wrapper getString:@"child"] substringToIndex:[wrapper getString:@"child"].length];
    if (child.length < 1) return;
    _shouldSave = YES;
    _categroyL.text = [NSString stringWithFormat:@"%@    %@",parent,child];
    [_pDic setValue:[wrapper getArray:@"childID"] forKey:@"IndustryIds"];
}

- (void)InfoDidSet:(NSString *)info withType:(InfoType)type
{
    _shouldSave = YES;
    if ([info isEqualToString:@"未填写"]) info = @"";
    [_pDic setValue:info forKey:type.key];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        ADAPI_adv3_EditEnterprise([self genDelegatorID:@selector(infoHandle:)], _pDic);
//    });
}

#pragma mark - 相机

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        [UICommon showCamera:self view:self allowsEditing:NO];
        
    }
    else if (buttonIndex == 1) {
        
        [UICommon showImagePicker:self view:self];
    }
}


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
                                                           ImgType:EditImageType200);
        imageEditor.rotateEnabled = NO;
        imageEditor.doneCallback = ^(UIImage *editedImage, BOOL canceled)
        {
            if(!canceled)
            {
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
    
//    
//    [picker dismissModalViewControllerAnimated:YES];
//    
//    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    UIImage * scaleImage = [image compressedImage];
//    ADAPI_Picture_Upload([self genDelegatorID:@selector(infoHandle:)], UIImagePNGRepresentation(scaleImage));
}

- (void)passImage:(UIImage *)image
{
    image = [image compressedImage];
    ADAPI_Picture_Upload([self genDelegatorID:@selector(infoHandle:)], UIImagePNGRepresentation(image));
}

- (void)onMoveBack:(UIButton *)sender
{
    if(!_shouldSave)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if (_shouldSave)
        {
            if (((NSString *)[_pDic objectForKey:@"Address"]).length < 1)
            {
                [HUDUtil showErrorWithStatus:@"详细地址不可为空"];
            }
            else if ( ((NSString *)[_pDic objectForKey:@"Tel"]).length < 1 )
            {
                [HUDUtil showErrorWithStatus:@"联系电话不可为空"];
            }
            else if (((NSString *)[_pDic objectForKey:@"Introduction"]).length < 1)
            {
                [HUDUtil showErrorWithStatus:@"商家简介不可为空"];
            }
            else if (((NSString *)[_pDic objectForKey:@"Feature"]).length < 1)
            {
                [HUDUtil showErrorWithStatus:@"特色优势不可为空"];
            }
            
//            if (!_willChangeSeverId)
//            {
//                [_pDic setValue:nil forKey:@"ServicePersonnelNumber"];
//            }
            ADAPI_adv3_EditEnterprise([self genDelegatorID:@selector(infoHandle:)], _pDic);
        }
//        [self performSelector:@selector(autoQuit) withObject:nil afterDelay:5];
    }
}

- (void)autoQuit
{
    if (self && [self isKindOfClass:[BusinessInfoManagerViewController class]])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
