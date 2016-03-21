//
//  UserStartApealingViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-12-31.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "UserStartApealingViewController.h"
#import "PreviewViewController.h"
@interface UserStartApealingViewController ()<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>{

    int _oldIndexLength;
}
@property (retain, nonatomic) IBOutlet UILabel *shouldBeganLebel;
@property (retain, nonatomic) IBOutlet UILabel *textViewLeftLabel;
@property (retain, nonatomic) IBOutlet UILabel *textViewMiddleNumberLabel;
@property (retain, nonatomic) IBOutlet UILabel *textViewRightLabel;
@property (retain, nonatomic) IBOutlet UIButton *addPictureBtn;
@property (strong, nonatomic) UIImage *imageUserChoosed;
@property (retain, nonatomic) IBOutlet UIView *bottomBackGroundView;
@property (assign, nonatomic) int picAlreadyHave;
@property (assign, nonatomic) int thisBtnTag;
@property (strong, nonatomic) NSMutableArray *imageDataSource;

@property (retain, nonatomic) IBOutlet UIImageView *imageView1;
@property (retain, nonatomic) IBOutlet UIImageView *imageView2;
@property (retain, nonatomic) IBOutlet UIImageView *imageView3;
@property (retain, nonatomic) IBOutlet UIImageView *imageView4;
@property (retain, nonatomic) IBOutlet UIImageView *imageView5;

@property (retain, nonatomic) IBOutlet UIButton *btn1;
@property (retain, nonatomic) IBOutlet UIButton *btn2;
@property (retain, nonatomic) IBOutlet UIButton *btn3;
@property (retain, nonatomic) IBOutlet UIButton *btn4;
@property (retain, nonatomic) IBOutlet UIButton *btn5;

@property (retain, nonatomic) IBOutlet UITextView *returnReasonTextView;

@property (retain, nonatomic) IBOutlet UIView *UILineView1;
@property (retain, nonatomic) IBOutlet UIView *UILineView2;
@property (retain, nonatomic) IBOutlet UIView *UILineView3;
@property (retain, nonatomic) IBOutlet UIView *UILineView4;
@property (strong, nonatomic) NSString *theReasonMerchantDisagreeReturn;
@end

@implementation UserStartApealingViewController

@synthesize shouldBeganLebel = _shouldBeganLebel;
@synthesize textViewLeftLabel = _textViewLeftLabel;
@synthesize textViewMiddleNumberLabel = _textViewMiddleNumberLabel;
@synthesize textViewRightLabel = _textViewRightLabel;
@synthesize imageUserChoosed = _imageUserChoosed;
@synthesize addPictureBtn = _addPictureBtn;
@synthesize bottomBackGroundView = _bottomBackGroundView;
@synthesize picAlreadyHave = _picAlreadyHave;
@synthesize imageDataSource = _imageDataSource;
@synthesize imageView1 = _imageView1;
@synthesize imageView2 = _imageView2;
@synthesize imageView3 = _imageView3;
@synthesize imageView4 = _imageView4;
@synthesize imageView5 = _imageView5;
@synthesize thisBtnTag = _thisBtnTag;
@synthesize btn1 = _btn1;
@synthesize btn2 = _btn2;
@synthesize btn3 = _btn3;
@synthesize btn4 = _btn4;
@synthesize btn5 = _btn5;
@synthesize orderId = _orderId;
@synthesize theReasonMerchantDisagreeReturn = _theReasonMerchantDisagreeReturn;
@synthesize returnReasonTextView = _returnReasonTextView;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setTitle:@"发起申诉"];
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"提交"];
    self.picAlreadyHave = 0;
    self.imageDataSource = WEAK_OBJECT(NSMutableArray, init);
    self.addPictureBtn.tag = 100;
    [self addDoneToKeyboard:_returnReasonTextView];
    
    [self.UILineView1 setFrame:CGRectMake(0, 0, 320, 0.5)];
    [self.UILineView2 setFrame:CGRectMake(0, 149.5, 320, 0.5)];
    [self.UILineView3 setFrame:CGRectMake(0, 0, 320, 0.5)];
    [self.UILineView4 setFrame:CGRectMake(0, 247.5, 320, 0.5)];
    
    self.imageView1.layer.borderWidth = 0.5;
    self.imageView1.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    self.imageView2.layer.borderWidth = 0.5;
    self.imageView2.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    self.imageView3.layer.borderWidth = 0.5;
    self.imageView3.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    self.imageView4.layer.borderWidth = 0.5;
    self.imageView4.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    self.imageView1.hidden = YES;
    self.imageView2.hidden = YES;
    self.imageView3.hidden = YES;
    self.imageView4.hidden = YES;
}

