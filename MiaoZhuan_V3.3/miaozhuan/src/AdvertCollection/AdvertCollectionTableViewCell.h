//
//  AdvertCollectionTableViewCell.h
//  miaozhuan
//
//  Created by abyss on 14/10/21.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "CRCommonCell.h"

@interface AdvertCollectionTableViewCell : CRCommonCell

@property (retain, nonatomic) IBOutlet NetImageView *img;
@property (retain, nonatomic) IBOutlet UIImageView *icon;
@property (retain, nonatomic) IBOutlet UILabel *titleL;
@property (retain, nonatomic) IBOutlet UILabel *textL;
@property (retain, nonatomic) NSString* adsId;
@property (assign, nonatomic) BOOL isYin;
@end
