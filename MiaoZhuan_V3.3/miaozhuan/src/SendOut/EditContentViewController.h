//
//  EditContentViewController.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^getBlock)(NSString *value);
@interface EditContentViewController : DotCViewController

@property (copy, nonatomic) getBlock value;
@property (nonatomic, copy) NSString *content;

@end
