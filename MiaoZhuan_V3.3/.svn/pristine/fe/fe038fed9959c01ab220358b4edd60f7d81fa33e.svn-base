//
//  MyMarketMyOrderReturnProdController.m
//  miaozhuan
//
//  Created by momo on 14/12/30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyMarketMyOrderReturnProdController.h"
#import "PSTCollectionView.h"
#import "AddPictureCell.h"
#import "PreviewViewController.h"
#import "YinYuanDelegate.h"
#import "YinYuanProdEditSubController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "EditImageViewController.h"
#import "RRLineView.h"
#import "IndustryPicker.h"
#import "MyMarketMyOrderListController.h"

@interface MyMarketMyOrderReturnProdController ()<UIActionSheetDelegate, PSTCollectionViewDataSource, PSTCollectionViewDelegate, UIImagePickerControllerDelegate, YinYuanProdDelegate, IndustryPickerDelegate>
{
    PSTCollectionView *_collectionview;
    NSInteger _deleteIndex;
    NSInteger _currentItem;//选择的某个图片
    
    int _returnType;
    
    NSMutableArray * _reasonArr;
    
    IndustryPicker *_industryPicker;

}

@property (nonatomic, retain) NSMutableArray *pickedUrls;
@property (nonatomic, retain) NSMutableArray *pickedIds;
@property (nonatomic, retain) NSString * comment;
@property (retain, nonatomic) IBOutlet RRLineView *line;
@property (retain, nonatomic) IBOutlet UILabel *reasonLbl;
@property (retain, nonatomic) IBOutlet UILabel *moneyLbl;

@end

@implementation MyMarketMyOrderReturnProdController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    InitNav(@"申请");
    
    [self setupMoveFowardButtonWithTitle:@"提交"];
    
    [self _initData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];

    [self addDoneToKeyboard:_totalPriceLbl];
    
    _returnType = 1;
    
    if(_isReturnMoney)
    {
        _returnType = 2;
        
        _totalPriceLbl.text = _totalPrice;
        
        _reasonLbl.text = @"退款原因";
        
        _moneyLbl.text = @"退款金额";
        
        [_reasonBtn setTitle:@"请选择退款原因" forState:UIControlStateNormal];
        
        _totalPriceLbl.userInteractionEnabled = NO;
    }
    else
    {
        _totalPriceLbl.userInteractionEnabled = YES;
        
        _totalPriceLbl.placeholder = [NSString stringWithFormat:@"最多不超过%@", _totalPrice];
    }
    
    _reasonArr = STRONG_OBJECT(NSMutableArray, init);
    

    ADAPI_MyGoldMallGetReturnReasons([self genDelegatorID:@selector(getReturnReasonsHandler:)], _returnType);
}

- (void)pickerIndustryOk:(IndustryPicker *)picker
{
    [_reasonBtn setTitle:picker.curText forState:UIControlStateNormal];

    [picker removeFromSuperview];

}

- (void)pickerIndustryCancel:(IndustryPicker *)picker
{
    [picker removeFromSuperview];
}

- (void) textFieldDidChange:(id)sender
{
    UITextField * textField = (UITextField *)[sender object];
    
    if([textField.text floatValue] > [_totalPrice floatValue])
    {
        _totalPriceLbl.text = _totalPrice;
        
        [_totalPriceLbl becomeFirstResponder];
        
        [HUDUtil showErrorWithStatus:[NSString stringWithFormat:@"最多不超过%@", _totalPrice]];

    }
}

- (void) onMoveFoward:(UIButton *)sender
{
    [_totalPriceLbl resignFirstResponder];
    
    NSMutableDictionary * dic = WEAK_OBJECT(NSMutableDictionary, init);
    
    NSString * reasonText = _reasonBtn.titleLabel.text;
    
    if(_isReturnMoney)
    {
        if([reasonText isEqualToString:@"请选择退款原因"])
        {
            [HUDUtil showErrorWithStatus:@"请选择退款原因"];
            
            return;
        }
        else
        {
            [dic setObject:reasonText forKey:@"ReturnReason"];
            
        }
    }
    else
    {
        if([reasonText isEqualToString:@"请选择退货原因"])
        {
            [HUDUtil showErrorWithStatus:@"请选择退货原因"];
            
            return;
        }
        else
        {
            [dic setObject:reasonText forKey:@"ReturnReason"];
            
        }
    }
    
    if([_totalPriceLbl.text floatValue] > 0)
    {
        if([_totalPriceLbl.text floatValue] > [_totalPrice floatValue])
        {
            [HUDUtil showErrorWithStatus:[NSString stringWithFormat:@"退货金额最多不超过%@", _totalPrice]];
            
            [_totalPriceLbl becomeFirstResponder];
            
            return;
        }
        
        [dic setObject:_totalPriceLbl.text forKey:@"ReturnAmount"];
    }
    else
    {
        [HUDUtil showErrorWithStatus:@"请填写退货金额"];
        
        [_totalPriceLbl becomeFirstResponder];
        
        return;
    }
    
    if(_comment.length)
    {
        [dic setObject:_comment forKey:@"Comment"];
    }
    
    if(_pickedIds.count)
    {
        [dic setObject:_pickedIds forKey:@"PictureIds"];
    }
    
    if(_isReturnMoney)//退款
    {
        [dic setObject:_orderNo forKey:@"OrderNo"];

        [dic setObject:[NSNumber numberWithInteger:_orderType] forKey:@"OrderType"];

        ADAPI_MallRefund([self genDelegatorID:@selector(mallRefundHandler:)], dic);
    }
    else
    {
        [dic setObject:_orderId forKey:@"OrderId"];

        ADAPI_ApplyToReturn([self genDelegatorID:@selector(applyforReturnHandler:)], dic);
    }
}

