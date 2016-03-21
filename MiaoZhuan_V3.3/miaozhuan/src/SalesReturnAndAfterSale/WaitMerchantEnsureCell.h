//
//  WaitMerchantEnsureCell.h
//  miaozhuan
//
//  Created by Santiago on 15-1-22.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSalesReturnCell.h"

@interface WaitMerchantEnsureCell : BaseSalesReturnCell
@property (retain, nonatomic) IBOutlet UILabel *creatTime;

@property (retain, nonatomic) IBOutlet UIView *uiLine;
+ (instancetype)newInstance;
@end
