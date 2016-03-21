//
//  IWSearchResultTableViewCell.h
//  miaozhuan
//
//  Created by luo on 15/4/24.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_PostBoard.h"
#import "NetImageView.h"


@interface IWSearchResultTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet NetImageView *imageViewCover;
@property (retain, nonatomic) IBOutlet UILabel *lableType;
@property (retain, nonatomic) IBOutlet UILabel *lableTitle;
@property (retain, nonatomic) IBOutlet UILabel *lableComplay;
@property (retain, nonatomic) IBOutlet UILabel *lableSalary;
@property (retain, nonatomic) IBOutlet UILabel *lableTime;
@property (retain, nonatomic) IBOutlet UILabel *lablePlace;
@property (retain, nonatomic) IBOutlet UILabel *label_Type;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraint_width_Address;


@property (retain, nonatomic) IBOutlet UILabel *lableLocation;

-(void) setupContent:(PostBoardSearchResultInfo *) resultInfo;

@end
