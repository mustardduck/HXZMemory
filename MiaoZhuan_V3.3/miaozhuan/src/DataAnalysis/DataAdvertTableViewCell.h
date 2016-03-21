//
//  DataAdvertTableViewCell.h
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"

@interface DataAdvertTableViewCell : UITableViewCell
@property (retain, nonatomic)  NSString *name;
@property (retain, nonatomic) IBOutlet NetImageView *advertImg;
@property (retain, nonatomic) IBOutlet UIImageView *flagImg;
@property (retain, nonatomic) IBOutlet UILabel *advertName;
@property (retain, nonatomic) IBOutlet UILabel *playNum;
@property (retain, nonatomic) IBOutlet UILabel *costNum;
@property (retain, nonatomic) IBOutlet UILabel *flagL;

@property (retain, nonatomic) IBOutlet UILabel *text_1;
@property (retain, nonatomic) IBOutlet UILabel *text_2;
@property (retain, nonatomic) IBOutlet UILabel *lblWatched;
@property (retain, nonatomic) IBOutlet UILabel *text_3;
@property (assign, nonatomic) NSUInteger advertID;
@property (nonatomic, assign) int type;
@end
