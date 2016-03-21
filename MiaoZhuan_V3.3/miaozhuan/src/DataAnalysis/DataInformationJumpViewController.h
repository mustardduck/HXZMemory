//
//  DataInformationJumpViewController.h
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAdvertViewController.h"

@interface DataInformationJumpViewController : DotCViewController
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) DataCategroy type;
@property (assign, nonatomic) NSUInteger advertID;
@property (retain, nonatomic) NSMutableArray *data;
@end
