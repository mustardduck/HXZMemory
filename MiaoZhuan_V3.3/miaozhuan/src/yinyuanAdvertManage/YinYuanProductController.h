//
//  YinYuanProductController.h
//  miaozhuan
//
//  Created by momo on 14-11-15.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedPoint.h"

@interface YinYuanProductController : DotCViewController

@property (retain, nonatomic) IBOutlet UIButton *createBtn;
@property (retain, nonatomic) IBOutlet UIButton *draftBtn;
@property (retain, nonatomic) IBOutlet UIButton *bindingBtn;
@property (retain, nonatomic) IBOutlet UIButton *proceedingBtn;
@property (retain, nonatomic) IBOutlet UIButton *AuditFailedBtn;

@property (retain, nonatomic) IBOutlet UIButton *exchangeBtn;
@property (retain, nonatomic) IBOutlet RedPoint *draftPoint;
@property (retain, nonatomic) IBOutlet RedPoint *bindingPoint;
@property (retain, nonatomic) IBOutlet RedPoint *auditFailedPoint;

- (IBAction)touchUpInsideOnBtn:(id)sender;

@end
