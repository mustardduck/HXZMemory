//
//  PersonalProfileViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/28.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PersonalProfileViewController.h"
#import "ThankFulMechanismTableViewCell.h"
#import "UIView+expanded.h"
#import "NetImageView.h"
#import "MoreProfileViewController.h"
#import "DatePickerViewController.h"
#import "IndustryPicker.h"
#import "ProfileNameViewController.h"
#import "VipPriviliegeViewController.h"
#import "PreviewViewController.h"
#import "EditImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "RRLineView.h"
@interface PersonalProfileViewController ()<UITableViewDataSource,UITableViewDelegate,DatePickerDelegate,IndustryPickerDelegate,UIActionSheetDelegate>
{
    NSArray * Titlearray;
    
    DictionaryWrapper* dic;
    
    NSString * trueName;
    
    NSString * sex;
    
    NSString * birthday;
    
    DatePickerViewController *datePickerView;
    
    NSArray *birthdayPickerArray;
    
    CGFloat offsetY;
    
    IndustryPicker *industryPicker;
    
    NSString * imagetitle;
    
    NSString * phontId;
}
@property (retain, nonatomic) IBOutlet UITableView *mainTableVIew;
@property (retain, nonatomic) IBOutlet UIView *heardVIew;
@property (retain, nonatomic) IBOutlet NetImageView *heardImage;
- (IBAction)imageBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *heardTop;
@property (retain, nonatomic) IBOutlet UIView *heardButton;

@end

@implementation PersonalProfileViewController
@synthesize mainTableVIew = _mainTableVIew;
@synthesize heardVIew = _heardVIew;
@synthesize heardImage = _heardImage;

-(void)viewWillAppear:(BOOL)animated
{
    Titlearray = [[NSArray arrayWithObjects:@[@"VIP等级"],@[@"账号",@"姓名",@"性别", @"生日"],@[@"更多资料"],nil]retain];
    
    offsetY = [UICommon getIos4OffsetY];
    
    birthdayPickerArray = [[NSArray alloc] initWithObjects:@"男",@"女", nil];
    
    dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    [dic retain];
    
    trueName = [dic getString:@"TrueName"];
    
    if ([dic getInt:@"Gender"] == 1)
    {
        sex = @"男";
    }
    else if ([dic getInt:@"Gender"] == 2)
    {
        sex = @"女";
    }
    else
    {
        sex = @"";
    }
    
    birthday = [dic getString:@"Birthday"];
    
    birthday = [UICommon formatDate:birthday];
    
    [birthday retain];
    
    if ([dic getBool:@"IsInfoGiftCompleted"])
    {
        _heardTop.hidden = YES;
        _heardVIew.frame = CGRectMake(0, 0, 320, 100);
        _heardButton.frame = CGRectMake(0, 10, 320, 90);
    }
    else
    {
        if ([dic getString:@"PhotoUrl"] == nil || [dic getString:@"TrueName"] == nil || [dic getString:@"Birthday"] == nil || [dic getString:@"OtherPhone"] == nil || [[dic getString:@"PhotoUrl"] isEqualToString:@""] || [[dic getString:@"TrueName"] isEqualToString:@""] || [[dic getString:@"Birthday"] isEqualToString:@""] || [[dic getString:@"OtherPhone"] isEqualToString:@""])
        {
            //如果其中一项为空
            
        }
        else
        {
#define CTJ_ISNIL_DIC(_key) [dic getString:_key]? [dic getString:_key]:@""
            
            NSString * Provinces = CTJ_ISNIL_DIC(@"Province");
            NSString * Citys = CTJ_ISNIL_DIC(@"City");
            NSString * Districts = CTJ_ISNIL_DIC(@"District");
            
            NSString * str = [NSString stringWithFormat:@"%@%@%@",Provinces,Citys,Districts];

            
            //或者 省市区全部为空
            if ([str isEqualToString:@""] || str == nil)
            {
                
            }
            else
            {
                _heardTop.hidden = YES;
                
                _heardVIew.frame = CGRectMake(0, 0, 320, 100);
                
                _heardButton.frame = CGRectMake(0, 10, 320, 90);
            }
        }
    }
    _mainTableVIew.tableHeaderView = _heardVIew;
    
    _mainTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_mainTableVIew reloadData];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"个人资料");
    
    [_heardImage roundCornerRadiusBorder];
}

