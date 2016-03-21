//
//  IWCompanyNatureChooseTableViewCell.h
//  miaozhuan
//
//  Created by admin on 15/4/27.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kIWCompanyTreatmentCellHeight 50.f

typedef void(^IWCompanyNatureChooseChanged)(BOOL selected);//选中回调事件

@interface IWCompanyTreatmentCell : UITableViewCell{
    BOOL isSelected;//是否选择
}

@property (retain, nonatomic) IBOutlet UILabel *label_Title;//标题
@property (retain, nonatomic) IBOutlet UIButton *button;//按钮
@property (strong, nonatomic) IWCompanyNatureChooseChanged changed;
@property (retain, nonatomic) IBOutlet UILabel *bottomLine;

-(void)setIsSelected:(BOOL)selected;

@end
