//
//  ContactorListViewController.h
//  miaozhuan
//
//  Created by 孙向前 on 14-12-2.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^getBlock) (DictionaryWrapper *value);

@interface ContactorListViewController : UIViewController

@property (nonatomic, copy) NSString *keyWord;

@property (assign, nonatomic) getBlock value;

@property (nonatomic, assign) BOOL isGold;

@end
