//
//  BusinessPlaceController.m
//  miaozhuan
//
//  Created by momo on 15/5/28.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "BusinessPlaceController.h"
#import "PSTCollectionView.h"
#import "RRLineView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "AddPictureCell.h"
#import "PreviewViewController.h"
#import "EditImageViewController.h"

@interface BusinessPlaceController ()<UIActionSheetDelegate, PSTCollectionViewDataSource, PSTCollectionViewDelegate, UIImagePickerControllerDelegate>
{
    PSTCollectionView *_collectionview;
    NSInteger _deleteIndex;
    NSInteger _currentItem;//选择的某个图片
    
    NSMutableArray * _reasonArr;
    
    DictionaryWrapper * UpImageDic;
}

@property (nonatomic, retain) NSMutableArray *pickedUrls;
@property (nonatomic, retain) NSMutableArray *pickedIds;
@property (nonatomic, retain) NSString * comment;
@property (retain, nonatomic) IBOutlet UIScrollView *scroller;
@property (retain, nonatomic) IBOutlet RRLineView *line;
@end

@implementation BusinessPlaceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"经营场所");
    
    ADAPI_adv3_3_Enterprise_PicRes([self genDelegatorID:@selector(handleGetProductDetail:)], @[@1106]);
    
    _reasonArr = STRONG_OBJECT(NSMutableArray, init);
    
    [self _initData];
}


- (void)handleGetProductDetail:(DelegatorArguments *)arguments
{
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed)
    {
        if(dic.data)
        {
            [self setSrcDataView:dic];
        }
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (void) setSrcDataView:(DictionaryWrapper *)dic
{
    NSArray * silverProdArr = dic.data;
    
    if(silverProdArr.count)
    {
        for(NSDictionary * dic in silverProdArr)
        {
            [_pickedIds addObject:[dic.wrapper getString:@"Id"]];
            
            [_pickedUrls addObject:[dic.wrapper getString:@"ResUrl"]];
        }
    }
    [self countHeight];
    [_collectionview reloadData];
}


- (void) _initData
{
    _currentItem = -1;
    _deleteIndex = -1;
    
    self.pickedUrls = [NSMutableArray arrayWithCapacity:0];
    self.pickedIds = [NSMutableArray arrayWithCapacity:0];
    
    [self _initPstCollectionView];
    
}

- (void)_initPstCollectionView{
    
    PSTCollectionViewFlowLayout *layout = WEAK_OBJECT(PSTCollectionViewFlowLayout, init);
    layout.minimumInteritemSpacing = 20.f;
    layout.minimumLineSpacing = 20.f;
    UIEdgeInsets insets = {.top = 0,.left = 20,.bottom = 20,.right = 20};
    layout.sectionInset = insets;
    
    _collectionview = WEAK_OBJECT(PSTCollectionView, initWithFrame:CGRectMake(0, 72, SCREENWIDTH, 200) collectionViewLayout:layout);
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.scrollEnabled = NO;
    _collectionview.backgroundColor = [UIColor whiteColor];
    [_collectionview registerNib:[UINib nibWithNibName:@"AddPictureCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AddPictureCell"];
    
    [_scroller addSubview:_collectionview];
    
    _scroller.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64);
    
    [_scroller setContentSize:CGSizeMake(320, 470)];
}

- (void)countHeight{
    //计算高度
    NSInteger count = _pickedUrls.count + 1;
    NSInteger row = (count % 3) ? (count / 3 + 1) : count / 3;
    float height = row * (80 + 20);
    
    _collectionview.height = height;
    
    _line.top = height + 213;
    
}
//上传图片
- (void)handleUploadPic:(DelegatorArguments *)arguments
{
    DictionaryWrapper* dic = arguments.ret;
    
    if ([arguments isEqualToOperation:ADOP_Picture_Upload])
    {
        [arguments logError];
        
        if (dic.operationSucceed)
        {
            NSLog(@"图片上传成功－－－－－－%@",dic.data);
            
            UpImageDic = dic.data;
            
            [UpImageDic retain];
            
            NSString *pid = [dic.data getString:@"PictureId"];
            
            ADAPI_adv3_3_Enterprise_AddPlacePic([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleUploadPic:)], pid);
        }
        else
        {
            [HUDUtil showErrorWithStatus:dic.operationMessage];
            return;
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_3_Enterprise_AddPlacePic])
    {
        [arguments logError];
        
        if (dic.operationSucceed)
        {
            NSString *url = [UpImageDic getString:@"PictureUrl"];
            NSString *pid = [UpImageDic getString:@"PictureId"];
            if (!pid)
            {
                return;
            }
            if (_currentItem == -1)
            {
                [_pickedUrls addObject:url];
                [_pickedIds addObject:pid];
            }
            else
            {
                [_pickedUrls removeObjectAtIndex:_currentItem];
                [_pickedUrls insertObject:url atIndex:_currentItem];
                [_pickedIds removeObjectAtIndex:_currentItem];
                [_pickedIds insertObject:pid atIndex:_currentItem];
            }
            [self countHeight];
            [_collectionview reloadData];
        }
        else
        {
            [HUDUtil showErrorWithStatus:dic.operationMessage];
            return;
        }
    }
}
//删除图片
- (void)handleDeletePic:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed)
    {
        NSLog(@"%@",dic.data);
        
        [_pickedIds removeObjectAtIndex:_deleteIndex];
        [_pickedUrls removeObjectAtIndex:(long)_deleteIndex];
        [self countHeight];
        [_collectionview reloadData];
    }
    else
    {
        
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
                                                           ImgType:EditImageType800);
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sheetTag = actionSheet.tag;
    
    if (sheetTag >= 1000 && sheetTag < 1000000) {
        
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
        }
        else if (buttonIndex == 3)
        {
            _deleteIndex = actionSheet.tag - 1000;
            
            //删除
            ADAPI_adv3_3_Enterprise_DeletePlacePic([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleDeletePic:)], _pickedIds[actionSheet.tag - 1000]);
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

#pragma mark - collectionview delegate / datasource
- (NSInteger)collectionView:(PSTCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _pickedUrls.count >= 10 ? 10 : _pickedUrls.count + 1;
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
    
    if (indexPath.row == _pickedUrls.count && _pickedUrls.count != 10) {
        cell.imageView.hidden = YES;
        cell.btnAdd.hidden = NO;
        [cell.btnAdd addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        cell.btnAdd.hidden = YES;
        cell.imageView.hidden = NO;
        [cell.imageView requestWithRecommandSize:_pickedUrls[indexPath.row]];
    }
    return cell;
}

- (CGSize)collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 80);
}

- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIActionSheet *sheet = [[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"预览" otherButtonTitles:@"相机拍摄", @"从相册中选择", @"删除",nil] autorelease];
    sheet.tag = indexPath.row + 1000;
    [sheet showInView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [_scroller release];
    [super dealloc];
}
@end
