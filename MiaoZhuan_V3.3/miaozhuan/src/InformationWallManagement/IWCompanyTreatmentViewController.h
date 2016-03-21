//
//  IWCompanyNatureViewController.h
//  miaozhuan
//
//  Created by admin on 15/4/27.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "DotCViewController.h"

typedef void(^IWCompanyTreatmentChooseFinished)(NSArray *items);//待遇选择完成

@interface IWCompanyTreatmentViewController : DotCViewController

@property (strong, nonatomic) IWCompanyTreatmentChooseFinished finished;
@property (strong, nonatomic) NSMutableArray *selectedItems;
@property (strong, nonatomic) NSMutableArray *chooseItems;

@end
