//
//  IWComplainReasonListTableViewCellStyle1.h
//  miaozhuan
//
//  Created by admin on 15/5/4.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kIWComplainReasonListTableViewCellStyle1Height 51.f

@interface IWComplainReasonListTableViewCellStyle1 : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *label_Title;
@property (retain, nonatomic) IBOutlet UIImageView *imageView_Check;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_line;

@end
