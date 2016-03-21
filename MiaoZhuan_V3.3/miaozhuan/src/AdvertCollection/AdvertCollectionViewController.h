//
//  AdvertCollectionViewController.h
//  miaozhuan
//
//  Created by abyss on 14/10/21.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFJLeftSwipeDeleteTableView.h"
#import "SelectionButton.h"
#import "otherButton.h"
#import "CommonTextField.h"

@interface AdvertCollectionViewController : DotCViewController

@property (retain, nonatomic) IBOutlet YFJLeftSwipeDeleteTableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *noCollectionView;
@property (retain, nonatomic) IBOutlet UIView *noSelectionView;
@property (retain, nonatomic) IBOutlet UIButton *selectionButton;
@property (retain, nonatomic) IBOutlet UIView *popView;
@property (retain, nonatomic) IBOutlet SelectionButton *bt1;
@property (retain, nonatomic) IBOutlet SelectionButton *bt2;
@property (retain, nonatomic) IBOutlet SelectionButton *bt3;
@property (retain, nonatomic) IBOutlet SelectionButton *btn4;
@property (retain, nonatomic) IBOutlet CommonTextField *textF;

@property (retain, nonatomic) IBOutlet otherButton *reSelectBt;
- (IBAction)reSelect:(id)sender;

- (IBAction)selectBt:(id)sender;
- (IBAction)selection:(id)sender;
//筛选
//- (void)selectTableViewBy:(NSInteger)type key:(NSString *)key;
@end
