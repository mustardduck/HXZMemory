//
//  SendOutAreaViewController.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CallBack) (NSArray *value);

@interface SendOutAreaViewController : DotCViewController

@property (nonatomic, copy) CallBack block;

@end
