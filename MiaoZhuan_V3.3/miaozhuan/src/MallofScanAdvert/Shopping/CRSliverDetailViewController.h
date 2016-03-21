//
//  CRSliverDetailViewController.h
//  miaozhuan
//
//  Created by abyss on 14/12/29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRSliverDetailViewController : DotCViewController
@property (assign ,nonatomic) NSInteger advertId;
@property (assign ,nonatomic) NSInteger productId;
@property (assign, nonatomic) BOOL isPreview;

@property (assign, nonatomic) BOOL comeFromOtherPlace;

@property (assign ,nonatomic) int comeformCounsel;
@end
