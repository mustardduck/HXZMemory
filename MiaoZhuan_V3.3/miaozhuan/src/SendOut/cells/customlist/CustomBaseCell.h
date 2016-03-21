//
//  CustomBaseCell.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBaseCell : UITableViewCell

+ (instancetype)createCellWithType:(NSInteger)type data:(DictionaryWrapper *)data;

@end
