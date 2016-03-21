//
//  DataAdvertViewController.h
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DataCategroy)
{
    DataCategroyYin = 0,
    DataCategroyZhi,
};

@interface DataAdvertViewController : DotCViewController
@property (retain, nonatomic) IBOutlet UIView *noDataView;
@property (assign, nonatomic) DataCategroy type;
@property (assign, nonatomic) NSInteger requestType;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *shaixuan;

@property (retain, nonatomic) NSMutableArray *netDataArray;
@end
