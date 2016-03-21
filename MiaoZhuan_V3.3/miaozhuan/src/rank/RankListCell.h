//
//  RankListCell.h
//  miaozhuan
//
//  Created by abyss on 14/10/21.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HightedButton.h"
#import "NetImageView.h"

@interface RankListCell : UITableViewCell

@property (assign, nonatomic) NSInteger tag;
@property (assign, nonatomic) BOOL      last;

@property (retain, nonatomic) NSArray* data;
@property (retain, nonatomic) IBOutlet NetImageView *leftImg;
@property (retain, nonatomic) IBOutlet UILabel *leftTitle;
@property (retain, nonatomic) IBOutlet UILabel *leftText;
@property (retain, nonatomic) IBOutlet NetImageView *rightImg;
@property (retain, nonatomic) IBOutlet UILabel *rightTitle;
@property (retain, nonatomic) IBOutlet UILabel *rightText;
@property (retain, nonatomic) IBOutlet HightedButton *leftButton;
@property (retain, nonatomic) IBOutlet HightedButton *rightButton;
@property (retain, nonatomic) IBOutlet UIView *leftView;
@property (retain, nonatomic) IBOutlet UIView *rightView;

@property (retain, nonatomic) DictionaryWrapper *leftDic;
@property (retain, nonatomic) DictionaryWrapper *rightDic;

- (IBAction)leftButton:(id)sender;
- (IBAction)rightButton:(id)sender;
@end
