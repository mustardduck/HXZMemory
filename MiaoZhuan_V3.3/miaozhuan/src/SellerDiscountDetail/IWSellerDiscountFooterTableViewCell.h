//
//  IWSellerDiscountFooterTableViewCell.h
//  miaozhuan
//
//  Created by luo on 15/5/14.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"

@interface IWSellerDiscountFooterTableViewCell : UITableViewCell<UIActionSheetDelegate>{
    BOOL _responsingLongPressGestureRecognizer;
}


@property (strong, nonatomic) UILongPressGestureRecognizer *longPressGestureRecognizer;

@property (strong, nonatomic) IBOutlet NetImageView *imageviewVoucher;


@end
