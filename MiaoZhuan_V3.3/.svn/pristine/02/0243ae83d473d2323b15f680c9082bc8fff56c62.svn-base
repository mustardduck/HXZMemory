//
//  AlreadyPublishManagementTableViewCell.h
//  miaozhuan
//
//  Created by luo on 15/4/23.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "SWTableViewCell.h"

typedef void(^IWAlreadyPublishManagementTableViewCellSeletedBlock)(BOOL isSelect);

@interface IWAlreadyPublishManagementTableViewCell : SWTableViewCell

@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, assign) BOOL isSelected;
@property (retain, nonatomic) IBOutlet UIView *view_Content;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_horizontal_CheckBox;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_horizontal_Title;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_horzontal_SubTitle;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *viewConstraint;
@property (retain, nonatomic) IBOutlet UIButton *buttonSelect;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewArrow;

@property (retain, nonatomic) IBOutlet UILabel *lableTitle;
@property (retain, nonatomic) IBOutlet UILabel *lableContent;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_Top;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_Middle;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_Bottom;
@property (retain, nonatomic) IBOutlet UILabel *label_AlreadyRefresh;

@property (copy, nonatomic) IWAlreadyPublishManagementTableViewCellSeletedBlock choiceItem;


-(void) updateContent:(BOOL) isEdit seleted:(BOOL) isSelected;

@end
