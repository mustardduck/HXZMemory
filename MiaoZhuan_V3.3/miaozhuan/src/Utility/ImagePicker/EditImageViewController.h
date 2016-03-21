//
//  EditImageViewController.h
//  guanggaoban
//
//  Created by 孙向前 on 14-6-12.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFImageEditorViewController.h"

#warning fix later
typedef NS_ENUM(NSInteger, EditImageType)
{
    EditImageType200        = 1 << 0,                                   //200*200
    EditImageType800        = 1 << 1,                                   //800*800
    EditImageTypeSquare     = (EditImageType200|EditImageType800),
    
    EditImageTypeAdertPic   = 1 << 2,                                   //广告图片
    EditImageTypeIdCard     = 1 << 3,                                   //身份证
    EditImageTypeExchange   = 1 << 4,                                   //兑换承诺书
    EditImageTypeIncHistory = 1 << 5,                                   //公司资质
};

@interface EditImageViewController : HFImageEditorViewController
@property (assign) CGFloat maxSize;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ImgType:(EditImageType)type;
@end






























/**
 #impot <Assert>

[UIApplication sharedApplication].statusBarHidden = NO;

UIImage *image =  [info objectForKey:UIImagePickerControllerOriginalImage];
NSURL *assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];

ALAssetsLibrary *library = [[[ALAssetsLibrary alloc] init] autorelease];
[library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
    UIImage *preview = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
    
    EditImageViewController *imageEditor = WEAK_OBJECT(EditImageViewController,initWithNibName:@"EditImageViewController" bundle:nil);
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

*/