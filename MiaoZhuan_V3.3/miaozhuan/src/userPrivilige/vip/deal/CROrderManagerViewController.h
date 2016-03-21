//
//  CROrderManagerViewController.h
//  miaozhuan
//
//  Created by abyss on 14/12/4.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTableViewCell.h"

@interface CROrderManagerViewController : DotCViewController
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) CRENUM_OrderType type;

@end
