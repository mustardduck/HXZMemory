//
//  IWExploitIWTableViewCell.h
//  miaozhuan
//
//  Created by Junnpy Zhong on 15/5/14.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kIWExploitTableViewCellHeight 80.f

@interface IWExploitTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *imageView_User;
@property (retain, nonatomic) IBOutlet UILabel *label_Title1;
@property (retain, nonatomic) IBOutlet UILabel *label_Title2;
@property (retain, nonatomic) IBOutlet UILabel *label_Title3;
@property (retain, nonatomic) IBOutlet UILabel *label_Title4;

-(void)updateContent:(DictionaryWrapper *)dic;

@end
