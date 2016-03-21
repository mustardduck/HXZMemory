//
//  AddManagerTableViewCell.h
//  miaozhuan
//
//  Created by Santiago on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddManagerTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *managerLabel;
@property (retain, nonatomic) IBOutlet UIButton *deleteBtn;
@property (retain, nonatomic) IBOutlet UIButton *checkFromList;
@property (retain, nonatomic) IBOutlet UITextField *managerNumberField;
@end
