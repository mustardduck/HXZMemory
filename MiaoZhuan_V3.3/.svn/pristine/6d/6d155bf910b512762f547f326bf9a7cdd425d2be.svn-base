//
//  RankListModelViewController.h
//  miaozhuan
//
//  Created by abyss on 14/10/22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "otherButton.h"

@interface RankListModelViewController : DotCViewController

//数据
@property (assign, nonatomic) NSArray* hisData;
@property (assign, nonatomic) NSInteger categregyId;
@property (retain, nonatomic) DictionaryWrapper *topDic;
@property (retain, nonatomic) IBOutlet UIImageView *line;


@property (retain, nonatomic) IBOutlet UITableView *tableView;

//顶部
@property (retain, nonatomic) IBOutlet UIView *top;
@property (retain, nonatomic) IBOutlet UIButton *bt1;
@property (retain, nonatomic) IBOutlet UIButton *bt2;
@property (retain, nonatomic) IBOutlet UIButton *bt3;
@property (assign, nonatomic) NSInteger sectionId;
//周一

@property (retain, nonatomic) IBOutlet UIView *searchView;
@property (retain, nonatomic) IBOutlet UILabel *searchLabel;
@property (retain, nonatomic) IBOutlet otherButton *searchBtn;

//底部
@property (retain, nonatomic) IBOutlet UILabel *bottmText;
//网络
@property (retain, nonatomic) IBOutlet UILabel *labelShow;

- (IBAction)topBar:(UIButton *)sender;
- (IBAction)phoneCall:(id)sender;
@end
