//
//  MallGoodsCell.h
//  miaozhuan
//
//  Created by 孙向前 on 14-12-26.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMallCell.h"
#import "NetImageView.h"
#import "RRLineView.h"

@interface MallGoodsCell : BaseMallCell

@property (nonatomic, retain) DictionaryWrapper *dataDic;

+ (instancetype)newInstance;

@property (retain, nonatomic) IBOutlet UIImageView *imgType;
@property (retain, nonatomic) IBOutlet NetImageView *imgPicture;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblNeedPay;
@property (retain, nonatomic) IBOutlet RRLineView *line;

@end