- (void)hiddenKeyboard {

    [_returnReasonTextView resignFirstResponder];
}

- (void)setUpTextViewBottomLabel:(NSString*)string {
    
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, 14) lineBreakMode:NSLineBreakByWordWrapping];
    [self.textViewMiddleNumberLabel setFrame:CGRectMake(_textViewRightLabel.frame.origin.x-size.width, _textViewRightLabel.frame.origin.y, size.width, 14)];
    [self.textViewLeftLabel setFrame:CGRectMake(_textViewMiddleNumberLabel.frame.origin.x-70, _textViewRightLabel.frame.origin.y, 70, 14)];
}

//提交
- (IBAction) onMoveFoward:(UIButton*) sender {
    
    WDictionaryWrapper *postData = WEAK_OBJECT(WDictionaryWrapper, init);
    NSMutableArray *idsArray = WEAK_OBJECT(NSMutableArray, init);
    [postData set:@"OrderId" string:[NSString stringWithFormat:@"%d",_orderId]];
    [postData set:@"Comment" string:_theReasonMerchantDisagreeReturn];
    
    for (NSDictionary *dic in _imageDataSource) {
        DictionaryWrapper *wrapper = dic.wrapper;
        [idsArray addObject:[wrapper getString:@"PictureId"]];
    }
    
    [postData set:@"PictureIds" value:idsArray];
    ADAPI_UserStartApealing([self genDelegatorID:@selector(postData:)],postData.dictionary);
}

//提交回调
- (void)postData:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed) {
        
        [HUDUtil showSuccessWithStatus:@"提交成功"];
        
        [self.delegate refresh];
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

//增加图片
- (IBAction)addPicture:(UIButton*)sender {
    
    self.thisBtnTag = (int)sender.tag;
    
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

//预览和替换
- (IBAction)previewAndChangePic:(UIButton *)sender {
    
    self.thisBtnTag = (int)sender.tag;
    
    UIActionSheet *sheet;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"预览",@"拍摄上传",@"相册选取",nil];
    }else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"预览",@"相册选取", nil];
    }
    
    sheet.tag = 266;
    
    [sheet showInView:self.view];
    [sheet release];
}

//预览图片页面
- (void)previewPic {
    
    PreviewViewController *temp = WEAK_OBJECT(PreviewViewController, init);
    temp.dataArray = _imageDataSource;
    [self.navigationController presentViewController:temp animated:YES completion:^{}];
}

#pragma mark -ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                    
                case 0:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                    // 取消
                case 2:
                    return;
            }
        }else {
            switch (buttonIndex) {
                    
                case 0:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                    break;
                case 1:
                    return;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        [imagePickerController release];
    }
    
    if (actionSheet.tag == 266) {
        
        NSUInteger sourceType = 0;
        
        BOOL supportCamara;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            supportCamara = YES;
            switch (buttonIndex) {
                    
                case 0:
                    // 预览
                    [self previewPic];
                    break;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 3:
                    return;
            }
        }else {
            supportCamara = NO;
            switch (buttonIndex) {
                    //预览
                case 0:
                    [self previewPic];
                    break;
                    //相册
                case 1:
                    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                    break;
                case 2:
                    return;
            }
        }
        
        if ((supportCamara&&(buttonIndex == 1||buttonIndex == 2))||(!supportCamara&&(buttonIndex == 1))) {
            
            // 跳转到相机或相册页面
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = sourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:^{}];
            
            [imagePickerController release];
        }
    }
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        self.imageUserChoosed = [[info objectForKey:UIImagePickerControllerOriginalImage] compressedImage];
        ADAPI_Picture_Upload([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleUploadPic:)],UIImagePNGRepresentation(_imageUserChoosed));
    }];
}

