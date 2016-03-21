//
//  PeopleSetCell.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRLineView.h"

@interface PeopleSetCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblStatus;
@property (retain, nonatomic) IBOutlet RRLineView *lineview;

@end
