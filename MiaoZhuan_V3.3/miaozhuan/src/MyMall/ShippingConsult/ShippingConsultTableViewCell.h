//
//  ShippingConsultTableViewCell.h
//  miaozhuan
//
//  Created by apple on 14/12/29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRLineView.h"

@interface ShippingConsultTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *cellPhoneLable;
@property (retain, nonatomic) IBOutlet UIButton *cellPhoneBtn;
@property (retain, nonatomic) IBOutlet RRLineView *cellLine;

@end
