//
//  SJYHCell.h
//  miaozhuan
//
//  Created by momo on 15/6/8.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "RRLineView.h"
#import "BaseMerchatCell.h"

@interface SJYHCell : BaseMerchatCell
@property (retain, nonatomic) IBOutlet UILabel *titlelbl;
@property (retain, nonatomic) IBOutlet NetImageView *imgView;
@property (retain, nonatomic) IBOutlet RRLineView *line;
@property (retain, nonatomic) IBOutlet UIView *timeView;
@property (retain, nonatomic) IBOutlet UILabel *timeLbl;
@property (retain, nonatomic) IBOutlet UILabel *redLbl;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *timeCons;
@property (nonatomic, retain) NSDictionary *dataDic;
@property (nonatomic, assign) int queryType;

+ (instancetype)newInstance;

@end
