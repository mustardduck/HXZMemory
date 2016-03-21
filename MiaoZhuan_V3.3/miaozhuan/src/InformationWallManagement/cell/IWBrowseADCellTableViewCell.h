//
//  IWAttractBusinessCellTableViewCell.h
//  miaozhuan
//
//  Created by Junnpy Zhong on 15/5/9.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_PostBoard.h"
#import "NetImageView.h"
#import "RTLabel.h"

@interface IWBrowseADCellTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet NetImageView *imageView_Logo;
@property (retain, nonatomic) IBOutlet UILabel *label_Title;
@property (retain, nonatomic) IBOutlet UILabel *label_Company;
@property (retain, nonatomic) IBOutlet UILabel *label_Type;
@property (retain, nonatomic) IBOutlet UILabel *label_Date;
@property (retain, nonatomic) IBOutlet UILabel *label_Address;
@property (retain, nonatomic) IBOutlet UILabel *label_Line;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_width_Address;
@property (retain, nonatomic) IBOutlet UILabel *label_Money;

-(void) setupDataContent:(PostBoardInfo *) obj PostBoardType:(PostBoardType)type;
@end
