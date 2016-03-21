//
//  IWSellerDiscountFooterTableViewCell.m
//  miaozhuan
//
//  Created by luo on 15/5/14.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWSellerDiscountFooterTableViewCell.h"

@implementation IWSellerDiscountFooterTableViewCell
- (void)awakeFromNib {
    // Initialization code
    
    
    if (self.longPressGestureRecognizer == nil) {
        self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
        self.longPressGestureRecognizer.delegate = self;
        self.longPressGestureRecognizer.minimumPressDuration = 1.f;
        [self.imageviewVoucher addGestureRecognizer:self.longPressGestureRecognizer];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)tapGestureRecognizer:(UILongPressGestureRecognizer *)sender {
    if(_responsingLongPressGestureRecognizer)return;
    _responsingLongPressGestureRecognizer = YES;
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"下载图片" otherButtonTitles: nil];
    [action showInView:self];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    _responsingLongPressGestureRecognizer = NO;
    
    if (buttonIndex == 0) { //下载
        [HUDUtil showWithStatus:@"正在保存凭证..."];
        UIImageWriteToSavedPhotosAlbum(self.imageviewVoucher.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }else{
        
    }
}

/**
 *  图片保存
 *
 */
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        [HUDUtil showSuccessWithStatus:@"凭证保存成功"];
    }else
    {
        [HUDUtil showErrorWithStatus:[error description]];
    }
}



@end
