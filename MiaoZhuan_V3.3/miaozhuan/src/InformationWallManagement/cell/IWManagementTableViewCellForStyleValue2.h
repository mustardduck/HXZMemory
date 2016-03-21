//
//  IWManagementTableViewCellForStyleValue2.h
//  miaozhuan
//
//  Created by admin on 15/4/27.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWManagementViewController.h"

#define kIWManagementTableViewCellForStyleValue2Height 51.f

@interface IWManagementTableViewCellForStyleValue2 : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *label_Title;
@property (retain, nonatomic) IBOutlet UILabel *label_SubTitle;
@property (retain, nonatomic) IBOutlet UILabel *topLine;
@property (retain, nonatomic) IBOutlet UILabel *bottomLine;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_top_TopLine;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_bottom_BottomLine;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_left_Top;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_left_Bottom;
@property (retain, nonatomic) IBOutlet UIView *view_Content;

-(void)updateCellAligningType:(IWManagementCellAligningType)aligningType;

@end