- (void) hiddenKeyboard
{
    [self.view endEditing:YES];
}

- (void) getReturnReasonsHandler:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed)
    {
        NSArray * arr = wrapper.data;
        
        for (NSDictionary * dic in arr)
        {
            [_reasonArr addObject:[dic.wrapper getString:@"Description"]];
        }
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void) mallRefundHandler:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed)
    {
        [HUDUtil showSuccessWithStatus:@"提交成功"];
        
        MyMarketMyOrderListController * view = WEAK_OBJECT(MyMarketMyOrderListController, init);
        view.queryType = 2;
        view.isReturnMoney = YES;
        [self.navigationController pushViewController:view animated:YES];
        
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void) applyforReturnHandler:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed)
    {
        [HUDUtil showSuccessWithStatus:@"提交成功"];
        
        MyMarketMyOrderListController * view = WEAK_OBJECT(MyMarketMyOrderListController, init);
        view.queryType = 3;
        view.isReturnMoney = YES;
        [self.navigationController pushViewController:view animated:YES];
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void) onMoveBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    _collectionview = WEAK_OBJECT(PSTCollectionView, initWithFrame:CGRectMake(0, 213, SCREENWIDTH, 100) collectionViewLayout:layout);
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.scrollEnabled = NO;
    _collectionview.backgroundColor = [UIColor whiteColor];
    [_collectionview registerNib:[UINib nibWithNibName:@"AddPictureCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AddPictureCell"];
    
    [self.view addSubview:_collectionview];
}

- (void)countHeight{
    //计算高度
    NSInteger count = _pickedUrls.count + 1;
    NSInteger row = (count % 3) ? (count / 3 + 1) : count / 3;
    float height = row * (80 + 20);
    
    _collectionview.height = height;
    
    _line.top = height + 213;
    
}

- (IBAction)touchUpInsideOn:(id)sender
{
    [_totalPriceLbl resignFirstResponder];
    
    if(sender == _reasonBtn)
    {
        if(_reasonArr.count)
        {
            _industryPicker = STRONG_OBJECT(IndustryPicker, initWithStyle:self pickerData:_reasonArr);
            
            NSInteger tag = 4;
            
            if(_isReturnMoney)
            {
                tag = 3;
            }
            
            [_industryPicker initwithtitles: tag];
            
            _industryPicker.height = YH(self.view);
            
            _industryPicker.top = 0;
            
            _industryPicker.delegate = self;
            
            [self.view addSubview:_industryPicker];
        }
    }
    else if (sender == _desBtn)
    {
        YinYuanProdEditSubController * view = WEAK_OBJECT(YinYuanProdEditSubController, init);
        
        view.delegate = self;
        
        view.naviTitle = @"补充说明";
        
        view.isReturnProduct = YES;
        
        view.prodDes = _comment;
        
        view.limitNum = 500;
        
        [self.navigationController pushViewController:view animated:YES];
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
            [_pickedUrls removeObjectAtIndex:_currentItem];
            [_pickedUrls insertObject:url atIndex:_currentItem];
            [_pickedIds removeObjectAtIndex:_currentItem];
            [_pickedIds insertObject:pid atIndex:_currentItem];
        }
        [self countHeight];
        [_collectionview reloadData];
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
//        else if (buttonIndex == 3){
//            //删除
//            _deleteIndex = actionSheet.tag - 1000;
//            
//            [_pickedIds removeObjectAtIndex:_deleteIndex];
//            [_pickedUrls removeObjectAtIndex:(long)_deleteIndex];
//            [self countHeight];
//            [_collectionview reloadData];
//            
//        }
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
    return _pickedUrls.count >= 5 ? 5 : _pickedUrls.count + 1;
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
    
    if (indexPath.row == _pickedUrls.count && _pickedUrls.count != 5) {
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
    
    UIActionSheet *sheet = [[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"预览" otherButtonTitles:@"相机拍摄", @"从相册中选择", nil] autorelease];
    sheet.tag = indexPath.row + 1000;
    [sheet showInView:self.view];
}

- (void) passReturnProduct:(NSString *)reasonDes
{
    if(reasonDes.length)
    {
        self.comment = reasonDes;
        
        [_desBtn setTitle:@"已填写" forState:UIControlStateNormal];
        [_desBtn setTitleColor:AppColor(85) forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_reasonBtn release];
    [_totalPriceLbl release];
    [_desBtn release];
    self.comment = nil;
    [_line release];
    [_reasonLbl release];
    [_moneyLbl release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setReasonBtn:nil];
    [self setTotalPriceLbl:nil];
    [self setDesBtn:nil];
    [super viewDidUnload];
}
@end
