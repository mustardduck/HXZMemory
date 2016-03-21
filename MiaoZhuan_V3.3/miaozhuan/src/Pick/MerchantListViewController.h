//
//  MerchantListViewController.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-3.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantListViewController : DotCViewController

@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *enId;
@property (retain, nonatomic) IBOutlet UIImageView *line;

@end
