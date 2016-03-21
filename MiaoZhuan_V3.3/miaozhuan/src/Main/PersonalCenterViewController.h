//
//  PersonalCenterViewController.h
//  test
//
//  Created by 孙向前 on 14-10-21.
//  Copyright (c) 2014年 sunxq_xiaoruan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "RRLineView.h"
@interface PersonalCenterViewController : DotCViewController
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) IBOutlet UIView *headView;
@property (retain, nonatomic) IBOutlet UIImageView *vip;
@property (retain, nonatomic) IBOutlet NetImageView *headImg;
@property (retain, nonatomic) IBOutlet UILabel *nameL;
@property (retain, nonatomic) IBOutlet UILabel *IDL;
@property (retain, nonatomic) IBOutlet RRLineView *lineImageOne;
- (IBAction)headTouch:(id)sender;
- (void)viewRefresh;
@end
