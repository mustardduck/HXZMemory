//
//  BaseMallCell.h
//  miaozhuan
//
//  Created by 孙向前 on 14-12-26.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseMallCell : UITableViewCell

+ (instancetype)createCell:(NSInteger)type withData:(id)data;

@end
