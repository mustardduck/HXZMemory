//
//  YinYuanAdvertMainController.h
//  miaozhuan
//
//  Created by momo on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedPoint.h"

@interface YinYuanAdvertMainController : DotCViewController
@property (retain, nonatomic) IBOutlet UIView *topView;
@property (retain, nonatomic) IBOutlet UIButton *createAdvertBtn;
@property (retain, nonatomic) IBOutlet UIButton *draftBtn;
@property (retain, nonatomic) IBOutlet RedPoint *draftRedPoint;
@property (retain, nonatomic) IBOutlet UIButton *successBtn;
@property (retain, nonatomic) IBOutlet RedPoint *successRedPoint;
@property (retain, nonatomic) IBOutlet UIButton *proccedingBtn;
@property (retain, nonatomic) IBOutlet UIButton *failBtn;
@property (retain, nonatomic) IBOutlet RedPoint *failRedPoint;
@property (retain, nonatomic) IBOutlet UIButton *playedBtn;
@property (retain, nonatomic) IBOutlet UIView *mainview;
@property (retain, nonatomic) IBOutlet UILabel *topTextField;

- (IBAction)touchUpInsideOnBtn:(id)sender;

@end
