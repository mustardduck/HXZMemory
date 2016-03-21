//
//  ComeFormAdvertTableViewCell.h
//  miaozhuan
//
//  Created by apple on 14/11/6.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRLineView.h"

@interface ComeFormAdvertTableViewCell : UITableViewCell
//{
//    BOOL imageFlag;
//}
@property (retain, nonatomic) IBOutlet UILabel *cellTitles;
@property (retain, nonatomic) IBOutlet UIImageView *cellImages;
@property (retain, nonatomic) IBOutlet UILabel *cellContent;
@property (retain, nonatomic) IBOutlet UILabel *cellTimes;
@property (retain, nonatomic) IBOutlet RRLineView *cellLines;
@property (assign, nonatomic) BOOL imageFlag;
@property (retain, nonatomic) IBOutlet UIView *redVIew;

@end
