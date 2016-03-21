//
//  SetConvertCenterViewController.h
//  miaozhuan
//
//  Created by Santiago on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YinYuanDelegate.h"

@interface SetConvertCenterViewController : DotCViewController

@property (assign) id<YinYuanSelectExPointDelegate> delegate;
@property (assign, nonatomic) BOOL isSelect;
@property (nonatomic, retain) NSMutableArray *selArr;
@property (nonatomic, assign) BOOL isYinYuanProdCreate;
@property (nonatomic, retain) NSString * selectId;

@end
