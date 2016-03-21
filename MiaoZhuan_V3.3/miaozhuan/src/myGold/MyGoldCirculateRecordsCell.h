//
//  MyGoldCirculateRecordsCell.h
//  miaozhuan
//
//  Created by momo on 14-12-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMyGoldCell.h"
#import "NetImageView.h"

@interface MyGoldCirculateRecordsCell : BaseMyGoldCell

@property (retain, nonatomic) IBOutlet NetImageView *headerImg;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblTime;
@property (retain, nonatomic) IBOutlet UILabel *lblNum;

@property (nonatomic, retain) NSDictionary *dataDic;
+ (instancetype)newInstance;

@end