- (IBAction) onMoveBack:(UIButton *)sender
{
    //保存本地
    int Gender;
    
    if ([sex isEqualToString:@"男"])
    {
        Gender = 1;
    }
    else if([sex isEqualToString:@"女"])
    {
        Gender = 2;
    }
    else
    {
        Gender = 0;
    }
    
    if (Gender != [dic getInt:@"Gender"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"ChangeUsers"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * str = [defaults objectForKey:@"ChangeUsers"];
    
    NSLog(@"---str---%@",str);
    
    if ([str isEqualToString:@"1"])
    {
        //有改动
        NSString * gender = [NSString stringWithFormat:@"%d",Gender];
        
        NSString * provinceId = [NSString stringWithFormat:@"%d",[dic getInt:@"ProvinceId"]];
        NSString * CityId = [NSString stringWithFormat:@"%d",[dic getInt:@"CityId"]];
        NSString * DistrictId = [NSString stringWithFormat:@"%d",[dic getInt:@"DistrictId"]];
        
#define CTJ_ISNIL_DIC(_key) [dic getString:_key]? [dic getString:_key]:@""
        
        trueName = CTJ_ISNIL_DIC(@"TrueName");
        
        NSString * otherphone = CTJ_ISNIL_DIC(@"OtherPhone");
        
        NSString * qq =CTJ_ISNIL_DIC(@"QQ");
        
        NSString * email = CTJ_ISNIL_DIC(@"Email");
        
        NSString * weibo = CTJ_ISNIL_DIC(@"Weibo");
        
        NSString * weixin = CTJ_ISNIL_DIC(@"Weixin");
        
        if (phontId == nil)
        {
            phontId = @"";
        }
        
        //上传数据
        ADAPI_adv3_Customer_FillDetailsInfo([self genDelegatorID:@selector(HandleNotification:)], phontId, trueName, gender, birthday, provinceId, CityId, DistrictId, otherphone, qq, email, weibo, weixin);
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0"  forKey:@"ChangeUsers"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_Customer_FillDetailsInfo])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)] autorelease];
    RRLineView *linetop = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 9.5, 320, 0.5));
    [sectionView addSubview:linetop];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 4;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ThankFulMechanismTableViewCell";
    ThankFulMechanismTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ThankFulMechanismTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    cell.thankfullcellTitle.text = Titlearray[indexPath.section][indexPath.row];
 
    [_heardImage requestPic:[dic getString:@"PhotoUrl"] placeHolder:NO];
    
    if (indexPath.section == 0)
    {
        if ([dic getInt:@"VipLevel"] == 0)
        {
            cell.isThankFulcellLable.text = @"未开通";
        }
        else
        {
            cell.isThankFulcellLable.text = [NSString stringWithFormat:@"当前VIP%d",[dic getInt:@"VipLevel"]];
        }
        cell.cellLines.left = 0;
        cell.cellLines.top = 49.5;
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            cell.isThankFulcellLable.text = [dic getString:@"UserName"];
            cell.cellJianTou.hidden =  YES;
        }
        else if(indexPath.row == 1)
        {
            cell.isThankFulcellLable.text = trueName;
        }
        else if(indexPath.row == 2)
        {
            cell.isThankFulcellLable.text = sex;
        }
        else
        {
            cell.isThankFulcellLable.text = birthday;
            
            cell.cellLines.left = 0;
            cell.cellLines.top = 49.5;
        }
    }
    else
    {
        cell.isThankFulcellLable.text = @"";
        cell.cellLines.left = 0;
        cell.cellLines.top = 49.5;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        PUSH_VIEWCONTROLLER(VipPriviliegeViewController);
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            
        }
        else if (indexPath.row == 1)
        {
            PUSH_VIEWCONTROLLER(ProfileNameViewController);
            model.name = trueName;
        }
        else if (indexPath.row == 2)
        {
            [self setPickerViewWith:@"性别"];
        }
        else
        {
            [self setDatePickerView];
            
            datePickerView.picker.date = [NSDate date];
            
            datePickerView.view.tag = 100;
            
            [datePickerView initwithtitles:0];
            
            [datePickerView setMaxDate:[NSDate date]];
            
            [self.view addSubview:datePickerView.view];
        }
    }
    else
    {
        PUSH_VIEWCONTROLLER(MoreProfileViewController);
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        return NO;
    }
    ThankFulMechanismTableViewCell *cell = (ThankFulMechanismTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThankFulMechanismTableViewCell *cell = (ThankFulMechanismTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

#pragma mark UIActionSheet

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


- (IBAction)imageBtn:(id)sender
{
    if ([dic getString:@"PhotoUrl"] == nil || [[dic getString:@"PhotoUrl"] isEqualToString:@""])
    {
        [self setActionSheet];
    }
    else
    {
        [self setActionSheetTwo];
    }
}

#pragma mark - 相机

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([dic getString:@"PhotoUrl"] == nil || [[dic getString:@"PhotoUrl"] isEqualToString:@""])
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
            preview.dataArray = @[@{@"PictureUrl":[dic getString:@"PhotoUrl"]}];
            preview.currentPage = 0;
            
            [self presentViewController:preview animated:NO completion:^{
               
            }];
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
                                                           ImgType:EditImageType200);
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

        [picker setNavigationBarHidden:YES animated:NO];
        [picker pushViewController:imageEditor animated:YES];

    } failureBlock:^(NSError *error) {
        NSLog(@"Failed to get asset from library");
    }];
    
}

