//
//  BaseMainCell.h
//  miaozhuan
//
//  Created by 孙向前 on 14-10-31.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseMainCell : UITableViewCell

+ (instancetype)createCell:(NSInteger)type withData:(id)data;

@end
