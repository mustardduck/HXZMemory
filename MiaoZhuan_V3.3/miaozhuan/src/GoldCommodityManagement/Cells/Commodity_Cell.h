//
//  Commodity_Cell.h
//  miaozhuan
//
//  Created by xm01 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "DictionaryWrapper.h"
#import "NetImageView.h"
#import "UIView+expanded.h"

@interface Commodity_Cell : BaseCell

@property(nonatomic, retain) IBOutlet UILabel       *productName;
@property(nonatomic, retain) IBOutlet NetImageView  *picture;
@property(nonatomic, retain) IBOutlet UIImageView   *offlineImage;          //下架标识图标
@property(nonatomic, retain) IBOutlet UILabel       *unitPrice;             //单价
@property(nonatomic, assign) IBOutlet UILabel       *onhandQty;             //库存数量
@property(nonatomic, retain) IBOutlet UILabel       *remainingTime;         //剩余时间
@property(nonatomic, assign) BOOL     hasLine;
@property(nonatomic, retain) IBOutlet UIView        *lineView;


-(void)updateCellData:(DictionaryWrapper *)fileInfo;

@end