- (void)passImage:(UIImage *)image
{
    image = [image scaleToSize:CGSizeMake(200, 200)];
    
    ADAPI_Picture_Upload([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleUploadPic:)], UIImagePNGRepresentation(image));
}

//上传图片
- (void)handleUploadPic:(DelegatorArguments *)arguments
{
    DictionaryWrapper* wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        NSString *url = [wrapper.data getString:@"PictureUrl"];
        
        NSLog(@"url----%@",url);
        
        if (!url)
        {
            return;
        }
        [_heardImage requestCustom:url width:_heardImage.width height:_heardImage.height];
        
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".PhotoUrl" string:url];
        
        imagetitle = url;
        
        [imagetitle retain];
        
        phontId = [wrapper.data getString:@"PictureId"];
        
        [phontId retain];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"ChangeUsers"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
    {
        [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
        return;
    }
}


#pragma mark UIPickerView

-(void) setDatePickerView
{
    datePickerView = [[DatePickerViewController alloc]initWithNibName:@"DatePickerViewController" bundle:nil];
    
    datePickerView.view.frame = CGRectMake(0, 0, 320, 460 + offsetY);
    
    datePickerView.delegate = self;
}

-(void) setPickerViewWith :(NSString *) title
{
    industryPicker = [[IndustryPicker alloc]initWithStyle:self pickerData:birthdayPickerArray];
    
    [industryPicker initwithtitles:1];
    
    industryPicker.frame = CGRectMake(0, 0, 320, 460 + offsetY);
    
    industryPicker.delegate = self;
    
    [self.view addSubview:industryPicker];
}

- (void) selectDateCallBack:(NSDate*)date
{
    [datePickerView.view removeFromSuperview];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString* text = [dateFormatter stringFromDate:date];
    
    if (datePickerView.view.tag == 100)
    {
        birthday = text;
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".Birthday" string:birthday];
    }
    
    [dateFormatter release];
    
    dateFormatter = nil;
    
    [_mainTableVIew reloadData];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"ChangeUsers"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) cancelDateCallBack:(NSDate*)date
{
    [datePickerView.view removeFromSuperview];
}

- (void)pickerIndustryOk:(IndustryPicker *)picker
{
    sex = picker.curText;
    [picker removeFromSuperview];
    [_mainTableVIew reloadData];
    int Gender;
    
    if ([sex isEqualToString:@"男"])
    {
        Gender = 1;
    }
    else
    {
        Gender = 2;
    }
    
    [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".Gender" string:[NSString stringWithFormat:@"%d",Gender]];
}

- (void)pickerIndustryCancel:(IndustryPicker *)picker
{
    [picker removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    [imagetitle release];
    
    [phontId release];
    
    [datePickerView release];
    
    datePickerView = nil;
    
    [industryPicker release];
    
    industryPicker = nil;
    
    [Titlearray release];
    
    Titlearray = nil;
    
    [dic release];
    dic = nil;
    
    [_mainTableVIew release];
    [_heardVIew release];
    [_heardImage release];
    [_heardTop release];
    [_heardButton release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainTableVIew:nil];
    [self setHeardVIew:nil];
    [self setHeardImage:nil];
    [super viewDidUnload];
}

@end