- (void)handleUploadPic:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        DictionaryWrapper *dataSource = wrapper.data;
        [HUDUtil showSuccessWithStatus:@"上传成功"];
        
        if (_thisBtnTag == 100) {
            
            self.picAlreadyHave++;
            int j = _picAlreadyHave/3;
            if (_picAlreadyHave == 5) {
                
                self.addPictureBtn.enabled = NO;
            }
            if (_picAlreadyHave != 3) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    [self.addPictureBtn setFrame:CGRectMake(100*(_picAlreadyHave%3)+20, 48+j*100, 80, 80)];
                }];
            }else {
                
                [self.addPictureBtn setFrame:CGRectMake(100*(_picAlreadyHave%3)+20, 48+j*100, 80, 80)];
            }
            
            switch (_picAlreadyHave) {
                case 1:
                    [self.imageView1 setImage:_imageUserChoosed];
                    self.btn1.hidden = NO;
                    self.imageView1.hidden = NO;
                    break;
                case 2:
                    [self.imageView2 setImage:_imageUserChoosed];
                    self.btn2.hidden = NO;
                    self.imageView2.hidden = NO;
                    break;
                case 3:
                    [self.imageView3 setImage:_imageUserChoosed];
                    self.btn3.hidden = NO;
                    self.imageView3.hidden = NO;
                    break;
                case 4:
                    [self.imageView4 setImage:_imageUserChoosed];
                    self.btn4.hidden = NO;
                    self.imageView4.hidden = NO;
                    break;
                case 5:
                    [self.imageView5 setImage:_imageUserChoosed];
                    self.btn5.hidden = NO;
                    self.imageView5.hidden = NO;
                    break;
                default:
                    break;
            }
            
            [self.imageDataSource addObject:dataSource.dictionary];
        }else {
        
            switch (_thisBtnTag) {
                case 1:
                    [self.imageView1 setImage:_imageUserChoosed];
                    [self.imageDataSource removeObjectAtIndex:_thisBtnTag - 1];
                    break;
                case 2:
                    [self.imageView2 setImage:_imageUserChoosed];
                    [self.imageDataSource removeObjectAtIndex:_thisBtnTag - 1];
                    break;
                case 3:
                    [self.imageView3 setImage:_imageUserChoosed];
                    [self.imageDataSource removeObjectAtIndex:_thisBtnTag - 1];
                    break;
                case 4:
                    [self.imageView4 setImage:_imageUserChoosed];
                    [self.imageDataSource removeObjectAtIndex:_thisBtnTag - 1];
                    break;
                case 5:
                    [self.imageView5 setImage:_imageUserChoosed];
                    [self.imageDataSource removeObjectAtIndex:_thisBtnTag - 1];
                    break;
                default:
                    break;
            }
            [self.imageDataSource insertObject:dataSource.dictionary atIndex:_thisBtnTag - 1];
        }
    }else{
        
        [HUDUtil showErrorWithStatus:@"上传失败"];
    }
}


#pragma mark -UITextFieldDelegate
- (void)textViewDidChange:(UITextView *)textView {
    
    _shouldBeganLebel.hidden = textView.text.length != 0;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if ([aString length] > 2000) {
        textView.text = [textView.text substringToIndex:_oldIndexLength];
        [HUDUtil showErrorWithStatus:@"最多可输入2000字"];
        return NO;
    }
    self.textViewMiddleNumberLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)2000 - [aString length]];
    [self setUpTextViewBottomLabel:_textViewMiddleNumberLabel.text];
    _oldIndexLength = (int)[aString length];
    return YES;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView {

    self.theReasonMerchantDisagreeReturn = textView.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    self.delegate = nil;
    [_theReasonMerchantDisagreeReturn release];
    [_imageUserChoosed release];
    [_imageDataSource release];
    [_shouldBeganLebel release];
    [_textViewLeftLabel release];
    [_textViewMiddleNumberLabel release];
    [_textViewRightLabel release];
    [_addPictureBtn release];
    [_bottomBackGroundView release];
    [_imageView1 release];
    [_imageView2 release];
    [_imageView3 release];
    [_imageView4 release];
    [_imageView5 release];
    [_btn1 release];
    [_btn2 release];
    [_btn3 release];
    [_btn4 release];
    [_btn5 release];
    [_returnReasonTextView release];
    [_UILineView1 release];
    [_UILineView2 release];
    [_UILineView3 release];
    [_UILineView4 release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTheReasonMerchantDisagreeReturn:nil];
    [self setImageDataSource:nil];
    [self setImageUserChoosed:nil];
    [self setShouldBeganLebel:nil];
    [self setTextViewLeftLabel:nil];
    [self setTextViewMiddleNumberLabel:nil];
    [self setTextViewRightLabel:nil];
    [self setAddPictureBtn:nil];
    [self setBottomBackGroundView:nil];
    [self setImageView1:nil];
    [self setImageView2:nil];
    [self setImageView3:nil];
    [self setImageView4:nil];
    [self setImageView5:nil];
    [self setBtn1:nil];
    [self setBtn2:nil];
    [self setBtn3:nil];
    [self setBtn4:nil];
    [self setBtn5:nil];
    [super viewDidUnload];
}
@end

