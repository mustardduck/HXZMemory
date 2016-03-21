//
//  NotifyClassTableViewCell.h
//  miaozhuan
//
//  Created by abyss on 14/11/13.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotifyClassTableViewCell : UITableViewCell
@property (assign, nonatomic) DictionaryWrapper *data;

@property (retain, nonatomic) IBOutlet UILabel *classL;
@property (assign, nonatomic, readonly) NSInteger newCount;

@property (assign, nonatomic, readonly) NSInteger type;
@property (assign, nonatomic, readonly) NSInteger cellStyle;
@property (retain, nonatomic) UIView* line;
- (void)jump;
@end
