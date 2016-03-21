//
//  CollectionReusableView.h
//  miaozhuan
//
//  Created by momo on 15/4/9.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTCollectionViewCell.h"

@interface CollectionReusableView : PSTCollectionReusableView
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
@property (retain, nonatomic) IBOutlet UIButton *downloadBtn;


@end
