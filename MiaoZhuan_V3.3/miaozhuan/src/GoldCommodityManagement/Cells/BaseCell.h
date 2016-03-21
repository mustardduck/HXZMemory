//
//  BaseCell.h
//  ImgAndTextCell
//
//  Created by totem on 13-12-10.
//  Copyright (c) 2013年 nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

+ (UINib *)nib;

+ (id)cellForTableView:(UITableView *)tableView withStyle:(UITableViewCellStyle)style cellID:(NSString*)cellID;
+ (id)cellForTableView:(UITableView *)tableView withStyle:(UITableViewCellStyle)style;
+ (id)cellForTableView:(UITableView *)tableView fromNib:(UINib *)nib;

+ (NSString *)cellIdentifier;

- (void)reset;

@end
