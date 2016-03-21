//
//  DetailSiteChangeTableViewCell.h
//  miaozhuan
//
//  Created by apple on 14/12/26.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRLineView.h"
@interface DetailSiteChangeTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *cellAddressLable;
@property (retain, nonatomic) IBOutlet UIButton *cellMapBtn;
@property (retain, nonatomic) IBOutlet UILabel *cellPhoneLable;
@property (retain, nonatomic) IBOutlet UIButton *cellPhoneBtn;
@property (retain, nonatomic) IBOutlet UILabel *cellTimeLable;
@property (retain, nonatomic) IBOutlet RRLineView *cellLine;
@property (retain, nonatomic) IBOutlet UIView *cellLineOne;

@end
