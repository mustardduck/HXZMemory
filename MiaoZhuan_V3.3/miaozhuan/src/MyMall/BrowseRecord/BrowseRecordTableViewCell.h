//
//  BrowseRecordTableViewCell.h
//  miaozhuan
//
//  Created by apple on 14/12/25.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"

@interface BrowseRecordTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet NetImageView *cellImages;
@property (retain, nonatomic) IBOutlet UILabel *cellTitle;
@property (retain, nonatomic) IBOutlet UILabel *cellTime;
@property (retain, nonatomic) IBOutlet UIImageView *cellTypeImage;

@end
