//
//  CheckAddressTableViewCell.h
//  miaozhuan
//
//  Created by apple on 14/12/31.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckAddressTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *cellImage;
@property (retain, nonatomic) IBOutlet UILabel *cellTitle;
@property (retain, nonatomic) IBOutlet UILabel *cellAddress;
@property (retain, nonatomic) IBOutlet UIImageView *cellCheckImage;
@property (assign, nonatomic) BOOL checkFlag;
@property (retain, nonatomic) IBOutlet UILabel *cellPhone;
@end
